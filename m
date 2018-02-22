From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH 2/2] ASoC: soc-generic-dmaengine-pcm: Fix
	sparse warnings
Date: Thu, 22 Feb 2018 16:02:22 -0300
Message-ID: <1519326142-26421-2-git-send-email-festevam@gmail.com>
References: <1519326142-26421-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qk0-f194.google.com (mail-qk0-f194.google.com
 [209.85.220.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 149482677F6
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 20:02:39 +0100 (CET)
Received: by mail-qk0-f194.google.com with SMTP id v124so7772004qkh.11
 for <alsa-devel@alsa-project.org>; Thu, 22 Feb 2018 11:02:39 -0800 (PST)
In-Reply-To: <1519326142-26421-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: Fabio Estevam <fabio.estevam@nxp.com>, alsa-devel@alsa-project.org, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Currently the following sparse warnings are observed:

sound/soc/soc-generic-dmaengine-pcm.c:185:34: warning: restricted snd_pcm_format_t degrades to integer
sound/soc/soc-generic-dmaengine-pcm.c:186:66: warning: incorrect type in argument 1 (different base types)
sound/soc/soc-generic-dmaengine-pcm.c:186:66:    expected restricted snd_pcm_format_t [usertype] format
sound/soc/soc-generic-dmaengine-pcm.c:186:66:    got int [signed] [assigned] i

Fix it by changing the loop variable to be of 'snd_pcm_format_t'.

Also introduce a SNDRV_PCM_FORMAT_FIRST label, which corresponds to the
first member (index 0) of the snd_pcm_format_t formats.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 include/uapi/sound/asound.h           | 1 +
 sound/soc/soc-generic-dmaengine-pcm.c | 5 +++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/uapi/sound/asound.h b/include/uapi/sound/asound.h
index 07d6158..ed0a120 100644
--- a/include/uapi/sound/asound.h
+++ b/include/uapi/sound/asound.h
@@ -242,6 +242,7 @@ typedef int __bitwise snd_pcm_format_t;
 #define	SNDRV_PCM_FORMAT_DSD_U16_BE	((__force snd_pcm_format_t) 51) /* DSD, 2-byte samples DSD (x16), big endian */
 #define	SNDRV_PCM_FORMAT_DSD_U32_BE	((__force snd_pcm_format_t) 52) /* DSD, 4-byte samples DSD (x32), big endian */
 #define	SNDRV_PCM_FORMAT_LAST		SNDRV_PCM_FORMAT_DSD_U32_BE
+#define	SNDRV_PCM_FORMAT_FIRST		SNDRV_PCM_FORMAT_S8
 
 #ifdef SNDRV_LITTLE_ENDIAN
 #define	SNDRV_PCM_FORMAT_S16		SNDRV_PCM_FORMAT_S16_LE
diff --git a/sound/soc/soc-generic-dmaengine-pcm.c b/sound/soc/soc-generic-dmaengine-pcm.c
index 32ea16d..785f25e 100644
--- a/sound/soc/soc-generic-dmaengine-pcm.c
+++ b/sound/soc/soc-generic-dmaengine-pcm.c
@@ -132,7 +132,8 @@ static int dmaengine_pcm_set_runtime_hwparams(struct snd_pcm_substream *substrea
 	u32 addr_widths = BIT(DMA_SLAVE_BUSWIDTH_1_BYTE) |
 			  BIT(DMA_SLAVE_BUSWIDTH_2_BYTES) |
 			  BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
-	int i, ret;
+	snd_pcm_format_t i;
+	int ret;
 
 	if (pcm->config && pcm->config->pcm_hardware)
 		return snd_soc_set_runtime_hwparams(substream,
@@ -182,7 +183,7 @@ static int dmaengine_pcm_set_runtime_hwparams(struct snd_pcm_substream *substrea
 		 * default assumption is that it supports 1, 2 and 4 bytes
 		 * widths.
 		 */
-		for (i = 0; i <= SNDRV_PCM_FORMAT_LAST; i++) {
+		for (i = SNDRV_PCM_FORMAT_FIRST; i <= SNDRV_PCM_FORMAT_LAST; i++) {
 			int bits = snd_pcm_format_physical_width(i);
 
 			/*
-- 
2.7.4
