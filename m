From: Lee Revell <rlrevell@joe-job.com>
Subject: Oops with ALSA CVS + kernel 2.6.9-rc3-mm3-VP-T3
Date: Fri, 29 Oct 2004 20:53:09 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1099097590.1579.11.camel@krustophenia.net>
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

I compiled and installed new ALSA modules and got this Oops when I did
'modprobe snd-emu10k1':

Unable to handle kernel NULL pointer dereference at virtual address 00000168
 printing eip:
de9c0495
*pde = 00000000
Oops: 0002 [#1]
PREEMPT
Modules linked in: snd_emu10k1 snd_rawmidi snd_seq_device snd_ac97_codec snd_pcm snd_timer snd_page_alloc snd_util_mem snd_hwdep snd realtime commoncap af_packet via_agp agpgart via_rhine mii crc32 usbhid uhci_hcd usbcore
CPU:    0
EIP:    0060:[<de9c0495>]    Not tainted VLI
EFLAGS: 00210282   (2.6.9-rc3-mm3-VP-T3)
EIP is at _snd_emu10k1_audigy_init_efx+0x13c5/0x1850 [snd_emu10k1]
eax: 00000000   ebx: c2818000   ecx: 0000005a   edx: c2818000
esi: c2818000   edi: c2818000   ebp: c3dc9e1c   esp: c3dc9dac
ds: 007b   es: 007b   ss: 0068   preempt: 00000001
Process modprobe (pid: 8561, threadinfo=c3dc9000 task=d3e23290)
Stack: c2818000 c3dc9e0c 00000006 00000065 000000c0 000000c0 060650c0 c2818000
       c3dc9e0c 00000006 00000064 000000c0 000000c0 060640c0 c20a1c1c c20a4000
       00000419 00000002 c20a1d1c c20a0000 c2818000 0000001e 0000005a 00000008
Call Trace:
 [<de9b2797>] snd_emu10k1_init+0x257/0x3b0 [snd_emu10k1]
 [<de9b31a4>] snd_emu10k1_create+0x494/0x590 [snd_emu10k1]
 [<de9b20c3>] snd_card_emu10k1_probe+0xc3/0x330 [snd_emu10k1]
 [<c02242a2>] pci_device_probe_static+0x42/0x60
 [<c02242f7>] __pci_device_probe+0x37/0x50
 [<c0224333>] pci_device_probe+0x23/0x50
 [<c024dab4>] bus_match+0x34/0x70
 [<c024dbf7>] driver_attach+0x67/0xa0
 [<c024e0fe>] bus_add_driver+0x8e/0xc0
 [<c024e6f6>] driver_register+0x56/0x60
 [<de974012>] alsa_card_emu10k1_init+0x12/0x16 [snd_emu10k1]
 [<c0224624>] pci_register_driver+0x94/0xc0
 [<de974012>] alsa_card_emu10k1_init+0x12/0x16 [snd_emu10k1]
 [<c01423b2>] sys_init_module+0x272/0x3d0
 [<c0106cb7>] syscall_call+0x7/0xb
Code: 13 04 00 00 68 c0 00 00 00 68 c0 00 00 00 6a 65 6a 06 8d 45 f0 50 8b 4d e0 51 e8 a7 d3 ff ff 8b 55 e0 8b 82 c0 00 00 00 8b 4d e8 <c7> 04 88 08 10 00 00 8b 82 c0 00 00 00 41 c7 04 88 00 00 ff ff



-- 
Lee Revell <rlrevell@joe-job.com>



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
