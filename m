From: Andrew Gaydenko <a@etver.com>
Subject: Re: ice1724 controls meaning
Date: Wed, 18 Feb 2004 15:39:13 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200402181539.13804@goldspace.net>
References: <200402162232.38240@goldspace.net> <s5h7jylybzz.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h7jylybzz.wl@alsa2.suse.de>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi,

Thanks! With your help (and after playing with alsamixer, (patched) qamix and pencil)
I have recognized almost all I have wanted. Nevertheless, one control isn't clear for
me (the issue isn't a stopper anyway). I mean 'Capture Route' enum items mnemonics. For
example:

- for "CD In 1" card input both the control values must be 'CD Left',
- for "Line In" input both control values must be 'Aux Left' (or 'Aux Right'? - don't 
  remember now, but it isn't important). 

You see, both control must have the _same values_ for normal _stereo_ capturing. I can
suggest three reasons of such inconsistency:

- my brain,
- the way concrete card manufacture has designed the card (Terratec Aureon 7.1 Space),
- the driver.

Which case to choose?

======= On Tuesday 17 February 2004 18:14, Takashi Iwai wrote: =======
At Mon, 16 Feb 2004 22:32:38 +0300,
Andrew Gaydenko wrote:

> numid=1, iface=CARD,name='ICE1724 EEPROM'

EEPROM contents.  not for mixer.

> numid=2, iface=MIXER,name='Multi Track Internal Clock'

the internal clock of the board.
note that ice1724 has a single rate for all channels.

> numid=3, iface=MIXER,name='Multi Track Rate Locking'

the rate locking - allow each app to set the rate or use
the fixed rate.

> numid=4, iface=MIXER,name='Multi Track Rate Reset'

reset the rate to the default value at each time the PCM is closed.
(the default value is the last internal clock rate.)

> > numid=5, iface=MIXER,name='H/W Playback Route'
> numid=6, iface=MIXER,name='H/W Playback Route',index=1
> ...
> numid=12,iface=MIXER,name='H/W Playback Route',index=7

the analog output routing for each channel.  they're enum.

> numid=13,iface=MIXER,name='Multi Track Peak'

peak meter.  read only.

> numid=14,iface=MIXER,name='IEC958 Playback Route'
> numid=15,iface=MIXER,name='IEC958 Playback Route',index=1

spdif output routing (left/right).  the enum valus.

> numid=16,iface=MIXER,name='IEC958 Output Switch'

turn on/off spdif output.

> numid=17,iface=PCM,name='IEC958 Playback Default',device=1

spdif status bits.  32bit long.

> numid=18,iface=MIXER,name='IEC958 Playback Con Mask',device=1
> numid=19,iface=MIXER,name='IEC958 Playback Pro Mask',device=1

available spdif status bit mask for consumer and professional modes.

> numid=20,iface=MIXER,name='DAC Volume'
> numid=21,iface=MIXER,name='DAC Volume',index=1
> ...
> numid=27,iface=MIXER,name='DAC Volume',index=7

DAC = digital-analog-converter
for each analog output channel.

> numid=28,iface=MIXER,name='Master Playback Volume'

master playback volume for analog outputs.

> numid=29,iface=MIXER,name='ADC Volume'
> numid=30,iface=MIXER,name='ADC Volume',index=1

ADC = analog-digital-converter
for each analog input channel.

> numid=31,iface=MIXER,name='Capture Route'

the recording source selection.   the enum values.


Takashi





-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
