From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: Tascam US-224 support: MIDI OK, Audio KO?
Date: Tue, 30 Mar 2004 09:14:14 +0100 (WEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <62898.195.245.190.94.1080634454.squirrel@www.rncbc.org>
References: <44618.195.245.190.94.1080560065.squirrel@www.rncbc.org>
    <200403292129.04497.annabellesgarden@yahoo.de>
    <32817.192.168.1.5.1080596468.squirrel@www.rncbc.org>
    <200403300157.51963.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200403300157.51963.annabellesgarden@yahoo.de>
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

Karsten,

>
> please try to enable audio out with "us428control -v2 -D hw:1" like this:
>
> - toggle INPUT MONITOR until us428control says "...Light is 1"
>

Yes, it does say "... Light is 1", but NO light on the LED.


> - then move Fader3 to max and play some audio.
> This is just a guess assuming audio out is mapped on us224 internal mixer
> 2, input monitor channel 1 is mapped on us224 internal mixer 0 and input
> monitor channel 2 is mapped on us224 internal mixer 1.
>

Nothing is heard.


> - Please also try your guitar on both inputs: move faders 1 & 2 to see if
> sound is routed to the outputs.
>

Again, nothing seems to be routed. No signal appears on output. Have
tryied on both guitar inputs (A and B), with several combinations and
fader positions, but can hear a thing.


>
> We have to tweak us428control to add real us224 support.

I guess that will be really necessary to have a proper us224control :)


> Above is just to verify that the current us428 internal mixer mechanics is
> usable for the us224.
>

It seems that it is not quite straightforward, isn't it? Is there any
other US-224 user out there to at least confirm all this? It surely ain't
nice this feeling of lonelyness ;) but I will prevail =:O


> Concerning us224's Lights I'm currently left in the dark....

So do the LEDs ;)


> For us428 I found that a 7Byte long USB-Message on pipe 4 is a Lights set
> command, while a 5Byte long is an internal mixer set command.
> You could tweak us428control to toggle the 0'th light instead of the 25'th
> light, which is InputMonitor Light on us428. the 0th light is Select
> Channel 1 on the us428.
> Exchange Cus428State.cc Line 118 , 119
> 				Light[0].Value = StateInputMonitor() ? SelectInputMonitor : Select;
> 				Light[2].Value = StateInputMonitor() ? MuteInputMonitor : Mute;
> for
> 				Light[0].Value = 0x55;
> 				Light[2].Value = 0xAA;
> to check light mechanics.
>

I'll try this tonight, rest assured.


> If there's still no lights, some usb snooping on windoz might help.
> I've some specially tuned stuff here which I could send you then.
>

That's of course a very good idea. Please do so ASAP.

I'll be very pleased to follow your instructions and get a thorough
profile on this. My laptop has a working winxp partition installed and the
US-224 (audio mixer leds) works there as designed, but that's hardly a
surprise for anyone :)

Cheers,
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
