From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000401]: alsaconf correctly identifies the driver, but it fails to load properly
Date: Fri, 24 Sep 2004 13:30:30 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040924113030.D41E59074@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 495B4288
	for <alsa-devel@alsa-project.org>; Fri, 24 Sep 2004 13:30:31 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000401
======================================================================
Reported By:                ronis
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     401
Category:                   PCI - atiixp
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               slackware-10.0
Kernel Version:             2.6.7
======================================================================
Date Submitted:             07-21-2004 18:30 CEST
Last Modified:              09-24-2004 13:30 CEST
======================================================================
Summary:                    alsaconf correctly identifies the driver, but it fails to load properly
Description: 
alsaconf chooses this driver, but when it tries to load:

 kernel: ATI IXP AC97 controller: probe of 0000:00:14.5 failed with error
-13

No sound, needless to say.


======================================================================

----------------------------------------------------------------------
 ronis - 07-21-2004 21:55 CEST 
----------------------------------------------------------------------
Oops, I just realized I'd pasted the wrong lines from lspci -vn:  

Here are the correct ones:

00:14.5 Class 0401: 1002:4341
        Subsystem: 103c:006b
        Flags: bus master, 66Mhz, slow devsel, latency 64, IRQ 5
        Memory at d0003000 (32-bit, non-prefetchable) [size=256]

----------------------------------------------------------------------
 ronis - 07-22-2004 16:38 CEST 
----------------------------------------------------------------------
I've resolved the problem.  Installing the CVS version of the atiixp
driver
works.   I'd been using the driver that came with the 2.6.7 linux kernel
sources.

Guess you can close this one.

----------------------------------------------------------------------
 Mark Knecht - 07-29-2004 17:35 CEST 
----------------------------------------------------------------------
Can someone point me towards instructions on how to 'install a CVS version
of the atiixp driver'? I'm seeing this problem and have been down for a
week.

Thanks

----------------------------------------------------------------------
 tiwai - 07-30-2004 16:44 CEST 
----------------------------------------------------------------------
1.0.6-rc will be released soon later.  Wait for a while...

Bug History
Date Modified  Username       Field                    Change              
======================================================================
07-21-04 18:30 ronis          New Bug                                      
07-21-04 18:30 ronis          Distribution              => slackware-10.0  
07-21-04 18:30 ronis          Kernel Version            => 2.6.7           
07-21-04 21:55 ronis          Bugnote Added: 0001465                       
07-22-04 16:38 ronis          Bugnote Added: 0001467                       
07-29-04 17:35 Mark Knecht    Bugnote Added: 0001484                       
07-30-04 16:44 tiwai          Bugnote Added: 0001487                       
07-30-04 16:44 tiwai          Resolution               open => fixed       
07-30-04 16:44 tiwai          Status                   assigned => resolved
09-24-04 11:29 assenls        Bug Monitored: assenls                       
09-24-04 13:30 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by: YOU BE THE JUDGE. Be one of 170
Project Admins to receive an Apple iPod Mini FREE for your judgement on
who ports your project to Linux PPC the best. Sponsored by IBM.
Deadline: Sept. 24. Go here: http://sf.net/ppc_contest.php
