From: p z oooo <pzad@pobox.sk>
Subject: Re: Sound programming confusion
Date: Thu, 26 Feb 2004 20:36:53 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200402261936.i1QJar0j024556@www3.pobox.sk>
Reply-To: p z oooo <pzad@pobox.sk>
Mime-Version: 1.0
Content-Type: TEXT/plain; charset=iso-8859-2
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: kbass@kenbass.com
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

>1) I've got 3 separate PCM 'mono' streams of data that I want to=20
>send to
>3 different outputs.

Should work.

>  a) How many PCM inputs do these cards/drivers support? Under OSS,
>there were 2, /dev/dsp and /dev/dsp1. Ideally I would like each=20
>input
>stream to have a seperate sample rate. In practice, 2 of them will=20
>be

If you how many PCM streams you may play at one time, then 32.

>25kHz, and one will be 22050Hz.

This should work.

>2) I want to reconfigure the 'routing' on the fly. How do I do this?
>I've seen documentation (which wasn't clear) about .asoundrc files=20
and
>such, but I need to change this programmaticaly.
>  Input 1- 25 kHz PCM stream=20
>  Input 2- 25 kHz PCM stream
>  Input 3- 22050Hz PCM stream
>  Output 1 - Front L
>  Output 2 - Front R
>  Output 3 - Rear L

Then you must use control (mixer) interface too.

>3) I'm totally confused about the capabilities of this card. Is this
>described at a high level somewhere or can someone explain this?

http://people.freenet.de/kxdev/docs/original/emu10k1-overview.pdf
http://people.freenet.de/kxdev/docs/original/fx8010-arch.pdf

>5) In the SB-Live-mixer.txt, section 3, PCM stream related=20
controls --
>I'm lost. What is a PCM Send Routing, what are A, B, C, D=20
destinations,
>why is there a distinction between mono and left/right, and how are
>these controlled?

Look at previous docs.=20
Alsa uses for pcm playback wavetable synth of emu10k1. Each voice of=20
this synth can by connected
up to 4 DSP inputs and "PCM send Routing". DSP has actualy 16 of=20
this inputs (FX bus). Then DSP executes=20
program and process these inputs and outputs it to DAC.=20
For example if you play one PCM stream, one voice of wavetable synth=20
is used. Output of this voice
can be send to 4 (this is A, B, C, D) FX bus inputs (this is=20
destination - 0 - 15).

Alsa uses these FX busses - they are forwarded to outputs.
FXBUS_PCM_LEFT=09=090x00 - everything from this goes to Front=20
Left speaker
FXBUS_PCM_RIGHT=09=090x01 - everything from this goes to Front=20
Right speaker
FXBUS_PCM_LEFT_REAR=090x02 - everything from this goes to Rear=20
Left speaker
FXBUS_PCM_RIGHT_REAR=090x03 - everything from this goes to Rear=20
Right speaker
FXBUS_MIDI_LEFT=09=090x04 - not usefull for you
FXBUS_MIDI_RIGHT=090x05 - not usefull for you
FXBUS_PCM_CENTER=090x06 - everything from this goes to Center=20
speaker
FXBUS_PCM_LFE=09=090x07 - everything from this goes to Subwoffer
FXBUS_PCM_LEFT_FRONT=090x08 - not usefull for you - used on Audigy
FXBUS_PCM_RIGHT_FRONT=090x09 - not usefull for you - used on Audigy

For mono PCM stream 1 voice is used.
For stereo PCM stream 2 voices are used.

For device 0 of sb live there are 32 substreams (0-31).
you can open any of them using hw:x,0,y device name where x is card=20
number - for you 0
and y is substream number (0-31). Warning you should use free stream=20
(check /proc/asound)

You can control routing using these controls (they control 1 voice=20
for mono PCM stream and 2 voices for stereo PCM stream):
EMU10K1 PCM Volume - this controls volume of PCM stream and there=20
are 32 of these control with
index 0-31 - this is substream number.
It has three values:
0 - mono, default 0xffff (no attenuation) - this controls volume of=20
mono stream
1 - left, default 0xffff (no attenuation) - this controls volume of=20
left channel of stream
2 - right, default 0xffff (no attenuation) - this controls volume of=20
right channel of stream

When you open mono stream only value 0 is used
When you open stereo stream only values 1,2 are used

EMU10K1 PCM Send Routing - this controls routing (means where to=20
send) of PCM stream and there are 32 of these control with
index 0-31 - this is substream number.
It has 12 values:
0 -  mono, A destination (FX-bus 0-15), default 0
1 -  mono, B destination (FX-bus 0-15), default 1
2 -  mono, C destination (FX-bus 0-15), default 2
3 -  mono, D destination (FX-bus 0-15), default 3
4 -  left, A destination (FX-bus 0-15), default 0
5 -  left, B destination (FX-bus 0-15), default 1
6 -  left, C destination (FX-bus 0-15), default 2
7 -  left, D destination (FX-bus 0-15), default 3
8 - right, A destination (FX-bus 0-15), default 0
9 - right, B destination (FX-bus 0-15), default 1
10 - right, C destination (FX-bus 0-15), default 2
11 - right, D destination (FX-bus 0-15), default 3

