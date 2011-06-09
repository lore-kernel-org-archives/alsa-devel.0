From: Liam Girdwood <lrg@ti.com>
Subject: [PATCH] ASoC: pcm - rename snd_codec_close() to
	snd_pcm_close().
Date: Thu, 9 Jun 2011 17:04:59 +0100
Message-ID: <1307635499-3622-1-git-send-email-lrg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from comal.ext.ti.com (comal.ext.ti.com [198.47.26.152])
	by alsa0.perex.cz (Postfix) with ESMTP id AD845103BF0
	for <alsa-devel@alsa-project.org>;
	Thu,  9 Jun 2011 18:05:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Make sure we follow naming convention for all PCM ops.

Signed-off-by: Liam Girdwood <lrg@ti.com>
---
 sound/soc/soc-pcm.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index f4864b0..b575939 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -268,7 +268,7 @@ static void close_delayed_work(struct work_struct *work)
  * freed here. The cpu DAI, codec DAI, machine and platform are also
  * shutdown.
  */
-static int soc_codec_close(struct snd_pcm_substream *substream)
+static int soc_pcm_close(struct snd_pcm_substream *substream)
 {
 	struct snd_soc_pcm_runtime *rtd = substream->private_data;
 	struct snd_soc_platform *platform = rtd->platform;
@@ -567,7 +567,7 @@ static snd_pcm_uframes_t soc_pcm_pointer(struct snd_pcm_substream *substream)
 /* ASoC PCM operations */
 static struct snd_pcm_ops soc_pcm_ops = {
 	.open		= soc_pcm_open,
-	.close		= soc_codec_close,
+	.close		= soc_pcm_close,
 	.hw_params	= soc_pcm_hw_params,
 	.hw_free	= soc_pcm_hw_free,
 	.prepare	= soc_pcm_prepare,
-- 
1.7.4.1
