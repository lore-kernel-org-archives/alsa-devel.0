From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ASoC: cht_bsw_rt5645: Fix leftover kmalloc
Date: Tue, 22 Nov 2016 18:11:08 +0100
Message-ID: <20161122171108.27238-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F626266D61
 for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2016 18:11:14 +0100 (CET)
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
Cc: Vinod Koul <vinod.koul@intel.com>, alsa-devel@alsa-project.org, Mengdong Lin <mengdong.lin@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

cht_bsw_rt5645 driver allocates the own codec_id string but doesn't
release it.  For simplicity, put the string in cht_mc_private; then
the string is allocated in a shot and released altogether.

Fixes: c8560b7c917f ("ASoC: cht_bsw_rt5645: Fix writing to string literal")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/intel/boards/cht_bsw_rt5645.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/boards/cht_bsw_rt5645.c b/sound/soc/intel/boards/cht_bsw_rt5645.c
index 56056ed7fcfd..16c94c45ce50 100644
--- a/sound/soc/intel/boards/cht_bsw_rt5645.c
+++ b/sound/soc/intel/boards/cht_bsw_rt5645.c
@@ -44,6 +44,7 @@ struct cht_acpi_card {
 struct cht_mc_private {
 	struct snd_soc_jack jack;
 	struct cht_acpi_card *acpi_card;
+	char codec_name[16];
 };
 
 static inline struct snd_soc_dai *cht_get_codec_dai(struct snd_soc_card *card)
@@ -354,7 +355,6 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	int i;
 	struct cht_mc_private *drv;
 	struct snd_soc_card *card = snd_soc_cards[0].soc_card;
-	char codec_name[16];
 	struct sst_acpi_mach *mach;
 	const char *i2c_name = NULL;
 	int dai_index = 0;
@@ -374,12 +374,12 @@ static int snd_cht_mc_probe(struct platform_device *pdev)
 	}
 	card->dev = &pdev->dev;
 	mach = card->dev->platform_data;
-	sprintf(codec_name, "i2c-%s:00", drv->acpi_card->codec_id);
+	sprintf(drv->codec_name, "i2c-%s:00", drv->acpi_card->codec_id);
 
 	/* set correct codec name */
 	for (i = 0; i < ARRAY_SIZE(cht_dailink); i++)
 		if (!strcmp(card->dai_link[i].codec_name, "i2c-10EC5645:00")) {
-			card->dai_link[i].codec_name = kstrdup(codec_name, GFP_KERNEL);
+			card->dai_link[i].codec_name = drv->codec_name;
 			dai_index = i;
 		}
 
-- 
2.10.2
