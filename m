From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000700]: IEC958 Capture and Universe support
Date: Fri, 3 Dec 2004 14:18:15 +0100
Message-ID: <455482e2f3887d397f03551764e04db8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A282C1F8
	for <alsa-devel@alsa-project.org>; Fri,  3 Dec 2004 14:18:15 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=700> 
======================================================================
Reported By:                ungod
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   700
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             12-02-2004 09:59 CET
Last Modified:              12-03-2004 14:18 CET
======================================================================
Summary:                    IEC958 Capture and Universe support
Description: 
I had some spare time, so I thought I would continue adding features to the
aureon driver. The attached patch is the result:

Summary: IEC958 Capture mixer controls and Universe support

 * Added SPI read routine
 * Added IEC958 Capture mixer controls
 * Improved Universe support
 * Headphone Amp renamed to External Amplifier
 * Fixed GPIO bug in Prodigy code (There is no GPIO23 on ICE1724)
 
Signed-off-by: Peter Christensen <peter@developers.dk>
======================================================================

----------------------------------------------------------------------
 ungod - 12-02-04 20:17 
----------------------------------------------------------------------
Well, I see your point about the CS bit for Prodigy. Actually I can't say
whether it will work for Prodigy, as I don't have that card. But since
there is no GPIO23 on ICE1724 (at least according to the datasheet), I
doubt that it worked before.
If I remember correct, the Aureon code also used the imaginary GPIO23
until someone found it out and corrected it. It is my belief that the
Aureon 7.1 Space and Prodigy 7.1 are completely identical, except that
Prodigy uses coax instead of optical, but naturally, I can't be sure.
Thing is, maybe nobody with the Prodigy attempted to used the S/PDIF out,
or maybe those who did, and found that it didn't work, didn't know where
to report the bug, or simply didn't care.

Fact is that there is only 23 GPIO pins (GPIO[22:0]) on ICE1724 although
there are room enough for one more in the CCS registers.

It would be nice to get feedback from a prodigy user however, but so far,
I haven't even found any other ALSA user, having an Aureon card.

----------------------------------------------------------------------
 tiwai - 12-03-04 14:18 
----------------------------------------------------------------------
A good point.
Ok, now I commited your patch to CVS.  Let's see whether anyone cries out
:)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-02-04 09:59 ungod          New Issue                                    
12-02-04 09:59 ungod          File Added: aureon-misc.diff                    
12-02-04 12:26 tiwai          Note Added: 0002679                          
12-02-04 20:17 ungod          Note Added: 0002696                          
12-03-04 14:18 tiwai          Status                   new => resolved     
12-03-04 14:18 tiwai          Resolution               open => fixed       
12-03-04 14:18 tiwai          Assigned To               => tiwai           
12-03-04 14:18 tiwai          Note Added: 0002711                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
