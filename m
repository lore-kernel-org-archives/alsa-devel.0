From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] ALSA: usb: Mark expected switch fall-through
Date: Wed, 1 Aug 2018 11:14:16 -0500
Message-ID: <20180801161416.GA8820@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-Id: alsa-devel@alsa-project.org

In preparation to enabling -Wimplicit-fallthrough, mark switch cases
where we are expecting to fall through.

Addresses-Coverity-ID: 115084 ("Missing break in switch")
Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 sound/usb/pcm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/usb/pcm.c b/sound/usb/pcm.c
index bbc7116..3828471 100644
--- a/sound/usb/pcm.c
+++ b/sound/usb/pcm.c
@@ -1694,6 +1694,7 @@ static int snd_usb_substream_playback_trigger(struct snd_pcm_substream *substrea
 	switch (cmd) {
 	case SNDRV_PCM_TRIGGER_START:
 		subs->trigger_tstamp_pending_update = true;
+		/* fall through */
 	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
 		subs->data_endpoint->prepare_data_urb = prepare_playback_urb;
 		subs->data_endpoint->retire_data_urb = retire_playback_urb;
-- 
2.7.4
