From: bugtrack@alsa-project.org
Subject: [ALSA - driver 0000475]: multiple input streams
Date: Fri,  3 Sep 2004 19:18:36 +0200 (CEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040903171836.F159C2D0C0@server.perex-int.cz>
Content-Type: text/plain; charset=iso-8859-1
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from mail.perex.cz (gate.perex.cz [82.113.61.162])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 4717A284
	for <alsa-devel@alsa-project.org>; Fri,  3 Sep 2004 19:18:37 +0200 (MEST)
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


A BUGNOTE has been added to this bug.
======================================================================
https://bugtrack.alsa-project.org/alsa-bug/bug_view_page.php?bug_id=0000475
======================================================================
Reported By:                omes
Assigned To:                perex
======================================================================
Project:                    ALSA - driver
Bug ID:                     475
Category:                   0_compilation problem_!!!
Reproducibility:            always
Severity:                   feature
Priority:                   normal
Status:                     assigned
Distribution:               
Kernel Version:             
======================================================================
Date Submitted:             08-30-2004 22:24 CEST
Last Modified:              09-03-2004 19:18 CEST
======================================================================
Summary:                    multiple input streams
Description: 
Why isnt ALSA handle multiple input streams by default?
======================================================================

----------------------------------------------------------------------
 tiwai - 08-31-2004 12:29 CEST 
----------------------------------------------------------------------
Please describe your problem more specifically.
Which sound card, etc?

----------------------------------------------------------------------
 omes - 09-03-2004 19:18 CEST 
----------------------------------------------------------------------
Sorry that i havent returned your post until now, ive been away this week.

Im currently using alsa-lib-1.0.6.

Im using an integrated sound card (came with an Asus motherboard):
00:1f.5 Multimedia audio controller: Intel Corp. 82801EB/ER (ICH5/ICH5R)
AC'97 Audio Controller (rev 02)

An example:
If I play audio in xmms, then load xine to play a movie or so, this is
what it says in the shell;

bash-2.05b$ xine
This is xine (X11 gui) - a free video player v0.99.2.
(c) 2000-2004 The xine Team.
ALSA lib pcm_hw.c:1155:(snd_pcm_hw_open) open /dev/snd/pcmC0D0p failed:
Device or resource busy

mplayer gives this result:
==========================================================================
Opening audio decoder: [mp3lib] MPEG layer-2, layer-3
MP3lib: init layer2&3 finished, tables done
AUDIO: 44100 Hz, 2 ch, 16 bit (0x10), ratio: 24000->176400 (192.0 kbit)
Selected audio codec: [mp3] afm:mp3lib (mp3lib MPEG layer-2, layer-3)
==========================================================================
Checking audio filter chain for 44100Hz/2ch/16bit -> 44100Hz/2ch/16bit...
AF_pre: af format: 2 bps, 2 ch, 44100 hz, little endian signed int
AF_pre: 44100Hz 2ch Signed 16-bit (Little-Endian)
audio_setup: Can't open audio device /dev/dsp: Device or resource busy
alsa-init: got device=0, subdevice=0
alsa-init: 1 soundcard found, using: default

(. gmplayer freeze .)

(. Closing xmms .)

alsa: 44100 Hz/2 channels/4 bpf/65536 bytes buffer/Signed 16 bit Little
Endian
AO: [alsa] 44100Hz 2ch Signed 16-bit (Little-Endian) (2 bps)
Building audio filter chain for 44100Hz/2ch/16bit -> 44100Hz/2ch/16bit...
Video: no video
Starting playback...
ALSA lib control.c:654:(snd_ctl_open_noupdate) Invalid CTL /dev/mixer
alsa-control: mixer attach /dev/mixer error: No such file or directory
ALSA lib control.c:654:(snd_ctl_open_noupdate) Invalid CTL /dev/mixer
alsa-control: mixer attach /dev/mixer error: No such file or directory
ALSA lib control.c:654:(snd_ctl_open_noupdate) Invalid CTL /dev/mixer
alsa-control: mixer attach /dev/mixer error: No such file or directory

(...)

(. Terminating .)

ALSA lib control.c:654:(snd_ctl_open_noupdate) Invalid CTL /dev/mixer
alsa-control: mixer attach /dev/mixer error: No such file or directory
ALSA lib control.c:654:(snd_ctl_open_noupdate) Invalid CTL /dev/mixer
alsa-control: mixer attach /dev/mixer error: No such file or directory
[ws] Error in display.
[ws]  Error code: 17 ( BadImplementation (server does not implement
operation) )[ws]  Request code: 20
[ws]  Minor code: 0
[ws]  Modules: key_events
Xlib: sequence lost (0x1406c > 0x407b) in reply type 0x11!

so mplayer complaines about control.c, and xine complaines about pcm_hw.c,
both in the alsa-lib.

Hope this helped a bit.

Bug History
Date Modified  Username       Field                    Change              
======================================================================
08-30-04 22:24 omes           New Bug                                      
08-31-04 12:29 tiwai          Bugnote Added: 0001671                       
09-03-04 18:47 omes           Bug Monitored: omes                          
09-03-04 19:18 omes           Bugnote Added: 0001696                       
======================================================================


-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=5047&alloc_id=10808&op=click
