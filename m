From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000469]: volume of sblive mic recording too low
Date: Tue,  7 Sep 2004 16:47:12 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040907144712.DA6F0E01F@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 402EF203
	for <alsa-devel@alsa-project.org>; Tue,  7 Sep 2004 16:47:13 +0200 (MEST)
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
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000469
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
Last Modified:              09-07-2004 16:47 CEST
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

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-28-04 01:36 wouter         New Bug                                      
08-28-04 01:36 wouter         File Added: amixer.txt                       
08-28-04 01:36 wouter         Distribution              => Debian          
08-28-04 01:36 wouter         Kernel Version            => 2.6.8           
09-07-04 09:40 pzad           Bugnote Added: 0001704                       
09-07-04 16:47 wouter         Bugnote Added: 0001716                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
