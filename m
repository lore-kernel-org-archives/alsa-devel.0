From: andersvi@extern.uio.no
Subject: Re: vxpocket 440 with alsa, problems with vxloader
Date: Fri, 14 Jan 2005 15:30:24 +0100
Message-ID: <copsm54t75r.fsf@olivier.localdomain>
References: <copr7koutib.fsf@olivier.localdomain>
	<s5hu0pk6wlq.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hu0pk6wlq.wl@alsa2.suse.de> (Takashi Iwai's message of "Fri,
 14 Jan 2005 13:09:21 +0100")
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thanks alot for response.  It got me further, but still no sound
out.  Anybody got a clue where this gets wrong?

>>> "TI" == Takashi Iwai <tiwai@suse.de> writes:

>> alsa is version 1.0.7

TI> vxpocket/vxp440 driver in ALSA 1.0.7 has a severe bug.
TI> Try ALSA 1.0.8 instead.
TI> 
TI> On ALSA 1.0.8, the firmware is loaded via hotplug automatically, so
TI> you don't need vxloader.  (It's only for 2.6 kernels.)
TI> Don't forget to update alsa-firmware, too.

With alsa-1.0.8, and upgraded firmware it behaves as follows.
Pcmcia card is card-1, builtin sound is card-0:

  $ alsamixer -c1
  alsamixer: function snd_ctl_open failed for hw:1: No such device

Plugging in the card gives output:

  $ alsamixer -c1
  No mixer elems found

And trying to play through the pcmcia-card does not work:

  $ aplay -D hw:0,0 test.wav
  Playing WAVE 'test.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
  $ aplay -D hw:1,0 test.wav
  ALSA lib pcm_hw.c:1174:(snd_pcm_hw_open) open /dev/snd/pcmC1D0p failed: No such device
  aplay: main:508: audio open error: No such device

Seems the card is detected 

  $ cat /proc/asound/cards 
  0 [I82801DBICH4   ]: ICH4 - Intel 82801DB-ICH4
		       Intel 82801DB-ICH4 with STAC9750/51 at 0xf4fff800, irq 17
  1 [VXPocket440    ]: VXPocket440 - Digigram VXPocket440
		       Digigram VXPocket440 at 0x100, irq 3

But all "parameters" are set to zero or something. 

  $ cat /proc/asound/card1/vx-status 
  Digigram VXPocket440 at 0x100, irq 3
  DSP audio info:
  Input Source: Line
  Clock Mode: Auto
  Clock Source: Internal
  Frequency: 0
  Detected Frequency: 0
  Detected UER type: Consumer
  Min/Max/Cur IBL: 0/0/0 (granularity=0)

  $ cat /proc/asound/devices 
    0: [0- 0]: ctl
   20: [0- 4]: digital audio playback
   27: [0- 3]: digital audio capture
   26: [0- 2]: digital audio capture
   25: [0- 1]: digital audio capture
   16: [0- 0]: digital audio playback
   24: [0- 0]: digital audio capture
    1:       : sequencer
   33:       : timer
   32: [1- 0]: ctl
   36: [1- 0]: hardware dependent


  $ uname -a
  Linux localhost 2.6.10-2.1.ll.rhfc2.ccrma #1 Thu Dec 30 06:24:24 EST 2004 i686 i686 i386 GNU/Linux
  $ 


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
