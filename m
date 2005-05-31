From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000190]: Compilation Error 2.6.4 /usr/src/linux/include/linux/pci.h
Date: Tue, 31 May 2005 18:03:25 +0200
Message-ID: <9a6c7e885d9aeee927252a17fcd556c5@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 013221CE
	for <alsa-devel@alsa-project.org>; Tue, 31 May 2005 18:03:25 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=190> 
======================================================================
Reported By:                Sean
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Issue ID:                   190
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     closed
Distribution:               
Kernel Version:             2.6.5
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             04-06-2004 01:52 CEST
Last Modified:              05-31-2005 18:03 CEST
======================================================================
Summary:                    Compilation Error 2.6.4
/usr/src/linux/include/linux/pci.h
Description: 
Building Alsa driver 1.0.4 failed on Linux 2.6.5 building memory.o with the
following error:
In file included from
/root/alsa/alsa-driver-1.0.4/alsa-kernel/core/memory.c:29,                
from /root/alsa/alsa-driver-1.0.4/acore/memory.c:2:
include/linux/pci.h:654: error: parse error before numeric constant

======================================================================

----------------------------------------------------------------------
 perex - 04-25-04 10:15 
----------------------------------------------------------------------
Note that you have to way one day until anonymous CVS is synced on
SourceForge.
Please try again.

----------------------------------------------------------------------
 jdthood - 03-19-05 09:48 
----------------------------------------------------------------------
This one can be closed.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-06-04 01:52 Sean           New Issue                                    
04-06-04 01:52 Sean           Kernel Version            => 2.6.5           
04-13-04 19:39 tiwai          Note Added: 0000794                          
04-13-04 23:21 Sean           File Added: .config                          
04-13-04 23:22 Sean           Note Added: 0000800                          
04-16-04 12:02 tiwai          Note Added: 0000834                          
04-16-04 22:32 Sean           Note Added: 0000845                          
04-20-04 12:50 tiwai          Note Added: 0000875                          
04-20-04 19:12 Sean           Note Added: 0000888                          
04-23-04 17:19 tiwai          Note Added: 0000901                          
04-23-04 21:47 Sean           Note Added: 0000919                          
04-23-04 21:48 Sean           File Added: config.log                       
04-24-04 21:58 tiwai          Status                   assigned => resolved
04-24-04 21:58 tiwai          Resolution               open => fixed       
04-24-04 21:58 tiwai          Assigned To              perex => tiwai      
04-24-04 21:58 tiwai          Note Added: 0000929                          
04-25-04 01:28 Sean           Status                   resolved => feedback
04-25-04 01:28 Sean           Resolution               fixed => reopened   
04-25-04 01:28 Sean           Note Added: 0000930                          
04-25-04 01:29 Sean           File Added: config.log                       
04-25-04 10:15 perex          Note Added: 0000936                          
03-19-05 09:48 jdthood        Note Added: 0004027                          
03-19-05 14:39 perex          Status                   feedback => resolved
03-19-05 14:39 perex          Resolution               reopened => fixed   
05-31-05 18:03 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
