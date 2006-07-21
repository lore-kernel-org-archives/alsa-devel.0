From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002285]: Alsa-lib needs to be updated to
	be compiled under kernel 2.6.17-1.2157
Date: Fri, 21 Jul 2006 07:59:11 +0200
Message-ID: <1fc95218eec091198692668b93841078@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3CFD5186
	for <alsa-devel@alsa-project.org>;
	Fri, 21 Jul 2006 07:59:12 +0200 (MEST)
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
Last Modified:              07-21-2006 07:59 CEST
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
 tiwai - 07-19-06 20:20 
----------------------------------------------------------------------
alsa-lib has nothing to do with the kernel tree headers.  The ALSA kernel
API is defined in its private headers (alsa-lib/include/sound/*).

If you got compile errors, it's the distro-specific glibc (header)
problem.

----------------------------------------------------------------------
 thesource - 07-21-06 07:59 
----------------------------------------------------------------------
Please, see this:

In file included from ../../include/sound/ainstr_iw.h:29,
                 from iwffff.c:47:
/usr/include/asm/types.h:67: error: conflicting types for 'blkcnt_t'
/usr/include/sys/types.h:235: error: previous declaration of 'blkcnt_t'
was heremake[2]: *** [iwffff.lo] Error 1
make[2]: Leaving directory `/mnt/e/temp/alsa-lib-1.0.12rc1/src/instr'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/mnt/e/temp/alsa-lib-1.0.12rc1/src'
make: *** [all-recursive] Error 1

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
07-19-06 20:20 tiwai          Note Added: 0011096                          
07-21-06 07:59 thesource      Note Added: 0011147                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
