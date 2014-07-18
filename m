From: Scott Jiang <scott.jiang.linux@gmail.com>
Subject: [PATCH] ASoC: blackfin: use samples to set silence
Date: Fri, 18 Jul 2014 16:14:57 +0800
Message-ID: <1405671297-17792-2-git-send-email-scott.jiang.linux@gmail.com>
References: <1405671297-17792-1-git-send-email-scott.jiang.linux@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0182.outbound.protection.outlook.com [207.46.163.182])
 by alsa0.perex.cz (Postfix) with ESMTP id E4833265526
 for <alsa-devel@alsa-project.org>; Thu, 17 Jul 2014 10:18:46 +0200 (CEST)
In-Reply-To: <1405671297-17792-1-git-send-email-scott.jiang.linux@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, Scott Jiang <scott.jiang.linux@gmail.com>
List-Id: alsa-devel@alsa-project.org

The third parameter for snd_pcm_format_set_silence needs the number
of samples instead of sample bytes.

Signed-off-by: Scott Jiang <scott.jiang.linux@gmail.com>
---
 sound/soc/blackfin/bf5xx-i2s-pcm.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/blackfin/bf5xx-i2s-pcm.c b/sound/soc/blackfin/bf5xx-i2s-pcm.c
index a3881c4..bcf5913 100644
--- a/sound/soc/blackfin/bf5xx-i2s-pcm.c
+++ b/sound/soc/blackfin/bf5xx-i2s-pcm.c
@@ -290,19 +290,19 @@ static int bf5xx_pcm_silence(struct snd_pcm_substream *substream,
 	unsigned int sample_size = runtime->sample_bits / 8;
 	void *buf = runtime->dma_area;
 	struct bf5xx_i2s_pcm_data *dma_data;
-	unsigned int offset, size;
+	unsigned int offset, samples;
 
 	dma_data = snd_soc_dai_get_dma_data(rtd->cpu_dai, substream);
 
 	if (dma_data->tdm_mode) {
 		offset = pos * 8 * sample_size;
-		size = count * 8 * sample_size;
+		samples = count * 8;
 	} else {
 		offset = frames_to_bytes(runtime, pos);
-		size = frames_to_bytes(runtime, count);
+		samples = count * runtime->channels;
 	}
 
-	snd_pcm_format_set_silence(runtime->format, buf + offset, size);
+	snd_pcm_format_set_silence(runtime->format, buf + offset, samples);
 
 	return 0;
 }
-- 
1.7.9.5
