From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002285]: Alsa-lib needs to be updated to
	be compiled under kernel 2.6.17-1.2157
Date: Mon, 17 Jul 2006 06:30:57 +0200
Message-ID: <99cc7f0795a3000a34795984f550a241@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 959CA1A9
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Jul 2006 06:30:57 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2285> 
======================================================================
Reported By:                thesource
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   2285
Category:                   0_general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-16-2006 07:52 CEST
Last Modified:              07-17-2006 06:30 CEST
======================================================================
Summary:                    Alsa-lib needs to be updated to be compiled under
kernel 2.6.17-1.2157
Description: 
It is neccessary due to some header file changes in new kernel. At this
moment alsa-lib 1.0.12rc1 can not be compiled - sys/types.h and
asm/types.h must not be included simultaniously or this will cause type
name conflict error.
======================================================================

----------------------------------------------------------------------
 cruiseoveride - 07-16-06 18:06 
----------------------------------------------------------------------
I seem to be able to compile it with FC5.x86_64
And im using it too

alsa-lib-1.0.12rc1

----------------------------------------------------------------------
 thesource - 07-17-06 06:30 
----------------------------------------------------------------------
Are you sure you are using 2157 version? Besides since this version asm
folders in source are different. There is no asm folder so I had to
retarget /usr/include/asm  
symbolic link to asm-i386 folder of my source. In this case compiler gives
error of conflicting names in sys/types.h and asm/types.h
Check on intel-based x86 system (not 64)

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-16-06 07:52 thesource      New Issue                                    
07-16-06 18:06 cruiseoveride  Note Added: 0011029                          
07-16-06 18:08 cruiseoveride  File Added: make_info.txt                    
07-17-06 06:30 thesource      Note Added: 0011034                          
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
