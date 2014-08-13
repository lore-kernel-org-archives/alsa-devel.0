From: Rongjun Ying <rongjun.ying@csr.com>
Subject: [PATCH 1/1] ASoC: sirf: usp: Add bitclock inversion
	support
Date: Wed, 13 Aug 2014 16:31:40 +0800
Message-ID: <1407918700-23972-1-git-send-email-rongjun.ying@csr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cluster-d.mailcontrol.com (cluster-d.mailcontrol.com
 [85.115.60.190])
 by alsa0.perex.cz (Postfix) with ESMTP id 464782654E9
 for <alsa-devel@alsa-project.org>; Wed, 13 Aug 2014 10:33:12 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Barry Song <baohua@kernel.org>, Arnd Bergmann <arnd@arndb.de>
Cc: Workgroup.linux@csr.com, Rongjun Ying <rongjun.ying@csr.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Rongjun Ying <rongjun.ying@csr.com>
---
 sound/soc/sirf/sirf-usp.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sirf/sirf-usp.c b/sound/soc/sirf/sirf-usp.c
index 3a73037..186dc7f 100644
--- a/sound/soc/sirf/sirf-usp.c
+++ b/sound/soc/sirf/sirf-usp.c
@@ -100,6 +100,16 @@ static int sirf_usp_pcm_set_dai_fmt(struct snd_soc_dai *dai,
 		return -EINVAL;
 	}
 
+	switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		usp->daifmt_format |= (fmt & SND_SOC_DAIFMT_INV_MASK);
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -177,7 +187,7 @@ static int sirf_usp_pcm_hw_params(struct snd_pcm_substream *substream,
 
 	shifter_len = data_len;
 
-	switch (usp->daifmt_format) {
+	switch (usp->daifmt_format & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_I2S:
 		regmap_update_bits(usp->regmap, USP_RX_FRAME_CTRL,
 			USP_I2S_SYNC_CHG, USP_I2S_SYNC_CHG);
@@ -193,6 +203,18 @@ static int sirf_usp_pcm_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	switch (usp->daifmt_format & SND_SOC_DAIFMT_INV_MASK) {
+	case SND_SOC_DAIFMT_NB_NF:
+		break;
+	case SND_SOC_DAIFMT_IB_NF:
+		regmap_update_bits(usp->regmap, USP_MODE1,
+			USP_RXD_ACT_EDGE_FALLING | USP_TXD_ACT_EDGE_FALLING,
+			USP_RXD_ACT_EDGE_FALLING);
+		break;
+	default:
+		return -EINVAL;
+	}
+
 	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
 		regmap_update_bits(usp->regmap, USP_TX_FRAME_CTRL,
 			USP_TXC_DATA_LEN_MASK | USP_TXC_FRAME_LEN_MASK
-- 
2.0.4



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Keep up to date with CSR on our technical blog, www.csr.com/blog, CSR people blog, www.csr.com/people, YouTube, www.youtube.com/user/CSRplc, Facebook, www.facebook.com/pages/CSR/191038434253534, or follow us on Twitter at www.twitter.com/CSR_plc.
New for 2014, you can now access the wide range of products powered by aptX at www.aptx.com.
