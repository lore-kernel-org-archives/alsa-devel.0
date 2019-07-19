Return-Path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id BBED5F800B2
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2019 08:32:56 +0200 (CEST)
From: <shumingf@realtek.com>
Date: Fri, 19 Jul 2019 14:32:49 +0800
Message-ID: <20190719063249.18806-1-shumingf@realtek.com>
MIME-Version: 1.0
Subject: [alsa-devel] [PATCH 2/3] ASoC: rt1308: add silence detection and
	manual PDB control
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, derek.fang@realtek.com, Shuming Fan <shumingf@realtek.com>, flove@realtek.com
List-ID: <alsa-devel@alsa-project.org>

From: Shuming Fan <shumingf@realtek.com>

We enable the silence detection function in initial settings.
PDB control changes to manual mode, hence the driver could
fully control the AMP output on/off.

Signed-off-by: Shuming Fan <shumingf@realtek.com>
---
 sound/soc/codecs/rt1308.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/rt1308.c b/sound/soc/codecs/rt1308.c
index 19d255e01827..cf3d72f99705 100644
--- a/sound/soc/codecs/rt1308.c
+++ b/sound/soc/codecs/rt1308.c
@@ -40,10 +40,10 @@ static const struct reg_sequence init_list[] = {
 	{ RT1308_VREF,			0x18100000 },
 	{ RT1308_IV_SENSE,		0x87010000 },
 	{ RT1308_DUMMY_REG,		0x00000200 },
-	{ RT1308_SIL_DET,		0x61c30000 },
+	{ RT1308_SIL_DET,		0xe1c30000 },
 	{ RT1308_DC_CAL_2,		0x00ffff00 },
 	{ RT1308_CLK_DET,		0x01000000 },
-	{ RT1308_POWER_STATUS,		0x00800000 },
+	{ RT1308_POWER_STATUS,		0x08800000 },
 	{ RT1308_DAC_SET,		0xafaf0700 },
 
 };
@@ -308,12 +308,13 @@ static int rt1308_classd_event(struct snd_soc_dapm_widget *w,
 	case SND_SOC_DAPM_POST_PMU:
 		msleep(30);
 		snd_soc_component_update_bits(component, RT1308_POWER_STATUS,
-			RT1308_POW_PDB_REG_BIT, RT1308_POW_PDB_REG_BIT);
+			RT1308_POW_PDB_REG_BIT | RT1308_POW_PDB_MN_BIT,
+			RT1308_POW_PDB_REG_BIT | RT1308_POW_PDB_MN_BIT);
 		msleep(40);
 		break;
 	case SND_SOC_DAPM_PRE_PMD:
 		snd_soc_component_update_bits(component, RT1308_POWER_STATUS,
-			RT1308_POW_PDB_REG_BIT, 0);
+			RT1308_POW_PDB_REG_BIT | RT1308_POW_PDB_MN_BIT, 0);
 		usleep_range(150000, 200000);
 		break;
 
-- 
2.22.0

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
https://mailman.alsa-project.org/mailman/listinfo/alsa-devel
