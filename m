From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000600]: Volume on spdif out is to loud, cant control it
Date: Thu, 16 Dec 2004 17:23:17 +0100
Message-ID: <9004616d73e73022ceeff4189189c6e2@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 2D872243
	for <alsa-devel@alsa-project.org>; Thu, 16 Dec 2004 17:23:17 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=600> 
======================================================================
Reported By:                LocalHero
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   600
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Distribution:               fedora 2
Kernel Version:             2.6.8-521
Resolution:                 won't fix
Fixed in Version:           
======================================================================
Date Submitted:             10-24-2004 18:05 CEST
Last Modified:              12-16-2004 17:23 CET
======================================================================
Summary:                    Volume on spdif out is to loud, cant control it
Description: 
I have a mythtv setup with a punid-r case. On the case there are a spdif
optical out that i have connected to a yamaha 550 reciever. The problem is
that i can only set the spdif on and off. Not control the volume and the
default linux volume is a bit to loud so it creates distorsion. I think
this is a problem in general cause i have another computer with sblive
that also creates to loud sound. But there im using the analog output and
can via the mixer set the volume to 90% to avoid it.

Is there a way to decrease the volume on the spdif out so that i dont get
the distorsion
======================================================================

----------------------------------------------------------------------
 tiwai - 11-09-04 16:11 
----------------------------------------------------------------------
Unfortunately, we can't fix this in the driver well.  It's a hardware
limitation.

The output to spdif isn't attenuated in ac97 block (it's digital ;)
so we have to do the volume control in software, either alsa-lib
or the app itself.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-24-04 18:05 LocalHero      New Issue                                    
10-24-04 18:05 LocalHero      Distribution              => fedora 2        
10-24-04 18:05 LocalHero      Kernel Version            => 2.6.8-521       
11-09-04 16:11 tiwai          Status                   assigned => resolved
11-09-04 16:11 tiwai          Resolution               open => won't fix   
11-09-04 16:11 tiwai          Note Added: 0002325                          
12-16-04 17:23 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
