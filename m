From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 08/17] ALSA: line6: Don't handle PCM trigger
	for other cards
Date: Mon, 19 Jan 2015 16:54:42 +0100
Message-ID: <1421682891-11594-9-git-send-email-tiwai@suse.de>
References: <1421682891-11594-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 0F8DB2610A3
 for <alsa-devel@alsa-project.org>; Mon, 19 Jan 2015 16:55:03 +0100 (CET)
In-Reply-To: <1421682891-11594-1-git-send-email-tiwai@suse.de>
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, Chris Rorvick <chris@rorvick.com>
List-Id: alsa-devel@alsa-project.org

Otherwise it oopses.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/usb/line6/pcm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/usb/line6/pcm.c b/sound/usb/line6/pcm.c
index 520cf540e83c..932cc7e194e2 100644
--- a/sound/usb/line6/pcm.c
+++ b/sound/usb/line6/pcm.c
@@ -233,6 +233,8 @@ int snd_line6_trigger(struct snd_pcm_substream *substream, int cmd)
 	clear_bit(LINE6_INDEX_PREPARED, &line6pcm->flags);
 
 	snd_pcm_group_for_each_entry(s, substream) {
+		if (s->pcm->card != substream->pcm->card)
+			continue;
 		switch (s->stream) {
 		case SNDRV_PCM_STREAM_PLAYBACK:
 			err = snd_line6_playback_trigger(line6pcm, cmd);
-- 
2.2.1
