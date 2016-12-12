From: Nobutaka Okabe <nob77413@gmail.com>
Subject: [PATCH] ALSA: usb-audio: Eliminate noise at the start
	of DSD playback.
Date: Tue, 13 Dec 2016 02:52:58 +0900
Message-ID: <1481565178-2199-1-git-send-email-nob77413@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f66.google.com (mail-pg0-f66.google.com [74.125.83.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 9BC31266499
 for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2016 18:53:16 +0100 (CET)
Received: by mail-pg0-f66.google.com with SMTP id x23so1642764pgx.3
 for <alsa-devel@alsa-project.org>; Mon, 12 Dec 2016 09:53:16 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Nobutaka Okabe <nob77413@gmail.com>
List-Id: alsa-devel@alsa-project.org

[Problem]
In some USB DACs, a terrible pop noise comes to be heard
at the start of DSD playback (in the following situations).

- play first DSD track
- change from PCM track to DSD track
- change from DSD64 track to DSD128 track (and etc...)
- seek DSD track
- Fast-Forward/Rewind DSD track

[Cause]
At the start of playback, there is a little silence.
The silence bit pattern "0x69" is required on DSD mode,
but it is not like that.

[Solution]
This patch adds DSD silence pattern to the endpoint settings.

Signed-off-by: Nobutaka Okabe <nob77413@gmail.com>
---
 sound/usb/endpoint.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 57b0d99..a2cdf33 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -638,7 +638,21 @@ static int data_ep_set_params(struct snd_usb_endpoint *ep,
 
 	ep->datainterval = fmt->datainterval;
 	ep->stride = frame_bits >> 3;
-	ep->silence_value = pcm_format == SNDRV_PCM_FORMAT_U8 ? 0x80 : 0;
+
+	switch (pcm_format) {
+	case SNDRV_PCM_FORMAT_U8:
+		ep->silence_value = 0x80;
+		break;
+	case SNDRV_PCM_FORMAT_DSD_U8:
+	case SNDRV_PCM_FORMAT_DSD_U16_LE:
+	case SNDRV_PCM_FORMAT_DSD_U32_LE:
+	case SNDRV_PCM_FORMAT_DSD_U16_BE:
+	case SNDRV_PCM_FORMAT_DSD_U32_BE:
+		ep->silence_value = 0x69;
+		break;
+	default:
+		ep->silence_value = 0;
+	}
 
 	/* assume max. frequency is 50% higher than nominal */
 	ep->freqmax = ep->freqn + (ep->freqn >> 1);
-- 
2.7.4
