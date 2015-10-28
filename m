From: Mark Brown <broonie@kernel.org>
Subject: Re: [alsa-devel] [PATCH V2 02/10] ASoC: img: Add driver for I2S
 input controller
Date: Thu, 29 Oct 2015 08:43:34 +0900
Message-ID: <20151028234334.GF28319@sirena.org.uk>
References: <1444653637-14711-1-git-send-email-Damien.Horsley@imgtec.com>
 <1444653637-14711-3-git-send-email-Damien.Horsley@imgtec.com>
 <20151019174732.GG32054@sirena.org.uk>
 <56293472.7000401@imgtec.com>
 <20151023225723.GO29919@sirena.org.uk>
 <562F824F.9070407@imgtec.com>
 <20151028010443.GX28319@sirena.org.uk>
 <56313B9C.8030502@imgtec.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="b/1LfoxmgmdMg2Yp"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <56313B9C.8030502@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Damien Horsley <Damien.Horsley@imgtec.com>
Cc: alsa-devel@alsa-project.org, James Hartley <James.Hartley@imgtec.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--b/1LfoxmgmdMg2Yp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 28, 2015 at 09:18:20PM +0000, Damien Horsley wrote:
> On 28/10/15 01:04, Mark Brown wrote:

> >> I think it also makes sense to keep the blocks consistent with each
> >> other. The spdif (out and in), and parallel out, all flush automatically
> >> when stopped, and the fifo for the i2s out block is cleared when the
> >> reset is asserted.

> > This seems like an issue that got missed in the other drivers then.  I'd
> > expect the trigger operation to be a minimal operation which starts and
> > stops the data transfer, not doing anything else.

> The spdif out, spdif in, and parallel out blocks auto-flush whenever
> they are stopped. It is not possible for software to prevent this behavior.

Oh, so this isn't the drivers doing this?  In that case it's fine for
them to do that, if it's what the hardware does it's what the hardware
does.  It sounded like you were saying that there was similar code in
the other drivers.

--b/1LfoxmgmdMg2Yp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWMV2mAAoJECTWi3JdVIfQPaUH/jOiapc4JkMTkvvv9ZM+Tm/M
lD+MciI97+XqrGEN52Tw+7PgxmFrNo4QKCph0q7P4mkdR+HoOi9vhaX6w5NikQUC
YE1USNDZZyugIBvKmFHF3dUB7rTEFUd6VLF0KaiIN4cAbxXauJMWYo/9zt2UzeeS
PdsrhYycJXSemHRvBItRXe3o5ID/Lar9gZJeFKUdOAHrBB4F0Xfsnj+JO8c1u3OV
xlivtWavyqB3KhtRMIPey20bmgAUp7TKynmsi8XdvsD59dIAuhO9y9/F4S0t1uuI
Ka92rmG2RxGfGjbW/p5xwUuPuxrON3adP9MhjKWbo2mYZ+0tuzMAolyMuKh1iiY=
=g61v
-----END PGP SIGNATURE-----

--b/1LfoxmgmdMg2Yp--
