From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001306]: Apparent race condition in snd_pcm_drain() sometimes hangs userspace processes
Date: Wed, 3 Aug 2005 17:34:19 +0200
Message-ID: <dfec1a771bb4ab79074c4df1e361b97a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 336D01DD
	for <alsa-devel@alsa-project.org>; Wed,  3 Aug 2005 17:34:19 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1306> 
======================================================================
Reported By:                jdthood
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1306
Category:                   CORE - pcm
Reproducibility:            sometimes
Severity:                   major
Priority:                   normal
Status:                     resolved
Distribution:               
Kernel Version:             
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             08-03-2005 17:12 CEST
Last Modified:              08-03-2005 17:34 CEST
======================================================================
Summary:                    Apparent race condition in snd_pcm_drain() sometimes
hangs userspace processes
Description: 
esd with libesd-alsa0 sometimes hangs userspace processes.
Reproducible on i386 and powerpc.

bt of the hanged state of esd, stracing esd appears to remove the
problem:

#0  0xffffe410 in ?? ()
#1  0xbfff9068 in ?? ()
#2  0xffffffff in ?? ()
#3  0x00000001 in ?? ()
#4  0xb7f1a4b5 in poll () from /lib/tls/i686/cmov/libc.so.6
#5  0xb7dd3ca1 in snd_pcm_wait_nocheck () from /usr/lib/libasound.so.2
#6  0xb7e09a2d in _snd_pcm_dmix_open () from /usr/lib/libasound.so.2
#7  0xb7dd1a9c in snd_pcm_drain () from /usr/lib/libasound.so.2
#8  0xb7dee0ea in _snd_pcm_rate_open () from /usr/lib/libasound.so.2
#9  0xb7dd1a9c in snd_pcm_drain () from /usr/lib/libasound.so.2
#10 0xb7fd12f9 in esd_audio_flush () from /usr/lib/libesd.so.0
#11 0x0804bdd0 in clean_exit ()
#12 0x0804a927 in clean_exit ()
#13 0xb7e72e8a in __libc_start_main () from /lib/tls/i686/cmov/libc.so.6
#14 0x08049751 in ?? ()
(gdb) cont
Continuing.
======================================================================

----------------------------------------------------------------------
 jdthood - 08-03-05 17:30 
----------------------------------------------------------------------
I don't know the version, but the bug was reported around the first of
July, 2005.

I will ask the submitter.

----------------------------------------------------------------------
 jdthood - 08-03-05 17:34 
----------------------------------------------------------------------
Submitter says "1.0.9" so the bug has probably already been fixed in
1.0.9a,
as you say.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
08-03-05 17:12 jdthood        New Issue                                    
08-03-05 17:18 tiwai          Note Added: 0005634                          
08-03-05 17:26 jdthood        Additional Information Updated                    
08-03-05 17:30 jdthood        Note Added: 0005635                          
08-03-05 17:34 jdthood        Note Added: 0005636                          
08-03-05 17:34 jdthood        Status                   new => resolved     
08-03-05 17:34 jdthood        Resolution               open => fixed       
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
