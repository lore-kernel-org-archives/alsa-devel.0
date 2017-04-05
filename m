From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: ssm4567: Add OF device ID table" to the
	asoc tree
Date: Wed, 05 Apr 2017 18:30:44 +0100
Message-ID: <E1cvolY-0000iS-Vu@debutante>
References: <20170404192630.11408-3-javier@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A92A26718D
 for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2017 19:30:58 +0200 (CEST)
In-Reply-To: <20170404192630.11408-3-javier@osg.samsung.com>
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
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: ssm4567: Add OF device ID table

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

>From 71c314d7ef2442cd798584a3dece8151215e1777 Mon Sep 17 00:00:00 2001
From: Javier Martinez Canillas <javier@osg.samsung.com>
Date: Tue, 4 Apr 2017 15:26:26 -0400
Subject: [PATCH] ASoC: ssm4567: Add OF device ID table

The driver doesn't have a struct of_device_id table but supported devices
are registered via Device Trees. This is working on the assumption that a
I2C device registered via OF will always match a legacy I2C device ID and
that the MODALIAS reported will always be of the form i2c:<device>.

But this could change in the future so the correct approach is to have an
OF device ID table if the devices are registered via OF.

Before this patch:

$ modinfo sound/soc/codecs/snd-soc-ssm4567.ko | grep alias
alias:          acpi*:INT343B:*
alias:          i2c:ssm4567

After this patch:

$ modinfo sound/soc/codecs/snd-soc-ssm4567.ko | grep alias
alias:          acpi*:INT343B:*
alias:          of:N*T*Cadi,ssm4567C*
alias:          of:N*T*Cadi,ssm4567
alias:          i2c:ssm4567

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/ssm4567.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/codecs/ssm4567.c b/sound/soc/codecs/ssm4567.c
index 2bb5a11c9ba1..a622623e8558 100644
--- a/sound/soc/codecs/ssm4567.c
+++ b/sound/soc/codecs/ssm4567.c
@@ -485,6 +485,14 @@ static const struct i2c_device_id ssm4567_i2c_ids[] = {
 };
 MODULE_DEVICE_TABLE(i2c, ssm4567_i2c_ids);
 
+#ifdef CONFIG_OF
+static const struct of_device_id ssm4567_of_match[] = {
+	{ .compatible = "adi,ssm4567", },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, ssm4567_of_match);
+#endif
+
 #ifdef CONFIG_ACPI
 
 static const struct acpi_device_id ssm4567_acpi_match[] = {
@@ -498,6 +506,7 @@ MODULE_DEVICE_TABLE(acpi, ssm4567_acpi_match);
 static struct i2c_driver ssm4567_driver = {
 	.driver = {
 		.name = "ssm4567",
+		.of_match_table = of_match_ptr(ssm4567_of_match),
 		.acpi_match_table = ACPI_PTR(ssm4567_acpi_match),
 	},
 	.probe = ssm4567_i2c_probe,
-- 
2.11.0
