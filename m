From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000731]: snd-ioctl32 problems on sparc linux
Date: Sun, 19 Dec 2004 13:21:09 +0100
Message-ID: <33e890a50da0326894b2ca31e55c38fe@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id D5598293
	for <alsa-devel@alsa-project.org>; Sun, 19 Dec 2004 13:21:09 +0100 (MET)
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


The following issue has been SUBMITTED.
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
Last Modified:              12-19-2004 13:21 CET
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

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-19-04 13:21 eradicator     New Issue                                    
12-19-04 13:21 eradicator     Distribution              => Gentoo          
12-19-04 13:21 eradicator     Kernel Version            => 2.6.9-gentoo-r10
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
