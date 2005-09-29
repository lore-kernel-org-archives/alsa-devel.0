From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001467]: Oops when removing snd-opti93x
Date: Thu, 29 Sep 2005 02:11:42 +0200
Message-ID: <2ee5bef0cca60f3c91cf729d37484119@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 46514163
	for <alsa-devel@alsa-project.org>; Thu, 29 Sep 2005 02:11:42 +0200 (MEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1467> 
======================================================================
Reported By:                kl
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1467
Category:                   ISA - opti9xx
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     new
Distribution:               Debian Sarge 3.1r0
Kernel Version:             2.6.10-2.6.13+
======================================================================
Date Submitted:             09-29-2005 02:11 CEST
Last Modified:              09-29-2005 02:11 CEST
======================================================================
Summary:                    Oops when removing snd-opti93x
Description: 
Kernel oopses when removing snd-opti93x module.  This affect all
kernels since 2.6.10, 2.6.{8,9} is fine.

I wasn't able locate source of problem -- diffs between versions are
just to big for me.  I _think_ changes in ALSA core code caused it,
because
rather little changed in opti-93x sources (between 2.6.8 - 2.6.13).

I'm downloading 2.6.14-rc2 right now, but I don't think it will fix
this problem.

(lspci's output not included because it is IMHO useless, flame me if it
was relevant)

Only vanilla kernels were used, without any proprietary additions.


Thanks for your work.

______________________________________________________________________

Kernel config:

  # Bus options (PCI, PCMCIA, EISA, MCA, ISA)
  CONFIG_PCI=y
  CONFIG_PCI_GOANY=y
  CONFIG_PCI_BIOS=y
  CONFIG_ISA=y
  
  # Plug and Play support
  CONFIG_PNP=y
  CONFIG_PNP_DEBUG=y
  
  # Sound
  CONFIG_SOUND=m
  
  # Advanced Linux Sound Architecture
  CONFIG_SND=m
  CONFIG_SND_TIMER=m
  CONFIG_SND_PCM=m
  CONFIG_SND_HWDEP=m
  CONFIG_SND_RAWMIDI=m
  CONFIG_SND_SEQUENCER=m
  # CONFIG_SND_SEQ_DUMMY is not set
  CONFIG_SND_OSSEMUL=y
  CONFIG_SND_MIXER_OSS=m
  CONFIG_SND_PCM_OSS=m
  CONFIG_SND_SEQUENCER_OSS=y
  CONFIG_SND_RTCTIMER=m
  CONFIG_SND_VERBOSE_PRINTK=y
  CONFIG_SND_DEBUG=y
  CONFIG_SND_DEBUG_MEMORY=y
  CONFIG_SND_DEBUG_DETECT=y
  
  # Generic devices
  CONFIG_SND_MPU401_UART=m
  CONFIG_SND_OPL3_LIB=m
  
  # ISA devices
  CONFIG_SND_OPTI93X=m
  

Relevant messages from kernel 2.6.13:

(boot)

  kernel: pnp: the driver 'system' has been registered
  kernel: Limiting direct PCI/PCI transfers.
  kernel: isapnp: Scanning for PnP cards...
  kernel: isapnp: Card 'OPTi Audio 16'
  kernel: isapnp: 1 Plug & Play card detected total

# modprobe snd-opti93x

  kernel: pnp: the driver 'opti9xx' has been registered
  kernel: pnp: match found with the PnP device '00:01.01' and the driver
'opti9xx'
  kernel: pnp: match found with the PnP device '00:01.03' and the driver
'opti9xx'
  kernel: pnp: Device 00:01.01 activated.
  kernel: pnp: Device 00:01.03 activated.
  kernel: ALSA sound/isa/opti9xx/opti92x-ad1848.c:585: WSS dma2 # 3 not
valid
  kernel: ALSA sound/drivers/opl3/opl3_lib.c:109: OPL3: stat1 = 0xff
  kernel: ALSA sound/drivers/opl3/opl3_lib.c:440: OPL2/3 chip not detected
at 0x380/0x382
  kernel: ALSA sound/isa/opti9xx/opti92x-ad1848.c:2141: no OPL device at
0x380-0x383

# rmmod snd-opti93x

  kernel: Unable to handle kernel paging request at virtual address
3935323d
  kernel:  printing eip:
  kernel: 3935323d
  kernel: *pde = 00000000
  kernel: Oops: 0000 [#1]
  kernel: Modules linked in: snd_opti93x snd_pcm snd_page_alloc
snd_opl3_lib snd_timer snd_hwdep snd_mpu401_uart snd_rawmidi
snd_seq_device snd soundcore w83781d i2c_sensor i2c_isa i2c_core 8139too
mii isofs zlib_inflate
  kernel: CPU:    0
  kernel: EIP:    0060:[phys_startup_32+958739005/-1073741824]    Not
tainted VLI
  kernel: EFLAGS: 00010202   (2.6.13-alsa+bug+hunter+pnp+debug) 
  kernel: EIP is at 0x3935323d
  kernel: eax: 3935323d   ebx: c0f6ec14   ecx: c0f3c154   edx: c487f650
  kernel: esi: c0f6ec14   edi: 00001fff   ebp: c0f3c014   esp: c2815df4
  kernel: ds: 007b   es: 007b   ss: 0068
  kernel: Process rmmod (pid: 776, threadinfo=c2814000 task=c2ef75e0)
  kernel: Stack: c487f60a c0f6ec14 c0f3c014 c0f6d8f4 c2cb79f4 c0f44214
c2cb7174 c48762e7 
  kernel:        c0f6ec14 b7fd3000 c2ef75e0 c2815ed8 00000000 c0f3c154
00001000 c4876770 
  kernel:        c0f3c014 c0f6ec14 00000003 00000001 00000000 c0f3c014
c489b580 00000000 
  kernel: Call Trace:
  kernel:  [pg0+72799754/1070515200] snd_opl3_free+0x6a/0xb0
[snd_opl3_lib]
  kernel:  [pg0+72762087/1070515200] snd_device_free+0xc7/0x160 [snd]
  kernel:  [pg0+72763248/1070515200] snd_device_free_all+0x70/0xb0 [snd]
  kernel:  [pg0+72740092/1070515200] snd_card_free+0x10c/0x260 [snd]
  kernel:  [pg0+72762399/1070515200] snd_device_disconnect+0x9f/0x130
[snd]
  kernel:  [do_no_page+381/688] do_no_page+0x17d/0x2b0
  kernel:  [pg0+72763039/1070515200] snd_device_disconnect_all+0x3f/0xa0
[snd]
  kernel:  [klist_release+0/64] klist_release+0x0/0x40
  kernel:  [pg0+72740605/1070515200] snd_card_free_in_thread+0x1d/0x80
[snd]
  kernel:  [pg0+72903214/1070515200] snd_opti9xx_pnp_remove+0x1e/0x40
[snd_opti93x]
  kernel:  [card_remove_first+95/112] card_remove_first+0x5f/0x70
  kernel:  [pnp_device_remove+60/64] pnp_device_remove+0x3c/0x40
  kernel:  [__device_release_driver+134/160]
__device_release_driver+0x86/0xa0
  kernel:  [driver_detach+87/96] driver_detach+0x57/0x60
  kernel:  [bus_remove_driver+100/144] bus_remove_driver+0x64/0x90
  kernel:  [driver_unregister+19/48] driver_unregister+0x13/0x30
  kernel:  [pnp_unregister_driver+22/48] pnp_unregister_driver+0x16/0x30
  kernel:  [pg0+72903263/1070515200] alsa_card_opti9xx_exit+0xf/0x2a
[snd_opti93x]
  kernel:  [sys_delete_module+324/384] sys_delete_module+0x144/0x180
  kernel:  [sys_munmap+68/112] sys_munmap+0x44/0x70
  kernel:  [sysenter_past_esp+84/117] sysenter_past_esp+0x54/0x75
  kernel: Code:  Bad EIP value.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-29-05 02:11 kl             New Issue                                    
09-29-05 02:11 kl             Distribution              => Debian Sarge 3.1r0
09-29-05 02:11 kl             Kernel Version            => 2.6.10-2.6.13+  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
