From: Lee Revell <rlrevell@joe-job.com>
Subject: Oops caused by flashplayer using OSS emulation
Date: Sat, 18 Sep 2004 19:09:15 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1095548954.9049.17.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

It's possible that this bug no longer exists, I believe this is a CVS
version of ALSA from between 1.0.5a and 1.0.6.  This was caused by a
flash applet in mozilla.

Unable to handle kernel NULL pointer dereference at virtual address 00000000
 printing eip:
c02d1d4f
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
Modules linked in: snd_pcm_oss snd_mixer_oss af_packet realtime snd_emu10k1 snd_rawmidi snd_pcm snd_timer snd_seq_device snd_ac97_codec snd_page_alloc snd_util_mem snd_hwdep snd via_agp agpgart via_rhine mii crc32 usbhid uhci_hcd usbcore
CPU:    0
EIP:    0060:[<c02d1d4f>]    Not tainted VLI
EFLAGS: 00010246   (2.6.9-rc1-bk12-VP-S0)
EIP is at __sched_text_end+0xb1f/0xfd8
eax: 00000000   ebx: 00002000   ecx: 00002000   edx: d3782000
esi: 09873968   edi: 00000000   ebp: d3783df8   esp: d3783de8
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process mozilla-bin (pid: 9158, threadinfo=d3782000 task=dda208c0)
Stack: 00000000 00002000 00002000 09873968 d3783e14 c021f8ce 00000000 09873968
       00002000 00000000 d9fc7400 d3783e3c de8beada 00000000 09873968 00002000
       00000000 00000001 00000000 d9fc7400 c15a0a60 d3783eb8 de8beffe c15a0a60
Call Trace:
 [<c021f8ce>] copy_from_user+0x5e/0x90
 [<de8beada>] snd_pcm_lib_write_transfer+0x7a/0x90 [snd_pcm]
 [<de8beffe>] snd_pcm_lib_write1+0x50e/0x8d0 [snd_pcm]
 [<de8b52c8>] snd_pcm_post_prepare+0x8/0x30 [snd_pcm]
 [<de8b43f8>] snd_pcm_action_single+0x48/0x50 [snd_pcm]
 [<c02d0b09>] cond_resched+0x9/0x70
 [<de8bf3c9>] snd_pcm_lib_write+0x9/0xb0 [snd_pcm]
 [<de8bf440>] snd_pcm_lib_write+0x80/0xb0 [snd_pcm]
 [<de8bea60>] snd_pcm_lib_write_transfer+0x0/0x90 [snd_pcm]
 [<de9da08e>] snd_pcm_oss_write3+0xae/0xe0 [snd_pcm_oss]
 [<de9da44b>] snd_pcm_oss_write2+0xbb/0xd0 [snd_pcm_oss]
 [<de9da5d6>] snd_pcm_oss_write1+0x176/0x1b0 [snd_pcm_oss]
 [<de9dceb2>] snd_pcm_oss_write+0x42/0x80 [snd_pcm_oss]
 [<c017037c>] vfs_write+0xbc/0x110
 [<c0170481>] sys_write+0x41/0x70
 [<c0106d97>] syscall_call+0x7/0xb
Code: ff 31 c0 e9 3e da f4 ff b0 01 e9 37 da f4 ff 01 c1 e9 7a da f4 ff 8d 4c 88 00 e9 71 da f4 ff 01 c1 eb 04 8d 4c 88 00 51 50 31 c0 <f3> aa 58 59 e9 9c da f4 ff b8 f2 ff ff ff e9 6d 69 f5 ff b8 f2





-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
