From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002254]: Compilation warnings that
	result in the module to not be loaded
Date: Thu, 6 Jul 2006 23:51:58 +0200
Message-ID: <b13eced5e85834bef28a0f6dddd9b5d8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id BBA8723D
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Jul 2006 23:51:58 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2254> 
======================================================================
Reported By:                LordRaiden
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   2254
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
Distribution:               Ubuntu
Kernel Version:             kernel 2.6.17-3
======================================================================
Date Submitted:             07-03-2006 05:47 CEST
Last Modified:              07-06-2006 23:51 CEST
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

----------------------------------------------------------------------
 LordRaiden - 07-06-06 06:18 
----------------------------------------------------------------------
Basically, if I do alsamixer or aplay -l I get what basically amounts to
soundcard not being found error. After a recent kernel update in Ubuntu
(2.6.17-4) I tried compiling/configuring but not installing the drivers. I
got the same set of warnings about the casts and the pointers.

Then I just tried using amarok. I just had to xine to alsa and it was
working. The drivers in the kernel are working fine at the moment.

I don't want to try installing the drivers just to lose my sound again. I
saw a big set of errors in dmesg with a whole lot values just dumped.



----------------------------------------------------------------------
 Adrian Bunk - 07-06-06 23:51 
----------------------------------------------------------------------
The ALSA drivers shipped with the Ubuntu kernel shouldn't be that much
different from the standalone ALSA drivers.

Please post the errors you are seeing in dmesg, or noone will be able to
help you.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-03-06 05:47 LordRaiden     New Issue                                    
07-03-06 05:47 LordRaiden     Distribution              => Ubuntu          
07-03-06 05:47 LordRaiden     Kernel Version            => kernel 2.6.17-3 
07-03-06 05:49 LordRaiden     Issue Monitored: LordRaiden                    
07-06-06 02:28 Adrian Bunk    Note Added: 0010846                          
07-06-06 02:28 Adrian Bunk    Category                 0_compilation problem_!!!
=> PCI - via82xx
07-06-06 02:28 Adrian Bunk    Steps to Reproduce Updated                    
07-06-06 06:17 LordRaiden     Note Added: 0010853                          
07-06-06 06:18 LordRaiden     Note Edited: 0010853                         
07-06-06 23:51 Adrian Bunk    Note Added: 0010887                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
