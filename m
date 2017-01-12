From: Nicholas Mc Guire <hofrat@osadl.org>
Subject: [PATCH] ASoC: rt5659: declare rt5659_i2c_driver static
Date: Thu, 12 Jan 2017 14:14:41 +0100
Message-ID: <1484226881-5667-1-git-send-email-hofrat@osadl.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Nicholas Mc Guire <hofrat@osadl.org>
List-Id: alsa-devel@alsa-project.org

Declar rt5659_i2c_driver, which is only being passed to
module_i2c_driver(rt5659_i2c_driver), static.

Fixes: commit d3cb2de2479b ("ASoC: rt5659: add rt5659 codec driver")
Signed-off-by: Nicholas Mc Guire <hofrat@osadl.org>
---
Problem found by sparse:
sound/soc/codecs/rt5659.c:4233:19: warning: symbol 'rt5659_i2c_driver' was not declared. Should it be static?

Patch was compile tested with: x86_64_defconfig + CONFIG_COMPILE_TEST=y
SND_SOC=m + SND_SOC_ALL_CODECS=m (implies SND_SOC_RT5659=m)

Patch is aginast 4.10-rc3 (localversion-next is next-20170112)

 sound/soc/codecs/rt5659.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5659.c b/sound/soc/codecs/rt5659.c
index db54550..90b5cc6 100644
--- a/sound/soc/codecs/rt5659.c
+++ b/sound/soc/codecs/rt5659.c
@@ -4230,7 +4230,7 @@ static struct acpi_device_id rt5659_acpi_match[] = {
 MODULE_DEVICE_TABLE(acpi, rt5659_acpi_match);
 #endif
 
-struct i2c_driver rt5659_i2c_driver = {
+static struct i2c_driver rt5659_i2c_driver = {
 	.driver = {
 		.name = "rt5659",
 		.owner = THIS_MODULE,
-- 
2.1.4
