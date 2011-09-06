From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Throughts on getting ALC892 working better (was
 Re: Help With Getting Line-in monitoring working)
Date: Tue, 6 Sep 2011 16:34:00 +0800
Message-ID: <CAN8ccia85ehbCDTQ_fh_W16mWQeROJN_40Zc5LAxhJVL1jmxfQ@mail.gmail.com>
References: <alpine.BSF.2.00.1109050127250.10767@bas.flux.utah.edu>
	<CAN8cciZS0wxW+MJgERzSYBW4_JKen13UEjwT-SQ10OV9WOWKpQ@mail.gmail.com>
	<alpine.BSF.2.00.1109050238310.10767@bas.flux.utah.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 203DD1039D5
	for <alsa-devel@alsa-project.org>;
	Tue,  6 Sep 2011 10:34:01 +0200 (CEST)
Received: by fxh10 with SMTP id 10so4203450fxh.38
	for <alsa-devel@alsa-project.org>; Tue, 06 Sep 2011 01:34:00 -0700 (PDT)
In-Reply-To: <alpine.BSF.2.00.1109050238310.10767@bas.flux.utah.edu>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2011/9/6 Kevin Atkinson <kevin@atkinson.dhs.org>:


How did you get "snd: bad kfree" in the system log ?



[    6.272032] snd: bad kfree (called from f87381e3)
--
[    6.272043]  [<f85612b1>] ? snd_hidden_kfree+0x91/0xa0 [snd]
[    6.272048]  [<f87381e3>] ? snd_array_free+0x13/0x30 [snd_hda_codec]
[    6.272052]  [<f87381e3>] ? snd_array_free+0x13/0x30 [snd_hda_codec]
[    6.272057]  [<f87abfaf>] ? alc_free_kctls+0x4f/0x60 [snd_hda_codec_real=
tek]
[    6.272061]  [<f87affed>] ? alc_build_controls+0x44d/0x4b0
[snd_hda_codec_realtek]


>
> I spent several hours going over the data sheet (ver 1.3, you can find it=
 at
> http://www.realtek.com/downloads/downloadsView.aspx?Langid=3D1&PNid=3D24&=
PFid=3D28&Level=3D5&Conn=3D4&ProdID=3D284&DownTypeID=3D1&GetDown=3Dfalse&Do=
wnloads=3Dtrue

>
> Apparently there is no hardware master control and the master and PCM sli=
der
> must be implemented in software.


>
> So, after the change you suggest below the mixer are mapped better in the
> newer drivers. =A0But things can be still be improved. =A0More below.
>

> Also to get line-in pass-through working via headphone out please unmute =
the
> second set of Amp-in vals of pin 0x26.
>
>> Node 0x26 [Audio Mixer] wcaps 0x20010b: Stereo Amp-In
>> =A0Amp-In caps: ofs=3D0x00, nsteps=3D0x00, stepsize=3D0x00, mute=3D1
>> =A0Amp-In vals: =A0[0x00 0x00] [0x80 0x80]
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ^^^^^^^^^^^ set t=
hese to 0x00
>>
>> =A0Connection: 2
>> =A0 =A00x25 0x0b
>


The ALC892 provides ten DAC channels that simultaneously support 7.1
channel sound playback, plus 2 channels of independent stereo sound
output (multiple streaming) through the front panel stereo outputs.


you can create playback device 2 for the front panel headphone by adding

spec->alt_dac_nid =3D 0x25;


> Apparently all analog inputs are mixed together using 0x0B and then the
> output is sent to a bunch of other audio mixers, but these mixers don't
> really control the volume, they just have a separate mute for the PCM and
> analog input. =A0That being said, it probably also makes sense to mute an=
alog
> audio (coming from 0x0B) on all but pins 0x26 (headphone) and 0x0C (front)
> by default.
>


The hardest thing is how to add the controls for this alc892

http://thread.gmane.org/gmane.linux.alsa.devel/88324

The laptop has built-in 5.1, and 5.1 or 7.1 output via jacks.

DAC NIDs:
0x02 front
0x03 rear
0x04 clfe
0x05 side

internal mixers:
0x0c front
0x0d rear
0x0e clfe
0x0f side

internal speaker pins:
0x14 front
0x15 "rear" (front of laptop)
0x16 clfe

external ports:
fixed route:
0x17 side

can select any output:
0x18 mic / output
0x1a line-in / output
0x1b headphone


>
> On an even lesser note, it would be really nice if ALSA could expose the
> full capacity of the hardware without having an unwieldy number of mixer
> controls. =A0For example each of the 5 output mixers have a separate PCM =
and
> analog pass-though mute control, it would be nice to expose this. =A0Also,
> each of the 8 analog pins can be repurposed as either input or output, so=
me
> of them have a headphone amp, some of them have a mic boost, it would be
> nice if all this could all be exposed. =A0However, I can see how exposing=
 all
> this will lead to a lot of confusing mixer settings.
>

does any user really want to pass the stereo signal from line in to
"center/lfe" ?
