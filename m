From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000731]: snd-ioctl32 problems on sparc linux
Date: Tue, 19 Jul 2005 06:50:46 +0200
Message-ID: <da3bae89140d19b7c213447f9f30efaf@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 236EA1A7
	for <alsa-devel@alsa-project.org>; Tue, 19 Jul 2005 06:50:47 +0200 (MEST)
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
Last Modified:              07-19-2005 06:50 CEST
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
 eradicator - 04-04-05 20:32 
----------------------------------------------------------------------
Ok, the ioctl32 problems seem to be all fixed.  The 'aoss mpg123' problem
is fixed with >=1.0.8.  Additionally, timidity -Os produces sound which is
skippy like xmms.  This seems to be directly related to the driver and not
ioctl32 as I popped in an ens1371 based card which works fine with xmms. 
Additionally, a native 64bit xmms causes the same skipping in playback, so
this seems to be a bug in the sun_cs4231 driver.  It's odd that the oss
playback (in-kernel as well as aoss) would work fine though...

----------------------------------------------------------------------
 eradicator - 07-19-05 06:50 
----------------------------------------------------------------------
this can probably be closed as this specific issue is no longer a problem
(but others have cropped up in 1.0.9 that I'll open a new bug for)

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
04-04-05 20:32 eradicator     Note Added: 0004329                          
07-19-05 06:50 eradicator     Note Added: 0005526                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
