From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000728]: periodic noise in audio output
Date: Sat, 11 Jun 2005 10:12:18 +0200
Message-ID: <016238d7c35479d1437ff3fac798476f@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 626EA141
	for <alsa-devel@alsa-project.org>; Sat, 11 Jun 2005 10:12:18 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=728> 
======================================================================
Reported By:                virtualman
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   728
Category:                   SPARC - cs4231
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             12-16-2004 23:12 CET
Last Modified:              06-11-2005 10:12 CEST
======================================================================
Summary:                    periodic noise in audio output
Description: 
I am having a periodic crackling noise in my audio output. I sounds like
the audio signal was not continuous at block boundaries.

I installed alsa-drivers (1.0.7) on a gentoo system. Therefore a number of
patches have been applied.

My audio hardware is a CS4231 on a Sun Ultra 10, the driver module
therefore is snd-sun-cs4231.

======================================================================

----------------------------------------------------------------------
 virtualman - 12-21-04 20:09 
----------------------------------------------------------------------
The problem as described applied to using ALSA directly. Using the OSS
emulation results in even weirder sound output: It is played too fast
(about two times). But it is not high pitched, but rather whole blocks are
skipped.

I just tried an USB audio device. It works well, both directly and through
OSS emulation. So it must be a problem with the sun-cs4231 driver.

----------------------------------------------------------------------
 subdino - 06-11-05 10:12 
----------------------------------------------------------------------
Same problem here (U10, debian sid, same with kernel.org kernel).
Loaded modules : snd_sun_cs4231, snd_ioctl32 (and dependencies)
Alsa version : alsa-base 1.0.9b-1, alsa-utils 1.0.8-4  (debian packages)

With xmms, playing a sound file, the glitches aren't critical (periodic
noise, but play speed is normal). Here is my xmms config (as in output
plugin configuration window) :
***
Soundcard :
Buffer size = 500ms
Period length = 500ms
XMMS :
Buffer size = 1000ms
Multithread mode & mmap mode enabled
***
The most important part is, as far as I tried, that both soundcard buffer
must have the same size.

With scummvm, the sound is first almost correct, but goes worse and worse
as time goes. Pausing the game & resuming doesn't work, while exitting it
& launching it again works. At a certain point the CPU use goes crazy,
like 50% system time & 50% user time. But kernel doesn't crash, when
program is stopped the cpu usage goes back to normal. As far as I've
tested, it doesn't happens with xmms.

Alsaplayer is also really convenient to test different buffer sizes.

I used to get more sound corruptions when intensively using the mixer
settings while playing, but it hasn't happened recently (since I switched
to 2.6.11 maybe).

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-16-04 23:12 virtualman     New Issue                                    
12-21-04 19:01 tiwai          Note Added: 0002905                          
12-21-04 20:09 virtualman     Note Added: 0002906                          
06-11-05 10:12 subdino        Note Added: 0004987                          
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
