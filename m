From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] pcm: direct: Fix deadlock in poll_descriptors
Date: Mon, 16 Jan 2017 16:26:30 +0100
Message-ID: <20170116152630.4448-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F07B267058
 for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2017 16:26:31 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 09ED4AAC4
 for <alsa-devel@alsa-project.org>; Mon, 16 Jan 2017 15:26:31 +0000 (UTC)
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

The recent change in PCM direct plugins to check XRUN in
poll_descriptors callback caused a regression; as consequence, the
whole playback hangs up.

The culprit is a mutex dead lock by the call in snd_pcm_state() inside
the new snd_pcm_direct_poll_descriptors().  The poll_descriptors code
path is protected with pcm mutex, thus an unlocked version
(__snd_pcm_state()) has to be used inside the callback instead.

Fixes: 789ee39727a1 ("pcm: direct: check state before enter poll on timer")
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/pcm/pcm_direct.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/pcm/pcm_direct.c b/src/pcm/pcm_direct.c
index f4d7c3f2f284..e4bef7860d01 100644
--- a/src/pcm/pcm_direct.c
+++ b/src/pcm/pcm_direct.c
@@ -676,7 +676,8 @@ int snd_pcm_direct_poll_descriptors(snd_pcm_t *pcm, struct pollfd *pfds,
 	}
 
 	/* this will also evaluate slave state and enter xrun if necessary */
-	switch (snd_pcm_state(pcm)) {
+	/* using __snd_pcm_state() since this function is called inside lock */
+	switch (__snd_pcm_state(pcm)) {
 	case SND_PCM_STATE_XRUN:
 		return -EPIPE;
 	default:
-- 
2.11.0
