From: Denis Sbragion <d.sbragion@infotecna.it>
Subject: Re: EWX 24/96 SPDIF input problem with 0.9.4 (and
  "compiler.h")
Date: Mon, 30 Jun 2003 17:55:39 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <5.1.0.14.1.20030630171403.0206b8e8@pop3.infotecna.lcl>
References: <s5hn0fzljm8.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0306301651490.13946-100000@pnote.perex-int.c
 z>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jaroslav Kysela <perex@suse.cz>, Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hello Jaroslav and Takashi,

At 16.53 30/06/2003 +0200, Jaroslav Kysela wrote:
...
>Sorry for late reply. My EWS 24/96 does not have this problem. I suggest
>to create a control which will turn on/off the V bit checking. I also
>suggest to verify the cable connection.

don't worry for the late reply, I know you're always so busy with the many 
ALSA development tasks. I'm not in a hurry cause I can always switch back 
to 0.9.3. In the meantime I've done many tests that may help find where the 
problem is. Here are some informations:

- I tested using BruteFIR and arecord. Things change between the two.
- Using the 0.9.4 drivers "downgraded" with just the cs8427 module from 
0.9.3, both BF and arecord work like a charm.
- Using the 0.9.4 cs8427 module arecord works but BF doesn't. No error pops 
up, BF just wait forever for samples to come in.
- If I try arecord immediately after killing BF it doesn't work either, 
again no error, just endless wait. But if I go to alsamixer and switch the 
sample rate from SPDIF to any value and then back to SPDIF before starting 
arecord, arecord starts to work again.

Of course I've already double checked any cabling problem.

I digged into BF to see if it does something weird that may fools the 
driver, even disabling parts of the code to see if there's any particular 
action that cause the driver to fail, but had no success. What BF does is 
not that much different from what arecord does, at least it looks ok to me, 
though I'm not an expert with ALSA programming. I checked also the driver 
to see if there's something wrong with the new reset code, double checking 
it against the newest cs8427 data sheet where the reset procedure is 
explained, but also here everything looks ok. I tried disabling just the V 
bit, and played also with many other cs8427 settings, but again no success. 
I also upgraded from the old 2.4.7 kernel to a newest 2.4.20, and nothing 
has changed.
         Some other informations. The V bit with older drivers caused 
problems only when lowering the volume on my CD player, which changes also 
the SPDIF output volume (pretty weird, I know). Below a given threshold the 
soundcard started with glitches and distortion, muting completely if I 
lowered the volume a bit more. So may be it's just the CDP that outputs 
something that the cs8427 sees as invalid. Anyway listening to the sound 
with the V bit disabled doesn't show any audible distortion even well below 
the glitching threshold, but may be the cs8427 is catching something which 
is not audible under normal conditions. I think the suggestion of creating 
a control to switch the V bit on and off would be an ideal solution.
         Finally some other small bugs which you may be interested in fixing:

- If I load the ice1712 driver and sets the DAC volumes to 100% using 
"alsactl restore" from a prevoius "alsactl store" the right channel remains 
muted. Alsamixer reports it as being at 100%, but no sound from it. I have 
to change the volume back  using amixer or alsamixer to get the channel 
unmuted. This is laying around since 0.9.0rc5. It's just an annoying quirk. 
I already checked in the drivers to see if there's something wrong but 
found nothing.
- If I set the volume of the ADCs to 0, do an "alsactl store" and then an 
"alsactl restore", the ADC volume of both channels is set to 101, when 100 
should be the maximum value, but both ADCs are anyway muted. This has 
started since 0.9.2 or 0.9.1, I'm not sure, but was not present in 0.9.0rc5.
- The sample rate loops between 48000 to 8000 when changed from alsamixer 
in one direction, go up to 96000, then SPDIF and the stop with no looping 
there when changed the other way around.

Hopes this helps. I hope to have the time to check the CVS version. 
Unfortunately I'm a bit busy.

Bye,
--
	Denis Sbragion
	InfoTecna
	Tel: +39 0362 805396, Fax: +39 0362 805404
	URL: http://www.infotecna.it



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
