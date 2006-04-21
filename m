From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002050]: Modprobe snd-intel8x0 gives unknown symbol
Date: Fri, 21 Apr 2006 13:58:51 +0200
Message-ID: <4481a3765589425ace6c439cbd6ef31d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 09BA116F
	for <alsa-devel@alsa-project.org>; Fri, 21 Apr 2006 13:58:51 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2050> 
======================================================================
Reported By:                binro
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2050
Category:                   PCI - intel8x0
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.16.1
======================================================================
Date Submitted:             04-21-2006 13:58 CEST
Last Modified:              04-21-2006 13:58 CEST
======================================================================
Summary:                    Modprobe snd-intel8x0 gives unknown symbol
Description: 
When I emerged alsa-driver-1.0.11 against a 2.6.16 kernel, the module load
produces "unknown symbol snd_ac97_pcm_close" and many more similar
messages. This worked fine with version 1.0.11_rc3 but fails with rc4, rc5
and final versions.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-21-06 13:58 binro          New Issue                                    
04-21-06 13:58 binro          Distribution              => Gentoo          
04-21-06 13:58 binro          Kernel Version            => 2.6.16.1        
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
