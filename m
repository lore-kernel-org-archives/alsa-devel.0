From: Andreas Hartmann <andihartmann@freenet.de>
Subject: Digigram VXpocket440 on SuSE 10.1 - a lot of problems
Date: Sat, 09 Dec 2006 19:58:26 +0100
Message-ID: <457B0752.6060203@p54A1AAF0.dip0.t-ipconnect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello!

I've got the following PCMCIA-card, running on SuSE 10.1 (kernel
2.6.16.21-0.25-default, and alsa-firmware-1.0.10-13,
alsa-tools-1.0.11-16, alsa-1.0.11-32)

The card is recognized as following:

aplay -l
card 0: VXPocket440 [Digigram VXPocket440], device 0: VX PCM [Digigram
VXPocket440]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: VXPocket440 [Digigram VXPocket440], device 1: VX PCM [Digigram
VXPocket440]
  Subdevices: 1/1
  Subdevice #0: subdevice #0


/proc/asound> cat devices
  2:        : timer
  3: [ 0- 1]: digital audio playback
  4: [ 0- 1]: digital audio capture
  5: [ 0- 0]: digital audio playback
  6: [ 0- 0]: digital audio capture
  7: [ 0]   : control


/proc/asound> cat pcm
00-01: VX PCM : Digigram VXPocket440 : playback 1 : capture 1
00-00: VX PCM : Digigram VXPocket440 : playback 1 : capture 1

/proc/asound> cat timers
G0: system timer : 4000.000us (10000000 ticks)
P0-0-0: PCM playback 0-0-0 : SLAVE
P0-0-1: PCM capture 0-0-1 : SLAVE
P0-1-0: PCM playback 0-1-0 : SLAVE
P0-1-1: PCM capture 0-1-1 : SLAVE

/proc/asound> cat version
Advanced Linux Sound Architecture Driver Version 1.0.11rc3 (Sun Jan 22
09:27:15 2006 UTC).

/proc/asound/card0> cat vx-status
Digigram VXPocket440 at 0xc100, irq 3
Xilinx Firmware: Loaded
Device Initialized: Yes
DSP audio info: realtime linear8 linear16 linear24
Input Source: Mic
Clock Mode: Auto
Clock Source: Internal
Frequency: 44100
Detected Frequency: 0
Detected UER type: Not Present
Min/Max/Cur IBL: 504/2016/504 (granularity=126)


All problems are related to the S/PDIF-out (I didn't test the analog
output so far).

1. distortions on high frequencies
When starting playback, almost every time(!), the sound is distorted, it
is rattling. It is really ugly. If the playback is paused for a few
seconds and started again, most times, the sound is fine afterwards.
Going back a few seconds can help, too.

2. muting the pcm does not work properly
If playback is muted with alsamixer or kmix, often just one channel
(left or right) is muted or unmuted.

3. pcm volume control
Adjusting the volume sometimes leads to one missing channel or the
channels are differently loud.

4. machine hangup
After removing the card, the actual session is dead, which means:
keyboard doesn't work any more, but the mouse is working. It isn't
possible to switch to another console - even with the mouse. But it is
possible to login remote with another KDE-session e.g.

5. fimrware?
vx-status reports, that the firmware would be loaded. I didn't start
vxloader. If I start it, I'm getting the message:

vxloader: no VX-compatible cards found


Meanwhile, I tried the following things - but nothing changed:
-> alsa 1.0.13
-> alsa 1.0.14rc1

I tested another DAC - always the same problems. This means, the error
must be in the software or the hardware is broken.

I tested the playback running under root - nothing changed.


BTW: capturing seems to work fine :-).


I would be very glad if I could get some hints, especially to problem 1
- it has the highest priority!

Kind regards,
Andreas Hartmann



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
