From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/3] ALSA: ASoC: Use codec digital mute when
	stopping playback
Date: Mon,  8 Sep 2008 16:13:54 +0100
Message-ID: <1220886834-14504-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20080908151250.GA14434@rakim.wolfsonmicro.main>
	<1220886834-14504-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1220886834-14504-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 55E2A243CE
	for <alsa-devel@alsa-project.org>;
	Mon,  8 Sep 2008 17:13:55 +0200 (CEST)
In-Reply-To: <1220886834-14504-2-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Muting the DAC masks artefacts introduced as the digital stream shuts
down, for example when the input stops being clocked.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-core.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1563cee..ad38113 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -340,6 +340,12 @@ static int soc_codec_close(struct snd_pcm_substream *substream)
 	}
 	codec->active--;
 
+	/* Muting the DAC suppresses artifacts caused during digital
+	 * shutdown, for example from stopping clocks.
+	 */
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		snd_soc_dai_digital_mute(codec_dai, 1);
+
 	if (cpu_dai->ops.shutdown)
 		cpu_dai->ops.shutdown(substream);
 
-- 
1.5.6.5
