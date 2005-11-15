From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001520]: Soundchip was not detected
Date: Tue, 15 Nov 2005 10:10:26 +0100
Message-ID: <daf2f31e491b7ce6e2336f44aee01477@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8562B1A1
	for <alsa-devel@alsa-project.org>; Tue, 15 Nov 2005 10:10:27 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1520> 
======================================================================
Reported By:                Henne
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1520
Category:                   ISA - cs4236
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               Slackware 9.0
Kernel Version:             2.6.14-rc4
======================================================================
Date Submitted:             11-01-2005 10:35 CET
Last Modified:              11-15-2005 10:10 CET
======================================================================
Summary:                    Soundchip was not detected
Description: 
I have an HP Omnibook 5700 CTX with some CS423x chip onboard, which is not
detected by alsaconf. I did not find the ids in cs4236.c so I think the
Pnp ID's
must added to this file.


======================================================================

----------------------------------------------------------------------
 Henne - 11-12-05 19:33 
----------------------------------------------------------------------
Okay,

I found, applied and run it. The chip is detected with alsaconf as a
cs4232 instead cs4236 and changes the modprobe.conf-file.

When I run modprobe snd-cs4232 (slackware 9.0 has no alsa-init-script), I
got a noise from the speakers and the kernel says:

ALSA (path to) cs4236.c:179: CS4232 WSS PnP manual resources are invalid,
using 
auto config

The modules are loaded.

Consulting the /proc - files I got:


/proc/ioports

...
0220-022f : CS4232 SB
...
0388-0389 : OPL2/3 (left)
038a-038b : OPL2/3 (right)
...
0534-0537 : CS4231
...


/proc/interrupts

...
5:     0     XT-PIC CS4231
...


/proc/dma

0: CS4231 - 2
1: CS4231 - 1
...


In /proc/asound I have a link CS4236 to card0

/proc/asound/cards
0 [CS4236]: CS4236 - CS4236
            CS4236 at 0x534, irq 5, dma 1&0

/proc/asound/devices
 4: [0- 0]: hardware dependent
16: [0- 0]: digital audio playback
24: [0- 0]: digital audio capture
 0: [0 -0]: ctl
33:       : timer


/proc/asound/card0/id

CS4236


/proc/asound/card0/pcm0c/info

...
id: CS4231
name: CS4236
...


So everything looks fine, but when I start alsamixer I get:

alsamixer: function snd_ctl_open failed for default: No such device


When starting aplay (without options) I get:

ALSA lib confmisc.c:672:(snd_func_card_driver) cannot find caro ´0´
and other "No such device" errors.

----------------------------------------------------------------------
 Henne - 11-15-05 10:10 
----------------------------------------------------------------------
I didn't give you the whole information.

1.

I compiled alsa-driver-1.10.rc3 again -with-debug=full , to see if this
brings more info to the screen.
dmesg tells now after:

ALSA (path to cs423x) cs4236.c:179: CS4232 WSS PnP manual resources are
invalid, using auto config

a new message:

ALSA (path to cs423x) cs4231_lib.c:386: cs4231_mce_down - auto calibration
time out (1)

The noise from the speaker sounds like a farth (I think that hint is very
usefull!!!)

2.

Whne I try to unload the module (modprobe -r snd-cs4232) the kernel says:

Unable to handle kernel NULL pointer dereference at virtual address
00000184 printing eip:
c2865ab9
*pde = 00000000
Ooops: 0000 [#1]
PREEMPT
Modules linked in: snd_cs4232 snd_opl3_lib snd_hwdep snd_cs4231_lib
snd_pcm snd_timer snd_page_alloc snd_mpu401_uart snd_rawmidi
snd_seq_device snd soundcore pcmcia firmware_class yenta_socket
rerc_nonstatic pcmcia_core rtc
CPU: 0
EIP: 0060:[<c2865ab9>] Not tainted VLI
EFLAGS: 00010202 (2.6.14-kj1)
EIP is at snd_card_disconntect+0x19/0x250 [snd]
eax: 00000000  ebx: c1836000  ecx: 00000001  edx: c10ad438
esi: c10ad400  edi: c283aa14  ebp: c283aa5c  esp: c1837ed4
ds: 00fb  es: 007b  ss: 0068
rocess modprobe (pid: 1147, threadinfo=c1836000 task=c1c9aa50)
Stack: c10ad438 c1836000 c10ad42c c02cc8f2 00000000 c10ad400 c283aa14
c283aa5c 
       c2838821 00000000 c10ad400 c01d0f43 c10ad400 c10ad468 c01fa823
c10ad400 
       c10ad400 c1836000 c283aa14 c01fa8cb c10ad400 c283aa14 c28388b0
00000000 
Call Trace:
 [<c02cc8f2>] klist_dec_and_del+0x12/0x20
 [<c2838821>] snd_cs4232_pnpbios_remove+0x11/0x20 [snd_cs4232]
 [<c01d0f43>] pnp_device_remove+0x33/0x40
 [<c01fa823>] __device_release_driver+0x63/0x70
 [<c01fa8cb>] driver_detach+0x6b/0x93
 [<c28388b0>] alsa_card_cs423x_exit+0x0/0x36 [snd_cs4232]
 [<c01fa2b2>] bus_remove_driver+0x42/0x70
 [<c01fab9b>] driver_unregister+0xb/0x20
 [<c28388c7>] alsa_card_cs423x_exit+0x17/0x36 [snd_cs4232]
 [<c012cd10>] sys_delete_module+0x150/0x190
 [<c0148131>] do_munmap+0xd1/0x100
 [<c0102b69>] syscall_call+0x7/0xb
Code: 26 00 b8 28 00 00 00 c3 8d 76 00 8d bc 27 00 00 00 00 55 57 56 53 bb
00 e0 ff ff 83 ec 10 21 e3 8b 4b 14 41 89 4b 14 8b 44 24 24 <8b> 90 84 01
00 00 85 d2 74 20 8b 43 14 48 89 43 14 8b 43 08 83 
 <6>note: modprobe[1147] exited with preempt_count 1

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-01-05 10:35 Henne          New Issue                                    
11-01-05 10:35 Henne          Distribution              => Slackware 9.0   
11-01-05 10:35 Henne          Kernel Version            => 2.6.14-rc4      
11-08-05 18:48 tiwai          Note Added: 0006637                          
11-08-05 21:00 Henne          Note Added: 0006643                          
11-12-05 19:33 Henne          Note Added: 0006688                          
11-15-05 10:10 Henne          Note Added: 0006729                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the JBoss Inc.  Get Certified Today
Register for a JBoss Training Course.  Free Certification Exam
for All Training Attendees Through End of 2005. For more info visit:
http://ads.osdn.com/?ad_id=7628&alloc_id=16845&op=click
