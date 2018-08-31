From: "Andrew F. Davis" <afd@ti.com>
Subject: [PATCH v2 2/2] ASoC: codecs: tas5720: add TAS5722 TDM slot width setting support
Date: Fri, 31 Aug 2018 09:47:14 -0500
Message-ID: <20180831144714.16499-2-afd@ti.com>
References: <20180831144714.16499-1-afd@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180831144714.16499-1-afd@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Andrew F . Davis" <afd@ti.com>
List-Id: alsa-devel@alsa-project.org

From: Andreas Dannenberg <dannenberg@ti.com>

Unlike the TAS5720, the TAS5722 can be configured to utilize 16-bit wide
slots in TDM mode. This can help easing audio clocking/frequency
requirements.

Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
Signed-off-by: Andrew F. Davis <afd@ti.com>
---

Changes from v1:
 - Use switch over if

 sound/soc/codecs/tas5720.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/sound/soc/codecs/tas5720.c b/sound/soc/codecs/tas5720.c
index 3c469112477a..6bd0e5d5347f 100644
--- a/sound/soc/codecs/tas5720.c
+++ b/sound/soc/codecs/tas5720.c
@@ -152,6 +152,7 @@ static int tas5720_set_dai_tdm_slot(struct snd_soc_dai *dai,
 				    int slots, int slot_width)
 {
 	struct snd_soc_component *component = dai->component;
+	struct tas5720_data *tas5720 = snd_soc_component_get_drvdata(component);
 	unsigned int first_slot;
 	int ret;
 
@@ -185,6 +186,20 @@ static int tas5720_set_dai_tdm_slot(struct snd_soc_dai *dai,
 	if (ret < 0)
 		goto error_snd_soc_component_update_bits;
 
+	/* Configure TDM slot width. This is only applicable to TAS5722. */
+	switch (tas5720->devtype) {
+	case TAS5722:
+		ret = snd_soc_component_update_bits(component, TAS5722_DIGITAL_CTRL2_REG,
+						    TAS5722_TDM_SLOT_16B,
+						    slot_width == 16 ?
+						    TAS5722_TDM_SLOT_16B : 0);
+		if (ret < 0)
+			goto error_snd_soc_component_update_bits;
+		break;
+	default:
+		break;
+	}
+
 	return 0;
 
 error_snd_soc_component_update_bits:
-- 
2.18.0
