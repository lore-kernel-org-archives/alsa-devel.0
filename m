From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Subject: [PATCH 6/7] ASoC: sti: sti-sas: add missing return in
	messages strings
Date: Mon, 24 Oct 2016 16:42:56 +0200
Message-ID: <1477320177-30130-7-git-send-email-arnaud.pouliquen@st.com>
References: <1477320177-30130-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com
 [62.209.51.94]) by alsa0.perex.cz (Postfix) with ESMTP id C8859266CC0
 for <alsa-devel@alsa-project.org>; Mon, 24 Oct 2016 16:43:19 +0200 (CEST)
In-Reply-To: <1477320177-30130-1-git-send-email-arnaud.pouliquen@st.com>
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
Cc: kernel@stlinux.com, Takashi Iwai <tiwai@suse.de>, arnaud.pouliquen@st.com, lgirdwood@gmail.com, broonie@kernel.org, Moise Gergaud <moise.gergaud@st.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
---
 sound/soc/codecs/sti-sas.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/sti-sas.c b/sound/soc/codecs/sti-sas.c
index 1488f4f..21d087b 100644
--- a/sound/soc/codecs/sti-sas.c
+++ b/sound/soc/codecs/sti-sas.c
@@ -124,7 +124,7 @@ static int  sti_sas_init_sas_registers(struct snd_soc_codec *codec,
 		ret = snd_soc_update_bits(codec, STIH407_AUDIO_GLUE_CTRL,
 					  SPDIF_BIPHASE_IDLE_MASK, 0);
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to update SPDIF registers");
+		dev_err(codec->dev, "Failed to update SPDIF registers\n");
 		return ret;
 	}
 
@@ -144,7 +144,7 @@ static int  sti_sas_init_sas_registers(struct snd_soc_codec *codec,
 					  STIH407_DAC_SOFTMUTE_MASK);
 
 	if (ret < 0) {
-		dev_err(codec->dev, "Failed to update DAC registers");
+		dev_err(codec->dev, "Failed to update DAC registers\n");
 		return ret;
 	}
 
@@ -292,13 +292,13 @@ static int sti_sas_prepare(struct snd_pcm_substream *substream,
 	switch (dai->id) {
 	case STI_SAS_DAI_SPDIF_OUT:
 		if ((drvdata->spdif.mclk / runtime->rate) != 128) {
-			dev_err(codec->dev, "unexpected mclk-fs ratio");
+			dev_err(codec->dev, "unexpected mclk-fs ratio\n");
 			return -EINVAL;
 		}
 		break;
 	case STI_SAS_DAI_ANALOG_OUT:
 		if ((drvdata->dac.mclk / runtime->rate) != 256) {
-			dev_err(codec->dev, "unexpected mclk-fs ratio");
+			dev_err(codec->dev, "unexpected mclk-fs ratio\n");
 			return -EINVAL;
 		}
 		break;
@@ -423,7 +423,7 @@ static int sti_sas_driver_probe(struct platform_device *pdev)
 	/* Populate data structure depending on compatibility */
 	of_id = of_match_node(sti_sas_dev_match, pnode);
 	if (!of_id->data) {
-		dev_err(&pdev->dev, "data associated to device is missing");
+		dev_err(&pdev->dev, "data associated to device is missing\n");
 		return -EINVAL;
 	}
 
-- 
1.9.1
