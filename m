From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001169]: route plugin: unneeded ttable levels propagation
Date: Thu, 16 Jun 2005 15:04:33 +0200
Message-ID: <5c7cd55a72913f8cfc701071b38a078b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 7166219D
	for <alsa-devel@alsa-project.org>; Thu, 16 Jun 2005 15:04:33 +0200 (MEST)
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


The following issue has been ASSIGNED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1169> 
======================================================================
Reported By:                Andrew
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   1169
Category:                   PCI - ice1724
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             06-08-2005 07:51 CEST
Last Modified:              06-16-2005 15:04 CEST
======================================================================
Summary:                    route plugin: unneeded ttable levels propagation
Description: 
v.1.0.9a is in use. All 1.0.9rcX have the same effect.

To replicate stereo to all eight channles I use this fragment in my
.asoundrc file:

pcm.!default {
        type plug
        slave {
                pcm "2x4"
                format S32_LE
        }
}

pcm.2x4 {
    type route
    slave.pcm surround71
    slave.channels 8
    ttable.0.0 0.03
    ttable.1.1 0.03
    ttable.0.2 1
    ttable.1.3 1
    ttable.0.4 1
    ttable.1.5 1
    ttable.0.6 1
    ttable.1.7 1
} 

All works fine except for levels are reduced for ALL channles rather
channels 0 and 1 only (the aim is to balance headphone output channels 0-1
with external amplifier(s) channels 2-7 levels).

Terratec Aureon 7.1 Space is in use.

I have selected "major" level as such situation is very error-prone:
unexpected high level output is possible which is danger for ears.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-08-05 07:51 Andrew         New Issue                                    
06-16-05 15:04 perex          Status                   new => assigned     
06-16-05 15:04 perex          Assigned To               => perex           
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
