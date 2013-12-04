From: Nicolin Chen <b42378@freescale.com>
Subject: [PATCH v2 2/2] ASoC: soc-pcm: Drop the redundant
	snd_soc_dai_digital_mute() in soc_pcm_close()
Date: Wed, 4 Dec 2013 11:18:37 +0800
Message-ID: <030f461e95c8d85413f5350e4414c076d1a41e90.1386126119.git.b42378@freescale.com>
References: <cover.1386126119.git.b42378@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0249.outbound.messaging.microsoft.com [213.199.154.249])
 by alsa0.perex.cz (Postfix) with ESMTP id 6C6C6265309
 for <alsa-devel@alsa-project.org>; Wed,  4 Dec 2013 04:18:21 +0100 (CET)
In-Reply-To: <cover.1386126119.git.b42378@freescale.com>
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

This patch removed the redundant snd_soc_dai_digital_mute() in close() since
it's better to mute in hw_free() which's slightly earlier and symmetrical for
the case of reconfiguration: 'aplay 44k1.wav 48k.wav', for example, will be
open()->hw_params()->prepare(unmute)->playi1ng->hw_free(mute)->hw_params()->
parepare(unmute)->playing->hw_free(mute)->close()

Signed-off-by: Nicolin Chen <b42378@freescale.com>
---
 sound/soc/soc-pcm.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index 3774471..1c3cd5e 100644
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
 
-- 
1.8.4
