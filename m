From: Annaliese McDermond <nh6z@nh6z.net>
Subject: [PATCH 01/13] ASoC: tlv320aic32x4: Break out clock
	setting into separate function
Date: Mon, 18 Mar 2019 20:37:44 -0700
Message-ID: <20190319033756.20616-2-nh6z@nh6z.net>
References: <20190319033756.20616-1-nh6z@nh6z.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp89.iad3a.emailsrvr.com (smtp89.iad3a.emailsrvr.com
 [173.203.187.89])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id C0124F896B7
 for <alsa-devel@alsa-project.org>; Tue, 19 Mar 2019 04:38:08 +0100 (CET)
In-Reply-To: <20190319033756.20616-1-nh6z@nh6z.net>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: broonie@kernel.org, alsa-devel@alsa-project.org
Cc: team@nwdigitalradio.com, Annaliese McDermond <nh6z@nh6z.net>
List-Id: alsa-devel@alsa-project.org

Break the clock setting logic out from the main hw_params.  It's
rather large and unweildy and makes for a large function.  This
also better enables some of the following changes to the clock
tree access in the driver.

Signed-off-by: Annaliese McDermond <nh6z@nh6z.net>
---
 sound/soc/codecs/tlv320aic32x4.c | 26 ++++++++++++++++++--------
 1 file changed, 18 insertions(+), 8 deletions(-)

diff --git a/sound/soc/codecs/tlv320aic32x4.c b/sound/soc/codecs/tlv320aic32x4.c
index 96f1526cb258..1aa8f5aa4225 100644
--- a/sound/soc/codecs/tlv320aic32x4.c
+++ b/sound/soc/codecs/tlv320aic32x4.c
@@ -696,17 +696,13 @@ static int aic32x4_set_dai_fmt(struct snd_soc_dai *codec_dai, unsigned int fmt)
 	return 0;
 }
 
-static int aic32x4_hw_params(struct snd_pcm_substream *substream,
-			     struct snd_pcm_hw_params *params,
-			     struct snd_soc_dai *dai)
+static int aic32x4_setup_clocks(struct snd_soc_component *component,
+				unsigned int sample_rate,
+				unsigned int parent_rate)
 {
-	struct snd_soc_component *component = dai->component;
-	struct aic32x4_priv *aic32x4 = snd_soc_component_get_drvdata(component);
-	u8 iface1_reg = 0;
-	u8 dacsetup_reg = 0;
 	int i;
 
-	i = aic32x4_get_divs(aic32x4->sysclk, params_rate(params));
+	i = aic32x4_get_divs(parent_rate, sample_rate);
 	if (i < 0) {
 		printk(KERN_ERR "aic32x4: sampling rate not supported\n");
 		return i;
@@ -763,6 +759,20 @@ static int aic32x4_hw_params(struct snd_pcm_substream *substream,
 	snd_soc_component_update_bits(component, AIC32X4_BCLKN,
 			    AIC32X4_BCLK_MASK, aic32x4_divs[i].blck_N);
 
+	return 0;
+}
+
+static int aic32x4_hw_params(struct snd_pcm_substream *substream,
+			     struct snd_pcm_hw_params *params,
+			     struct snd_soc_dai *dai)
+{
+	struct snd_soc_component *component = dai->component;
+	struct aic32x4_priv *aic32x4 = snd_soc_component_get_drvdata(component);
+	u8 iface1_reg = 0;
+	u8 dacsetup_reg = 0;
+
+	aic32x4_setup_clocks(component, params_rate(params), aic32x4->sysclk);
+
 	switch (params_width(params)) {
 	case 16:
 		iface1_reg |= (AIC32X4_WORD_LEN_16BITS <<
-- 
2.19.1
