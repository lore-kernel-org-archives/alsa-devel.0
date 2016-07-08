From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/3] ASoC: Intel: Add surface3 entry in
	CHT-RT5645 machine
Date: Fri,  8 Jul 2016 15:39:51 +0530
Message-ID: <1467972591-29175-4-git-send-email-vinod.koul@intel.com>
References: <1467972591-29175-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 92E7626595B
 for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2016 12:03:09 +0200 (CEST)
In-Reply-To: <1467972591-29175-1-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Stephen Just <stephenjust@gmail.com>, patches.audio@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, apterix@gmail.com, broonie@kernel.org, Sachin Mokashi <sachinx.mokashi@intel.com>, Vinod Koul <vinod.koul@intel.com>, bugzilla@hadess.net
List-Id: alsa-devel@alsa-project.org

Surface3 device is a CHT machine, so add entry for it.
Also update the HID from BIOS.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=98001
Signed-off-by: Sachin Mokashi <sachinx.mokashi@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/soc/intel/boards/cht_bsw_rt5645.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index d7ef292c402d..f26c7b8545ae 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -30,6 +30,7 @@
 #include <sound/jack.h>
 #include "../../codecs/rt5645.h"
 #include "../atom/sst-atom-controls.h"
+#include "../common/sst-acpi.h"
 
 #define CHT_PLAT_CLK_3_HZ	19200000
 #define CHT_CODEC_DAI	"rt5645-aif1"
@@ -340,10 +341,13 @@ static struct snd_soc_card snd_soc_card_chtrt5650 = {
 };
 
 static struct cht_acpi_card snd_soc_cards[] = {
+	{"10EC5640", CODEC_TYPE_RT5645, &snd_soc_card_chtrt5645},
 	{"10EC5645", CODEC_TYPE_RT5645, &snd_soc_card_chtrt5645},
 	{"10EC5650", CODEC_TYPE_RT5650, &snd_soc_card_chtrt5650},
 };
 
+static char cht_rt5640_codec_name[16]; /* i2c-<HID>:00 with HID being 8 chars */
+
 static int snd_cht_mc_probe(struct platform_device *pdev)
 {
 	int ret_val = 0;
@@ -351,6 +355,9 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	struct cht_mc_private *drv;
 	struct snd_soc_card *card = snd_soc_cards[0].soc_card;
 	char codec_name[16];
+	struct sst_acpi_mach *mach;
+	const char *i2c_name = NULL;
+	int dai_index;
 
 	drv = devm_kzalloc(&pdev->dev, sizeof(*drv), GFP_ATOMIC);
 	if (!drv)
@@ -366,12 +373,23 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 		}
 	}
 	card->dev = &pdev->dev;
+	mach = card->dev->platform_data;
 	sprintf(codec_name, "i2c-%s:00", drv->acpi_card->codec_id);
 
 	/* set correct codec name */
 	for (i = 0; i < ARRAY_SIZE(cht_dailink); i++)
-		if (!strcmp(card->dai_link[i].codec_name, "i2c-10EC5645:00"))
+		if (!strcmp(card->dai_link[i].codec_name, "i2c-10EC5645:00")) {
 			card->dai_link[i].codec_name = kstrdup(codec_name, GFP_KERNEL);
+			dai_index = i;
+		}
+
+	/* fixup codec name based on HID */
+	i2c_name = sst_acpi_find_name_from_hid(mach->id);
+	if (i2c_name != NULL) {
+		snprintf(cht_rt5640_codec_name, sizeof(cht_rt5640_codec_name),
+			"%s%s", "i2c-", i2c_name);
+		cht_dailink[dai_index].codec_name = cht_rt5640_codec_name;
+	}
 
 	snd_soc_card_set_drvdata(card, drv);
 	ret_val = devm_snd_soc_register_card(&pdev->dev, card);
-- 
1.9.1
