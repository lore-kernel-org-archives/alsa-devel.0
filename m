From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: sb8: Fix fall-through annotations
Date: Tue, 2 Oct 2018 11:56:36 +0200
Message-ID: <20181002095636.GA29253@embeddedor.com>
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
 sound/isa/sb/sb8_main.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/isa/sb/sb8_main.c b/sound/isa/sb/sb8_main.c
index 4817977..8288fae 100644
--- a/sound/isa/sb/sb8_main.c
+++ b/sound/isa/sb/sb8_main.c
@@ -130,13 +130,13 @@ static int snd_sb8_playback_prepare(struct snd_pcm_substream *substream)
 			chip->playback_format = SB_DSP_HI_OUTPUT_AUTO;
 			break;
 		}
-		/* fallthru */
+		/* fall through */
 	case SB_HW_201:
 		if (rate > 23000) {
 			chip->playback_format = SB_DSP_HI_OUTPUT_AUTO;
 			break;
 		}
-		/* fallthru */
+		/* fall through */
 	case SB_HW_20:
 		chip->playback_format = SB_DSP_LO_OUTPUT_AUTO;
 		break;
@@ -287,7 +287,7 @@ static int snd_sb8_capture_prepare(struct snd_pcm_substream *substream)
 			chip->capture_format = SB_DSP_HI_INPUT_AUTO;
 			break;
 		}
-		/* fallthru */
+		/* fall through */
 	case SB_HW_20:
 		chip->capture_format = SB_DSP_LO_INPUT_AUTO;
 		break;
@@ -387,7 +387,7 @@ irqreturn_t snd_sb8dsp_interrupt(struct snd_sb *chip)
 	case SB_MODE_PLAYBACK_16:	/* ok.. playback is active */
 		if (chip->hardware != SB_HW_JAZZ16)
 			break;
-		/* fallthru */
+		/* fall through */
 	case SB_MODE_PLAYBACK_8:
 		substream = chip->playback_substream;
 		if (chip->playback_format == SB_DSP_OUTPUT)
@@ -397,7 +397,7 @@ irqreturn_t snd_sb8dsp_interrupt(struct snd_sb *chip)
 	case SB_MODE_CAPTURE_16:
 		if (chip->hardware != SB_HW_JAZZ16)
 			break;
-		/* fallthru */
+		/* fall through */
 	case SB_MODE_CAPTURE_8:
 		substream = chip->capture_substream;
 		if (chip->capture_format == SB_DSP_INPUT)
-- 
2.7.4
