From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000167]: alsamixer crashes system when snd-ioctl32 is loaded
Date: Sat, 27 Nov 2004 22:05:19 +0100
Message-ID: <836d45bedd0bc5427e918cb91cecbc89@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 475DC20D
	for <alsa-devel@alsa-project.org>; Sat, 27 Nov 2004 22:05:20 +0100 (MET)
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
Last Modified:              11-27-2004 22:05 CET
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
 tiwai - 11-27-04 19:25 
----------------------------------------------------------------------
Thanks for checking.  Just to be sure, could you try snd-dummy driver and
timidity on sparc64?
Since it works on x86-64, I guess it's driver-specific.  (EPIPE error
means usually the buffer under/overrun.)

----------------------------------------------------------------------
 eradicator - 11-27-04 22:05 
----------------------------------------------------------------------
It happens with snd-ens1371, snd-sun-cs4231, and snd-dummy

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
11-21-04 17:44 sjoerd         Note Added: 0002489                          
11-21-04 21:26 eradicator     Note Added: 0002490                          
11-21-04 21:36 eradicator     Note Added: 0002491                          
11-21-04 22:46 sjoerd         Note Added: 0002492                          
11-22-04 00:08 eradicator     Note Added: 0002493                          
11-22-04 00:14 eradicator     File Added: alsa-driver-1.0.7-ioctl32.patch       
            
11-22-04 00:49 eradicator     Note Added: 0002494                          
11-22-04 16:22 tiwai          Note Added: 0002508                          
11-23-04 10:16 eradicator     Note Added: 0002514                          
11-23-04 15:34 tiwai          Note Added: 0002515                          
11-23-04 15:36 tiwai          File Added: ioctl32-user-alloc.diff               
    
11-24-04 10:26 eradicator     Note Added: 0002544                          
11-24-04 12:53 eradicator     Note Added: 0002553                          
11-24-04 13:01 eradicator     Note Added: 0002556                          
11-24-04 13:01 tiwai          Note Added: 0002557                          
11-24-04 13:09 tiwai          Note Added: 0002559                          
11-24-04 14:29 eradicator     Note Added: 0002563                          
11-24-04 14:52 tiwai          Note Added: 0002564                          
11-24-04 14:53 tiwai          File Added: ioctl32-user-alloc-hack.diff          
         
11-24-04 23:24 eradicator     Note Added: 0002582                          
11-24-04 23:31 eradicator     Note Added: 0002583                          
11-25-04 12:22 tiwai          Note Added: 0002588                          
11-25-04 12:23 tiwai          File Added: ioctl32-user-alloc-hack2.diff         
          
11-26-04 08:26 eradicator     Note Added: 0002594                          
11-26-04 08:59 eradicator     File Added: revert-pcm_hw_params.patch            
       
11-26-04 09:22 eradicator     File Added: alsa.strace                      
11-26-04 09:22 eradicator     Note Added: 0002595                          
11-26-04 12:40 tiwai          Note Added: 0002604                          
11-26-04 15:17 tiwai          Note Added: 0002606                          
11-26-04 15:17 tiwai          File Added: ioctl32-user-alloc-hack3.diff         
          
11-26-04 20:31 eradicator     Note Added: 0002611                          
11-26-04 21:05 eradicator     Note Added: 0002612                          
11-26-04 21:40 eradicator     Note Added: 0002613                          
11-26-04 21:40 eradicator     File Added: strace                           
11-26-04 21:53 eradicator     Note Added: 0002614                          
11-27-04 19:25 tiwai          Note Added: 0002616                          
11-27-04 22:05 eradicator     Note Added: 0002618                          
======================================================================




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
