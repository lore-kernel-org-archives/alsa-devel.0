From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: Verifying mixer dB data/Invalid dB data from USB
	cards, especially Aureon 5.1 MkII
Date: Sun, 21 Feb 2010 11:49:18 +0800
Message-ID: <4f3252891002201949k48e0208fw40590803ac1a8192@mail.gmail.com>
References: <20100216223938.GA23623@sirena.org.uk>
	<20100216233825.GB23623@sirena.org.uk>
	<20100216235658.GA6766@tango.0pointer.de>
	<4f3252891002171748tdcaa87n4d11d9880c0043e3@mail.gmail.com>
	<20100218023742.GC23637@tango.0pointer.de>
	<4f3252891002172215j7b85313ci3626a1bdad5c040c@mail.gmail.com>
	<20100218181322.GB5606@tango.0pointer.de>
	<alpine.LNX.2.00.1002190916410.28127@eeebox2.perex-int.cz>
	<4f3252891002190257u608073c3l48f2251d8a6458ee@mail.gmail.com>
	<20100219151328.GC25873@tango.0pointer.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 19DF7103806
	for <alsa-devel@alsa-project.org>; Sun, 21 Feb 2010 04:49:19 +0100 (CET)
Received: by pwi9 with SMTP id 9so1322547pwi.38
	for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2010 19:49:18 -0800 (PST)
In-Reply-To: <20100219151328.GC25873@tango.0pointer.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2010/2/19 Lennart Poettering <mznyfn@0pointer.de>

> On Fri, 19.02.10 18:57, Raymond Yau (superquad.vortex2@gmail.com) wrote:
>
> > PA assume every sound card can only record from one capture source at t=
he
> > same time (like those AC97 card )
>
> That is true. PA does not try to cover the complete functionality of
> the hardware. We limit ourselves to what we think is common on the
> desktop or in a mobile environment, and I don't think recording from
> mic and line-in at the same time would be useful in more than
> exceptional cases.
>

http://www.intel.com/design/chipsets/hdaudio.htm

The most common onboard audio is HDA so this is not any exceptional cases

Those HDA multi streaming  feature are most users wanted in desktop
enviornment, are pulseaudio really designed for deskop or just only for
notebook and mobile ?

The front panel green/pink jack can be used by one application while the
rear panel audio jacks can be used to another application for surround or
mic for karaoke


*When AC=9197 was initially developed*, users were typically listening to o=
nly
music and movies with stereo sound. With the success of DVD movies encoded
with Dolby* Digital and DTS* multi-channel audio formats, users have become
accustomed to listening in full surround sound with anywhere from six to
eight speakers. While AC=9197 technology has struggled to keep pace with all
these advancements, Intel High Definition Audio is designed specifically for
the high-quality multi-channel audio experiences. Newer audio and video
encoding/decoding algorithms also enable a higher-quality listening
experience.



*Consumers also want the ability to play back two different audio tracks*,
such as a CD and a DVD simultaneously, which can't be done using current
audio solutions. Intel HD Audio features multi-streaming capabilities that
give users the ability to send two or more different audio streams to
different locations at the same time, from the same PC.



 Send a game's sound through 5.1 speakers while the Internet chatting audio
is sent through your headset.

 Send a DVD movie with 5.1 audio to a surround sound system in the living
room, while you listen to digital music and surf the Web on the PC.



>
> > Is HDA_SUBDEV_NID_FLAG or any API for the application to find the corre=
ct
> > mixer control for these kind of capturing subdevices  ? ( simple mixer
> api
> > is not able to know the subdevice number )
>
> There is currently no API at all to figure out the relation between PCM
> devices and mixer controls in ALSA. PA hences bases this all on
> assumptions and expectes in this acse that the first mixer control is
> also the first PCM device, if you understand what I mean by that.
>
> Lennart
>

THe point is that PA release/close the device (suspend on idle) , if another
application using the subdevice 0 before PA resume/reopen, PA will open
subdevice 1 and cannot find the correct capture volume control and user will
complain they cannot record

Since PA did not check the subdevice number to find the correct mixer
control
