From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000679]: No sound on rear speakers
Date: Fri, 26 Nov 2004 12:32:43 +0100
Message-ID: <037a8ec64ef99250af058978b64f8bed@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CEA7E235
	for <alsa-devel@alsa-project.org>; Fri, 26 Nov 2004 12:32:43 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=679> 
======================================================================
Reported By:                NosyMan
Assigned To:                pzad
======================================================================
Project:                    ALSA - driver
Issue ID:                   679
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             2.6.9
======================================================================
Date Submitted:             11-26-2004 10:24 CET
Last Modified:              11-26-2004 12:32 CET
======================================================================
Summary:                    No sound on rear speakers
Description: 
I have no sound on rear speakers in ALSA 1.0.7. The sound was ok in
previous version tested 1.0.5 :-(
======================================================================

----------------------------------------------------------------------
 NosyMan - 11-26-04 12:15 
----------------------------------------------------------------------
cat /proc/asound/version
Advanced Linux Sound Architecture Driver Version 1.0.7.
Compiled on Nov 25 2004 for kernel 2.6.9.


cat /proc/asound/card0/codec97#0/ac97#0-0
0-0/0: SigmaTel STAC9708/11

Capabilities     : -headphone out-
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
 pzad - 11-26-04 12:32 
----------------------------------------------------------------------
OK, this is Old SB Live.

Hmm, AFAIK there wasn't any change in driver which should affect rear
speakers.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-26-04 10:24 NosyMan        New Issue                                    
11-26-04 10:24 NosyMan        Kernel Version            => 2.6.9           
11-26-04 10:51 NosyMan        Issue Monitored: NosyMan                     
11-26-04 11:02 pzad           Note Added: 0002596                          
11-26-04 11:23 NosyMan        Issue End Monitor: NosyMan                    
11-26-04 11:24 NosyMan        File Added: test.state                       
11-26-04 11:24 NosyMan        Note Added: 0002597                          
11-26-04 11:27 NosyMan        Note Added: 0002598                          
11-26-04 11:27 NosyMan        Issue Monitored: NosyMan                     
11-26-04 12:03 pzad           Note Added: 0002599                          
11-26-04 12:15 NosyMan        Note Added: 0002600                          
11-26-04 12:32 pzad           Note Added: 0002603                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
