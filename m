From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: add xtensa xtfpga I2S interface and platform
Date: Wed, 29 Oct 2014 21:16:13 +0000
Message-ID: <20141029211613.GN18557@sirena.org.uk>
References: <1414436825-19416-1-git-send-email-jcmvbkbc@gmail.com>
 <20141027193229.GE18557@sirena.org.uk>
 <CAMo8Bf+Z9V8mkiC3JOupPQmi1EJUDKrb1qcNncDbsEbhjigbww@mail.gmail.com>
 <20141028154224.GX18557@sirena.org.uk>
 <CAMo8BfLpJ0bdmaFt9+gLQ_kEjB68XdjAJUw8f8s=Owv46h_yDQ@mail.gmail.com>
 <20141028173853.GD18557@sirena.org.uk>
 <CAMo8BfJfRTo7puxeafyBnaGWhY38o6ktsSBugcSmSaMYUArcyw@mail.gmail.com>
 <20141029210250.GM18557@sirena.org.uk>
 <CAMo8BfJJSTiYB14OjFgjH3K+AFbTF9DO9KkKUckAsgd8YDPs-w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JdlTQj2sMQFvN3Tf"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAMo8BfJJSTiYB14OjFgjH3K+AFbTF9DO9KkKUckAsgd8YDPs-w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Max Filippov <jcmvbkbc@gmail.com>
Cc: alsa-devel@alsa-project.org, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, LKML <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>
List-Id: alsa-devel@alsa-project.org


--JdlTQj2sMQFvN3Tf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 30, 2014 at 12:10:56AM +0300, Max Filippov wrote:
> On Thu, Oct 30, 2014 at 12:02 AM, Mark Brown <broonie@kernel.org> wrote:

> > Just keep the code physically separate so the DMA bits are hanging off
> > the DMA operations and the interface setup bits are hanging off the DAI
> > operations rather than all mixed in together.

> Ok. Should I also move them to a separate file, or one file is good for now?

It's probably not essential to split at this point.

--JdlTQj2sMQFvN3Tf
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUUVkcAAoJECTWi3JdVIfQZ3IH+wbGU4ko0iu4pdT0EQOqbxuh
16O2zF48PXI6iAyaiUagdp1TxcNP2VtjZtMX25Af9Nz54dDjPuJivopmjDu8xeRj
SwMH6HBJPBbBuS8uF3oRlOk3FWZPAA+GMgZvI0pnDLAQCzzRr6aGcwNv9//dzss8
A5k3sWGyAX8Gf5h9oGqNLr01gArF/MEBisksliiRAEwkTzrAheiyZ8ststfNLQOi
n9EVzwRafsvH8r12JBQhzI1jdbsI+BN7XRk/AozzDJZkYciigerqsRiGaCouWkQN
5fIJbhnVrzd3ThBup6bPH2b1Q17J3zTzVkQU3E8cQv+sz/Fj+0fQ9cjoApxz0+c=
=i1lD
-----END PGP SIGNATURE-----

--JdlTQj2sMQFvN3Tf--
