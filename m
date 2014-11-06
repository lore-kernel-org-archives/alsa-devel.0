From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH alsa-lib] pcm: dmix: Don't ignore
	SND_TIMER_EVENT_MSTOP
Date: Thu,  6 Nov 2014 12:14:13 +0100
Message-ID: <1415272453-31507-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id ECFFE26516D
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 12:14:15 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 70D03ADA8
 for <alsa-devel@alsa-project.org>; Thu,  6 Nov 2014 11:14:15 +0000 (UTC)
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
List-Id: alsa-devel@alsa-project.org

When a slave PCM gets an error like XRUN, it stops and notifies with
SND_TIMER_EVENT_MSTOP event.  But the current code filters out this
type and eventually hang due to the empty timer queue.  The fix is to
just add this event type to the filter bit mask.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/pcm/pcm_direct.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index 8e37bcba5e19..195fddf06cda 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -1148,6 +1148,7 @@ int snd_pcm_direct_initialize_poll_fd(snd_pcm_direct_t *dmix)
 
 	dmix->timer_events = (1<<SND_TIMER_EVENT_MSUSPEND) |
 			     (1<<SND_TIMER_EVENT_MRESUME) |
+			     (1<<SND_TIMER_EVENT_MSTOP) |
 			     (1<<SND_TIMER_EVENT_STOP);
 
 	/*
-- 
2.1.3
