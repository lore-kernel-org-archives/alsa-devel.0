From: bugtrack@alsa-project.org
Subject: [ALSA - utils 0000575]: alsa mixer settings and sporatic loss of sound
Date: Tue, 22 Mar 2005 09:43:39 +0100
Message-ID: <7fb6387bd01bbb3625087b2d91a9d128@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 77E701E5
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2005 09:43:40 +0100 (MET)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=575> 
======================================================================
Reported By:                grapnell
Assigned To:                
======================================================================
Project:                    ALSA - utils
Issue ID:                   575
Category:                   alsamixer
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Resolution:                 unable to duplicate
Fixed in Version:           
======================================================================
Date Submitted:             10-09-2004 18:09 CEST
Last Modified:              03-22-2005 09:43 CET
======================================================================
Summary:                    alsa mixer settings and sporatic loss of sound
Description: 
one thing i have noticed about alsa, is a very small event can trigger a
major crash of alsa, such as the forced quit of a non-responding
application that uses sound etc will cause alsa to crash, and I cannot get
sound support to come back unless I reboot. also, the mixer settings will
not save, I have to unmute and restore all the mixer settings manually
everytime I reboot.
======================================================================

----------------------------------------------------------------------
 tiwai - 10-12-04 14:40 
----------------------------------------------------------------------
The crash really depends on the hardware.  Please describe as precisely
as possible which board you have, on which kernel and distro with which
ALSA driver version, and what happens with which procedure how
frequently.

The mixer setting is FAQ.  It's a feature.

----------------------------------------------------------------------
 jdthood - 03-20-05 13:28 
----------------------------------------------------------------------
In the absence of the additional information that would be required
to deal with this bug report, I suggest that it be closed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-09-04 18:09 grapnell       New Issue                                    
10-12-04 14:40 tiwai          Note Added: 0002095                          
03-20-05 13:28 jdthood        Note Added: 0004084                          
03-22-05 09:43 jdthood        Status                   new => closed       
03-22-05 09:43 jdthood        Resolution               open => unable to
duplicate
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
