From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000557]: SNDCTL_DSP_GETOPTR not working correctly in specific situation
Date: Tue, 9 Aug 2005 13:46:14 +0200
Message-ID: <87fb10914868f30353e500510b9f1f06@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 53D791C9
	for <alsa-devel@alsa-project.org>; Tue,  9 Aug 2005 13:46:14 +0200 (MEST)
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


The following issue has been CLOSED
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=557> 
======================================================================
Reported By:                minmax
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   557
Category:                   CORE OSS - pcm
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Debian unstable
Kernel Version:             vanilla 2.6.7
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             10-01-2004 16:18 CEST
Last Modified:              08-09-2005 13:46 CEST
======================================================================
Summary:                    SNDCTL_DSP_GETOPTR not working correctly in specific
situation
Description: 
When the first few writes to the oss emulation device are done in specific
way, SNDCTL_DSP_GETOPTR returns wrongly huge results in info.bytes
======================================================================

----------------------------------------------------------------------
 tiwai - 05-31-05 17:55 
----------------------------------------------------------------------
fix5 looks fine to me.  Let's commit it and close this issue.

----------------------------------------------------------------------
 perex - 05-31-05 18:06 
----------------------------------------------------------------------
Ok, the problem seems to be resolved. Reopen if not....

Issue History
Date Modified  Username       Field                    Change              
======================================================================
10-01-04 16:18 minmax         New Issue                                    
10-01-04 16:18 minmax         Distribution              => Debian unstable 
10-01-04 16:18 minmax         Kernel Version            => vanilla 2.6.7   
10-02-04 10:52 minmax         Issue Monitored: minmax                      
04-09-05 16:09 jdthood        Note Added: 0004406                          
04-09-05 16:22 minmax         Note Added: 0004410                          
05-13-05 15:20 gk4            Note Added: 0004646                          
05-13-05 15:24 perex          Note Added: 0004647                          
05-13-05 15:26 tiwai          Note Added: 0004648                          
05-13-05 19:35 gk4            Note Added: 0004651                          
05-13-05 19:38 tiwai          Note Added: 0004652                          
05-13-05 19:48 gk4            Note Added: 0004655                          
05-15-05 15:50 tiwai          Note Added: 0004663                          
05-16-05 16:08 gk4            Note Added: 0004676                          
05-19-05 15:28 parente        Note Added: 0004693                          
05-20-05 00:38 minmax         Note Added: 0004698                          
05-26-05 17:27 Roger Mach     Note Added: 0004738                          
05-27-05 10:56 perex          Note Added: 0004742                          
05-27-05 11:03 perex          File Added: fix2.patch                       
05-27-05 11:04 perex          Note Added: 0004743                          
05-27-05 15:41 parente        Note Added: 0004752                          
05-30-05 09:51 perex          Note Added: 0004798                          
05-31-05 14:04 parente        Note Added: 0004831                          
05-31-05 15:54 perex          Status                   new => assigned     
05-31-05 15:54 perex          Assigned To               => perex           
05-31-05 15:55 perex          Note Added: 0004833                          
05-31-05 16:10 parente        Note Added: 0004834                          
05-31-05 16:38 perex          File Added: oss-optr-fix3.patch                   

05-31-05 16:41 perex          Note Added: 0004837                          
05-31-05 16:55 tiwai          Note Added: 0004838                          
05-31-05 16:56 parente        Note Added: 0004839                          
05-31-05 17:02 parente        Note Edited: 0004839                         
05-31-05 17:13 tiwai          Note Added: 0004840                          
05-31-05 17:13 perex          File Added: oss-optr-fix4.patch                   

05-31-05 17:13 tiwai          File Added: pcm-oss-ptr-fix4.diff                 
  
05-31-05 17:14 perex          Note Added: 0004841                          
05-31-05 17:18 perex          Note Added: 0004842                          
05-31-05 17:39 tiwai          Note Added: 0004843                          
05-31-05 17:44 parente        Note Added: 0004844                          
05-31-05 17:51 perex          File Added: oss-optr-fix5.patch                   

05-31-05 17:52 perex          Note Added: 0004845                          
05-31-05 17:55 tiwai          Note Added: 0004846                          
05-31-05 18:06 perex          Status                   assigned => resolved
05-31-05 18:06 perex          Resolution               open => fixed       
05-31-05 18:06 perex          Note Added: 0004847                          
08-09-05 13:46 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
