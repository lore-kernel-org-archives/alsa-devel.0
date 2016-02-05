From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: mxs-saif: check BUSY bit in hw_params() only if
 not mclk_in_use
Date: Fri, 5 Feb 2016 16:00:22 +0000
Message-ID: <20160205160022.GX4455@sirena.org.uk>
References: <1454505500-30384-1-git-send-email-mans@mansr.com>
 <20160205131944.GB12311@sirena.org.uk>
 <yw1x60y3i94n.fsf@unicorn.mansr.com>
 <20160205133712.GC12311@sirena.org.uk>
 <yw1xwpqjgtmt.fsf@unicorn.mansr.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="JQJYpj0es6mGpGbU"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <yw1xwpqjgtmt.fsf@unicorn.mansr.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


--JQJYpj0es6mGpGbU
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 05, 2016 at 01:43:22PM +0000, M=E5ns Rullg=E5rd wrote:
> Mark Brown <broonie@kernel.org> writes:

> > By looking at people working on the driver in git and the authors listed
> > in the driver (get_maintainer --git will do most of this for you, though
> > you do have to think about false positives).  As previously advised this
> > is not something that can be fully automated, you need to think about
> > who you are sending things to and why.

> Most files have been touched by many people.  I thought the entire point
> of the MAINTAINERS file was to remove the guesswork from choosing where
> to send patches.  Apparently sound/ has rules of its own.

No, this is true in general for the kernel - I'm just repeating
SubmittingPatches to you here.  Most individual drivers don't have a
specific entry in MAINTAINERS and it's probably not worth the bother
trying to get it completely 100% accurate.  MAINTAINERS is there to be
helpful and to have things like lists and git hanging off it but it's
not the be all and end all of everything, it still generates false
positives (consider how many ASoC patches Jaroslav has reviewed for
example) and false negatives.  No automated system is going to be
perfect, at some point you're going to need to think.

--JQJYpj0es6mGpGbU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWtMcVAAoJECTWi3JdVIfQH+YH/iop/WMb9HzEfVpJoimhn2pR
XwdpZfyBdPB0bIUuXy1F6XhRRktIF7ULxIFr5WAUOMOOZcG797N9LnXQeTF6zMSh
cz4c4nbT2XLL/ePvhAkt/cG8SbE3gHh7QGLi2jWbt19DdIAuHep7IOO1DqztZjgu
gYYGkl3XNKhRaNwHGlMZMTjqnDeFlLDGiXIIBNO710BvPRq3zMEYALlnIGw1kHP1
SNlCWRxa6KWWeHUmB7Doa3Nubm9LERSAIzGnDJgi9u+pa7UpXr72dVmWAW1j3lir
pqW5L5ww6SuwNZWh3jQ/Ny/tSv3QRQUlyXb7ogVNpzJsrcmVCYVN/pfCmZcXP0M=
=+aFU
-----END PGP SIGNATURE-----

--JQJYpj0es6mGpGbU--
