From: noreply@alsa-project.org
Subject: [ALSA - driver 0000033]: Capture does not work with VIA VT8237 and ALC655
Date: Fri, 16 Jul 2004 14:35:53 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040716123553.CB6082C005@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 1DF24244
	for <alsa-devel@alsa-project.org>; Fri, 16 Jul 2004 14:35:54 +0200 (MEST)
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


The following bug has been CLOSED
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000033
======================================================================
Reported By:                Niccolo Rigacci
Assigned To:                tiwai
======================================================================
Project:                    ALSA - driver
Bug ID:                     33
Category:                   PCI - via82xx
Reproducibility:            always
Severity:                   major
Priority:                   normal
Status:                     closed
Distribution:               alsa-source_1.0.1-1_all.deb
Kernel Version:             2.4.22
======================================================================
Date Submitted:             02-03-2004 14:43 CET
Last Modified:              07-16-2004 14:35 CEST
======================================================================
Summary:                    Capture does not work with VIA VT8237 and ALC655
Description: 
I have a motherboard based on the VIA KT600 Northbridge and the VT8237
Southbridge. The codec is an ALC655.

I tried the ALSA module snd-via82xx. PCM audio works fine, but several
things did not work:

- The MIC input does not work, no matter how I set alsamixer
  controls (the OSS driver via82cxxx_audio, instead can
  properly mix the input). LINE and CD inputs work.

- Capture does not work. I tried to enable capturing from
  MIC, LINE or CD, but no stream is received by arecord.
  Also OSS emulation (/dev/dsp) does not receive any data.
  I tried to set, unmute and capture any control in
  alsamixer. The OSS dirver via82cxxx_audio can't capture
  too.

======================================================================

----------------------------------------------------------------------
 tiwai - 02-04-2004 17:49 CET 
----------------------------------------------------------------------
please attach /etc/asound.state and the contents of
/proc/asound/card0/codec97#0/* files.

----------------------------------------------------------------------
 ukonrad - 02-13-2004 18:42 CET 
----------------------------------------------------------------------
Same Problem with VT8235 and ALC650 on Asus A7V8x with 1.02c drivers,
Kernel 2.6.2. When i plug in my tv card from line-in to mic jack there is
sound but when i start krec the right channel is always louder as the
left. When i  split the mic in kamix to left and right channel playing
around with the activate buttons from the playback moves mic right slider
to 0 ! Switching both input source to line and record from mic krec shows
the right channel from line ( seems so ) and the left channel ~ -17db
constant. Now when i thumb the mic ( ooooops ) on the table there is a
little change in the left channel in krec visible. Switching the left
input source in kamix to mic mutes both channels in krec. Under windows
2000 ( argh ) recording works very fine from mic. Playback on linux works
very fine including via dxs and spdif out.

----------------------------------------------------------------------
 tiwai - 03-01-2004 19:17 CET 
----------------------------------------------------------------------
the mic input might be dependent on 'Input Source Select' enum control. 
please make sure that 'Mic' is chosen.
and, turn OFF 'Mic As Center/LFE'.  this means that the mic jack
is used for center/lfe output!

if it still doesn't help, my wild guesses are:

- there could be a problem of mic-input bias level on the old
  ALC650 chip.  try the attached patch.
- there are two capture devices, hw:0,0 and hw:0,1.  try both.

----------------------------------------------------------------------
 tiwai - 03-02-2004 12:29 CET 
----------------------------------------------------------------------
the last patch was broken.  the fixed one is uploaded.

----------------------------------------------------------------------
 ukonrad - 03-03-2004 17:19 CET 
