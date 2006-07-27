From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002285]: Alsa-lib needs to be updated to
	be compiled under kernel 2.6.17-1.2157
Date: Thu, 27 Jul 2006 13:01:28 +0200
Message-ID: <cd185e4a8fc3fd50df9b593ef3638dd8@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 3D357170
	for <alsa-devel@alsa-project.org>;
	Thu, 27 Jul 2006 13:01:29 +0200 (MEST)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2285> 
======================================================================
Reported By:                thesource
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   2285
Category:                   0_general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             07-16-2006 07:52 CEST
Last Modified:              07-27-2006 13:01 CEST
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
 tiwai - 07-23-06 00:03 
----------------------------------------------------------------------
Not yet.  I'll commit it after I back to home.

----------------------------------------------------------------------
 tiwai - 07-27-06 13:01 
----------------------------------------------------------------------
Fixed on HG.

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
07-21-06 16:32 tiwai          Note Added: 0011150                          
07-21-06 16:33 tiwai          File Added: alsa-lib-include-fix.diff             
      
07-21-06 18:41 thesource      Note Added: 0011151                          
07-22-06 22:26 rlrevell       Note Added: 0011171                          
07-23-06 00:03 tiwai          Note Added: 0011174                          
07-27-06 13:01 tiwai          Status                   new => resolved     
07-27-06 13:01 tiwai          Resolution               open => fixed       
07-27-06 13:01 tiwai          Assigned To               => tiwai           
07-27-06 13:01 tiwai          Note Added: 0011271                          
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
