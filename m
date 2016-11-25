From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ASoC: cht_bsw_rt5672: Use HID translation unit
Date: Fri, 25 Nov 2016 15:40:18 +0100
Message-ID: <20161125144018.28896-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4A7F6267323
 for <alsa-devel@alsa-project.org>; Fri, 25 Nov 2016 15:40:22 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Instead of hard-coded "i2c-10EC5670:00", use the translation helper to
avoid the mismatch between i2c-codec and ACPI strings just like what
we've done for bytcr_rt5640.  This gives more robust binding on funky
devices like Dell Wyse 3040.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/intel/boards/cht_bsw_rt5672.c | 30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5672.c b/sound/soc/intel/boards/cht_bsw_rt5672.c
index df9d254baa18..fe607d8701a0 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5672.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5672.c
@@ -25,12 +25,14 @@
 #include <sound/jack.h>
 #include "../../codecs/rt5670.h"
 #include "../atom/sst-atom-controls.h"
+#include "../common/sst-acpi.h"
 
 /* The platform clock #3 outputs 19.2Mhz clock to codec as I2S MCLK */
 #define CHT_PLAT_CLK_3_HZ	19200000
 #define CHT_CODEC_DAI	"rt5670-aif1"
 
 static struct snd_soc_jack cht_bsw_headset;
+static char cht_bsw_codec_name[16];
 
 /* Headset jack detection DAPM pins */
 static struct snd_soc_jack_pin cht_bsw_headset_pins[] = {
@@ -295,7 +297,7 @@ static int cht_suspend_pre(struct snd_soc_card *card)
 	struct snd_soc_codec *codec;
 
 	list_for_each_entry(codec, &card->codec_dev_list, card_list) {
-		if (!strcmp(codec->component.name, "i2c-10EC5670:00")) {
+		if (!strcmp(codec->component.name, cht_bsw_codec_name)) {
 			dev_dbg(codec->dev, "disabling jack detect before going to suspend.\n");
 			rt5670_jack_suspend(codec);
 			break;
@@ -309,7 +311,7 @@ static int cht_resume_post(struct snd_soc_card *card)
 	struct snd_soc_codec *codec;
 
 	list_for_each_entry(codec, &card->codec_dev_list, card_list) {
-		if (!strcmp(codec->component.name, "i2c-10EC5670:00")) {
+		if (!strcmp(codec->component.name, cht_bsw_codec_name)) {
 			dev_dbg(codec->dev, "enabling jack detect for resume.\n");
 			rt5670_jack_resume(codec);
 			break;
@@ -335,9 +337,33 @@ static struct snd_soc_card snd_soc_card_cht = {
 	.resume_post = cht_resume_post,
 };
 
+#define RT5672_I2C_DEFAULT	"i2c-10EC5670:00"
+
 static int snd_cht_mc_probe(struct platform_device *pdev)
 {
 	int ret_val = 0;
+	struct sst_acpi_mach *mach = pdev->dev.platform_data;
+	const char *i2c_name;
+	int i;
+
+	strcpy(cht_bsw_codec_name, RT5672_I2C_DEFAULT);
+
+	/* fixup codec name based on HID */
+	if (mach) {
+		i2c_name = sst_acpi_find_name_from_hid(mach->id);
+		if (i2c_name) {
+			snprintf(cht_bsw_codec_name, sizeof(cht_bsw_codec_name),
+				 "i2c-%s", i2c_name);
+			for (i = 0; i < ARRAY_SIZE(cht_dailink); i++) {
+				if (!strcmp(cht_dailink[i].codec_name,
+					    RT5672_I2C_DEFAULT)) {
+					cht_dailink[i].codec_name =
+						cht_bsw_codec_name;
+					break;
+				}
+			}
+		}
+	}
 
 	/* register the soc card */
 	snd_soc_card_cht.dev = &pdev->dev;
-- 
2.10.2
