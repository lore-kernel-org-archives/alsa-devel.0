From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000469]: volume of sblive mic recording too low
Date: Fri, 17 Sep 2004 10:35:53 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040917083553.283094B011@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 67902147
	for <alsa-devel@alsa-project.org>; Fri, 17 Sep 2004 10:35:53 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_advanced_page.php?bug_id=0000469
======================================================================
Reported By:                wouter
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Bug ID:                     469
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Debian
Kernel Version:             2.6.8
======================================================================
Date Submitted:             08-28-2004 01:36 CEST
Last Modified:              09-17-2004 10:35 CEST
======================================================================
Summary:                    volume of sblive mic recording too low
Description: 
The recordings made with the Mic input on my sblive (5.1) are substantially
lower in volume than direct playback output. If fact, they are too low to
be really useful in for instance video conferencing, barely reaching 1/4
in the VU meter of the gnomemeeting voip program - with Mic boost on.

Setting "Capture" to anything but zero stops any sound from being
captured.

"AC97 Capture" seems to be controlling the volume of the recording, but it
is too low even with the slider on 100%.

People on the users mailinglist seem to indicate that "Capture" actually
should work, which it doesn't.
======================================================================

----------------------------------------------------------------------
 pzad - 09-07-2004 09:40 CEST 
----------------------------------------------------------------------
What ac97 uses your sb live ???
Check /proc/asound/card*/codec97#*/ac97#?-? file for your card.

----------------------------------------------------------------------
 wouter - 09-07-2004 16:47 CEST 
----------------------------------------------------------------------
[senta:~] cat /proc/asound/card0/codec97#0/ac97#0-0
0-0/0: SigmaTel STAC9708/11

Capabilities     :
DAC resolution   : 18-bit
ADC resolution   : 18-bit
3D enhancement   : SigmaTel 3D Enhancement

Current setup
Mic gain         : +20dB [+20dB]
POP path         : pre 3D
Sim. stereo      : off
3D enhancement   : off
Loudness         : off
Mono output      : MIX
Mic select       : Mic1
ADC/DAC loopback : off
Extended ID      : codec=0 rev=0 SDAC DSA=0
Extended status  : SDAC

----------------------------------------------------------------------
 pzad - 09-16-2004 10:22 CEST 
----------------------------------------------------------------------
On my audigy "capture" control works as expected.

Could you attach content of (ac97 codec register dump)
/proc/asound/card*/codec97#*/ac97#?-?+reg
when "capture" is 0 and capture works
and
/proc/asound/card*/codec97#*/ac97#?-?+reg
when "capture" is not 0 and capture doesn't work ???

----------------------------------------------------------------------
 wouter - 09-16-2004 16:00 CEST 
----------------------------------------------------------------------
I attached the resgister values. The only difference is setting "Capture"
from 0% (recording working) to 100% (recording not working).

----------------------------------------------------------------------
 pzad - 09-17-2004 10:35 CEST 
----------------------------------------------------------------------
AC97 registers are OK. I don't know where is the problem. I will look
closer to others AC97 registers this weekend.

Last thing, attach outputs of alsactl (can_capture.state,
cannot_capture.state)
when "capture" is 0 and capture works
alsactl -f can_capture.state store
and
when "capture" is not 0 and capture doesn't work ???
alsactl -f cannot_capture.state store

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-28-04 01:36 wouter         New Bug                                      
08-28-04 01:36 wouter         File Added: amixer.txt                       
08-28-04 01:36 wouter         Distribution              => Debian          
08-28-04 01:36 wouter         Kernel Version            => 2.6.8           
09-07-04 09:40 pzad           Bugnote Added: 0001704                       
09-07-04 16:47 wouter         Bugnote Added: 0001716                       
09-16-04 10:22 pzad           Bugnote Added: 0001767                       
09-16-04 15:58 wouter         File Added: can_capture.txt                    
09-16-04 15:58 wouter         File Added: cannot_capture.txt                    
09-16-04 16:00 wouter         Bugnote Added: 0001774                       
09-17-04 10:35 pzad           Bugnote Added: 0001777                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
