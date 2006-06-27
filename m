From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0002235]: ALSA dependent applications
	segfault with 1.0.12rc1!
Date: Tue, 27 Jun 2006 10:03:55 +0200
Message-ID: <19c6b19d879be6be73f533dd8425da51@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id CE0D719F
	for <alsa-devel@alsa-project.org>;
	Tue, 27 Jun 2006 10:03:55 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2235> 
======================================================================
Reported By:                quetzyg
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   2235
Category:                   PCI - hda-intel
Reproducibility:            always
Severity:                   crash
Priority:                   normal
Status:                     assigned
Distribution:               Slackware
Kernel Version:             2.6.17.1
======================================================================
Date Submitted:             06-27-2006 09:29 CEST
Last Modified:              06-27-2006 10:03 CEST
======================================================================
Summary:                    ALSA dependent applications segfault with 1.0.12rc1!
Description: 
All applications that use ALSA for sound output, segfault after initiated.
If I use OSS emulation instead of ALSA (on applications that support both,
of course), the applications run flawlessly.

Something broke in this new version...

Only OSS compat. lib. is 1.0.11, all the rest (driver, lib and utils) are
1.0.12rc1.

Cheers,
Quetzy Garcia
======================================================================

----------------------------------------------------------------------
 quetzyg - 06-27-06 09:57 
----------------------------------------------------------------------
quetzyg@DRUMCODE:~$ aplay -v .amsn/skins/Tux/sounds/online.wav 
Segmentation fault
quetzyg@DRUMCODE:~$

Back to the basics... :-\

----------------------------------------------------------------------
 Raymond - 06-27-06 10:03 
----------------------------------------------------------------------
Please post the gdb backtrace of the seg fault as described in
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2203

using aplay -v .amsn/skins/Tux/sounds/online.wav

Issue History
Date Modified  Username       Field                    Change              
======================================================================
06-27-06 09:29 quetzyg        New Issue                                    
06-27-06 09:29 quetzyg        Distribution              => Slackware       
06-27-06 09:29 quetzyg        Kernel Version            => 2.6.17.1        
06-27-06 09:40 Raymond        Note Added: 0010572                          
06-27-06 09:41 Raymond        Note Edited: 0010572                         
06-27-06 09:42 Raymond        Note Edited: 0010572                         
06-27-06 09:44 quetzyg        Note Added: 0010573                          
06-27-06 09:46 Raymond        Note Added: 0010574                          
06-27-06 09:57 quetzyg        Note Added: 0010575                          
06-27-06 10:03 Raymond        Note Added: 0010576                          
======================================================================



Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
