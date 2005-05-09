From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000914]: nm256 causes kernel to hard freeze
Date: Mon, 9 May 2005 22:08:57 +0200
Message-ID: <fc8f92c772266e5a9bfb38164964db69@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 86A1F2CE
	for <alsa-devel@alsa-project.org>; Mon,  9 May 2005 22:08:57 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=914> 
======================================================================
Reported By:                vaxen
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   914
Category:                   PCI - nm256
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.9 2.6.10
======================================================================
Date Submitted:             02-16-2005 20:39 CET
Last Modified:              05-09-2005 22:08 CEST
======================================================================
Summary:                    nm256 causes kernel to hard freeze
Description: 
Hi, here is my specs:

Gateway solo 3300
http://support.gateway.com/support/manlib/Notebooks/Solo3300/8506533/06533.htm
Audio chipset NM2200 interface to AC97 CODEC

pegasos vaxen # lspci -tv
-[00]-+-00.0  Intel Corp. 440BX/ZX/DX - 82443BX/ZX/DX Host bridge
      +-01.0-[01]--+-00.0  Neomagic Corporation NM2200 [MagicGraph 256AV]
      |            \-00.1  Neomagic Corporation NM2200 [MagicMedia 256AV
Audio]
      +-07.0  Intel Corp. 82371AB/EB/MB PIIX4 ISA
      +-07.1  Intel Corp. 82371AB/EB/MB PIIX4 IDE
      +-07.2  Intel Corp. 82371AB/EB/MB PIIX4 USB
      +-07.3  Intel Corp. 82371AB/EB/MB PIIX4 ACPI
      +-0a.0  Texas Instruments PCI1211
      +-0d.0  3Com Corporation 3c905C-TX/TX-M [Tornado]
      \-10.0  Agere Systems (former Lucent Microelectronics) WinModem 56k

I am using a custom patched kernel at
http://morph-sources.sourceforge.net/?q=node/27 

It is using 2.6.10 with 1.08 alsa drivers wth alsa-bk-2005-01-05.patch and
alsa-bk-2005-01-14.patch.

I compiled the drivers into the kernel, the kernel hard freezes after
displaying these message:
nm256:found card signature in video RAM: 0x27ec00
nm256:Mapping port 1 from 0x2709a0-0x27ec00
I have to switch off the laptop as it does not respond to any inputs.

I also tried compiling the drivers as modules, when I tried to modprobe
snd-nm256, the kernel hard freezes without any warning message.

I also tried vanilla 2.6.9 which contains alsa 1.0.6 driver. It freezes
like 2.6.10.

I have not tried alsa 1.0.7 driver.

Please let me know if you need more diagnostic information to fix this
problem.
======================================================================

----------------------------------------------------------------------
 vaxen - 03-11-05 14:25 
----------------------------------------------------------------------
Just tried 2.6.10 and 2.6.11 with reset_workaround=1 option. Same result.

----------------------------------------------------------------------
 MeneM - 05-09-05 22:08 
----------------------------------------------------------------------
Hi There,

I've got the same issue here, and I think I can help figure it out.
I'm using Debian, with a custom compiled Kernel version 2.6.11.

I've got one kernel version 2.6.11 which I'll call "1". It's compiled
without Alsa support and woth OSS support.

The other kernel, also 2.6.11, which i'll call "2", is vice versa, same
options except that Alsa is compiled in and no OSS.

When the driver crashes:

I boot up with "1", so that the OSS driver runs. I can hear Audio.
Everything works... The OSS way ;-)

Then I boot up with the "2" kernel (with Alsa). Low and behold, the whole
system boots up fine, and I have sound, I can control the audio with all
kinds of programs etc. In other words: the ALSA way ;-)

The when I boot the "2" kernel a second time, the boot hangs when trying
to load the nm256 driver.

Subsequent boot attempts fail as well.

BUT!, when I boot into the "1" kernel, so that the OSS driver loads again,
I can boot the "2" driver once again!

So the whole story starts from the front.

I've tried: buffer_top, reset_workaround and force_ac97 in different way's
and combo's all with the exact same result as above.

More then willing to do any kind of testing, as long as it does not
destroy my laptop. If it will destroy the audio of the laptop, so be it,
as long as I can use the rest.

Later,
Mark

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-16-05 20:39 vaxen          New Issue                                    
02-16-05 20:39 vaxen          Kernel Version            => 2.6.9 2.6.10    
02-16-05 21:36 vaxen          Note Added: 0003626                          
02-16-05 21:38 vaxen          Note Edited: 0003626                         
02-16-05 21:56 vaxen          Note Edited: 0003626                         
02-17-05 18:31 tiwai          Note Added: 0003632                          
02-17-05 20:44 vaxen          Note Added: 0003638                          
02-17-05 20:45 vaxen          Note Edited: 0003638                         
02-17-05 21:28 vaxen          Note Added: 0003641                          
02-17-05 22:40 vaxen          Note Added: 0003644                          
02-24-05 03:55 vaxen          Note Added: 0003717                          
02-24-05 04:01 vaxen          Note Added: 0003718                          
02-24-05 22:04 tiwai          Note Added: 0003727                          
02-25-05 16:29 vaxen          Note Added: 0003735                          
03-10-05 12:50 interfaSys     Note Added: 0003849                          
03-10-05 14:38 tiwai          Note Added: 0003852                          
03-10-05 14:38 tiwai          File Added: nm256-test.diff                    
03-10-05 18:56 vaxen          Note Added: 0003870                          
03-10-05 19:57 vaxen          Note Added: 0003871                          
03-11-05 12:15 tiwai          Note Added: 0003886                          
03-11-05 14:25 vaxen          Note Added: 0003888                          
05-09-05 22:08 MeneM          Note Added: 0004630                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
