From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 5/7 linux-next] ASoC: ak4554: constify of_device_id array
Date: Sun, 22 Mar 2015 18:05:34 +0000
Message-ID: <20150322180534.GR6643@sirena.org.uk>
References: <1426697344-4884-1-git-send-email-fabf@skynet.be>
 <1426697344-4884-6-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7L9kolmstoDTZ4pm"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426697344-4884-6-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--7L9kolmstoDTZ4pm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 18, 2015 at 05:49:00PM +0100, Fabian Frederick wrote:
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)

Applied, thanks.

--7L9kolmstoDTZ4pm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDwRtAAoJECTWi3JdVIfQLG8H/jod7hHIBD2fSaTMOoOoxJgb
5suXsgXNBk8AD287f+9PIRN5Cl4FRMUnyC9jgwJG+6aVeW/hGbiIpcLMFcIkwUem
ycbVgpqg6tpFForWfNKiaLS0ycRlwK8gWSnjnKoZ2D1iOgvfxvSKbqwN+IhoNEpI
QhDArS3/xwfs5nT98UZpOX38SQKcleV0D6ydxYjHJ/pYCQ425O0oG6eE3KG33aKX
/AjY+B9/ht8SQKcYsRq0vdEs2NZIyoEey8ricuskYZGQgtIRCZb1G3FR74q/u8GT
5ASPmWANyGU0I7BhWTITfA1VyjbZAJ0rBWel6ev+69slTQUvlKJb4k0knkMBJTI=
=qqXv
-----END PGP SIGNATURE-----

--7L9kolmstoDTZ4pm--
