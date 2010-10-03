From: <martin@ti.com>
Subject: [PATCH 1/1] ALSA: ASoc: DaVinci Delay start of ASP to
	trigger
Date: Sun, 3 Oct 2010 16:44:19 -0500
Message-ID: <1286142259-6625-1-git-send-email-martin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id B9AFB103871
	for <alsa-devel@alsa-project.org>;
	Sun,  3 Oct 2010 23:45:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: davinci-linux-open-source@linux.davincidsp.com, broonie@sirena.org.uk, Martin Ambrose <martin@ti.com>, Troy Kisky <troy.kisky@boundarydevices.com>
List-Id: alsa-devel@alsa-project.org

From: Troy Kisky <troy.kisky@boundarydevices.com>

Since only 4 mainline ASoC codecs support the trigger
callback, we cannot rely upon them stopping the frame clock
if they are master and must assume it is running even if the
sound is paused. Thus we cannot start the ASP until the trigger
method.

Signed-off-by: Troy Kisky <troy.kisky@boundarydevices.com>
Signed-off-by: Martin Ambrose <martin@ti.com>

---
 sound/soc/davinci/davinci-i2s.c |    6 ------
 1 files changed, 0 insertions(+), 6 deletions(-)

diff --git a/sound/soc/davinci/davinci-i2s.c b/sound/soc/davinci/davinci-i2s.c
index 9e8932a..a66c237 100644
--- a/sound/soc/davinci/davinci-i2s.c
+++ b/sound/soc/davinci/davinci-i2s.c
@@ -572,10 +572,6 @@ static int davinci_i2s_prepare(struct snd_pcm_substream *substream,
 	struct davinci_mcbsp_dev *dev = dai->private_data;
 	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
 	davinci_mcbsp_stop(dev, playback);
-	if ((dev->pcr & DAVINCI_MCBSP_PCR_FSXM) == 0) {
-		/* codec is master */
-		davinci_mcbsp_start(dev, substream);
-	}
 	return 0;
 }
 
@@ -585,8 +581,6 @@ static int davinci_i2s_trigger(struct snd_pcm_substream *substream, int cmd,
 	struct davinci_mcbsp_dev *dev = dai->private_data;
 	int ret = 0;
 	int playback = (substream->stream == SNDRV_PCM_STREAM_PLAYBACK);
-	if ((dev->pcr & DAVINCI_MCBSP_PCR_FSXM) == 0)
-		return 0;	/* return if codec is master */
 
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
-- 
1.7.0.4
