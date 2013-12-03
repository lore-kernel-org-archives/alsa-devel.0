From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH] ASoC: soc-pcm: Only do
	snd_soc_dai_digital_mute() in hw_free()
Date: Tue, 3 Dec 2013 17:16:06 +0800
Message-ID: <1386062166-29634-1-git-send-email-b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0186.outbound.messaging.microsoft.com [213.199.154.186])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AE2626512D
 for <alsa-devel@alsa-project.org>; Tue,  3 Dec 2013 10:16:25 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

This patch removed the redundant snd_soc_dai_digital_mute() in close() since
it is better to mute in hw_free() which is slightly earlier and symmetrical
for the case of reconfiguration, 'aplay 44100.wav 48000.wav' for example:
open()->hw_params()->prepare(unmute)->playing->hw_free(mute)->hw_params()->
parepare(unmute)->playing->hw_free(mute)->close()

This patch also corrects the condition of the snd_soc_dai_digital_mute() in
hw_free() because it would not be executed as we only decrease codec->active
in snd_soc_close().

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 sound/soc/soc-pcm.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index eb340a8..eac82858 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -474,11 +474,6 @@ static int soc_pcm_close(struct snd_pcm_substream *substream)
 	codec_dai->active--;
 	codec->active--;
 
-	/* Muting the DAC suppresses artifacts caused during digital
-	 * shutdown, for example from stopping clocks.
-	 */
-	snd_soc_dai_digital_mute(codec_dai, 1, substream->stream);
-
 	if (cpu_dai->driver->ops->shutdown)
 		cpu_dai->driver->ops->shutdown(substream, cpu_dai);
 
@@ -689,7 +684,7 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 	struct snd_soc_platform *platform = rtd->platform;
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct snd_soc_dai *codec_dai = rtd->codec_dai;
-	struct snd_soc_codec *codec = rtd->codec;
+	bool playback = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 1 : 0;
 
 	mutex_lock_nested(&rtd->pcm_mutex, rtd->pcm_subclass);
 
@@ -707,7 +702,8 @@ static int soc_pcm_hw_free(struct snd_pcm_substream *substream)
 	}
 
 	/* apply codec digital mute */
-	if (!codec->active)
+	if ((playback && codec_dai->playback_active == 1) ||
+			(!playback && codec_dai->capture_active == 1))
 		snd_soc_dai_digital_mute(codec_dai, 1, substream->stream);
 
 	/* free any machine hw params */
-- 
1.8.4
