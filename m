From: Juha <juhis@trinity.is-a-geek.com>
Subject: CD SPDIF in Soundblaster Live 5.1 working?
Date: Mon, 06 Oct 2003 18:27:43 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1065454063.968.16.camel@client.veehoo.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi there,

I'm trying to route spdif signal from my dvb card through my soundcard,
a sb live 5.1, to my amplifier. My amplifier states that it's 48kHz
spdif signal. I connected the spdif out of the dvb card to the "CD
SPDIF" connector of the sb live card. Is this the proper way to do it,
ie, should it work or could it be made to work? 

I've tried to get some clue about alsamixer settings from 

http://alsa.opensrc.org/?SBliveMixer

>From the above webpage I get the idea, that spdif capture should be
possible with alsa drivers. Especially the "IEC958 TTL Capture Volume"
switch sounds like it could turn on spdif input. The webpage also states
that:

...
This PCM device (it's the 4th PCM device (index 3!) and first subdevice
(index 0) for a given card) allows to forward 48kHz, stereo, 16-bit
little endian streams without any modifications to the digital output
(coaxial or optical).
...

And this (if I understand correctly) is exactly what I want to do. But,
for some reason, I can't see the 4th PCM device. A listing of the
capture devices don't list that as an option:

bash:~# arecord -l
**** List of CAPTURE Hardware Devices ****
card 0: Live [Sound Blaster Live!], device 0: emu10k1 [EMU10K1]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Live [Sound Blaster Live!], device 1: emu10k1 mic [EMU10K1 MIC]
  Subdevices: 1/1
  Subdevice #0: subdevice #0
card 0: Live [Sound Blaster Live!], device 2: emu10k1 efx [EMU10K1 EFX]
  Subdevices: 1/1
  Subdevice #0: subdevice #0


I've tried different options to snd-emu10k1. Currently I'm using the
following line, since it gives me the most options to play with.

options snd-emu10k1 extin=0x3fff extout=0x1fff

I'm using version 0.9.7 of the driver. Any help would be *greatly*
appreciated. Is this even possible with the card, I'm pretty clueless at
the moment.

Best regards,

Juha




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
