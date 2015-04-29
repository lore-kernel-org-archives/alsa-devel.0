From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH utils 1/2] aplay: Fix type for signal flag
Date: Wed, 29 Apr 2015 18:05:49 +0200
Message-ID: <1430323550-17662-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 8A3102605D7
 for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2015 18:05:51 +0200 (CEST)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 4DE51AB1C
 for <alsa-devel@alsa-project.org>; Wed, 29 Apr 2015 16:05:51 +0000 (UTC)
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

A flag used in signal handlers has to be a special atomic type,
volatile sig_atomic_t.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 aplay/aplay.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/aplay/aplay.c b/aplay/aplay.c
index e58e1bcbdd7e..dfa1a0a95867 100644
--- a/aplay/aplay.c
+++ b/aplay/aplay.c
@@ -107,7 +107,7 @@ static snd_pcm_stream_t stream = SND_PCM_STREAM_PLAYBACK;
 static int mmap_flag = 0;
 static int interleaved = 1;
 static int nonblock = 0;
-static int in_aborting = 0;
+static volatile sig_atomic_t in_aborting = 0;
 static u_char *audiobuf = NULL;
 static snd_pcm_uframes_t chunk_size = 0;
 static unsigned period_time = 0;
-- 
2.3.6
