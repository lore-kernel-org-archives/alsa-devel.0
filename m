From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0001425]: Driver only records left channel when requested to record in stereo from Line-In
Date: Thu, 15 Sep 2005 22:08:48 +0200
Message-ID: <d5fb221c556fff8368e0dbb230aad043@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id D4670175
	for <alsa-devel@alsa-project.org>; Thu, 15 Sep 2005 22:08:48 +0200 (MEST)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=1425> 
======================================================================
Reported By:                David Klusacek
Assigned To:                
======================================================================
Project:                    ALSA - driver
Issue ID:                   1425
Category:                   PCI - ens1371
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     new
Distribution:               my own build
Kernel Version:             2.6.5
======================================================================
Date Submitted:             09-15-2005 21:49 CEST
Last Modified:              09-15-2005 22:08 CEST
======================================================================
Summary:                    Driver only records left channel when requested to
record in stereo from Line-In
Description: 

DESCRIBTION

When recording analog source, only one channel is really being captured,
while the other returns some garbage (usually low volume), regardless of
the recording program being used. 

The cables I'm using are OK, since although the right channel cannot be
recorded it still gives rise to feedback driven oscilations when the
volume of Line-In is  
elevated enough (and microphone (which is connected to Line-In thru
low-noise amplifier) captures what the speaker emits).

The interesting thing is that the left channel behaves the opposite way.
It can 
be recorded, but it cannot be listened to just by changing the volume by
the alsamixer. 

I'm using kernel version 2.6.5, alsa driver version 1.0.9b, alsa library
version 1.0.9, alsa utils version 1.0.9a, all compiled by gcc-2.95.3 with
glibc-2.2.5.



STEPS TO REPRODUCE

(a) Set up the mixer (this is taken from my system init scripts. It looks
strange but it was the only way to get the volume right the old days I had
VA-503+ mainboad (FIC).)

amix()
{
  amixer -qc "$@"
  usleep 100000
}

mmm() { #strange workaround for ill behaving card or chipset
  amix  $1 set Master 70% mute
  amix  $1 set Master 60% unmute
  amix  $1 set Capture 70% unmute
  amix  $1 set Mic 100% captur mute
  amix  $1 set PCM 70% mute
  amix  $1 set PCM 90% unmute
  amix  $1 set PCM 95% unmute
  amix  $1 set Master 100% unmute
  amix  $1 set Capture 80% mute
  amix  $1 set Mic 50% captur mute
  amix  $1 set Capture 50% unmute
  amix  $1 set Line 0% captur mute
}

(b) connect left channel of Line-In to signal source.

arecord -f dat left.wav

(c) connect right channel of Line-In to signal source.

arecord -f dat right.wav

(d) when playing left.wav and right.wav you will find out, that right.wav
contains nearly silence in its right channel and some crosstalk in the
left channel, while the left.wav contains the recorded signal in its left
channel.


NOTE

This problem appears to exist on at least three different soundcards
(snd-ens1371, snd-via82xx and snd-intel8x0 (intel records left and omits
right channel)), I think that it may have something to do with the pcm
core or 
snd-ac97-codec. 

Note also, that drivers for ens1371 and via82xx worked well in the older
(0.5.10b) versions of ALSA.


======================================================================

----------------------------------------------------------------------
 David Klusacek - 09-15-05 22:08 
----------------------------------------------------------------------
ad (a) in steps to reproduce: I have acidentally omitted the last command:

mmm 0

Issue History
Date Modified  Username       Field                    Change              
======================================================================
09-15-05 21:49 David Klusacek New Issue                                    
09-15-05 21:49 David Klusacek Distribution              => my own build    
09-15-05 21:49 David Klusacek Kernel Version            => 2.6.5           
09-15-05 22:08 David Klusacek Note Added: 0006223                          
======================================================================




-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
