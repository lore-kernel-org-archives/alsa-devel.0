From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000687]: Cannot build gentoo-ebuild for 1.0.7
Date: Mon, 3 Jan 2005 16:54:10 +0100
Message-ID: <e14ab245c6c4a29a575473e4ca212008@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8F21927A
	for <alsa-devel@alsa-project.org>; Mon,  3 Jan 2005 16:54:10 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=687> 
======================================================================
Reported By:                m_wright
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Issue ID:                   687
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     closed
Distribution:               Gentoo Linux
Kernel Version:             2.6.9-ck2
Resolution:                 won't fix
Fixed in Version:           
======================================================================
Date Submitted:             11-28-2004 19:06 CET
Last Modified:              01-03-2005 16:54 CET
======================================================================
Summary:                    Cannot build gentoo-ebuild for 1.0.7
Description: 
The gentoo ebuild for 1.0.7-r1 (basically 1.0.7) fails on linux kernel
2.6.9-ck2 with the following errors:

/var/tmp/portage/alsa-driver-1.0.7-r1/work/alsa-driver-1.0.7/acore/memory_wrapper.c:
In function `snd_compat_vmalloc_to_page':
/var/tmp/portage/alsa-driver-1.0.7-r1/work/alsa-driver-1.0.7/acore/memory_wrapper.c:41:
warning: implicit declaration of function `VMALLOC_VMADDR'
/var/tmp/portage/alsa-driver-1.0.7-r1/work/alsa-driver-1.0.7/acore/memory_wrapper.c:47:
warning: implicit declaration of function `pte_offset'
/var/tmp/portage/alsa-driver-1.0.7-r1/work/alsa-driver-1.0.7/acore/memory_wrapper.c:47:
warning: assignment makes pointer from integer without a cast
======================================================================

----------------------------------------------------------------------
 ebichu - 12-01-04 20:42 
----------------------------------------------------------------------
Is it because configure is checking the processor type and machine type
*after* checking for vmalloc_to_page?

It looks like a Gentoo-specific bug, as the Gentoo ebuild script patches
the configure script to change the order of the configuration options.  It
seems this was done to support compilation on sparc64 (at least according
to the comments in Gentoo's CVS).  I'll bounce this back to the Gentoo
developers.

----------------------------------------------------------------------
 tiwai - 12-01-04 23:25 
----------------------------------------------------------------------
Yes, that explains why.  Obviously the patch is broken.
I set this to wont fix, since this issue was solved differently on CVS.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-28-04 19:06 m_wright       New Issue                                    
11-28-04 19:06 m_wright       Distribution              => Gentoo Linux    
11-28-04 19:06 m_wright       Kernel Version            => 2.6.9-ck2       
11-29-04 15:27 tiwai          Note Added: 0002638                          
11-29-04 16:41 m_wright       Note Added: 0002653                          
11-29-04 17:20 tiwai          Note Added: 0002655                          
12-01-04 16:01 ebichu         Note Added: 0002665                          
12-01-04 16:01 ebichu         Issue Monitored: ebichu                      
12-01-04 16:35 tiwai          Note Added: 0002666                          
12-01-04 18:25 ebichu         Note Added: 0002667                          
12-01-04 19:06 tiwai          Note Added: 0002668                          
12-01-04 20:42 ebichu         Note Added: 0002669                          
12-01-04 23:25 tiwai          Status                   assigned => resolved
12-01-04 23:25 tiwai          Resolution               open => won't fix   
12-01-04 23:25 tiwai          Note Added: 0002670                          
01-03-05 16:54 tiwai          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
