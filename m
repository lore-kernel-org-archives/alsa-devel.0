From: Peter L Jones <peter@drealm.org.uk>
Subject: 2.5.40bk4 "bad"!
Date: Sun, 6 Oct 2002 00:56:08 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200210060056.08839@advent.drealm.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi there,

Is this a known problem?

kernel: bad: scheduling while atomic!
kernel: Call Trace:
kernel:  [schedule+61/724] schedule+0x3d/0x2d4
kernel:  [common_interrupt+24/32] common_interrupt+0x18/0x20
kernel:  [interruptible_sleep_on+91/144] interruptible_sleep_on+0x5b/0x90
kernel:  [default_wake_function+0/52] default_wake_function+0x0/0x34
kernel:  [<cb8d5bce>] snd_seq_cell_alloc+0x9a/0x15c [snd-seq]
kernel:  [<cb8d5d09>] snd_seq_event_dup+0x79/0x1e8 [snd-seq]
kernel:  [<cb8d6773>] snd_seq_enqueue_event+0xa3/0xac [snd-seq]
kernel:  [<cb8d2ed8>] snd_seq_client_enqueue_event+0xbc/0xf4 [snd-seq]
kernel:  [<cb8d311d>] snd_seq_write+0x1a9/0x1ec [snd-seq]
kernel:  [vfs_write+177/304] vfs_write+0xb1/0x130
kernel:  [sys_write+42/60] sys_write+0x2a/0x3c
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

Oh, and also:

kernel: Debug: sleeping function called from illegal context at 
include/asm/semaphore.h:119
kernel: Call Trace:
kernel:  [__might_sleep+84/96] __might_sleep+0x54/0x60
kernel:  [<cb8d9fa0>] .rodata+0x7e0/0x1ae0 [snd-seq]
kernel:  [<cb8d5be7>] snd_seq_cell_alloc+0xb3/0x15c [snd-seq]
kernel:  [<cb8d9fa0>] .rodata+0x7e0/0x1ae0 [snd-seq]
kernel:  [<cb8d5d09>] snd_seq_event_dup+0x79/0x1e8 [snd-seq]
kernel:  [<cb8d6773>] snd_seq_enqueue_event+0xa3/0xac [snd-seq]
kernel:  [<cb8d2ed8>] snd_seq_client_enqueue_event+0xbc/0xf4 [snd-seq]
kernel:  [<cb8d311d>] snd_seq_write+0x1a9/0x1ec [snd-seq]
kernel:  [vfs_write+177/304] vfs_write+0xb1/0x130
kernel:  [sys_write+42/60] sys_write+0x2a/0x3c
kernel:  [syscall_call+7/11] syscall_call+0x7/0xb

Ta.

-- Peter



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
