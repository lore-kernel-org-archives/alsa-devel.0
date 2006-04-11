From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001235]: ESI ESP 1010 partialy supportet
Date: Tue, 11 Apr 2006 18:20:27 +0200
Message-ID: <16caf7fca273103d95dad43de2641981@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7CE5C166
	for <alsa-devel@alsa-project.org>; Tue, 11 Apr 2006 18:20:27 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1235> 
======================================================================
Reported By:                metasymbol
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1235
Category:                   PCI - ice1712
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               SuSE 9.2/9.3, Debian.
Kernel Version:             2.6.xx
======================================================================
Date Submitted:             07-06-2005 10:16 CEST
Last Modified:              04-11-2006 18:20 CEST
======================================================================
Summary:                    ESI ESP 1010 partialy supportet
Description: 
The ESI ESP1010 is a 10CH I/0 Audiosystem with 2 midi I/O.
The base features are supportet:
Midi I/O and 8 CH Analog

not supportet:
The digital I/O
the virtual headphone mixing
the virtual preampflifer mixing (by design of the Envy24control)

======================================================================

----------------------------------------------------------------------
 tiwai - 07-08-05 12:10 
----------------------------------------------------------------------
Try another board model via model option in case that your device is
compatible with another one?

----------------------------------------------------------------------
 supermihi - 04-11-06 18:20 
----------------------------------------------------------------------
I also have that device. I have no experience in driver development, but
maybe I can help some way with e.g. debug outputs. Other than metasymbol I
am not able to play anything on this device, at least not with xine using
alsa.
If I select the ESP card as output (which is hw:2 for me) in amarok, it
says "device busy", although I'm not using it with any other application.
I remember that I was able to play things on it (but not adjust the
volume) with an earlier ALSA verison, maybe a year ago.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-06-05 10:16 metasymbol     New Issue                                    
07-06-05 10:16 metasymbol     Distribution              => SuSE 9.2/9.3, Debian.
07-06-05 10:16 metasymbol     Kernel Version            => 2.6.xx          
07-08-05 12:10 tiwai          Note Added: 0005415                          
04-11-06 18:17 supermihi      Issue Monitored: supermihi                    
04-11-06 18:20 supermihi      Note Added: 0009233                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
