From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH utils 2/2] aplay: Fix uninterruptible aplay
Date: Wed, 29 Apr 2015 18:05:50 +0200
Message-ID: <1430323550-17662-2-git-send-email-tiwai@suse.de>
References: <1430323550-17662-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8AB1F26060B
 for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2015 18:05:51 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4DE8BABBB
 for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2015 16:05:51 +0000 (UTC)
In-Reply-To: <1430323550-17662-1-git-send-email-tiwai@suse.de>
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

When aplay is invoked to play from stdin, it can't be terminated by
normal signals like SIGTERM or SIGINT.  It's because our signal
handler tries to trap as much as possible while the stalling point is
not in the PCM loop but rather the file I/O.

For fixing this, leave our signal handler once when a signal is
received and snd_pcm_abort() is called.  At the next hit, it shall be
handled normally.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 aplay/aplay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/aplay/aplay.c b/aplay/aplay.c
index dfa1a0a95867..459f7dd6f667 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -399,7 +399,7 @@ static void signal_handler(int sig)
 		handle = NULL;
 		prg_exit(EXIT_FAILURE);
 	}
-	signal(sig, signal_handler);
+	signal(sig, SIG_DFL);
 }
 
 /* call on SIGUSR1 signal. */
-- 
2.3.6
