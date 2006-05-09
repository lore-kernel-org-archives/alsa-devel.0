From: bugtrack@alsa-project.org
Subject: [ALSA - lib 0002095]: Choppy sound using default dmix config for some applications but not others.
Date: Tue, 9 May 2006 13:20:03 +0200
Message-ID: <763264dc5bc9ef579d4c1344bd47571b@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 76AAC17A
	for <alsa-devel@alsa-project.org>; Tue,  9 May 2006 13:20:03 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2095> 
======================================================================
Reported By:                BigBaaadBob
Assigned To:                perex
======================================================================
Project:                    ALSA - lib
Issue ID:                   2095
Category:                   1_pcm_d - direct PCM plugins (dmix+)
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     assigned
======================================================================
Date Submitted:             05-03-2006 01:09 CEST
Last Modified:              05-09-2006 13:20 CEST
======================================================================
Summary:                    Choppy sound using default dmix config for some
applications but not others.
Description: 
As reported in http://forums.gentoo.org/viewtopic-t-457951.html
alsa 1.0.11 causes skipping sound in some applications but not others.

Sound skips in rhytymbox and totem, but not xmms, realplayer, or mplayer.

This occurs with default dmix setup (i.e. with no .asoundrc).  Creating an
.asoundrc like this causes the skipping to stop for those applications
that skip.

pcm.!default {
  type hw
  card 0
}

This has been reported using the cmipci driver, the Intel ICH4 driver, the
i915GM driver, and on a ppc iBook G4.

On user reports that fiddling with the .asoundrc parameters can lessen the
problem, but not eliminate the problem.
======================================================================

----------------------------------------------------------------------
 razamatan - 05-09-06 07:23 
----------------------------------------------------------------------
actually, my experience is similar but different.

i have a abit mobo using the via chipset (via82xx), and i use a 2.6.16-r6
gentoo-sources kernel and the driver is compiled from the kernel source.

my sound gets severly garbled (not choppy, but sounds like cat /dev/random
> /dev/audio) at odd times when i try using ogg123, mpg321, aplay. 
however, when i use anything backended by xine or madplay everything's
fine.

when i use a asoundrc that looks like:
  pcm.!default {
    type hw
    card 0
  }

things sorta work... nothing is garbled, but things play in roughly 2x
speed.

using a asoundrc that looks like:
  defaults.pcm.dmix_max_periods -1

doesn't do anything at all (garbled audio using mpg321, ogg123, aplay).

i've since reverted to alsa-lib-1.0.10 w/ no asoundrc and things work
peachy like it should.



----------------------------------------------------------------------
 dsandras - 05-09-06 13:20 
----------------------------------------------------------------------
Many Ekiga users are also complaining about this problem. Reverting to an
older libasound2 makes it disappear.

It also crashes the Ekiga ALSA plugin:
#3  0xb6376fe5 in free () from /lib/tls/libc.so.6
#4  0xb58b6f70 in snd_pcm_adpcm_decode () from /usr/lib/libasound.so.2
#5  0xb58955b9 in snd_pcm_hw_free () from /usr/lib/libasound.so.2
#6  0xb58bc3ed in _snd_pcm_rate_linear_open () from
/usr/lib/libasound.so.2
#7  0xb58955b9 in snd_pcm_hw_free () from /usr/lib/libasound.so.2
#8  0xb589fc2e in snd_pcm_close () from /usr/lib/libasound.so.2


I think that the person who will fix that problem should check everything
works OK with Ekiga and contact me personally in case of problem.

(The backtrace above is obtained after a export MALLOC_CHECK_=2 to force
crashes in case of memory allocation problems).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
05-03-06 01:09 BigBaaadBob    New Issue                                    
05-03-06 01:27 wellwhoopdedoooNote Added: 0009580                          
05-03-06 01:28 wellwhoopdedoooIssue Monitored: wellwhoopdedooo                  
 
05-03-06 01:29 wellwhoopdedoooNote Edited: 0009580                         
05-03-06 01:31 BigBaaadBob    Note Added: 0009581                          
05-03-06 11:45 tiwai          Note Added: 0009586                          
05-03-06 19:27 tiwai          Note Added: 0009601                          
05-05-06 22:49 BigBaaadBob    Note Added: 0009632                          
05-09-06 06:48 razamatan      Note Added: 0009651                          
05-09-06 06:49 razamatan      Issue Monitored: razamatan                    
05-09-06 06:55 razamatan      Note Edited: 0009651                         
05-09-06 07:23 razamatan      Note Edited: 0009651                         
05-09-06 13:20 dsandras       Note Added: 0009654                          
======================================================================




-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
