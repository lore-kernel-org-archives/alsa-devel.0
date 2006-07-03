From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002254]: Compilation warnings that
	result in the module to not be loaded
Date: Mon, 3 Jul 2006 05:47:46 +0200
Message-ID: <a82e771694deb680ab29d587e6f4d970@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3F63B21C
	for <alsa-devel@alsa-project.org>;
	Mon,  3 Jul 2006 05:47:46 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2254> 
======================================================================
Reported By:                LordRaiden
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2254
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu
Kernel Version:             kernel 2.6.17-3
======================================================================
Date Submitted:             07-03-2006 05:47 CEST
Last Modified:              07-03-2006 05:47 CEST
======================================================================
Summary:                    Compilation warnings that result in the module to
not be loaded
Description: 
I tried both 1.0.11 and 1.0.12rc1, both with the same result. i'm trying to
compile via82xx drivers, but I think the problems are in an acore/sound.c
file (everything else compiles without errors or warnings.

/home/raiden/alsa/alsa-driver-1.0.12rc1/acore/sound.c: In function
&#8216;snd_register_device&#8217;:
/home/raiden/alsa/alsa-driver-1.0.12rc1/acore/sound.c:293: warning:
passing argument 2 of &#8216;class_device_create&#8217; makes pointer from
integer without a cast
/home/raiden/alsa/alsa-driver-1.0.12rc1/acore/sound.c:293: warning:
passing argument 3 of &#8216;class_device_create&#8217; makes integer from
pointer without a cast
/home/raiden/alsa/alsa-driver-1.0.12rc1/acore/sound.c:293: warning:
passing argument 4 of &#8216;class_device_create&#8217; from incompatible
pointer type
/home/raiden/alsa/alsa-driver-1.0.12rc1/acore/sound.c:293: warning:
passing argument 5 of &#8216;class_device_create&#8217; discards
qualifiers from pointer target type

======================================================================

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-03-06 05:47 LordRaiden     New Issue                                    
07-03-06 05:47 LordRaiden     Distribution              => Ubuntu          
07-03-06 05:47 LordRaiden     Kernel Version            => kernel 2.6.17-3 
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
