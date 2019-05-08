From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: Add support for Conexant CX2072X
	CODEC
Date: Wed, 8 May 2019 17:10:06 +0900
Message-ID: <20190508081006.GZ14916@sirena.org.uk>
References: <20190423141336.12568-1-tiwai@suse.de>
 <20190423141336.12568-2-tiwai@suse.de>
 <20190427175938.GJ14916@sirena.org.uk>
 <s5h36lxpcbd.wl-tiwai@suse.de>
 <20190503064729.GF14916@sirena.org.uk>
 <s5hk1f8m2f1.wl-tiwai@suse.de>
 <20190506042625.GK14916@sirena.org.uk>
 <s5hsgtr6h5y.wl-tiwai@suse.de>
 <20190506140506.GQ14916@sirena.org.uk>
 <s5h4l674n9g.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7741747885046584711=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 3711DF896E6
 for <alsa-devel@alsa-project.org>; Wed,  8 May 2019 10:10:30 +0200 (CEST)
In-Reply-To: <s5h4l674n9g.wl-tiwai@suse.de>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org


--===============7741747885046584711==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="93p3Mfsbf6DTJ78q"
Content-Disposition: inline


--93p3Mfsbf6DTJ78q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 06, 2019 at 05:26:51PM +0200, Takashi Iwai wrote:
> Mark Brown wrote:

> > Like I say if the device is using the fact that the pin is a GPIO
> > there's quite likely something wrong - that shouldn't be something that
> > the user of an interrupt should need to see.

> Yeah, unfortunately we have no reference, so the only chance would be
> to test with another board that has a different setup.

The GPIO/IRQ equivalence thing should just be a purely Linux internal
thing - looking at the driver it appears that there's no need to look at
the GPIO status, Linux can tell if something is plugged in purely by
reading the chip registers so the jack status function could directly be
the interrupt handler.

--93p3Mfsbf6DTJ78q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAlzSjt0ACgkQJNaLcl1U
h9CjYAf8DHvaYxkZbQ7oaFnpZ8ZGWrYVJcJ+gplAOz1SsdDuF9l9x4szd//g2Gn9
14A+VN/G4Dy4EVWOjW+VoDcCAwfHHYmeFD2fuXEu/iMHvEbEovt5fTLcP43GUCjF
fV0bfs2vbkQV+kcynR6aJy7g3aOx0vWMLHuTvUL6X2lz2i4bZSXgdcTZo8Nzo43W
rzIlKO5pqt8G7QQ21CEdFvfORj3RZgwOsD76quvioVkOaFNBQRbYJ1MK+jWlgOOf
M9K2f2s9KpqgU6p5Xk3vD6skkVt2gjkdkKvSln/r8NC0uqKKG3ecxlgRQow377pi
vZFTeT2yM5X1Mk2mMLTAVYnS54vlJw==
=rcaF
-----END PGP SIGNATURE-----

--93p3Mfsbf6DTJ78q--

--===============7741747885046584711==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7741747885046584711==--
