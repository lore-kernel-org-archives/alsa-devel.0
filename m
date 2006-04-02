From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001424]: crash on snd-powermac initilize
Date: Mon, 3 Apr 2006 01:31:41 +0200
Message-ID: <afd5d190d12320e8f2782e327ab3d9ed@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 19BB61AA
	for <alsa-devel@alsa-project.org>; Mon,  3 Apr 2006 01:31:42 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1424> 
======================================================================
Reported By:                amir
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1424
Category:                   PPC - powermac
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               GeeXboX
Kernel Version:             2.6.13.1
======================================================================
Date Submitted:             09-15-2005 20:38 CEST
Last Modified:              04-03-2006 01:31 CEST
======================================================================
Summary:                    crash on snd-powermac initilize
Description: 
I have users reporting a reproducable, on init, crash of our powerpc
distro,
but this happens to only some of the ppc users.

the distro is geexbox, www.geexbox.org

this crash happens also when snd-powermac is compiled as module,
and crashes when module is loaded.

I can't reproduce the bug myself, but I have users who do the tests,
and those users report that debian and ubuntu works great for them.

this bug also happened with linux 2.6.12
======================================================================

----------------------------------------------------------------------
 netstar - 03-01-06 07:20 
----------------------------------------------------------------------
I can also confirm this behaviour.  Using 2.6.15 kernel and any
distribution.  I think it's an issue with older iMacs.  My model is:

processor       : 0
cpu             : PPC970FX, altivec supported
clock           : 1800.000000MHz
revision        : 3.0 (pvr 003c 0300)

timebase        : 33333333
machine         : PowerMac8,1
motherboard     : PowerMac8,1 MacRISC4 Power Macintosh
detected as     : 338 (iMac G5)
pmac flags      : 00000000
L2 cache        : 512K unified
pmac-generation : NewWorld

This crashing is definitely not distribution specific, but rather model
specific.

----------------------------------------------------------------------
 bugmenot - 04-03-06 01:31 
----------------------------------------------------------------------
I get the same crash with linux 2.6.16 and gentoo
(gentoo-sources-2.6.16-r1) on an iBook G3

The oops I get:

Unable to handle kernel paging request for data at address 0x00000002
Faulting instruction address: 0xc0163bac
Oops: Kernel access of bad area, sig: 11 [#1]
Modules linked in: snd_powermac snd_pcm snd_page_alloc airport orinoco
hermes af_packet sungem sungem_phy usbhid snd_seq snd_timer snd_seq_device
snd soundcore evdev ohci_hcd usbcore unix
NIP: C0163BAC LR: EA106248 CTR: C0163B8C
REGS: dd601cc0 TRAP: 0300   Not tainted  (2.6.16-gentoo-r1)
MSR: 00009032 <EE,ME,IR,DR>  CR: 22028484  XER: 20000000
DAR: 00000002, DSISR: 40000000
TASK = c18a6bd0[6967] 'modprobe' THREAD: dd600000
GPR00: EA106248 DD601D70 C18A6BD0 00000000 00000001 00000060 00000000
00000001
GPR08: 00000002 00000000 00000070 C0163B8C 22028482 1001E7A0 00000000
10001144
GPR16: 00002000 00000000 00000003 1002AF18 10000000 10000000 10000000
100170F8
GPR24: 00000000 100170B4 100170A8 DE800800 E6D6C7A0 0000000A EA10E14C
00000000
NIP [C0163BAC] i2c_smbus_write_byte_data+0x20/0x44
LR [EA106248] send_init_client+0x40/0xd8 [snd_powermac]
Call Trace:
[DD601D70] [C00465B0] setup_irq+0x100/0x144 (unreliable)
[DD601DB0] [EA106248] send_init_client+0x40/0xd8 [snd_powermac]
[DD601DD0] [E906DF00] snd_pmac_tumbler_post_init+0x28/0x78 [snd_powermac]
[DD601DE0] [E906C31C] snd_pmac_probe+0x31c/0x334 [snd_powermac]
[DD601E10] [C0143214] platform_drv_probe+0x20/0x30
[DD601E20] [C0140E0C] driver_probe_device+0xc8/0x118
[DD601E40] [C0140488] bus_for_each_drv+0x5c/0xa4
[DD601E70] [C0140EF8] device_attach+0x98/0xb0
[DD601E90] [C014050C] bus_add_device+0x3c/0x148
[DD601EB0] [C013EF68] device_add+0x10c/0x174
[DD601ED0] [C0142F88] platform_device_add+0x158/0x1c8
[DD601EF0] [C01431A8] platform_device_register_simple+0x40/0x8c
[DD601F10] [E906C374] alsa_card_pmac_init+0x40/0x9c [snd_powermac]
[DD601F20] [C004328C] sys_init_module+0x1cc/0x2ec
[DD601F40] [C000CFD4] ret_from_syscall+0x0/0x38
--- Exception: c01 at 0xff3f948
    LR = 0x10002494
Instruction dump:
80010044 38210040 7c0803a6 4e800020 7c0802a6 9421ffc0 98a10010 7c691b78
7c872378 38c00000 90010044 39000002 <a0a30002> a0890004 39210010 80630008


The content of /proc/cpuinfo:

processor       : 0
cpu             : 750FX
temperature     : 38 C (uncalibrated)
clock           : 700.000000MHz
revision        : 2.2 (pvr 7000 0202)
bogomips        : 49.53
timebase        : 24835245
machine         : PowerBook4,3
motherboard     : PowerBook4,3 MacRISC2 MacRISC Power Macintosh
detected as     : 257 (iBook 2 rev. 2)
pmac flags      : 0000001b
L2 cache        : 512K unified
pmac-generation : NewWorld

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-15-05 20:38 amir           New Issue                                    
09-15-05 20:38 amir           File Added: .config                          
09-15-05 20:38 amir           Distribution              => GeeXboX         
09-15-05 20:38 amir           Kernel Version            => 2.6.13.1        
03-01-06 07:20 netstar        Note Added: 0008272                          
04-03-06 01:31 bugmenot       Note Added: 0009075                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
