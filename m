From: Karsten Wiese <annabellesgarden@yahoo.de>
Subject: Re: Tascam US-224 support: MIDI OK, Audio KO?
Date: Mon, 29 Mar 2004 21:29:04 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200403292129.04497.annabellesgarden@yahoo.de>
References: <44618.195.245.190.94.1080560065.squirrel@www.rncbc.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <44618.195.245.190.94.1080560065.squirrel@www.rncbc.org>
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
Cc: Rui Nuno Capela <rncbc@rncbc.org>
List-Id: alsa-devel@alsa-project.org

Am Montag 29 M=E4rz 2004 13:34 schrieb Rui Nuno Capela:
>=20
> My first question goes whether us428control's not recognizing any USx2y
> hardware dependant stuff (hwdep) either on hw:0 or hw:1. I'm almost sure
> that it should be on hw:1 as the US-224 is configured as my second
> soundcard under the ALSA configuration (i.e. alias snd-usb-usx2y
> snd-card-1). But us428control does not find anything, at least after the
> firmware gets loaded.
I only have a us428 here, so I assume us224 behaves the same.

could it be it is already running (started by hotpug scripts which were=20
installed with alsa)?=20
Did you try "ps -aux|grep us428control" ?
	aconnect -li gave you among others
	 client 129: 'US-428' [type=3Duser]
	     0 'Controls        '
this usually is due to us428controls activity.
>
> Strange enough, to me at least, us428control seems to work between the fw
> and fpga loading steps. Using lsusb, I've noticed that the USB ids do
> change from 1604:8004 to 1604:8005 while plugging in. Guess that's normal,
> and it marks the momemt when fw is loaded and fpga is about to.
>
> The second one is about the LEDs on the control surface: besides the USB
> light, isn't that supposed to light up anything else? Everything else is
> dead dark. Touching the knobs, pushing the buttons or whatever doesn't
> make any visible difference. Is that supposed to be normal?
if us428control is running ok (AND fits the us224), INPUT MONITOR Led is=20
functional.
Also if INPUT MONITOR Led is ON, SELECT and MUTE Leds work.

>
> OK. I've tested on two different systems, a Compaq laptop w/Mandrake 10.0
> (P4 2.533GHz, OHCI) and on a custom desktop w/SUSE 9.0 (P4 3.333GHz
> SMP/HT, UHCI). On both, the firmware seems to get loaded and only visible
> thing to note is that the USB light gets lit.
>
> The only thing that i could get to work is the MIDI interface. AFAICT all
> faders, buttons and the jog wheel do send MIDI control events, and I could
> intercept those on the ALSA sequencer interface. MIDI seems pretty
> functional then. I could also test the external raw MIDI interface, by
> sending out some notes and it seems to work too.
faders, buttons and the jog wheel do send MIDI control events are made by=20
us428control.

>
> It's the PCM audio part that gets me worried. ALSA reports both capture
> and playback PCM interfaces. But on all my tests I could only ear silence.
> Not a sound. Dead silence only. Although it all seems to be OK, at least
> as reported by ALSA.
us428 MASTER Slider behaves funny here:=20
if it is set to MAXIMUM at Firmware BootUp, it tells us428control that it i=
s=20
ZEROed!
To hear audio here I have to set MASTER Fader below MAX first.
Later I can put it to MAX and it behaves as expected.

>
> Quite traditionally this symptom is due to initially default muted mixer
> channels, but running `alsamixer -c1` reports that there's no mixer elems.
> So how can I unmute this beast?
>
Hope the above helps. Mixer support isn't yet written, sorry.

To see if capturing works:
can you record a file and it looks like expected in an audio editor?

(UHCI worked more often than OHCI, but also UHCI can be tricky:
on a via mobo one connector does it, but the other not !?!)

Cheers,
Karsten



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
