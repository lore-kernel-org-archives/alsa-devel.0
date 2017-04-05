From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoc: rt5645: Add OF device ID table" to the
	asoc tree
Date: Wed, 05 Apr 2017 18:30:48 +0100
Message-ID: <E1cvolc-0000k1-25@debutante>
References: <20170404192630.11408-2-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EF5BB267111
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 19:30:58 +0200 (CEST)
In-Reply-To: <20170404192630.11408-2-javier@osg.samsung.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Javier Martinez Canillas <javier@osg.samsung.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Bard Liao <bardliao@realtek.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoc: rt5645: Add OF device ID table

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 9ba2da5f5d18daaa365ab5426b05e16f1d114786 Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javier@osg.samsung.com>
Date: Tue, 4 Apr 2017 15:26:25 -0400
Subject: [PATCH] ASoc: rt5645: Add OF device ID table

The driver doesn't have a struct of_device_id table but supported devices
are registered via Device Trees. This is working on the assumption that a
I2C device registered via OF will always match a legacy I2C device ID and
that the MODALIAS reported will always be of the form i2c:<device>.

But this could change in the future so the correct approach is to have an
OF device ID table if the devices are registered via OF.

Before this patch:

$ modinfo sound/soc/codecs/snd-soc-rt5645.ko | grep alias
alias:          acpi*:10EC3270:*
alias:          acpi*:10EC5640:*
alias:          acpi*:10EC5650:*
alias:          acpi*:10EC5648:*
alias:          acpi*:10EC5645:*
alias:          i2c:rt5650
alias:          i2c:rt5645

After this patch:

$ modinfo sound/soc/codecs/snd-soc-rt5645.ko | grep alias
alias:          of:N*T*Crealtek,rt5650C*
alias:          of:N*T*Crealtek,rt5650
alias:          of:N*T*Crealtek,rt5645C*
alias:          of:N*T*Crealtek,rt5645
alias:          acpi*:10EC3270:*
alias:          acpi*:10EC5640:*
alias:          acpi*:10EC5650:*
alias:          acpi*:10EC5648:*
alias:          acpi*:10EC5645:*
alias:          i2c:rt5650
alias:          i2c:rt5645

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 10c2a564a715..f8550ef2261b 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3542,6 +3542,15 @@ static const struct i2c_device_id rt5645_i2c_id[] = {
 };
 MODULE_DEVICE_TABLE(i2c, rt5645_i2c_id);
 
+#ifdef CONFIG_OF
+static const struct of_device_id rt5645_of_match[] = {
+	{ .compatible = "realtek,rt5645", },
+	{ .compatible = "realtek,rt5650", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, rt5645_of_match);
+#endif
+
 #ifdef CONFIG_ACPI
 static const struct acpi_device_id rt5645_acpi_match[] = {
 	{ "10EC5645", 0 },
@@ -3901,6 +3910,7 @@ static void rt5645_i2c_shutdown(struct i2c_client *i2c)
 static struct i2c_driver rt5645_i2c_driver = {
 	.driver = {
 		.name = "rt5645",
+		.of_match_table = of_match_ptr(rt5645_of_match),
 		.acpi_match_table = ACPI_PTR(rt5645_acpi_match),
 	},
 	.probe = rt5645_i2c_probe,
-- 
2.11.0
