From: bugtrack@alsa-project.org
Subject: [ALSA - liboss 0000196]: full duplex doesn't work any more
Date: Tue, 22 Mar 2005 09:38:25 +0100
Message-ID: <5aa6562552441a5c13e344620148a313@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 926C928B
	for <alsa-devel@alsa-project.org>; Tue, 22 Mar 2005 09:38:25 +0100 (MET)
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


The following issue requires your FEEDBACK.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=196> 
======================================================================
Reported By:                nathanel
Assigned To:                
======================================================================
Project:                    ALSA - liboss
Issue ID:                   196
Category:                   
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     feedback
======================================================================
Date Submitted:             04-08-2004 20:59 CEST
Last Modified:              03-22-2005 09:38 CET
======================================================================
Summary:                    full duplex doesn't work any more
Description: 
I'm using the attached .asoundrc to separate front an rear speakers of my
Soundblaster Live! to dsp and dsp1 respectively. I have my headphones
connected to the rear speaker output and running gnomemeeting with
alsa-oss on dsp1. Unfortunately this setup stopped working with alsa-oss
version 1.0.3 or higher (Different versions of alsa-libs didn't make any
difference). Playing music solely on dsp1 still works (tried with xmms
OSS) and recording also works (other people can hear me in gnomemeeting),
but both at the same time is no longer functioning (read: I can't hear my
dialog partner). As gnomemeering opens the audio device for recording
first, i suspect that full duplex support got broken somewhere between
1.0.2 and 1.0.3.
======================================================================

----------------------------------------------------------------------
 jdthood - 03-22-05 09:37 
----------------------------------------------------------------------
It has been a long time since you filed this bug.  You never
got a reply.  Have you managed to make any progress on it on
your own?



----------------------------------------------------------------------
 nathanel - 03-21-05 16:15 
----------------------------------------------------------------------
Unfortunately no. Meanwhile I had some look at the changes between alsa-oss
1.0.2 and 1.0.3 and it seems to me that some major rewrite/refactoring was
going on at that time, making it quite hard to spot any differences that
could be the cause. I eventually gave up and for now I'm still sticking to
the old version.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
04-08-04 20:59 nathanel       New Issue                                    
04-08-04 20:59 nathanel       File Added: .asoundrc                        
03-20-05 23:59 jdthood        Note Added: 0004104                          
03-21-05 16:15 nathanel       Note Added: 0004119                          
03-22-05 09:37 jdthood        Note Edited: 0004104                         
03-22-05 09:38 jdthood        Status                   new => feedback     
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
