From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000059]: On au8820 left and right channels are swapped
Date: Tue, 22 Mar 2005 22:33:18 +0100
Message-ID: <b4fad97e0da3fd434019184fdfe66575@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 6F23E27A
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2005 22:33:18 +0100 (MET)
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


The following issue has been set as RELATED TO issue 0000949.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=59> 
======================================================================
Reported By:                kernel_bug
Assigned To:                mjander
======================================================================
Project:                    ALSA - driver
Issue ID:                   59
Category:                   PCI - au88x0
Reproducibility:            random
Severity:                   major
Priority:                   normal
Status:                     feedback
Distribution:               
Kernel Version:             2.6.2
======================================================================
Date Submitted:             02-13-2004 11:40 CET
Last Modified:              03-10-2005 21:25 CET
======================================================================
Summary:                    On au8820 left and right channels are swapped
Description: 
In most cases, left and right channels are swapped. But in approx. 5% cases
all OK. Looks like the matter is somewhere in byte alignment...
======================================================================
Relationships       ID      Summary
----------------------------------------------------------------------
related to          0000949 Randomly, left and right tracks are swaped
======================================================================

----------------------------------------------------------------------
 kernel_bug - 02-21-04 15:40 
----------------------------------------------------------------------
If you think that i have swapped my speakers, it is not true: mixer works
correctly.

----------------------------------------------------------------------
 Tim - 03-02-04 02:56 
----------------------------------------------------------------------
I have exactly the same problem: Since I changed from an old OSS driver
version with precompiled parts to ALSA, in more or less 95% of all cases
the channels are swapped. (au8820)

----------------------------------------------------------------------
 kernel_bug - 04-09-04 11:54 
----------------------------------------------------------------------
Ok, with last release (1.0.4) it works almost correctly. Channels swapped
only on first playing after loading modules. After this, all works
correctly.

----------------------------------------------------------------------
 mjander - 04-09-04 18:35 
----------------------------------------------------------------------
This bug is believed to be fixed in latest patch posted on OpenVortex devel
list. Will be sent to the ALSA guys now.

----------------------------------------------------------------------
 mjander - 04-17-04 18:59 
----------------------------------------------------------------------
THis bug has been fixed in alsa-driver version beyond 1.0.4 (to be released
at a unknown time). A patch is available at:
http://docencia.mat.utfsm.cl/~mjander/aureal/alsa/aureal-2.6.5.diff.gz
The credits for the bug discovery are for "claudia" (VortexOfSound
forum).

Best Regards

----------------------------------------------------------------------
 kernel_bug - 04-26-04 17:04 
----------------------------------------------------------------------
Channels are still swapped (always) when you are playing something first
time after loading modules. At least on my system, the following steps
always result in channel swapping:
1. unload ALSA modules (I usually do it with `service alsasound stop`)
2. Load them back
3. Play the sound.

----------------------------------------------------------------------
 mjander - 04-26-04 23:27 
----------------------------------------------------------------------
Could you send me more details ? I really don't understand exactly what do
you mean.
email: mjander(at)users[dot].sourceforge[dot]net

Thanks

----------------------------------------------------------------------
 jdthood - 03-10-05 15:31 
----------------------------------------------------------------------
> Channels are still swapped (always) when you are playing something
> first time after loading modules.

Submitter: Is this bug still present?  Are the channels swapped just
after the module is loaded?

----------------------------------------------------------------------
 mjander - 03-10-05 16:44 
----------------------------------------------------------------------
AFAIK this bug was solved a long time ago. It was supposedly caused by a
incorrect routing table initialization (bug found by Claudia). That fact,
i guess, leaved some random routes interferening with other intentional
routes.

Did anyone still get this bug or may we close it ?

Best Regards

Manuel

----------------------------------------------------------------------
 kernel_bug - 03-10-05 21:25 
----------------------------------------------------------------------
> Did anyone still get this bug or may we close it ?

Yes, I still get this bug. Channels are swapped just after the module is
loaded. First attempt to play something causes output with swapped
channels, all consequent attempts cause normal output.

"A long time ago" there was fixed another bug concerned with _random_
channel swap at _any_ attempt of output. Now we _always_ have swapped
channels, but only when you try to output something just after the module
is loaded.

I use ALSA drivers from the Linux kernel 2.6.11.

Thanks.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
02-13-04 11:40 kernel_bug     New Issue                                    
02-21-04 15:40 kernel_bug     Note Added: 0000280                          
03-02-04 02:56 Tim            Note Added: 0000429                          
04-09-04 11:54 kernel_bug     Note Added: 0000774                          
04-09-04 18:35 mjander        Note Added: 0000777                          
04-17-04 18:59 mjander        Status                   assigned => closed  
04-17-04 18:59 mjander        Note Added: 0000849                          
04-26-04 17:04 kernel_bug     Status                   closed => feedback  
04-26-04 17:04 kernel_bug     Resolution               open => reopened    
04-26-04 17:04 kernel_bug     Note Added: 0000953                          
04-26-04 23:27 mjander        Note Added: 0000956                          
03-10-05 15:31 jdthood        Note Added: 0003866                          
03-10-05 16:44 mjander        Note Added: 0003867                          
03-10-05 21:25 kernel_bug     Note Added: 0003873                          
03-22-05 22:33 jdthood        Relationship added       related to 0000949  
======================================================================




-------------------------------------------------------
This SF.net email is sponsored by: 2005 Windows Mobile Application Contest
Submit applications for Windows Mobile(tm)-based Pocket PCs or Smartphones
for the chance to win $25,000 and application distribution. Enter today at
http://ads.osdn.com/?ad_id=6882&alloc_id=15148&op=click
