From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000731]: snd-ioctl32 problems on sparc
	linux
Date: Sat, 5 Aug 2006 13:14:40 +0200
Message-ID: <b1fda0d93dc22fcb0eb63f23ad557042@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 8120816B
	for <alsa-devel@alsa-project.org>;
	Sat,  5 Aug 2006 13:14:40 +0200 (MEST)
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


The following issue has been RESOLVED.
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
Status:                     resolved
Distribution:               Gentoo
Kernel Version:             2.6.9-gentoo-r10
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             12-19-2004 13:21 CET
Last Modified:              08-05-2006 13:14 CEST
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

The strace can be found in bug #167 as I originally mentioned it there. 
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
08-05-06 13:14 Adrian Bunk    Status                   new => resolved     
08-05-06 13:14 Adrian Bunk    Resolution               open => fixed       
======================================================================



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
