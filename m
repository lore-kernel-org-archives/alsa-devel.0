From: Olivier Moysan <olivier.moysan@st.com>
Subject: [PATCH] ASoC: stm32: dfsdm: add 16 bits audio record support
Date: Wed, 19 Jun 2019 13:40:02 +0200
Message-ID: <1560944402-8115-1-git-send-email-olivier.moysan@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, mcoquelin.stm32@gmail.com, alexandre.torgue@st.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org, linux-stm32@st-md-mailman.stormreply.com, linux-kernel@vger.kernel.org, olivier.moysan@st.com, arnaud.pouliquen@st.com
Cc: benjamin.gaignard@st.com
List-Id: alsa-devel@alsa-project.org

Add support of audio 16 bits format record to STM32
DFSDM driver.

Signed-off-by: Olivier Moysan <olivier.moysan@st.com>
---
 sound/soc/stm/stm32_adfsdm.c | 49 +++++++++++++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 10 deletions(-)

diff --git a/sound/soc/stm/stm32_adfsdm.c b/sound/soc/stm/stm32_adfsdm.c
index cc517e007039..3c9a9deec9af 100644
--- a/sound/soc/stm/stm32_adfsdm.c
+++ b/sound/soc/stm/stm32_adfsdm.c
@@ -45,7 +45,7 @@ struct stm32_adfsdm_priv {
 static const struct snd_pcm_hardware stm32_adfsdm_pcm_hw = {
 	.info = SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_PAUSE,
-	.formats = SNDRV_PCM_FMTBIT_S32_LE,
+	.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
 
 	.rate_min = 8000,
 	.rate_max = 32000,
@@ -141,7 +141,8 @@ static const struct snd_soc_dai_driver stm32_adfsdm_dai = {
 	.capture = {
 		    .channels_min = 1,
 		    .channels_max = 1,
-		    .formats = SNDRV_PCM_FMTBIT_S32_LE,
+		    .formats = SNDRV_PCM_FMTBIT_S16_LE |
+			       SNDRV_PCM_FMTBIT_S32_LE,
 		    .rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
 			      SNDRV_PCM_RATE_32000),
 		    },
@@ -152,30 +153,58 @@ static const struct snd_soc_component_driver stm32_adfsdm_dai_component = {
 	.name = "stm32_dfsdm_audio",
 };
 
+static void memcpy_32to16(void *dest, const void *src, size_t n)
+{
+	unsigned int i = 0;
+	u16 *d = (u16 *)dest, *s = (u16 *)src;
+
+	s++;
+	for (i = n; i > 0; i--) {
+		*d++ = *s++;
+		s++;
+	}
+}
+
 static int stm32_afsdm_pcm_cb(const void *data, size_t size, void *private)
 {
 	struct stm32_adfsdm_priv *priv = private;
 	struct snd_soc_pcm_runtime *rtd = priv->substream->private_data;
 	u8 *pcm_buff = priv->pcm_buff;
 	u8 *src_buff = (u8 *)data;
-	unsigned int buff_size = snd_pcm_lib_buffer_bytes(priv->substream);
-	unsigned int period_size = snd_pcm_lib_period_bytes(priv->substream);
 	unsigned int old_pos = priv->pos;
-	unsigned int cur_size = size;
+	size_t buff_size = snd_pcm_lib_buffer_bytes(priv->substream);
+	size_t period_size = snd_pcm_lib_period_bytes(priv->substream);
+	size_t cur_size, src_size = size;
+	snd_pcm_format_t format = priv->substream->runtime->format;
+
+	if (format == SNDRV_PCM_FORMAT_S16_LE)
+		src_size >>= 1;
+	cur_size = src_size;
 
 	dev_dbg(rtd->dev, "%s: buff_add :%pK, pos = %d, size = %zu\n",
-		__func__, &pcm_buff[priv->pos], priv->pos, size);
+		__func__, &pcm_buff[priv->pos], priv->pos, src_size);
 
-	if ((priv->pos + size) > buff_size) {
-		memcpy(&pcm_buff[priv->pos], src_buff, buff_size - priv->pos);
+	if ((priv->pos + src_size) > buff_size) {
+		if (format == SNDRV_PCM_FORMAT_S16_LE)
+			memcpy_32to16(&pcm_buff[priv->pos], src_buff,
+				      buff_size - priv->pos);
+		else
+			memcpy(&pcm_buff[priv->pos], src_buff,
+			       buff_size - priv->pos);
 		cur_size -= buff_size - priv->pos;
 		priv->pos = 0;
 	}
 
-	memcpy(&pcm_buff[priv->pos], &src_buff[size - cur_size], cur_size);
+	if (format == SNDRV_PCM_FORMAT_S16_LE)
+		memcpy_32to16(&pcm_buff[priv->pos],
+			      &src_buff[src_size - cur_size], cur_size);
+	else
+		memcpy(&pcm_buff[priv->pos], &src_buff[src_size - cur_size],
+		       cur_size);
+
 	priv->pos = (priv->pos + cur_size) % buff_size;
 
-	if (cur_size != size || (old_pos && (old_pos % period_size < size)))
+	if (cur_size != src_size || (old_pos && (old_pos % period_size < size)))
 		snd_pcm_period_elapsed(priv->substream);
 
 	return 0;
-- 
2.7.4
