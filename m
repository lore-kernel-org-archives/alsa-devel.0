From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000167]: alsamixer crashes system when snd-ioctl32 is loaded
Date: Sun, 21 Nov 2004 12:54:18 +0100
Message-ID: <74c160769eae5a0a5b121e7d7766e993@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id A3C3B25A
	for <alsa-devel@alsa-project.org>; Sun, 21 Nov 2004 12:54:18 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=167> 
======================================================================
Reported By:                bons78
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   167
Category:                   SPARC - cs4231
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               debian/unstable
Kernel Version:             linux-2.6.4+
======================================================================
Date Submitted:             03-30-2004 00:02 CEST
Last Modified:              11-21-2004 12:54 CET
======================================================================
Summary:                    alsamixer crashes system when snd-ioctl32 is loaded
Description: 
alsamixer crashes system hard when snd-ioctl32 is loaded.
System still responds to some sysrq commands (sync remount boot show) -
sysrq (term killall) has no effect.
There's no chance to do any other keyboard input. No logs, no traps, no
oops. Machine still responds to ping,(even port 22 stays open) but login
via ssh is not possible. 

alsamixer, of course, is useless without the ioctl32 wrapper loaded - but
does not crash the system then.
So I suspect a problem in the ioctl32 wrapper.



======================================================================

----------------------------------------------------------------------
 eradicator - 11-21-04 11:57 
----------------------------------------------------------------------
also of note is the following change that sjored made in the patch her
reported to the list:

@@ -456,7 +491,7 @@
        SNDRV_PCM_IOCTL_READN_FRAMES32 = _IOR('A', 0x53, struct
sndrv_xfern32),
        SNDRV_PCM_IOCTL_HW_REFINE_OLD32 = _IOWR('A', 0x10, struct
sndrv_pcm_hw_params_old32),
        SNDRV_PCM_IOCTL_HW_PARAMS_OLD32 = _IOWR('A', 0x11, struct
sndrv_pcm_hw_params_old32),
-       SNDRV_PCM_IOCTL_SYNC_PTR32 = _IOWR('A', 0x23, struct
sndrv_pcm_sync_ptr),
+       SNDRV_PCM_IOCTL_SYNC_PTR32 = _IOWR('A', 0x23, struct
sndrv_pcm_sync_ptr32),
 
 };

That hunk is not in mine because that change is already in
alsa-driver-1.0.7 but it is NOT in what is included in linux-2.6.9... so
if you're using the kernel source rather than alsa-driver, you should make
that change too...

----------------------------------------------------------------------
 sjoerd - 11-21-04 12:54 
----------------------------------------------------------------------
Your right about the cp++ bug ofcourse. But note that kfree(NULL), just
like free(NULL) is an perfectly valid operation. So the cases you pointed
out aren't bugs, it's ment to work that way :).. The indirect value does
indeed always do kfree(NULL), i started fixing that one but couldn't find
out what it was ment to do. So i stopped, but never cleaned up the
start..

Also note that on the sparclist i posted a patch against 2.6.9 and here
one against the alsa CVS. I never did test the patch against alsa CVS, but
it was trivial to forward port. But that's why there are little
differences

On the matter whether to do the extra buffers on all architectures. I
don't think you gain a lot from different codepaths for different archs,
because some are just a minimal amount faster.. If you really want that
though, i would only do the ones in pcm32.. The others are afaik just done
on application startup most of the time.. The big downside of the ifdef
stuff is that your code doesn't get as well tested as with just one
unified code path (and we know how well the original code was tested on
sparc..)... Ofcourse if you do the ifdef way, special case the archs where
you know it does work, so it will at least work on an untested arch :) 

As last thought for now. Both our patches allow one to specify in an ioctl
how much memory the kernel should allocated.. That's not very good, so
there should be some upper limits added. But i'll leave that to the alsa
people, because they  probably know what sane limits are for these
functions.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
03-30-04 00:02 bons78         New Issue                                    
03-30-04 00:02 bons78         Distribution              => debian/unstable 
03-30-04 00:02 bons78         Kernel Version            => linux-2.6.4+    
04-13-04 19:41 tiwai          Note Added: 0000795                          
07-04-04 22:32 weeve          Note Added: 0001381                          
07-05-04 08:09 eradicator     Issue Monitored: eradicator                    
11-19-04 05:45 weeve          Note Added: 0002474                          
11-19-04 05:46 weeve          Issue Monitored: weeve                       
11-19-04 05:55 rlrevell       Note Added: 0002475                          
11-20-04 10:23 eradicator     Note Added: 0002478                          
11-20-04 11:14 eradicator     Note Added: 0002479                          
11-20-04 16:36 sjoerd         File Added: sparc-alsa-cvs.patch                  
 
11-20-04 16:36 sjoerd         Note Added: 0002480                          
11-20-04 18:15 sjoerd         Issue Monitored: sjoerd                      
11-21-04 03:05 eradicator     Note Added: 0002482                          
11-21-04 11:34 eradicator     File Added: alsa-driver-1.0.7.ioctl32.patch       
            
11-21-04 11:39 eradicator     Note Added: 0002485                          
11-21-04 11:49 eradicator     File Added: alsa-driver-1.0.7.ioctl32.patch       
            
11-21-04 11:50 eradicator     Note Added: 0002486                          
11-21-04 11:57 eradicator     Note Added: 0002487                          
11-21-04 12:54 sjoerd         Note Added: 0002488                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
