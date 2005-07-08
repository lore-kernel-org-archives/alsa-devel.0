From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000898]: API compatibility with pselect(2)
Date: Fri, 8 Jul 2005 10:35:15 +0200
Message-ID: <2c278947f690c18b3619308bba88927c@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 060C2186
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 10:35:15 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=898> 
======================================================================
Reported By:                phunge
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   898
Category:                   0_general
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     closed
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             02-09-2005 16:11 CET
Last Modified:              07-08-2005 10:35 CEST
======================================================================
Summary:                    API compatibility with pselect(2)
Description: 
I have a program which uses the ALSA sequencer API, and also uses
setitimer() to trigger some regular processing.

I had a bug where I cannot open the sequencer when running under valgrind
- the
program output "Unknown SEQ default" when calling snd_seq_open. My theory
is, this is caused by a SIGALRM being delivered while alsa-lib is in
read() or write() or some other syscall, and none of alsa-lib handles
EINTR correctly.

I fixed this by blocking SIGALRM except for when calling poll(). However,
using poll() there's no way to atomically unblock a signal and enter
poll() - that's what pselect is for. However, the
snd_*_poll_descriptors-style API makes it hard to use select/pselect, so
I'm forced to implement it in a way that's not 100% 
free of race conditions.

My request: please add a way to use select/pselect with ALSA.
======================================================================

----------------------------------------------------------------------
 phunge - 02-14-05 11:04 
----------------------------------------------------------------------
I didn't think of that - that will work fine. This bug is a non-issue.

Thanks for the info.

----------------------------------------------------------------------
 tiwai - 02-14-05 16:09 
----------------------------------------------------------------------
OK, closing now.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-09-05 16:11 phunge         New Issue                                    
02-09-05 17:12 tiwai          Note Added: 0003557                          
02-14-05 11:04 phunge         Note Added: 0003588                          
02-14-05 16:09 tiwai          Status                   new => resolved     
02-14-05 16:09 tiwai          Resolution               open => not an issue
02-14-05 16:09 tiwai          Assigned To               => tiwai           
02-14-05 16:09 tiwai          Note Added: 0003591                          
02-14-05 16:09 tiwai          Assigned To              tiwai =>            
07-08-05 10:35 perex          Status                   resolved => closed  
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
