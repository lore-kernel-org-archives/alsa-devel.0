From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002263]: All sound plays in an endless
	loop
Date: Fri, 7 Jul 2006 08:06:32 +0200
Message-ID: <57f3539243f7e26b6de61d0e3a13275e@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id B349F25F
	for <alsa-devel@alsa-project.org>;
	Fri,  7 Jul 2006 08:06:32 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been SUBMITTED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2263> 
======================================================================
Reported By:                NathanF
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   2263
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Grafpup Linux
Kernel Version:             2.6.17.3
======================================================================
Date Submitted:             07-07-2006 08:06 CEST
Last Modified:              07-07-2006 08:06 CEST
======================================================================
Summary:                    All sound plays in an endless loop
Description: 
dmesg reports 'snd_via82xx_modem: Unknown symbol snd_verbose_printk'

Playing a sound file results in the first second repeating in an endless
loop until the process is killed. Some applications will not play at all,
flash animations in a browser play silently.
======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-07-06 08:06 NathanF        New Issue                                    
07-07-06 08:06 NathanF        Distribution              => Grafpup Linux   
07-07-06 08:06 NathanF        Kernel Version            => 2.6.17.3        
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
