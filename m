From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000728]: periodic noise in audio output
Date: Wed, 1 Mar 2006 00:59:37 +0100
Message-ID: <a5b5e5aecfce01110a5945de41de5fb0@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [85.132.177.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 071A21C7
	for <alsa-devel@alsa-project.org>; Wed,  1 Mar 2006 00:59:37 +0100 (MET)
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


The following issue has been CLOSED
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
Status:                     closed
Distribution:               
Kernel Version:             
Resolution:                 open
Fixed in Version:           
======================================================================
Date Submitted:             12-16-2004 23:12 CET
Last Modified:              03-01-2006 00:59 CET
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
 subdino - 06-11-05 10:14 
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

Of course, playing a CD (through analogic audio cable) works perfectly.



----------------------------------------------------------------------
 rlrevell - 12-30-05 21:48 
----------------------------------------------------------------------
You can't set the buffer and period sizes to the same values because at
least 2 periods need to fit in a buffer.

Try it with the default settings:

Soundcard :
Buffer size = 500ms
Period length = 50ms (not 500ms!)
XMMS :
Buffer size = 3000ms

Issue History
Date Modified  Username       Field                    Change              
======================================================================
12-16-04 23:12 virtualman     New Issue                                    
12-21-04 19:01 tiwai          Note Added: 0002905                          
12-21-04 20:09 virtualman     Note Added: 0002906                          
06-11-05 10:12 subdino        Note Added: 0004987                          
06-11-05 10:14 subdino        Note Edited: 0004987                         
06-18-05 17:42 subdino        Issue Monitored: subdino                     
12-30-05 21:48 rlrevell       Note Added: 0007265                          
03-01-06 00:59 rlrevell       Status                   new => closed       
======================================================================




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
