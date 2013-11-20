From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH][topic/symmetry] ASoC: soc-pcm: move DAIs
	parameters cleaning into hw_free()
Date: Wed, 20 Nov 2013 18:37:09 +0800
Message-ID: <1384943829-9005-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0252.outbound.messaging.microsoft.com [213.199.154.252])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A52D260786
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 11:37:02 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

We're now applying soc_hw_params_symmetry() to reject unmatched parameters
while we clear parameters in soc_pcm_close(). So here's a use case might be
broken by this mechanism: aplay -Dhw:0 44100.wav 48000.wav 32000.wav

In this case, we call soc_pcm_open()->soc_pcm_hw_params()->soc_pcm_hw_free()
->soc_pcm_hw_params()->soc_pcm_hw_free()->soc_pcm_close() in order. As we
only clear parameters in soc_pcm_close(). The parameters would be remained
in the system even if the playback of 44100.wav is finished.

Thus, this patch is trying to move parameters cleaning into hw_free() so that
the system can continue to serve this kind of use case.

Also, since we set them in hw_params(), it should be better to clear them in
hw_free() for symmetry.

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 sound/soc/soc-pcm.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 60d9cfb..d519757 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -443,19 +443,6 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 	codec_dai->active--;
 	codec->active--;
 
-	/* clear the corresponding DAIs rate when inactive */
-	if (!cpu_dai->active) {
-		cpu_dai->rate = 0;
-		cpu_dai->channels = 0;
-		cpu_dai->sample_bits = 0;
-	}
-
-	if (!codec_dai->active) {
-		codec_dai->rate = 0;
-		codec_dai->channels = 0;
-		codec_dai->sample_bits = 0;
-	}
-
 	/* Muting the DAC suppresses artifacts caused during digital
 	 * shutdown, for example from stopping clocks.
 	 */
@@ -671,6 +658,19 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
+	/* clear the corresponding DAIs parameters when going to be inactive */
+	if (cpu_dai->active == 1) {
+		cpu_dai->rate = 0;
+		cpu_dai->channels = 0;
+		cpu_dai->sample_bits = 0;
+	}
+
+	if (codec_dai->active == 1) {
+		codec_dai->rate = 0;
+		codec_dai->channels = 0;
+		codec_dai->sample_bits = 0;
+	}
+
 	/* apply codec digital mute */
 	if (!codec->active)
 		snd_soc_dai_digital_mute(codec_dai, 1, substream->stream);
-- 
1.8.4
