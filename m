From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000600]: Volume on spdif out is to loud, cant control it
Date: Tue, 9 Nov 2004 16:11:02 +0100
Message-ID: <2288743369ce694effa7bf97c0f10da7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8EA4823E
	for <alsa-devel@alsa-project.org>; Tue,  9 Nov 2004 16:11:02 +0100 (MET)
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
Status:                     resolved
Distribution:               fedora 2
Kernel Version:             2.6.8-521
Resolution:                 won't fix
Fixed in Version:           
======================================================================
Date Submitted:             10-24-2004 18:05 CEST
Last Modified:              11-09-2004 16:11 CET
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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