----------------------------------------------------------------------
i try to use the patch you uploaded, but in alsa-driver 1.02c as in 1.03
patching failed ( not always, only hunk#1 ). The driver compiles but no
change at all. How can i switch hw:0,0 hw:0,1 with normal mixer ( kmix
kamix )??? !!!! With the partial applied patch capture from line in on
right channel is broken by me. Is it possible that kmix or kamix are not
able to switch right the recording channel. Kmix from kde3.2 seems very
buggy ( you can select all channel at one to record :-( ) Is it possible
to record ( for test ) with arecord ?? But what is the correct command to
record from mic hw:0,0 or hw:0,1

----------------------------------------------------------------------
 tiwai - 03-04-2004 11:00 CET 
----------------------------------------------------------------------
there is only one mixer.
hw:0,0 and hw:0,1 are meant for the pcm, i.e.

   % arecord -Dhw:0,1 -fdat foo.wav

i don't know whether kmix or kamix is buggy.  try amixer or
alsamixer, then.

----------------------------------------------------------------------
 ukonrad - 03-06-2004 12:37 CET 
----------------------------------------------------------------------
I try to record with arecord with unpatched 1.02c kernel driver on
2.6.4-rc1 today. Capture with both "input source select" switched to
"line" and recording source "line" records bad from "line in" jack. Left
channel shows input, right channel nothing or only still -30 db in krec.
Recorded sound is clear but only mono ( left channel ). Switching the
recording channel to "cd" ... same effect but also recorded sound is very
noise and has NO dynamic. Xine both time shows only output on left
channel. Capture with both "input source select" switched to "mic" and
recording source "mic" records nothing from "mic" jack. I don't know where
to start, there is nothing what has properly function when recording.

----------------------------------------------------------------------
 ukonrad - 03-19-2004 18:05 CET 
----------------------------------------------------------------------
I am so crazy, first i have done "patch -p 1 'your patch'" in main
directory "alsa-driver-1.0.3". Hunk 1 failed !!!! But i have to patch in
"alsa-driver/alsa-kernel". With the patch applied recording from mic are
OK. Thanks, and sorry ....

----------------------------------------------------------------------
 Niccolo Rigacci - 04-18-2004 10:49 CEST 
----------------------------------------------------------------------
Solved.

Sorry for not giving feedback to this thread, but I had very little time,
yesterday I started to work to the problem again. First I upgraded to
kernel 2.4.25 and alsa 1.0.3 (not the latest, but I prefer to stay with
Debian Testing). Don't know what solved the problem, but now the MIC input
works well and capturing works too.

Many thanks to all the people working on this project.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
02-03-04 14:43 Niccolo RigacciNew Bug                                      
02-04-04 17:49 tiwai          Bugnote Added: 0000154                       
02-04-04 17:49 tiwai          Assigned To               => tiwai           
02-04-04 17:49 tiwai          Status                   new => assigned     
02-06-04 01:15 Niccolo RigacciFile Added: asound.state                     
02-06-04 01:15 Niccolo RigacciFile Added: ac97#0-0                         
02-06-04 01:15 Niccolo RigacciFile Added: ac97#0-0+regs                    
02-13-04 18:42 ukonrad        Bugnote Added: 0000239                       
02-14-04 10:52 ukonrad        Bug Monitored: ukonrad                       
02-14-04 10:52 ukonrad        Bug End Monitor: ukonrad                     
03-01-04 19:17 tiwai          Bugnote Added: 0000417                       
03-01-04 19:17 tiwai          File Added: alc650-mic-bias.dif                    
03-02-04 12:29 tiwai          Bugnote Added: 0000439                       
03-02-04 12:30 tiwai          File Added: alc650-mic-bias2.dif                    
03-03-04 17:19 ukonrad        Bugnote Added: 0000467                       
03-04-04 11:00 tiwai          Bugnote Added: 0000476                       
03-06-04 12:37 ukonrad        Bugnote Added: 0000517                       
03-14-04 18:09 dESA54         Bug Monitored: dESA54                        
03-19-04 18:05 ukonrad        Bugnote Added: 0000645                       
04-18-04 10:49 Niccolo RigacciBugnote Added: 0000851                       
04-23-04 17:20 tiwai          Resolution               open => fixed       
04-23-04 17:20 tiwai          Status                   assigned => resolved
07-16-04 14:35 tiwai          Status                   resolved => closed  
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
