From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002062]: azx_get_response_timeout -> no sound with hda_intel
Date: Wed, 26 Apr 2006 00:09:59 +0200
Message-ID: <060432e8c30caa90c839b5b88314c17b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 9D1C8159
	for <alsa-devel@alsa-project.org>; Wed, 26 Apr 2006 00:09:59 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2062> 
======================================================================
Reported By:                lemzwerg
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2062
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             Linux linux 2.6.16.9-smp #1 SMP Fri Apr 21 11:20:09
CEST 2006 i686 i686 i386 GNU/Linux
======================================================================
Date Submitted:             04-23-2006 14:06 CEST
Last Modified:              04-26-2006 00:09 CEST
======================================================================
Summary:                    azx_get_response_timeout -> no sound with hda_intel
Description: 
I have exactly the same problem as reported here (with the same
hardware, this is, SigmaTel STAC9200 codec, but in an Dell Inspiron
6400):

  http://threebit.net/mail-archive/linux-kernel/msg00690.html

but I'm using the latest ALSA and Linux kernel versions...

Any fix available?

======================================================================

----------------------------------------------------------------------
 tiwai - 04-24-06 15:54 
----------------------------------------------------------------------
Don't use CVS anymore but use Hg repo.

----------------------------------------------------------------------
 eivindt - 04-26-06 00:09 
----------------------------------------------------------------------
Sorry about that.  Still not working though, but I'll report that as a
separate bug.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-23-06 14:06 lemzwerg       New Issue                                    
04-23-06 14:06 lemzwerg       Kernel Version            => Linux linux
2.6.16.9-smp #1 SMP Fri Apr 21 11:20:09 CEST 2006 i686 i686 i386 GNU/Linux
04-23-06 23:10 eivindt        Note Added: 0009445                          
04-23-06 23:10 eivindt        Issue Monitored: eivindt                     
04-24-06 15:54 tiwai          Note Added: 0009457                          
04-26-06 00:09 eivindt        Note Added: 0009498                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
