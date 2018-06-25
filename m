From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: seq: Fix UBSAN warning at
	SNDRV_SEQ_IOCTL_QUERY_NEXT_CLIENT ioctl
Date: Mon, 25 Jun 2018 11:19:09 +0200
Message-ID: <20180625091909.5915-2-tiwai@suse.de>
References: <20180625091909.5915-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 9039C267735
 for <alsa-devel@alsa-project.org>; Mon, 25 Jun 2018 11:19:12 +0200 (CEST)
In-Reply-To: <20180625091909.5915-1-tiwai@suse.de>
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
Cc: air icy <icytxw@gmail.com>
List-Id: alsa-devel@alsa-project.org

The kernel may spew a WARNING with UBSAN undefined behavior at
handling ALSA sequencer ioctl SNDRV_SEQ_IOCTL_QUERY_NEXT_CLIENT:

UBSAN: Undefined behaviour in sound/core/seq/seq_clientmgr.c:2007:14
signed integer overflow:
2147483647 + 1 cannot be represented in type 'int'
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x122/0x1c8 lib/dump_stack.c:113
 ubsan_epilogue+0x12/0x86 lib/ubsan.c:159
 handle_overflow+0x1c2/0x21f lib/ubsan.c:190
  __ubsan_handle_add_overflow+0x2a/0x31 lib/ubsan.c:198
 snd_seq_ioctl_query_next_client+0x1ac/0x1d0 sound/core/seq/seq_clientmgr.c:2007
 snd_seq_ioctl+0x264/0x3d0 sound/core/seq/seq_clientmgr.c:2144
 ....

It happens only when INT_MAX is passed there, as we're incrementing it
unconditionally.  So the fix is trivial, check the value with
INT_MAX.  Although the bug itself is fairly harmless, it's better to
fix it so that fuzzers won't hit this again later.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=200211
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_clientmgr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index 61a07fe34cd2..56ca78423040 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -2004,7 +2004,8 @@ static int snd_seq_ioctl_query_next_client(struct snd_seq_client *client,
 	struct snd_seq_client *cptr = NULL;
 
 	/* search for next client */
-	info->client++;
+	if (info->client < INT_MAX)
+		info->client++;
 	if (info->client < 0)
 		info->client = 0;
 	for (; info->client < SNDRV_SEQ_MAX_CLIENTS; info->client++) {
-- 
2.17.1
