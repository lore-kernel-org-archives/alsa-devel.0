From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001259]: Audigy 4 Pro (SB0380) with ALSA 1.0.9rc2 - no sound from AUX in
Date: Wed, 1 Mar 2006 10:46:41 +0100
Message-ID: <2fc0ae813475dd9f89577952369424db@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 121AB186
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2006 10:46:42 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1259> 
======================================================================
Reported By:                iq79
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1259
Category:                   PCI - emu10k1
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               Gentoo Linux
Kernel Version:             2.6.12-gentoo-r1
======================================================================
Date Submitted:             07-15-2005 18:18 CEST
Last Modified:              03-01-2006 10:46 CET
======================================================================
Summary:                    Audigy 4 Pro (SB0380) with ALSA 1.0.9rc2 - no sound
from AUX in
Description: 
I am unable to unmute the internal AUX-in header of my Audigy4Pro.

- I played around with all (Playback/Capture) mixer settings in alsamixer
but I couldn't find a configuration which gives me sound from AUX-in.

- I tried loading emu10k1 module with several extin/exout combinations.
That didn't help, too.
======================================================================

----------------------------------------------------------------------
 jcdutton - 07-20-05 05:32 
----------------------------------------------------------------------
I will look at this in a few weeks time, as I am away from home at the
moment.
I have an Audigy4.

----------------------------------------------------------------------
 iq79 - 03-01-06 10:46 
----------------------------------------------------------------------
*bump*

Still having this problem. I double-checked everything again (HW is okay,
software setup should be fine, too), but couldn't get it to work.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-15-05 18:18 iq79           New Issue                                    
07-15-05 18:18 iq79           Distribution              => Gentoo Linux    
07-15-05 18:18 iq79           Kernel Version            => 2.6.12-gentoo-r1
07-15-05 19:49 pzad           Note Added: 0005483                          
07-15-05 19:50 pzad           Note Edited: 0005483                         
07-15-05 23:40 iq79           Note Added: 0005484                          
07-16-05 16:31 jdthood        Note Added: 0005496                          
07-16-05 18:36 iq79           File Added: amixer_output                    
07-16-05 18:38 iq79           Note Added: 0005500                          
07-20-05 05:32 jcdutton       Note Added: 0005532                          
03-01-06 10:46 iq79           Note Added: 0008278                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
