From: Mark Salyzyn <salyzyn@android.com>
Subject: [PATCH v2] ALSA: seq: resize buffer for overflow
Date: Fri,  6 Oct 2017 10:17:27 -0700
Message-ID: <20171006171731.88889-1-salyzyn@android.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: bunk@kernel.org, bunk@stusta.de, Mark Salyzyn <salyzyn@android.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Can not replicate, issue discovered in fuzzing. Stack trace below.
No functional or performance testing done regarding the fix.

Trap at (reformatted):

snd_seq_oss_readq_puts(struct seq_oss_readq *q, int dev,
                       unsigned char *data, int len)
{
    union evrec rec;
    int result;

    memset(&rec, 0, sizeof(rec));
    rec.c[0] = SEQ_MIDIPUTC;
    rec.c[2] = dev;

    while (len-- > 0) {
        rec.c[1] = *data++; // data is RBX  HERE

'data' pointer just passed a page boundary, so the buffer supplied
was short.  Caller must have been handed an ev->type equal to
SNDDRV_SEQ_EVENT_SYSEX, which resulted in handing off
ev->data.ext.ptr[ev->data.ext.len] buffer.  Intuited that the source
of the event and buffer was referenced in
snd_midi_event_encode_byte() passing a larger length than the
allocated buffer.

BUG: unable to handle kernel paging request at ffffc900008ab000
IP: [<ffffffff82e2fc05>] snd_seq_oss_readq_puts+0xd5/0x170 sound/core/seq/oss/seq_oss_readq.c:112
PGD 1da091067 PUD 1da092067
Oops: 0000 [#1] PREEMPT SMP KASAN
Dumping ftrace buffer:
   (ftrace buffer empty)
Modules linked in:
CPU: 1 PID: 3264 Comm: XXXXXXXX
Hardware name: XXXXXXXXXX
task: ffff8801cdd9e000 task.stack: ffff8801ce648000
RIP: 0010:[<ffffffff82e2fc05>]  [<ffffffff82e2fc05>] snd_seq_oss_readq_puts+0xd5/0x170 sound/core/seq/oss/seq_oss_readq.c:112
RSP: 0018:ffff8801ce64f1c0  EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffffc900008ab000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: ffffffff858e5780
RBP: ffff8801ce64f260 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 1ffff10039cc9df2 R12: 000000003fffffa4
R13: dffffc0000000000 R14: ffff8801ce64f238 R15: ffffc900008ab001
FS:  00007fe3d3d9e700(0000) GS:ffff8801db300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffc900008ab000 CR3: 00000001d19b7000 CR4: 00000000001406e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Stack:
 1ffff10039cc9e3b ffff8801ce64f1f8 ffff8801d0b9aa00 0000000041b58ab3
 ffffffff841daf3c ffffffff82e2fb30 0000000000000286 0000000000000005
 ffffffff838aa5d5 ffffffff861962c0 dffffc0000000000 ffff8801ce64f260
Call Trace:
 [<ffffffff82e2ebbe>] send_midi_event sound/core/seq/oss/seq_oss_midi.c:616 [inline]
 [<ffffffff82e2ebbe>] snd_seq_oss_midi_input+0x8ce/0xa70 sound/core/seq/oss/seq_oss_midi.c:535
 [<ffffffff82e2758d>] snd_seq_oss_event_input+0x15d/0x220 sound/core/seq/oss/seq_oss_event.c:439
 [<ffffffff82e0b650>] snd_seq_deliver_single_event.constprop.11+0x310/0x7c0 sound/core/seq/seq_clientmgr.c:621
 [<ffffffff82e0be16>] deliver_to_subscribers sound/core/seq/seq_clientmgr.c:676 [inline]
 [<ffffffff82e0be16>] snd_seq_deliver_event+0x316/0x740 sound/core/seq/seq_clientmgr.c:807
 [<ffffffff82e0cf9e>] snd_seq_kernel_client_dispatch+0x11e/0x150 sound/core/seq/seq_clientmgr.c:2314
 [<ffffffff82e31775>] dummy_input+0x235/0x320 sound/core/seq/seq_dummy.c:104
 [<ffffffff82e0b650>] snd_seq_deliver_single_event.constprop.11+0x310/0x7c0 sound/core/seq/seq_clientmgr.c:621
 [<ffffffff82e0bc2d>] snd_seq_deliver_event+0x12d/0x740 sound/core/seq/seq_clientmgr.c:818
 [<ffffffff82e0d0ed>] snd_seq_dispatch_event+0x11d/0x520 sound/core/seq/seq_clientmgr.c:892
 [<ffffffff82e1117e>] snd_seq_check_queue.part.3+0x38e/0x510 sound/core/seq/seq_queue.c:285
 [<ffffffff82e11d8d>] snd_seq_check_queue sound/core/seq/seq_queue.c:357 [inline]
 [<ffffffff82e11d8d>] snd_seq_enqueue_event+0x32d/0x3d0 sound/core/seq/seq_queue.c:363
 [<ffffffff82e0c444>] snd_seq_client_enqueue_event+0x204/0x3e0 sound/core/seq/seq_clientmgr.c:951
 [<ffffffff82e0cc55>] kernel_client_enqueue.part.10+0xb5/0xd0 sound/core/seq/seq_clientmgr.c:2251
 [<ffffffff82e0cd3f>] kernel_client_enqueue sound/core/seq/seq_clientmgr.c:2241 [inline]
 [<ffffffff82e0cd3f>] snd_seq_kernel_client_enqueue_blocking+0xcf/0x110 sound/core/seq/seq_clientmgr.c:2279
 [<ffffffff82e27f68>] insert_queue sound/core/seq/oss/seq_oss_rw.c:189 [inline]
 [<ffffffff82e27f68>] snd_seq_oss_write+0x538/0x850 sound/core/seq/oss/seq_oss_rw.c:148
 [<ffffffff82e1fab4>] odev_write+0x64/0x90 sound/core/seq/oss/seq_oss.c:177
 [<ffffffff8156ab43>] __vfs_write+0x103/0x680 fs/read_write.c:510
 [<ffffffff8156ec70>] vfs_write+0x170/0x4e0 fs/read_write.c:560
 [<ffffffff81572669>] SYSC_write fs/read_write.c:607 [inline]
 [<ffffffff81572669>] SyS_write+0xd9/0x1b0 fs/read_write.c:599
 [<ffffffff838aad85>] entry_SYSCALL_64_fastpath+0x23/0xc6
Code: 4d 9a eb 4e e8 2d aa 53 fe 4c 8d 7b 01 48 89 d8 48 89 d9 48 c1 e8 03 83 e1 07 42 0f b6 04 28 38 c8 7f 08 84 c0 0f 85 80 00 00 00 <41> 0f b6 47 ff 41 83 ec 01 48 8b b5 68 ff ff ff 48 8b bd 70 ff
RIP  [<ffffffff82e2fc05>] snd_seq_oss_readq_puts+0xd5/0x170 sound/core/seq/oss/seq_oss_readq.c:112
 RSP <ffff8801ce64f1c0>
CR2: ffffc900008ab000

Signed-off-by: Mark Salyzyn <salyzyn@android.com>

v2: removed nested locks in snd_midi_event_resize_buffer
---
 sound/core/seq/seq_midi_event.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/sound/core/seq/seq_midi_event.c b/sound/core/seq/seq_midi_event.c
index 90bbbdbeba03..ed3206ef0cd4 100644
--- a/sound/core/seq/seq_midi_event.c
+++ b/sound/core/seq/seq_midi_event.c
@@ -192,8 +192,7 @@ EXPORT_SYMBOL(snd_midi_event_no_status);
 /*
  * resize buffer
  */
-#if 0
-int snd_midi_event_resize_buffer(struct snd_midi_event *dev, int bufsize)
+static int snd_midi_event_resize_buffer(struct snd_midi_event *dev, int bufsize)
 {
 	unsigned char *new_buf, *old_buf;
 	unsigned long flags;
@@ -203,16 +202,13 @@ int snd_midi_event_resize_buffer(struct snd_midi_event *dev, int bufsize)
 	new_buf = kmalloc(bufsize, GFP_KERNEL);
 	if (new_buf == NULL)
 		return -ENOMEM;
-	spin_lock_irqsave(&dev->lock, flags);
 	old_buf = dev->buf;
 	dev->buf = new_buf;
 	dev->bufsize = bufsize;
 	reset_encode(dev);
-	spin_unlock_irqrestore(&dev->lock, flags);
 	kfree(old_buf);
 	return 0;
 }
-#endif  /*  0  */
 
 /*
  *  read bytes and encode to sequencer event if finished
@@ -297,6 +293,8 @@ int snd_midi_event_encode_byte(struct snd_midi_event *dev, int c,
 	} else 	if (dev->type == ST_SYSEX) {
 		if (c == MIDI_CMD_COMMON_SYSEX_END ||
 		    dev->read >= dev->bufsize) {
+			if (dev->read > dev->bufsize)
+				snd_midi_event_resize_buffer(dev, dev->read);
 			ev->flags &= ~SNDRV_SEQ_EVENT_LENGTH_MASK;
 			ev->flags |= SNDRV_SEQ_EVENT_LENGTH_VARIABLE;
 			ev->type = SNDRV_SEQ_EVENT_SYSEX;
-- 
2.14.2.920.gcf0c67979c-goog
