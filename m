From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0000898]: API compatibility with pselect(2)
Date: Mon, 14 Feb 2005 16:09:38 +0100
Message-ID: <ce9317086d0056d53166a4166f3dbeff@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1AEE81FE
	for <alsa-devel@alsa-project.org>; Mon, 14 Feb 2005 16:09:39 +0100 (MET)
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


The following issue has been RESOLVED.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=898> 
======================================================================
Reported By:                phunge
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   898
Category:                   general
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     resolved
Resolution:                 not an issue
Fixed in Version:           
======================================================================
Date Submitted:             02-09-2005 16:11 CET
Last Modified:              02-14-2005 16:09 CET
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
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
