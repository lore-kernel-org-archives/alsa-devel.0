From: Domen Puncer <domen@coderock.org>
Subject: snd_trident: Oops on rmmod (because trident_t *trident freed?)
Date: Fri, 10 Sep 2004 15:38:08 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040910133808.GB3546@masina.coderock.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi.

While 'debugging' my mpu401 problems i found this reproducible oops:


Unable to handle kernel paging request at virtual address cb97a124
 printing eip:
d0a274b5
*pde = 00030067
*pte = 0b97a000
Oops: 0000 [#1]
PREEMPT SMP DEBUG_PAGEALLOC
Modules linked in: ipv6 uhci_hcd ehci_hcd stv680 videodev ohci_hcd snd_trident snd_util_mem snd_mpu401_uart 8139too mii crc32 parport_pc ppdev parport snd_ens1371 snd_rawmidi snd_ac97_codec rtc
CPU:    0
EIP:    0060:[<d0a274b5>]    Not tainted VLI
EFLAGS: 00010002   (2.6.9-rc1-bk7-kjt2) 
EIP is at snd_trident_codec_write+0x35/0x1d0 [snd_trident]
eax: cb97a120   ebx: ffffffff   ecx: 00000000   edx: 00000000
esi: cb978014   edi: 00000000   ebp: c0fdbe18   esp: c0fdbdec
ds: 007b   es: 007b   ss: 0068
Process rmmod (pid: 4262, threadinfo=c0fdb000 task=c5eb6a40)
Stack: 0ffe9378 c02eb114 cb97a120 00000282 0000f200 cacc2e0c c0fdbe1c 00000282 
       d0a318ac cacc2e0c 00000002 c0fdbe30 d086915a 9f9fb114 cacc2e0c cacc2e0c 
       ccfaac0c c0fdbe40 d086c991 cacc2e0c ccfaad4c c0fdbe4c d086a64e cffe8e8c 
Call Trace:
 [<c010618a>] show_stack+0x7a/0x90
 [<c0106312>] show_registers+0x152/0x1c0
 [<c0106513>] die+0xf3/0x1e0
 [<c0118c35>] do_page_fault+0x1d5/0x562
 [<c0105df9>] error_code+0x2d/0x38
 [<d086915a>] snd_ac97_write+0x6a/0x70 [snd_ac97_codec]
 [<d086c991>] snd_ac97_powerdown+0x71/0x90 [snd_ac97_codec]
 [<d086a64e>] snd_ac97_dev_free+0xe/0x20 [snd_ac97_codec]
 [<c02eff73>] snd_device_free+0xb3/0x150
 [<c02f034f>] snd_device_free_all+0x5f/0xa0
 [<c02e9f46>] snd_card_free+0x156/0x330
 [<d0a2728f>] snd_trident_remove+0xf/0x40 [snd_trident]
 [<c0201f6e>] pci_device_remove+0x2e/0x30
 [<c02660a7>] device_release_driver+0x57/0x60
 [<c02660c9>] driver_detach+0x19/0x30
 [<c026654d>] bus_remove_driver+0x5d/0x90
 [<c0266a57>] driver_unregister+0x17/0x40
 [<c020217e>] pci_unregister_driver+0xe/0x20
 [<c013a1e6>] sys_delete_module+0x136/0x1a0
 [<c010538f>] syscall_call+0x7/0xb
Code: 53 bb ff ff ff ff 83 ec 20 66 89 55 e6 89 45 e8 8b 70 04 9c 8f 45 e0 fa b8 00 f0 ff ff 21 e0 ff 40 14 8d 86 0c 21 00 00 89 45 dc <81> 78 04 ad 4e ad de 0f 85 6d 01 00 00 8b 55 e0 f0 fe 8e 0c 21 
 <6>note: rmmod[4262] exited with preempt_count 1

And then a bunch of messages (with traces) similar to this:
Debug: sleeping function called from invalid context at include/linux/rwsem.h:43


Debugging:
objdump -d showed snd_trident_codec_write+0x35 is testing against
SPINLOCK_MAGIC, so i conclude "trident->reg_lock" is invalid.
Call trace shows some _free functions that might be the reason for that.


Hope it helps.


	Domen


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM. 
Deadline: Sept. 13. Go here: http://sf.net/ppc_contest.php
