From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000167]: alsamixer crashes system when snd-ioctl32 is loaded
Date: Sun, 21 Nov 2004 11:50:57 +0100
Message-ID: <68c287aece4f585f6facde587bc21c3d@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 56D11269
	for <alsa-devel@alsa-project.org>; Sun, 21 Nov 2004 11:50:57 +0100 (MET)
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
Last Modified:              11-21-2004 11:50 CET
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
 eradicator - 11-21-04 11:39 
----------------------------------------------------------------------
Ok, I uploaded alsa-driver-1.0.7.ioctl32.patch:

This basically incorporates the changes in  sjoerd's patch as well... I
return -EINVAL if indirect is used (like he does), but I show what I think
would be an acceptable workaround if I understand what it's doing (but
like him, I'm not entirely sure what that IOCTL is doing, so hopefully
someone else can provide a better fix for that one).

That all being said, I still can't get alsa sound output using my
ens1371... oss emulation still works fine, and with the patch alsamixer
works well, but the machine is still hanging on pcm playback using:

aplay /usr/kde/3.3/share/sounds/pop.wav

This is true using both my patch and sjored's, so I think we're still
missing something...

----------------------------------------------------------------------
 eradicator - 11-21-04 11:50 
----------------------------------------------------------------------
noticed another bug... the cp++ in the xfern code needed to be moved up so
that if the copy_from_user() fails in that loop, the last allocation needs
to be kfree()d...

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
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
