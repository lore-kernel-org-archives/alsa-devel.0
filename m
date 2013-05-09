From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: sgtl5000: Fix driver probe after
	reset
Date: Thu, 9 May 2013 11:00:52 +0100
Message-ID: <20130509100052.GC7478@sirena.org.uk>
References: <1368045961-31213-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5643180315306573429=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 76E172619EE
 for <alsa-devel@alsa-project.org>; Thu,  9 May 2013 12:00:56 +0200 (CEST)
In-Reply-To: <1368045961-31213-1-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, lars@metafoo.de, matt@genesi-usa.com, eric.nelson@boundarydevices.com, troy.kisky@boundarydevices.com
List-Id: alsa-devel@alsa-project.org


--===============5643180315306573429==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MgjYdQjNYOWmcHZa"
Content-Disposition: inline


--MgjYdQjNYOWmcHZa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2013 at 05:45:55PM -0300, Fabio Estevam wrote:

> As the sgtl5000 codec did not go through a real reset, we cannot rely on =
the=20
> sgtl5000_reg_defaults array, since these are only valid after a clean pow=
er-on=20
> reset.

> To fix this issue, use 'num_reg_defaults_raw' which tells the regcache dr=
iver
> to actually read the codec registers and then fill the cache with these v=
alues.
>=20
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - Remove sgtl5000_reg_defaults array
> - Do not use num_reg_defaults_raw

Changelog update needed here :)

I'm not sure that removing the defaults is the ideal thing here - it
means that the driver will be stuck with whatever the last booted OS
left the device running which may or may not be sane.  Explicitly
writing in all the values we want seems safer, that way we know how the
device is configured and there's less potential for odd bugs caused by
rebooting at the wrong moment.

--MgjYdQjNYOWmcHZa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJRi3PRAAoJELSic+t+oim9e0cP+gLtv/Wnaxvxos/0NJkFFz6y
S6hiaf5AMiTLIOIMtYs0YgqSCzQYBxXoUZ7K3HqwhTJ6XVR9WPz3AT307YXPawrK
X64dlE8DJBLaW6VhhMTqsjNxjp6rSB+NqayfjJucK85emSCP0E/0qY6EdrcG/t+1
d5G0U0RCtVEJEoFhE/oTKd7mb2nNPQVVTMT9hiREAjNMaJQ0ZNXPxeUqrqn+rqXe
TmUgg2TD0pqh8meY1UyL4pH9s4GotCsxHXdQoOgLHWJZNtwlzImijnI2rwzGDwNU
5pf8Eq/lv896ZrFmPl/h6aAWH+B1wJMdzU/yW9VMSaKGAA+L8wi7rd3HFyufpDT2
g5/YbsYZmhbNQ+YBuv7eXolPQqBKutlvYmKyzR6QYFVodFgKPsJKbhcKRbeXmnE3
OVA7jsIxUSPCo1j8MNGSkbdoOM4jW+GkFMrF92iaa/1os4P8HwvjftMzv1a3thmY
Z5b2F9y4LPTF87XttNCPEBOLZ1uJP0uG3cLGylFYHKdG+zJnDLPB32eOcyF14e0L
Vw7J69J8my4gLdhz5pBwOxD13Zhs+2nAQ93phLKS9lWowYL0zI9An3olZj+KczQw
6e5peqBgGDIkiFHzr7mqw9df4mPzdctTl/PoG64xwVlSdq0ylvYweP1xrE56zTym
IP3ALIP8OPGply9xIlww
=4N2e
-----END PGP SIGNATURE-----

--MgjYdQjNYOWmcHZa--

--===============5643180315306573429==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5643180315306573429==--
