From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: add core audio driver for Broadcom Cygnus SOC.
Date: Wed, 8 Apr 2015 20:23:09 +0100
Message-ID: <20150408192309.GI6023@sirena.org.uk>
References: <1427771784-29950-1-git-send-email-sbranden@broadcom.com>
 <1427771784-29950-3-git-send-email-sbranden@broadcom.com>
 <20150331064209.GD2869@sirena.org.uk>
 <551D8EB6.1050004@broadcom.com>
 <20150406161939.GJ6023@sirena.org.uk>
 <552492E1.3050207@broadcom.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="f2BigOnaJvEXISGh"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <552492E1.3050207@broadcom.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lori Hikichi <lhikichi@broadcom.com>
Cc: Scott Branden <sbranden@broadcom.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, bcm-kernel-feedback-list@broadcom.com, Dmitry Torokhov <dtor@google.com>, Anatol Pomazao <anatol@google.com>, abrestic@google.com, bryeung@google.com, olofj@google.com, pwestin@google.com
List-Id: alsa-devel@alsa-project.org


--f2BigOnaJvEXISGh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 07, 2015 at 07:30:57PM -0700, Lori Hikichi wrote:
> On 15-04-06 09:19 AM, Mark Brown wrote:

> >OK, so that seems fragile - what happens if we're slightly late
> >processing an interrupt or miss one entirely?  Most hardware has some
> >way to read back the current position which tends to be more reliable,
> >is that not an option here?

> The hardware updates a read pointer (rdaddr) which we feed to ALSA via the
> ".pointer" hook. So yes, the hardware does have a register that tells us =
its
> progress.  This routine (ringbuf_inc) actually updates a write pointer
> (wraddr) which is a misnomer.  The write pointer doesn=E2=80=99t actually=
 tell us
> where we are writing to =E2=80=93 ALSA keeps track of that. The wraddr on=
ly prevents
> the hardware from reading past it.  We just use it, along with a low water
> mark configuration register, to keep the periodic interrupts firing.  The
> hardware is tracking the distance between rdaddr and wraddr and comparing
> that to the low water mark.

The code has handling for both read and write so it's not just updating
a write pointer.  Is there no flexibility in the hardware regarding
interrupt generation?

> Being late processing the interrupt is okay since there are more samples =
to
> read.  That is, it was only a low water mark interrupt and we have one
> period of valid data still (we configure low water to be one period).
> Missing an interrupt is okay since the hardware will just stop reading fr=
om
> buffer when rdaddr has hit wraddr.

Stopping if we miss an interrupt is precisely the sort of situation we
want to avoid if we can - if the application is sufficiently far ahead
of the hardware everything should continue to work fine.  The minimal
period size appears to be very small so this is a potential issue, if an
application tries to use many very small periods it's both more
vulnerable to some other interrupt taking longer than might be desirable
and likely that things would be fine as the application is hopefully
more than one period ahead of where the hardware is at.

If the hardware is always going to halt at the end of the period there's
not a huge amount we can do about this except possibly raise the minimum
period if systems are running into trouble but if there's a way to avoid
doing that then that would be even better.

--f2BigOnaJvEXISGh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVJYAcAAoJECTWi3JdVIfQKgYH/2Py0WoQdaSx5YK5cT3yT1Mc
OZVcOwvVBy7HUX8hw9IearSMTHSqawpCvEzZsMRJb5WPsSXFDQsYsW1qOSDsTfCQ
ksAEutjVuN9qcb0GjnEt7Wb8YeRuRVYYEDvTCNsWiiLh9y15pTg5qBWeq8Og1Ki/
Jbjdwug0Om5iMIlZm28cmW6mJqpZbKKNM17khqJFNYvU3VWNeUYSGU7GkCvFwGZN
8IKGqf9o77CsZwsWqJ2HBKqCCjFHWkZJUwDAUqvIamh+8dFCH1tU5kht9YaAcZ0r
CoJPEFNQAr3J6cyvxthNQo1rFpoFojOyXxze4K66n/lZ/eclOCrVBbrBWZLzaPg=
=X8Xc
-----END PGP SIGNATURE-----

--f2BigOnaJvEXISGh--
