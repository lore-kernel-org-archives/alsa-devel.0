From: Chris Rankin <rankincj@yahoo.com>
Subject: Re: [BUG] Linux 2.6.20.1 - unable to handle kernel
	paging request - accessing freed memory?
Date: Thu, 1 Mar 2007 11:28:17 +0000 (GMT)
Message-ID: <462787.14129.qm@web52911.mail.yahoo.com>
References: <84144f020702270648o32fb15dfg4267f0cb5b50454a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from web52911.mail.yahoo.com (web52911.mail.yahoo.com
	[206.190.49.21])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 9701E3BB
	for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2007 12:28:18 +0100 (MET)
In-Reply-To: <84144f020702270648o32fb15dfg4267f0cb5b50454a@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Takashi Iwai <tiwai@suse.de>, Randy Dunlap <randy.dunlap@oracle.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

--- Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> Yeah, but the oops looks more like a reference counting problem with
> sysfs dentries. No harm in trying out the patch or reproducing without
> CONFIG_SCHED_SMT though.
> 

Nope, no difference. Again, this happened while trying to start World of Warcraft. However, this
time there is no snd-rtctimer module in the stack.

[drm] Initialized radeon 1.25.0 20060524 on minor 0
agpgart: Found an AGP 3.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V3 device at 0000:00:00.0 into 8x mode
agpgart: Putting AGP V3 device at 0000:01:00.0 into 8x mode
[drm] Setting GART location based on new memory map
[drm] Loading R200 Microcode
[drm] writeback test succeeded in 1 usecs
BUG: unable to handle kernel paging request at virtual address 6b6b6ceb
 printing eip:
c01300fb
*pde = 00000000
Oops: 0002 [#1]
PREEMPT SMP
Modules linked in: radeon drm pwc eeprom cpufreq_ondemand p4_clockmod speedstep_lib nfsd exportfs
ipv6 autofs4 nfs lockd sunrpc af_packet firmware_class binfmt_misc video1394 raw1394 video thermal
processor fan button ac lp eth1394 parport_pc parport nvram compat_ioctl32 videodev snd_usb_audio
snd_usb_lib v4l2_common v4l1_compat sd_mod snd_emu10k1_synth sg snd_emux_synth snd_seq_virmidi
snd_seq_midi_emul snd_emu10k1 snd_rawmidi snd_ac97_codec ac97_bus snd_seq_dummy snd_seq_oss
snd_seq_midi_event ohci1394 ieee1394 snd_seq snd_pcm_oss snd_mixer_oss snd_pcm sata_sil libata
snd_seq_device ehci_hcd uhci_hcd i2c_i801 snd_timer e7xxx_edac edac_mc e1000 serio_raw psmouse
i2c_core snd_page_alloc snd_util_mem snd_hwdep snd soundcore scsi_mod ide_cd intel_agp cdrom
agpgart pcspkr usbcore ext3 jbd
CPU:    0
EIP:    0060:[<c01300fb>]    Not tainted VLI
EFLAGS: 00010246   (2.6.20.1 #2)
EIP is at module_put+0x20/0x52
eax: 6b6b6ceb   ebx: 6b6b6b6b   ecx: 00000001   edx: ebd46000
esi: ecc56358   edi: 6b6b6b6b   ebp: ec25411c   esp: ebd46f58
ds: 007b   es: 007b   ss: 0068
Process udevd (pid: 7609, ti=ebd46000 task=f7fe6560 task.ti=ebd46000)
Stack: ec25a2fc c01839ee 00000010 ed6d669c f5cafc88 c015123b 00000000 00000000
       f7ff2208 ed6d669c f7561990 00000000 ed6d669c c014ed78 00000003 00000003
       f7561990 f7561a10 c014fd71 00000003 00000007 00000003 ebd46000 c0102bce
Call Trace:
 [<c01839ee>] sysfs_release+0x2d/0x4c
 [<c015123b>] __fput+0x96/0x13c
 [<c014ed78>] filp_close+0x51/0x58
 [<c014fd71>] sys_close+0x70/0xa7
 [<c0102bce>] sysenter_past_esp+0x5f/0x85
 [<c027007b>] __sched_text_start+0x75b/0x965
 [<c0270033>] __sched_text_start+0x713/0x965
 =======================
Code: 00 89 f0 83 c4 0c 5b 5e 5f 5d c3 53 89 c3 85 c0 74 49 b8 01 00 00 00 e8 73 49 fe ff e8 e3 5a
07 00 c1 e0 07 8d 84 18 80 01 00 00 <ff> 08 83 3b 02 75 0b 8b 83 88 05 00 00 e8 bd 45 fe ff b8 01
00
EIP: [<c01300fb>] module_put+0x20/0x52 SS:ESP 0068:ebd46f58
 <6>note: udevd[7609] exited with preempt_count 1
BUG: scheduling while atomic: udevd/0x10000001/7609
 [<c026f976>] __sched_text_start+0x56/0x965
 [<c011cc5e>] irq_exit+0x37/0x42
 [<c010d1d3>] smp_apic_timer_interrupt+0x70/0x79
 [<c010369c>] apic_timer_interrupt+0x28/0x30
 [<c0114afd>] __cond_resched+0x12/0x2c
 [<c0270889>] cond_resched+0x26/0x31
 [<c01404ba>] unmap_vmas+0x3d3/0x4df
 [<c0142cdd>] exit_mmap+0x7e/0x10a
 [<c0116bc3>] mmput+0x1d/0x78
 [<c011b30e>] do_exit+0x1b2/0x6d8
 [<c011007b>] sys_vm86+0x9d/0x21d
 [<c01040f7>] die+0x1f2/0x217
 [<c011180a>] do_page_fault+0x442/0x510
 [<c01113c8>] do_page_fault+0x0/0x510
 [<c02722ac>] error_code+0x7c/0x84
 [<c01300fb>] module_put+0x20/0x52
 [<c01839ee>] sysfs_release+0x2d/0x4c
 [<c015123b>] __fput+0x96/0x13c
 [<c014ed78>] filp_close+0x51/0x58
 [<c014fd71>] sys_close+0x70/0xa7
 [<c0102bce>] sysenter_past_esp+0x5f/0x85
 [<c027007b>] __sched_text_start+0x75b/0x965
 [<c0270033>] __sched_text_start+0x713/0x965
 =======================



	
	
		
___________________________________________________________ 
New Yahoo! Mail is the ultimate force in competitive emailing. Find out more at the Yahoo! Mail Championships. Plus: play games and win prizes. 
http://uk.rd.yahoo.com/evt=44106/*http://mail.yahoo.net/uk 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
