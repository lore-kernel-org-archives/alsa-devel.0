From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000381]: master volume doesn't work; headphone works.
Date: Fri, 24 Sep 2004 13:36:13 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040924113613.15967101DE@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 73DE6263
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 13:36:13 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000381
======================================================================
Reported By:                amitshah
Assigned To:                tiwai
======================================================================
Project:                    ALSA - utils
Bug ID:                     381
Category:                   alsamixer
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
======================================================================
Date Submitted:             07-13-2004 10:57 CEST
Last Modified:              09-24-2004 13:36 CEST
======================================================================
Summary:                    master volume doesn't work; headphone works.
Description: 
The 'master' and 'master mono' volume controls don't work. 'Headphone' and
'pcm' do work, however.

$ cat /proc/asound/card0/codec97#0/ac97#0-0
0-0/0: Analog Devices AD1885

Capabilities     : -headphone out-
DAC resolution   : 16-bit
ADC resolution   : 16-bit
3D enhancement   : Analog Devices Phat Stereo

Current setup
Mic gain         : +20dB [+20dB]
POP path         : post 3D
Sim. stereo      : off
3D enhancement   : on
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=0 DSA=0 VRA
Extended status  : VRA
PCM front DAC    : 44100Hz
PCM ADC          : 44100Hz



AD18XX configuration
Unchained        : 0x1000,0x0000,0x0000
Chained          : 0x0000,0x0000,0x0000

lspci -vv:
0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801BA/BAM AC'97
Audio (rev 04)
        Subsystem: Intel Corp.: Unknown device 4d56
        Control: I/O+ Mem- BusMaster+ SpecCycle- MemWINV- VGASnoop-
ParErr- Stepping- SERR- FastB2B-
        Status: Cap- 66MHz- UDF- FastB2B+ ParErr- DEVSEL=medium >TAbort-
<TAbort- <MAbort- >SERR- <PERR-
        Latency: 0
        Interrupt: pin B routed to IRQ 17
        Region 0: I/O ports at e800
        Region 1: I/O ports at ef00 [size=64]

======================================================================

----------------------------------------------------------------------
 tiwai - 07-16-2004 12:00 CEST 
----------------------------------------------------------------------
Try 'ac97_quirk=1' module option for snd-intel8x0.

If it works, please show the output of lspci -nv, so that
the workaround is added the the driver.

----------------------------------------------------------------------
 amitshah - 07-20-2004 12:22 CEST 
----------------------------------------------------------------------
Output of lspci -nv for the sound card:

0000:00:1f.5 0401: 8086:2445 (rev 04)
        Subsystem: 8086:4d56
        Flags: bus master, medium devsel, latency 0, IRQ 17
        I/O ports at e800 [size=256]
        I/O ports at ef00 [size=64]

It works with ac97_quirk=1; the 'headphone' control is now gone and master
works properly. Though, master mono doesn't seem to make any difference.
What's that setting supposed to do?

Thanks.

----------------------------------------------------------------------
 tiwai - 07-30-2004 17:29 CEST 
----------------------------------------------------------------------
Perhaps master mono is not connected to any output.  Just ignore it.

The workaround for your mobo was added to the CVS tree now.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-13-04 10:57 amitshah       New Bug                                      
07-16-04 12:00 tiwai          Bugnote Added: 0001443                       
07-20-04 12:22 amitshah       Bugnote Added: 0001461                       
07-30-04 17:29 tiwai          Bugnote Added: 0001500                       
07-30-04 17:29 tiwai          Assigned To               => tiwai           
07-30-04 17:29 tiwai          Resolution               open => fixed       
07-30-04 17:29 tiwai          Status                   new => resolved     
09-24-04 13:36 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
