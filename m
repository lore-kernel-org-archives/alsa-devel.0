From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 7/7 linux-next] ASoC: rsnd: constify of_device_id array
Date: Sun, 22 Mar 2015 18:06:42 +0000
Message-ID: <20150322180642.GT6643@sirena.org.uk>
References: <1426697344-4884-1-git-send-email-fabf@skynet.be>
 <1426697344-4884-8-git-send-email-fabf@skynet.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ceuyUbi+oA5bUa/n"
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1426697344-4884-8-git-send-email-fabf@skynet.be>
Sender: linux-kernel-owner@vger.kernel.org
To: Fabian Frederick <fabf@skynet.be>
Cc: linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--ceuyUbi+oA5bUa/n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Mar 18, 2015 at 05:49:02PM +0100, Fabian Frederick wrote:
> of_device_id is always used as const.
> (See driver.of_match_table and open firmware functions)

Applied, thanks.

--ceuyUbi+oA5bUa/n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJVDwSxAAoJECTWi3JdVIfQbtIH/0VdcDqKqb8CY1IgWMG11aJ5
XyTMtczm/lOBEUpRxZfprIaE8QHKYtEEyIWRcyFZTCbcAPL394qgxWkL19uJiF4m
Eq/SfgRa5P7sBBep+k0d9AveM/pQgkKnD206dAoGRq0dNgEPalBWyy21mqdBvTTg
uXICavIkfeXxMSw+gICVYnoAavOJgpiMEHY0cEMRBDMwKsVDbDjLcOXSdKvaGYEe
LzSvbw0r1XzLt80K2nhXh6OYHZxtPwylc39immzFiBz2eHs2BqdBTyERFUa0afbU
XkAw4E9c1BP6+657nDOwYetUla65p4LcZXBod1LUtcG/TfN62omMsTngYN1nLOg=
=EHrQ
-----END PGP SIGNATURE-----

--ceuyUbi+oA5bUa/n--
