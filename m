From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0001231]: Sharing soundcard via dmix does not work when mixing 32bit and 64bit applications.
Date: Fri, 8 Jul 2005 12:00:53 +0200
Message-ID: <50e78893e7ce75481bd21e099ad5caf7@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8BFB018A
	for <alsa-devel@alsa-project.org>; Fri,  8 Jul 2005 12:00:53 +0200 (MEST)
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


A NOTE has been added to this issue.
======================================================================
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1231> 
======================================================================
Reported By:                Tobias Diedrich
Assigned To:                
======================================================================
Project:                    ALSA - lib
Issue ID:                   1231
Category:                   0_general
Reproducibility:            always
Severity:                   minor
Priority:                   normal
Status:                     new
======================================================================
Date Submitted:             07-04-2005 16:30 CEST
Last Modified:              07-08-2005 12:00 CEST
======================================================================
Summary:                    Sharing soundcard via dmix does not work when mixing
32bit and 64bit applications.
Description: 
I have configured a friends AMD64-System to use dmix by default.
I also made the same configuration for the 32bit-chroot and made sure
that
/tmp is a bind-mount, so the dmix-Socket is shared between 32bit and 64bit
applications.
However while sharing between one type of applications (either all 32bit
or all 64bit) works fine, mixed sharing doesn't work.  A strace shows that
the socket is opened by apparently communication fails.
I suspect that the structures passed by dmix have problems with differntly
sized fields between 32bit and 64bit.
======================================================================

----------------------------------------------------------------------
 tiwai - 07-08-05 12:00 
----------------------------------------------------------------------
Yes, it's incompatible between 32 and 64bits.  The struct shared in shmem
doesn't match.
snd_pcm_direct_share_t in pcm_direct.h defines the shared struct and the
size of snd_pcm_[su]frames_t is long, so it depends on architecture.
Also, we should be careful about alignment, too...

Issue History
Date Modified  Username       Field                    Change              
======================================================================
07-04-05 16:30 Tobias DiedrichNew Issue                                    
07-08-05 12:00 tiwai          Note Added: 0005412                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by the 'Do More With Dual!' webinar happening
July 14 at 8am PDT/11am EDT. We invite you to explore the latest in dual
core and dual graphics technology at this free one hour event hosted by HP, 
AMD, and NVIDIA.  To register visit http://www.hp.com/go/dualwebinar
