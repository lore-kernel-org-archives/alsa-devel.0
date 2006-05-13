From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002122]: DMIX crashes Ekiga
Date: Sat, 13 May 2006 18:29:01 +0200
Message-ID: <8f2d15900e90044d2096417ca53a7f6a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D27D0173
	for <alsa-devel@alsa-project.org>; Sat, 13 May 2006 18:29:01 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2122> 
======================================================================
Reported By:                dsandras
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   2122
Category:                   1_pcm_d - direct PCM plugins (dmix+)
Reproducibility:            always
Severity:                   block
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             05-13-2006 17:35 CEST
Last Modified:              05-13-2006 18:29 CEST
======================================================================
Summary:                    DMIX crashes Ekiga
Description: 
This problem is probably related to problem #2095 that was closed. 
Unfortunately, I can not reopen it, so I'm posting a new bug report.

When using DMIX, Ekiga crashes. This problem was not present with earlier
versions of libasound2. I applied all patches from CVS.
======================================================================

----------------------------------------------------------------------
 dsandras - 05-13-06 17:41 
----------------------------------------------------------------------
If I comment out the period_time, period_size, buffer_size in the above
configuration and play some sound with aplay, I get the same backtrace :
*** glibc detected *** free(): invalid pointer: 0x0806dd80 ***

Program received signal SIGABRT, Aborted.
[Switching to Thread -1210476320 (LWP 29600)]
0xb7dc37c7 in raise () from /lib/tls/libc.so.6
(gdb) bt
#0  0xb7dc37c7 in raise () from /lib/tls/libc.so.6
#1  0xb7dc506b in abort () from /lib/tls/libc.so.6
#2  0xb7dfa545 in __libc_message () from /lib/tls/libc.so.6
#3  0xb7e00b97 in _int_free () from /lib/tls/libc.so.6
#4  0xb7e01032 in free () from /lib/tls/libc.so.6
#5  0xb7f6ffd0 in snd_pcm_adpcm_decode () from /usr/lib/libasound.so.2
#6  0xb7f4e609 in snd_pcm_hw_free () from /usr/lib/libasound.so.2
#7  0xb7f7561d in _snd_pcm_rate_linear_open () from
/usr/lib/libasound.so.2
#8  0xb7f4e609 in snd_pcm_hw_free () from /usr/lib/libasound.so.2
#9  0xb7f58c7e in snd_pcm_close () from /usr/lib/libasound.so.2
#10 0x0804ff7b in ?? ()
#11 0x0805ba08 in ?? ()
#12 0x00000000 in ?? ()

----------------------------------------------------------------------
 rlrevell - 05-13-06 18:29 
----------------------------------------------------------------------
Why are you using an .asoundrc - dmix has been enabled by default for
several releases.

Also try the latest HG sources - CVS is dead and has not been updated for
a while

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-13-06 17:35 dsandras       New Issue                                    
05-13-06 17:39 dsandras       Note Added: 0009795                          
05-13-06 17:41 dsandras       Note Added: 0009796                          
05-13-06 18:29 rlrevell       Note Added: 0009799                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
