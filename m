From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002285]: Alsa-lib needs to be updated to
	be compiled under kernel 2.6.17-1.2157
Date: Mon, 17 Jul 2006 16:17:44 +0200
Message-ID: <3c4ff1202539f1e49544edbb391de6eb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id EF532CB
	for <alsa-devel@alsa-project.org>;
	Mon, 17 Jul 2006 16:17:44 +0200 (MEST)
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
Last Modified:              07-17-2006 16:17 CEST
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
 cruiseoveride - 07-17-06 14:41 
----------------------------------------------------------------------
[vikky@server ~]$ rpm -qa kernel*
kernel-devel-2.6.17-1.2157_FC5
kernel-2.6.17-1.2157_FC5
[vikky@server ~]$

the file list in kernel-devl is in the attached file

----------------------------------------------------------------------
 thesource - 07-17-06 16:17 
----------------------------------------------------------------------
Sorry forgot to say: I use kernel source rpm. I compiled my kernel from
source (because I want to use nvidia agp and fedora guys stupidly compiled
agpgart into kernel). Try scr.rpm for this kernel and check directory
structure to see what I mean.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-16-06 07:52 thesource      New Issue                                    
07-16-06 18:06 cruiseoveride  Note Added: 0011029                          
07-16-06 18:08 cruiseoveride  File Added: make_info.txt                    
07-17-06 06:30 thesource      Note Added: 0011034                          
07-17-06 14:41 cruiseoveride  Note Added: 0011038                          
07-17-06 14:43 cruiseoveride  File Added: kernel-devel_filelist.txt             
      
07-17-06 16:17 thesource      Note Added: 0011043                          
======================================================================




-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
