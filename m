From: Ben Gardiner <bengardiner@nanometrics.ca>
Subject: [PATCH 2/6] ASoC: davinci-pcm: expand the .formats
Date: Tue, 24 May 2011 14:50:16 -0400
Message-ID: <d733cdfeefba81cbe4f0d4ab49057e80dbe99612.1306258759.git.bengardiner@nanometrics.ca>
References: <cover.1306258759.git.bengardiner@nanometrics.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog105.obsmtp.com (na3sys009aog105.obsmtp.com
	[74.125.149.75])
	by alsa0.perex.cz (Postfix) with ESMTP id 80F881039E3
	for <alsa-devel@alsa-project.org>;
	Tue, 24 May 2011 20:50:38 +0200 (CEST)
Received: by mail-vw0-f47.google.com with SMTP id 2so5877953vws.6
	for <alsa-devel@alsa-project.org>; Tue, 24 May 2011 11:50:25 -0700 (PDT)
In-Reply-To: <cover.1306258759.git.bengardiner@nanometrics.ca>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Sekhar Nori <nsekhar@ti.com>, Liam Girdwood <lrg@ti.com>, alsa-devel@alsa-project.org, davinci-linux-open-source@linux.davincidsp.com
Cc: Steven Faludi <stevenfaludi@nanometrics.ca>, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

Based on the data_type test in ping_pong_dma_setup, davinci-pcm is capable of
handling data of width up to and including 32bits.

"
	if ((data_type == 0) || (data_type > 4)) {
		printk(KERN_ERR "%s: data_type=%i\n", __func__, data_type);
		return -EINVAL;
	}
"

Update the .format member of the snd_pcm_hardware instances it registers to
reflect this capability.

Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
Reviewed-by: Steven Faludi <stevenfaludi@nanometrics.ca>

---
 sound/soc/davinci/davinci-pcm.c |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/sound/soc/davinci/davinci-pcm.c b/sound/soc/davinci/davinci-pcm.c
index 0d04e0c..1e47267 100644
--- a/sound/soc/davinci/davinci-pcm.c
+++ b/sound/soc/davinci/davinci-pcm.c
@@ -46,11 +46,27 @@ static void print_buf_info(int slot, char *name)
 }
 #endif
 
+#define DAVINCI_PCM_FMTBITS	(\
+				SNDRV_PCM_FMTBIT_S8	|\
+				SNDRV_PCM_FMTBIT_U8	|\
+				SNDRV_PCM_FMTBIT_S16_LE	|\
+				SNDRV_PCM_FMTBIT_S16_BE	|\
+				SNDRV_PCM_FMTBIT_U16_LE	|\
+				SNDRV_PCM_FMTBIT_U16_BE	|\
+				SNDRV_PCM_FMTBIT_S24_LE	|\
+				SNDRV_PCM_FMTBIT_S24_BE	|\
+				SNDRV_PCM_FMTBIT_U24_LE	|\
+				SNDRV_PCM_FMTBIT_U24_BE	|\
+				SNDRV_PCM_FMTBIT_S32_LE	|\
+				SNDRV_PCM_FMTBIT_S32_BE	|\
+				SNDRV_PCM_FMTBIT_U32_LE	|\
+				SNDRV_PCM_FMTBIT_U32_BE)
+
 static struct snd_pcm_hardware pcm_hardware_playback = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
 		 SNDRV_PCM_INFO_PAUSE | SNDRV_PCM_INFO_RESUME),
-	.formats = (SNDRV_PCM_FMTBIT_S16_LE),
+	.formats = DAVINCI_PCM_FMTBITS,
 	.rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
 		  SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |
 		  SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
@@ -72,7 +88,7 @@ static struct snd_pcm_hardware pcm_hardware_capture = {
 	.info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
 		 SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_MMAP_VALID |
 		 SNDRV_PCM_INFO_PAUSE),
-	.formats = (SNDRV_PCM_FMTBIT_S16_LE),
+	.formats = DAVINCI_PCM_FMTBITS,
 	.rates = (SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000 |
 		  SNDRV_PCM_RATE_22050 | SNDRV_PCM_RATE_32000 |
 		  SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 |
-- 
1.7.4.1
