From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Add surface3 entry in CHT-RT5645
	machine" to the asoc tree
Date: Fri, 08 Jul 2016 14:32:09 +0200
Message-ID: <E1bLUwz-0006th-SB@finisterre>
References: <1467972591-29175-4-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 3B4C726595B
 for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2016 14:32:41 +0200 (CEST)
In-Reply-To: <1467972591-29175-4-git-send-email-vinod.koul@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@intel.com>
Cc: alsa-devel@alsa-project.org, Stephen Just <stephenjust@gmail.com>, patches.audio@intel.com, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, liam.r.girdwood@linux.intel.com, apterix@gmail.com, broonie@kernel.org, Sachin Mokashi <sachinx.mokashi@intel.com>, bugzilla@hadess.net
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Add surface3 entry in CHT-RT5645 machine

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

>From 07d5c17b80f67d1b2cc2c8243590e2abed4bd7ae Mon Sep 17 00:00:00 2001
From: Vinod Koul <vinod.koul@intel.com>
Date: Fri, 8 Jul 2016 15:39:51 +0530
Subject: [PATCH] ASoC: Intel: Add surface3 entry in CHT-RT5645 machine

Surface3 device is a CHT machine, so add entry for it.
Also update the HID from BIOS.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=98001
Signed-off-by: Sachin Mokashi <sachinx.mokashi@intel.com>
Signed-off-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
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
2.8.1
