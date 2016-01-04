From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Constify ACPI device ids" to
	the asoc tree
Date: Mon, 04 Jan 2016 22:18:48 +0000
Message-ID: <E1aGDSi-0002kH-Dw@debutante>
References: <1451773436-25518-1-git-send-email-minipli@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 725AB2604DF
 for <alsa-devel@alsa-project.org>; Mon,  4 Jan 2016 23:18:58 +0100 (CET)
In-Reply-To: <1451773436-25518-1-git-send-email-minipli@googlemail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mathias Krause <minipli@googlemail.com>, Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, John Lin <john.lin@realtek.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: Constify ACPI device ids

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

>From e2973769372a3de1c20249206db5ee93287a2230 Mon Sep 17 00:00:00 2001
From: Mathias Krause <minipli@googlemail.com>
Date: Sat, 2 Jan 2016 23:23:56 +0100
Subject: [PATCH] ASoC: rt5645: Constify ACPI device ids

Constify the ACPI device ID array, no need to have it writable at
runtime. Also drop the unused RT5645_INIT_REG_LEN define.

Signed-off-by: Mathias Krause <minipli@googlemail.com>
Cc: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>
Cc: John Lin <john.lin@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 57c8d9ecfde1..bd23496a56ff 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -64,7 +64,6 @@ static const struct reg_sequence init_list[] = {
 	{RT5645_PR_BASE + 0x21,	0x4040},
 	{RT5645_PR_BASE + 0x23,	0x0004},
 };
-#define RT5645_INIT_REG_LEN ARRAY_SIZE(init_list)
 
 static const struct reg_sequence rt5650_init_list[] = {
 	{0xf6,	0x0100},
@@ -3521,7 +3520,7 @@ static const struct i2c_device_id rt5645_i2c_id[] = {
 MODULE_DEVICE_TABLE(i2c, rt5645_i2c_id);
 
 #ifdef CONFIG_ACPI
-static struct acpi_device_id rt5645_acpi_match[] = {
+static const struct acpi_device_id rt5645_acpi_match[] = {
 	{ "10EC5645", 0 },
 	{ "10EC5650", 0 },
 	{},
-- 
2.6.2
