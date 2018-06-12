From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] pcm: dmix: Fix hwptr updates at status call
Date: Tue, 12 Jun 2018 13:56:50 +0200
Message-ID: <20180612115650.15965-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 47553267252
 for <alsa-devel@alsa-project.org>; Tue, 12 Jun 2018 13:56:53 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext-too.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id A9720AC71
 for <alsa-devel@alsa-project.org>; Tue, 12 Jun 2018 11:56:52 +0000 (UTC)
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

In the commit 38a2d2eda880 ("pcm: dmix: Do not discard slave reported
delay in status result"), the PCM dmix hwptr update code was rewritten
to follow the slave PCM hwptr update.  This is based on the similar
change in PCM dshare, the commit faf53c197cab.

There was a bug in the commit 38a2d2eda880 regarding the PCM state
change, and it was addressed in commit 3752e6b8733d ("pcm: dmix: Fix
the inconsistent PCM state").  However, we've hit yet another bug in
this commit.  Namely, the hwptr update was forgotten in the
snd_pcm_dmix_sync_ptr0() function.  So the hwptr value passed from
snd_pcm_dmix_status() isn't properly stored, and it screws up at some
long run occasionally.

This patch covers the bug by replacing with the right value.

Fixes: 38a2d2eda880 ("pcm: dmix: Do not discard slave reported delay in status result")
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=200013
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 src/pcm/pcm_dmix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/pcm/pcm_dmix.c b/src/pcm/pcm_dmix.c
index c65259beb1d6..3a951f533655 100644
--- a/src/pcm/pcm_dmix.c
+++ b/src/pcm/pcm_dmix.c
@@ -398,7 +398,7 @@ static int snd_pcm_dmix_sync_ptr0(snd_pcm_t *pcm, snd_pcm_uframes_t slave_hw_ptr
 	snd_pcm_sframes_t diff;
 	
 	old_slave_hw_ptr = dmix->slave_hw_ptr;
-	dmix->slave_hw_ptr = *dmix->spcm->hw.ptr;
+	dmix->slave_hw_ptr = slave_hw_ptr;
 	diff = slave_hw_ptr - old_slave_hw_ptr;
 	if (diff == 0)		/* fast path */
 		return 0;
-- 
2.17.1
