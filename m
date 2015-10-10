From: Ricard Wanderlof <ricard.wanderlof@axis.com>
Subject: Re: [PATCH v2] ALSA: usb-audio: Fix max packet size
 calculation for USB audio
Date: Sat, 10 Oct 2015 17:46:08 +0200
Message-ID: <alpine.DEB.2.02.1510101724440.26426@lnxricardw1.se.axis.com>
References: <alpine.DEB.2.02.1510100012390.7332@lnxricardw1.se.axis.com>
 <5618D0E1.1000308@ladisch.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bastet.se.axis.com (bastet.se.axis.com [195.60.68.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 43A0C26046A
 for <alsa-devel@alsa-project.org>; Sat, 10 Oct 2015 17:46:13 +0200 (CEST)
In-Reply-To: <5618D0E1.1000308@ladisch.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Clemens Ladisch <clemens@ladisch.de>
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Takashi Iwai <tiwai@suse.de>, alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org


On Sat, 10 Oct 2015, Clemens Ladisch wrote:

There is a maximum size for USB packets, but not for git commit messages. :)

Smiley aside, do you think more of the rationale should be in the commit =

message or is it sufficient the way it is?

> > The problem here is that the addition of 0xffff is in the wrong place. =
We don't
> > want the rounding up to take place on the frequency, but on the resulti=
ng
> > packet size.
> =

> Packets must not contain partial frames, so the rounding must take place
> on the number of frames per packet.

That of course makes perfect sense.

> > Let's take an example. We have a sample rate of 96 kHz, so our
> > ep->freqn is 786432 (see usb_high_speed_rate()). Add 25% (line 612) and=
 we get
> > 983040.  The calculated maxsize is then ((983040 + 65535) * 8) >> 16 =
=3D 127 .
> =

> That code was intended to round correctly, but it's obviously wrong
> because the result is not an integer multiple of the frame size.

If that is the case we need to do something like

maxsize =3D (((freqn + 0xffff) & 0xffff0000) * frame_size) >> 16

where the & 0xffff0000 rounds the Q16.16 number down to the nearest =

integer, so that when multiplying by frame_size we get an integral =

multiple thereof.

In the (trivial) case above (with 983040 =3D 0xf0000) we get

maxsize =3D (((0xf0000 + 0xffff) & 0xffff0000) *8) >> 16 =3D 120

(which is correct).

> (Please write Q16.16 values in hex.)

Ok, will do.

> > This is also corroborated by the wMaxPacketSize check on line 616. Assu=
me
> > that wMaxPacketSize =3D 108
> =

> It would not make sense to have a value that is not a multiple of the
> frame size.  (I'm not saying that it doesn't occur in practice ...)

In this particular case I was withholding information. :) The actual =

device in question needs a quirk whereby the audio data in each packet is =

prefixed by an u32 containing the number of audio data bytes in the =

packet. So 108 is the actual number, as the corresponding number of audio =

bytes, 104, is a multiple of 8. But of course I should not have used that =

particular maxsize as an example in this patch.

Ok, I'll rework this and resubmit.

/Ricard
-- =

Ricard Wolf Wanderl=F6f                           ricardw(at)axis.com
Axis Communications AB, Lund, Sweden            www.axis.com
Phone +46 46 272 2016                           Fax +46 46 13 61 30
