From: Fabio Estevam <festevam@gmail.com>
Subject: [PATCH] ASoC: fsl: fsl_ssi: Fix simultaneous capture
	and playback
Date: Mon, 23 Sep 2013 01:08:25 -0300
Message-ID: <1379909305-23572-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ye0-f178.google.com (mail-ye0-f178.google.com
 [209.85.213.178])
 by alsa0.perex.cz (Postfix) with ESMTP id C7BE726513E
 for <alsa-devel@alsa-project.org>; Mon, 23 Sep 2013 06:08:37 +0200 (CEST)
Received: by mail-ye0-f178.google.com with SMTP id m5so1006289yen.23
 for <alsa-devel@alsa-project.org>; Sun, 22 Sep 2013 21:08:36 -0700 (PDT)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, b42378@freescale.com
List-Id: alsa-devel@alsa-project.org

From: Fabio Estevam <fabio.estevam@freescale.com>

When doing simultaneous capture and playback on a mx6 board we get the following
error:

$ arecord -f cd  | aplay -f cd
imx-sgtl5000 sound.13: set sample size in capture stream first
fsl-ssi-dai 2028000.ssi: ASoC: can't open interface 2028000.ssi: -11
ALSA lib pcm_dmix.c:1018:(snd_pcm_dmix_
open) unable to open slave
aplay: main:660: audio open error: Device or resource busy
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo

The 'arecord -f cd  | aplay -f cd' always trigger cause the 
'if (!first_runtime->sample_bits)' block to be true which returns an error.

Adjust the logic inside fsl_ssi_startup(), so that we do not always hit the 
error when playing  'arecord | aplay' line for the first time.

Reported-by: Chris Clepper <cgclepper@gmail.com>
Suggested-by: Nicolin Chen <b42378@freescale.com>
Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 sound/soc/fsl/fsl_ssi.c | 15 ++++-----------
 1 file changed, 4 insertions(+), 11 deletions(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index 6ac8730..cdbb641 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -469,19 +469,12 @@ static int fsl_ssi_startup(struct snd_pcm_substream *substream,
 			 * parameters, then the second stream may be
 			 * constrained to the wrong sample rate or size.
 			 */
-			if (!first_runtime->sample_bits) {
-				dev_err(substream->pcm->card->dev,
-					"set sample size in %s stream first\n",
-					substream->stream ==
-					SNDRV_PCM_STREAM_PLAYBACK
-					? "capture" : "playback");
-				return -EAGAIN;
-			}
-
-			snd_pcm_hw_constraint_minmax(substream->runtime,
-				SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
+			if (first_runtime->sample_bits) {
+				snd_pcm_hw_constraint_minmax(substream->runtime,
+						SNDRV_PCM_HW_PARAM_SAMPLE_BITS,
 				first_runtime->sample_bits,
 				first_runtime->sample_bits);
+			}
 		}
 
 		ssi_private->second_stream = substream;
-- 
1.8.1.2
