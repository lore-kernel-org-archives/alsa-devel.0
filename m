From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: seq: Break too long mutex context in the
	write loop
Date: Mon, 15 Jul 2019 23:06:44 +0200
Message-ID: <20190715210644.24299-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 545E5F802BC
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2019 23:06:47 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id 92BF8ABC2
 for <alsa-devel@alsa-project.org>; Mon, 15 Jul 2019 21:06:46 +0000 (UTC)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The fix for the racy writes and ioctls to sequencer widened the
application of client->ioctl_mutex to the whole write loop.  Although
it does unlock/relock for the lengthy operation like the event dup,
the loop keeps the ioctl_mutex for the whole time in other
situations.  This may take quite long time if the user-space would
give a huge buffer, and this is a likely cause of some weird behavior
spotted by syzcaller fuzzer.

This patch puts a simple workaround, just adding a mutex break in the
loop when a large number of events have been processed.  This
shouldn't hit any performance drop because the threshold is set high
enough for usual operations.

Fixes: 7bd800915677 ("ALSA: seq: More protection for concurrent write and ioctl races")
Reported-by: syzbot+97aae04ce27e39cbfca9@syzkaller.appspotmail.com
Reported-by: syzbot+4c595632b98bb8ffcc66@syzkaller.appspotmail.com
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/core/seq/seq_clientmgr.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/sound/core/seq/seq_clientmgr.c b/sound/core/seq/seq_clientmgr.c
index a60e7a17f0b8..7737b2670064 100644
--- a/sound/core/seq/seq_clientmgr.c
+++ b/sound/core/seq/seq_clientmgr.c
@@ -1021,7 +1021,7 @@ static ssize_t snd_seq_write(struct file *file, const char __user *buf,
 {
 	struct snd_seq_client *client = file->private_data;
 	int written = 0, len;
-	int err;
+	int err, handled;
 	struct snd_seq_event event;
 
 	if (!(snd_seq_file_flags(file) & SNDRV_SEQ_LFLG_OUTPUT))
@@ -1034,6 +1034,8 @@ static ssize_t snd_seq_write(struct file *file, const char __user *buf,
 	if (!client->accept_output || client->pool == NULL)
 		return -ENXIO;
 
+ repeat:
+	handled = 0;
 	/* allocate the pool now if the pool is not allocated yet */ 
 	mutex_lock(&client->ioctl_mutex);
 	if (client->pool->size > 0 && !snd_seq_write_pool_allocated(client)) {
@@ -1093,12 +1095,19 @@ static ssize_t snd_seq_write(struct file *file, const char __user *buf,
 						   0, 0, &client->ioctl_mutex);
 		if (err < 0)
 			break;
+		handled++;
 
 	__skip_event:
 		/* Update pointers and counts */
 		count -= len;
 		buf += len;
 		written += len;
+
+		/* let's have a coffee break if too many events are queued */
+		if (++handled >= 200) {
+			mutex_unlock(&client->ioctl_mutex);
+			goto repeat;
+		}
 	}
 
  out:
-- 
2.16.4