this means, where you want route this stream.

When you open mono stream only value 0,1,2,3 are used
When you open stereo stream only values 4,5,6,7,8,9,10,11 are used

EMU10K1 PCM Send Volume - this controls routing (means how much to=20
send) of PCM stream and there are 32 of these control with
index 0-31 - this is substream number. This is pair with EMU10K1 PCM=20
Send Routing
It has 12 values:
0 -  mono, A destination attn, default 255 (no attenuation)
1 -  mono, B destination attn, default 255 (no attenuation)
2 -  mono, C destination attn, default 0 (mute)
3 -  mono, D destination attn, default 0 (mute)
4 -  left, A destination attn, default 255 (no attenuation)
5 -  left, B destination attn, default 0 (mute)
6 -  left, C destination attn, default 0 (mute)
7 -  left, D destination attn, default 0 (mute)
8 - right, A destination attn, default 0 (mute)
9 - right, B destination attn, default 255 (no attenuation)
10 - right, C destination attn, default 0 (mute)
11 - right, D destination attn, default 0 (mute)

When you open mono stream only value 0,1,2,3 are used
When you open stereo stream only values 4,5,6,7,8,9,10,11 are used

For example:
You want play mono stream to front right and rear left speaker
then you should set values like this:
EMU10K1 PCM Send Routing[stream_number][0] =3D 1 (FXBUS_PCM_RIGHT)
EMU10K1 PCM Send Routing[stream_number][1] =3D 2 (FXBUS_PCM_LEFT_REAR)
EMU10K1 PCM Send Routing[stream_number][2] =3D 0 (not used)
EMU10K1 PCM Send Routing[stream_number][3] =3D 0 (not used)

EMU10K1 PCM Send Volume[stream_number][0] =3D 255 (FXBUS_PCM_RIGHT)
EMU10K1 PCM Send Volume[stream_number][1] =3D 255 (FXBUS_PCM_LEFT_REAR)
EMU10K1 PCM Send Volume[stream_number][2] =3D 0 (not used)
EMU10K1 PCM Send Volume[stream_number][3] =3D 0 (not used)

You want play stereo stream left channle to front right and rear=20
left speaker
then you should set values like this:
EMU10K1 PCM Send Routing[stream_number][4] =3D 1 (FXBUS_PCM_RIGHT)
EMU10K1 PCM Send Routing[stream_number][5] =3D 0 (not used)
EMU10K1 PCM Send Routing[stream_number][6] =3D 0 (not used)
EMU10K1 PCM Send Routing[stream_number][7] =3D 0 (not used)
EMU10K1 PCM Send Routing[stream_number][8] =3D 0 (not used)
EMU10K1 PCM Send Routing[stream_number][9] =3D 2 (FXBUS_PCM_LEFT_REAR)
EMU10K1 PCM Send Routing[stream_number][10] =3D 0 (not used)
EMU10K1 PCM Send Routing[stream_number][11] =3D 0 (not used)

EMU10K1 PCM Send Volume[stream_number][4] =3D 255 (FXBUS_PCM_RIGHT)
EMU10K1 PCM Send Volume[stream_number][5] =3D 0 (not used)
EMU10K1 PCM Send Volume[stream_number][6] =3D 0 (not used)
EMU10K1 PCM Send Volume[stream_number][7] =3D 0 (not used)
EMU10K1 PCM Send Volume[stream_number][8] =3D 0 (not used)
EMU10K1 PCM Send Volume[stream_number][9] =3D 255 (FXBUS_PCM_LEFT_REAR)
EMU10K1 PCM Send Volume[stream_number][10] =3D 0 (not used)
EMU10K1 PCM Send Volume[stream_number][11] =3D 0 (not used)

This may be not correct (I think that this is how it works). I newer=20
tryed this, but I want
know if this works.
Maybe you must (if you can't set controls values) remove "lock true"=20
from /usr/share/alsa/conf/cards/emu10k1.conf
under=20
name "EMU10K1 PCM Send Volume"
and
name "EMU10K1 PCM Send Routing"
otherways you can change routing on the fly (maybe, I don't know).


>7) How do I do accomplish this using an asoundrc file? I can't even
>figure that out. I've got an SB Live! 5.1 (EMU10K1).
>How do I 'simply' setup 2 'streams' (not sure I'm using the correct
>terminology).
=20
Look at /usr/share/alsa/conf/cards/emu10k1.conf (devices front,=20
rear, ...)

If you have more questions then ask, I'll try to help if I know=20
(latency may be high :-)).

Peter Zubaj


=0A____________________________________=0Ahttp://www.logofun.pobox.sk - uro=
bte radost svojmu telefonu=0A


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
