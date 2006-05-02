From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002094]: No sound from subwoofer
Date: Wed, 3 May 2006 00:02:58 +0200
Message-ID: <565ff5d38e0f5ec728fb23eabf52b37a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 31A0C11F
	for <alsa-devel@alsa-project.org>; Wed,  3 May 2006 00:02:58 +0200 (MEST)
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


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2094> 
======================================================================
Reported By:                oryn
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2094
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
Distribution:               debian
Kernel Version:             2.6.15.5
======================================================================
Date Submitted:             05-03-2006 00:02 CEST
Last Modified:              05-03-2006 00:02 CEST
======================================================================
Summary:                    No sound from subwoofer
Description: 
The subwoofer has stopped working, it used to work on 1.0.9 as rear-left.
And before that it even used to be LFE.
I used a .asoundrc script to funnel L+R > rear-left.
I have tried removing the .asoundrc script and running speaker-test -c6
and I only get sound from front-left and front-right.

I don't know if there is something to do with the new intel-hda patch as
thats the sound system that the "NEW" asus W1000 uses.

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-03-06 00:02 oryn           New Issue                                    
05-03-06 00:02 oryn           Distribution              => debian          
05-03-06 00:02 oryn           Kernel Version            => 2.6.15.5        
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
