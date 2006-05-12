From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002114]: Unnable to conect with sound server. Crash signal  6 SIGSEGV.  No sounds in sistem!
Date: Fri, 12 May 2006 16:13:53 +0200
Message-ID: <d584db913ab26509459f6aadcbcb47be@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 71A3C175
	for <alsa-devel@alsa-project.org>; Fri, 12 May 2006 16:13:53 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2114> 
======================================================================
Reported By:                caroldaza
Assigned To:                tiwai
======================================================================
Project:                    ALSA - lib
Issue ID:                   2114
Category:                   0_general
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     resolved
Resolution:                 fixed
Fixed in Version:           
======================================================================
Date Submitted:             05-11-2006 21:56 CEST
Last Modified:              05-12-2006 16:13 CEST
======================================================================
Summary:                    Unnable to conect with sound server. Crash signal  6
SIGSEGV.  No sounds in sistem!
Description: 
(no debugging symbols found)
Using host libthread_db library "/lib/libthread_db.so.1".
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
[Thread debugging using libthread_db enabled]
[New Thread 16384 (LWP 5886)]
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
(no debugging symbols found)
[KCrash handler]
#41 0x407b0ef1 in kill () from /lib/libc.so.6
#42 0x40648bb1 in pthread_kill () from /lib/libpthread.so.0
#43 0x40648f2b in raise () from /lib/libpthread.so.0
#44 0x407b0b24 in raise () from /lib/libc.so.6
#45 0x407b23fd in abort () from /lib/libc.so.6
#46 0x407aa00f in __assert_fail () from /lib/libc.so.6
#47 0x40333cd4 in snd_pcm_close () from /usr/lib/./libasound.so.2
#48 0x4014fa02 in Arts::AudioIOALSA::open ()
   from /opt/kde/lib/libartsflow.so.1
#49 0x4012aef8 in Arts::AudioSubSystem::open ()
   from /opt/kde/lib/libartsflow.so.1
#50 0x4012ad92 in Arts::AudioSubSystem::check ()
   from /opt/kde/lib/libartsflow.so.1
#51 0x08062980 in Arts::SoundServer_skel::~SoundServer_skel ()
#52 0x4079d469 in __libc_start_main () from /lib/libc.so.6
#53 0x08053dd1 in ?? ()

======================================================================

----------------------------------------------------------------------
 tiwai - 05-12-06 16:13 
----------------------------------------------------------------------
A known problem of arts.  Should be fixed with the latest version of
alsa-lib and arts.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-11-06 21:56 caroldaza      New Issue                                    
05-12-06 16:13 tiwai          Status                   new => resolved     
05-12-06 16:13 tiwai          Resolution               open => fixed       
05-12-06 16:13 tiwai          Assigned To               => tiwai           
05-12-06 16:13 tiwai          Note Added: 0009780                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
