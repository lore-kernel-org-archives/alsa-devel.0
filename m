From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001963]: Returning from suspend-to-ram "mutes" sounds
Date: Sun, 26 Mar 2006 04:26:03 +0200
Message-ID: <e3f52cd5cdd14c6b9c22a5fcf43fbcfa@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B2D0A1D4
	for <alsa-devel@alsa-project.org>; Sun, 26 Mar 2006 04:26:03 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1963> 
======================================================================
Reported By:                Jeff250
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   1963
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu Dapper
Kernel Version:             2.6.15-19-686
======================================================================
Date Submitted:             03-25-2006 03:35 CET
Last Modified:              03-26-2006 04:26 CEST
======================================================================
Summary:                    Returning from suspend-to-ram "mutes" sounds
Description: 
I have a Dell XPS m140 laptop using the hda-intel driver with the Sigmatel
STAC 9200 chip.  When I suspend-to-ram the laptop and resume from suspend,
the sound is "muted" in that alsamixer does not actually show any tracks
to be muted, but changing the master volume up or down restores sound
output.  As a workaround, I've added to my resume script an amixer command
to slightly modify the volume automatically on resume from suspend.  I'm
using v1.0.11rc4+ from CVS, and this problem is not present in Alsa
1.0.10.  Thanks for your time.
======================================================================

----------------------------------------------------------------------
 tiwai - 03-26-06 01:28 
----------------------------------------------------------------------
Does the suspend-to-disk work?

----------------------------------------------------------------------
 Jeff250 - 03-26-06 04:26 
----------------------------------------------------------------------
I just tested it, and it suffers from the same problem.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-25-06 03:35 Jeff250        New Issue                                    
03-25-06 03:35 Jeff250        Distribution              => Ubuntu Dapper   
03-25-06 03:35 Jeff250        Kernel Version            => 2.6.15-19-686   
03-26-06 01:28 tiwai          Note Added: 0008956                          
03-26-06 04:26 Jeff250        Note Added: 0008965                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
