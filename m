From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000854]: Can't load module snd-cs4236, snd-cs4236 or snd-sb8
Date: Mon, 28 Mar 2005 04:23:42 +0200
Message-ID: <4e8ef9d0c7863f91926e4e623a85f3a1@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 61DD4253
	for <alsa-devel@alsa-project.org>; Mon, 28 Mar 2005 04:23:42 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=854> 
======================================================================
Reported By:                mrpee
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   854
Category:                   ISA - cs4236
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Debian
Kernel Version:             2.6.8-2-386
======================================================================
Date Submitted:             01-28-2005 13:18 CET
Last Modified:              03-28-2005 04:23 CEST
======================================================================
Summary:                    Can't load module snd-cs4236, snd-cs4236 or snd-sb8
Description: 
I can't load any modules for my sound carc Cirrus Logic cs4237b on my Dell
Latitude CP M233XT. I tried snd-cs4236, snd-cs4236 and also the
soundblaster module snd-sb8 with the same result "no such device".

I think I'll tried everything, kernel 2.4 with alsamodules, 2.6.1, alsa
1.0.7-2. half/full duplex, changing irq, dma etc.

Here is a link from another forum whith the same problem:
http://www.talkaboutsoftware.com/group/linux.debian.laptop/messages/7049.html
======================================================================

----------------------------------------------------------------------
 mrpee - 01-28-05 13:23 
----------------------------------------------------------------------
Sorry It should say cd4232 and cs4236 in the summary and description

----------------------------------------------------------------------
 jdthood - 03-28-05 04:23 
----------------------------------------------------------------------
Submitter: Send the output of lsmod.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
01-28-05 13:18 mrpee          New Issue                                    
01-28-05 13:18 mrpee          Distribution              => Debian          
01-28-05 13:18 mrpee          Kernel Version            => 2.6.8-2-386     
01-28-05 13:23 mrpee          Note Added: 0003426                          
03-28-05 04:23 jdthood        Note Added: 0004233                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
