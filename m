From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: intel8x0: Fix fall-through annotations
Date: Wed, 3 Oct 2018 12:38:36 +0200
Message-ID: <20181003103836.GA21649@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

Replace "fallthru" with a proper "fall through" annotation.

This fix is part of the ongoing efforts to enabling
-Wimplicit-fallthrough

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/pci/intel8x0.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/pci/intel8x0.c b/sound/pci/intel8x0.c
index 9517f9b..ffddcdf 100644
--- a/sound/pci/intel8x0.c
+++ b/sound/pci/intel8x0.c
@@ -825,7 +825,7 @@ static int snd_intel8x0_pcm_trigger(struct snd_pcm_substream *substream, int cmd
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_RESUME:
 		ichdev->suspended = 0;
-		/* fallthru */
+		/* fall through */
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		val = ICH_IOCE | ICH_STARTBM;
@@ -833,7 +833,7 @@ static int snd_intel8x0_pcm_trigger(struct snd_pcm_substream *substream, int cmd
 		break;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 		ichdev->suspended = 1;
-		/* fallthru */
+		/* fall through */
 	case SNDRV_PCM_TRIGGER_STOP:
 		val = 0;
 		break;
@@ -867,7 +867,7 @@ static int snd_intel8x0_ali_trigger(struct snd_pcm_substream *substream, int cmd
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_RESUME:
 		ichdev->suspended = 0;
-		/* fallthru */
+		/* fall through */
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
@@ -884,7 +884,7 @@ static int snd_intel8x0_ali_trigger(struct snd_pcm_substream *substream, int cmd
 		break;
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 		ichdev->suspended = 1;
-		/* fallthru */
+		/* fall through */
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
 		/* pause */
-- 
2.7.4
