From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000731]: snd-ioctl32 problems on sparc linux
Date: Wed, 16 Mar 2005 20:26:31 +0100
Message-ID: <aabcd6fb6a724eaa487f033e20878cdb@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 8AC39227
	for <alsa-devel@alsa-project.org>; Wed, 16 Mar 2005 20:26:31 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=731> 
======================================================================
Reported By:                eradicator
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   731
Category:                   CORE - pcm
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               Gentoo
Kernel Version:             2.6.9-gentoo-r10
======================================================================
Date Submitted:             12-19-2004 13:21 CET
Last Modified:              03-16-2005 20:26 CET
======================================================================
Summary:                    snd-ioctl32 problems on sparc linux
Description: 
Some 32bit alsa programs fail on sparc64, but when these programs are
compiled in 64bit mode, they work fine.  Same version of alsa-lib in both
cases.


32bit $ timidity -Os Final\ Fantasy\ 7\ -\ Aerith\'s\ Theme.mid 
...
Text: Reset All Controller
Now Loading..ALSA lib pcm_hw.c:146:(sync_ptr1) SNDRV_PCM_IOCTL_SYNC_PTR
failed: Broken pipe
ALSA lib pcm_hw.c:146:(sync_ptr1) SNDRV_PCM_IOCTL_SYNC_PTR failed: Broken
pipe
ALSA lib pcm_hw.c:146:(sync_ptr1) SNDRV_PCM_IOCTL_SYNC_PTR failed: Broken
pipe
Terminated sig=0x02

The strace can be found in bug
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=167 as I originally
mentioned it there. 
When doing this, you hear the first tone, and then the failed ioctl occur
(so it's not on the first one)...

32bit $ aoss mpg123 Final\ Fantasy\ 7\ -\ Aerith\'s\ Theme.mp3
System lockup... I just noticed this one, so I haven't been able to debug,
but I'm betting it's more get_fs() == KERNEL_DS and accessing __user mem
problems...
using alsa-oss version 1.0.7

======================================================================

----------------------------------------------------------------------
 tiwai - 03-16-05 12:26 
----------------------------------------------------------------------
Interesting.  It means that snd-seq-oss influences on PCM?

BTW, any chance to use the new compat layer (compat_ioctl vfs) on sparc?

----------------------------------------------------------------------
 eradicator - 03-16-05 20:26 
----------------------------------------------------------------------
Actually, it looks like it is/was actually a problem in alsa-lib.  I
updated to alsa-lib-1.0.8, and now I have audio playback.  However, the
audio is playing at about 2x the expected rate (Actually it's more like
12/7 the normal rate)  I tested it for 2 minutes to determine that.

I believe this is resulting from data being dropped in the stream because
the audio "jitters" at about 5Hz.  The data in between these jitters
sounds correct, but the "jitter" appears to be a skip over certain sound. 
The Scherzo in Dvorak's Symphony No 9 from the New World provides a good
showcase for this as parts of it are very quiet aside from very short
tones.  When plying through ALSA, some of these tones are skipped which
leads me to conclude that it's pcm data being dropped rather than a
timescale going on.

What version introduced the new compat_ioctl vfs?

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-19-04 13:21 eradicator     New Issue                                    
12-19-04 13:21 eradicator     Distribution              => Gentoo          
12-19-04 13:21 eradicator     Kernel Version            => 2.6.9-gentoo-r10
12-21-04 18:44 tiwai          Note Added: 0002901                          
12-22-04 07:39 eradicator     Note Added: 0002907                          
12-22-04 11:58 tiwai          Note Added: 0002908                          
03-16-05 11:23 eradicator     Note Added: 0003936                          
03-16-05 11:41 eradicator     Note Added: 0003938                          
03-16-05 12:26 tiwai          Note Added: 0003939                          
03-16-05 20:26 eradicator     Note Added: 0003964                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
