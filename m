From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000726]: headphone output on the docking station (Dell Lattitude D400) does not work
Date: Tue, 11 Jan 2005 13:11:23 +0100
Message-ID: <e40dcd7e2e6fa0cd341e285e662c3fa7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 86ABE2EA
	for <alsa-devel@alsa-project.org>; Tue, 11 Jan 2005 13:11:23 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=726> 
======================================================================
Reported By:                vassili
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   726
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     new
Distribution:               debian
Kernel Version:             2.6.8, custom build
======================================================================
Date Submitted:             12-15-2004 17:26 CET
Last Modified:              01-11-2005 13:11 CET
======================================================================
Summary:                    headphone output on the docking station (Dell
Lattitude D400) does not work
Description: 
Support of a headphone jack on the docking station is missing.

Hardware: Dell Latitude D400 with docking station, 
Intel 82810DB AC97 Audio
======================================================================

----------------------------------------------------------------------
 tiwai - 01-07-05 19:56 
----------------------------------------------------------------------
Which codec?  Attach the contents of /proc/asound/card0/codec97#0/* files
(and /etc/asound.state).

----------------------------------------------------------------------
 vassili - 01-11-05 13:11 
----------------------------------------------------------------------
Kernel upgraded to 2.6.10, using ALSA driver from that kernel.

If "IEC958 Playback AC97-SPSA" is muted, there is strongly distorted 
signal on the headphone jack of the docking station.
Otherwise, there is not output at all.

Master (internal speaker of the laptop) - working OK
Headphone on the laptop - working OK
digital out on the docking station - untested

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-15-04 17:26 vassili        New Issue                                    
12-15-04 17:26 vassili        Distribution              => debian          
12-15-04 17:26 vassili        Kernel Version            => 2.6.8, custom build
01-07-05 19:56 tiwai          Note Added: 0003120                          
01-11-05 13:02 vassili        File Added: codecs                           
01-11-05 13:11 vassili        Note Added: 0003144                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
