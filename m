From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000669]: Creative SB Live! 24-bit External (USB) works only at a minimal level.
Date: Sun, 9 Jan 2005 02:04:11 +0100
Message-ID: <cedc30b72d4e040fe6ca0e2110584b1a@bugtrack.alsa-project.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from bugtrack.alsa-project.org (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id DD33A1E9
	for <alsa-devel@alsa-project.org>; Sun,  9 Jan 2005 02:04:11 +0100 (MET)
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
<https://bugtrack.alsa-project.org/alsa-bug/view.php?id=669> 
======================================================================
Reported By:                Henni
Assigned To:                Clemens Ladisch
======================================================================
Project:                    ALSA - driver
Issue ID:                   669
Category:                   USB - usb-audio
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               Gentoo 2004.3
Kernel Version:             2.6.9-cko3
======================================================================
Date Submitted:             11-23-2004 19:23 CET
Last Modified:              01-09-2005 02:04 CET
======================================================================
Summary:                    Creative SB Live! 24-bit External (USB) works only
at a minimal level.
Description: 
The Creative SB Live! 24-bit External is a "card" similar to the Audigy 2
NX (probably its litte brother).

With the snd-usb-audio the ''only'' thing working is the stereo output. I
read that the Audigy 2 NX works far better with the snd-usb-audio.
Probably there is a way to get the SB Live! 24-bit on a similar lvl?

PS: I added some informations about it as an attachment.

======================================================================

----------------------------------------------------------------------
 Henni - 11-24-04 00:51 
----------------------------------------------------------------------
Yes. I tried alsamixer. It shows only PCM Output and PCM Capture (I got
"PCM capture" by using the "Show only Capture" option of alsamixer).

I 'got' working the 4 and 6 channels Mode with mplayer by using the
following option:

  mplayer $FILE -channels 4 (or 6) -ao alsa:device=default 

(I have to use alsa:device=default because mplayer tries to use surround41
or surround51 if you choose alsa and channels > 2 and this results in an
error).

But DigitalOut doesn't work as it should.

If I choose mplayer $FILE -channels 4 the digital out works (testet with
an Pioneer Home Cinema System with Optical In). With -channels 6 I get an
underrun and with -ac hwac3 (for AC3 Passthrough) it doesn't work (there
is no definition for the optical out).

----------------------------------------------------------------------
 kempokaraterulz - 01-09-05 02:04 
----------------------------------------------------------------------
I have the same results  as the original reporter, except i notice randomly
my sound dies and i have to pause / unpause whatever i was playing music
in in order to get the sound to come out again. This may not be alsa's
fault since i find that  my usb webcam randomly dies when attached to my
laptop as well. 

Here is some additional info about the unit itself,
FRONT: 
Two LED's: 1 power (if  driver is loaded it is lit) 1 'CMSS' light ... ive
never seen it lit
A 'CMSS' button, pressing it appears to have no effect, no messages are
logged in any of my logs either
An IRDA port, doesnt seem to be detected in any way on the computer
A head phone jack: Works
A microphone jack: Untested
An optical output: Works in 2 channel mode
TOP:
An analog Mic level wheel (untested)
A click wheel type deal thats for controlling volume: Non functional
Pushing in the volume click wheel is supposed to mute / unmute, but it
only mutes and the only way to unmute is to unload the driver and reload
the driver
BACK:
C/Sub port: Untested
Rear Port: Untested
Front Port: Untested
Line in port: Untested
SPDIF Out: Works, but only in 2 channel mode
DIN(for controlling creative brand speakers i guess): Untested
USB 2.0 connection.

Issue History
Date Modified  Username       Field                    Change              
======================================================================
11-23-04 19:23 Henni          New Issue                                    
11-23-04 19:23 Henni          File Added: output.txt                       
11-23-04 19:23 Henni          Distribution              => Gentoo 2004.3   
11-23-04 19:23 Henni          Kernel Version            => 2.6.9-cko3      
11-23-04 19:58 Henni          Issue Monitored: Henni                       
11-23-04 21:09 pzad           Note Added: 0002527                          
11-24-04 00:51 Henni          Note Added: 0002540                          
01-09-05 02:04 kempokaraterulzNote Added: 0003133                          
======================================================================




-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
