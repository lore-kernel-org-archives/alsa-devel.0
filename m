From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: fsl_ssi: Add suspend/resume support
Date: Mon, 26 May 2014 14:24:47 +0100
Message-ID: <20140526132447.GW22111@sirena.org.uk>
References: <1400823536-31708-1-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4018543314505632271=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id E461B265158
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 15:25:13 +0200 (CEST)
In-Reply-To: <1400823536-31708-1-git-send-email-festevam@gmail.com>
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, timur@tabi.org, shawn.guo@freescale.com
List-Id: alsa-devel@alsa-project.org


--===============4018543314505632271==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="XhDIt1ZqED2V8RHq"
Content-Disposition: inline


--XhDIt1ZqED2V8RHq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 23, 2014 at 02:38:56AM -0300, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
>=20
> Doing a suspend/resume sequence while playing an audio track in the backg=
roung
> causes broken audio right after resume:

Applied, thanks.

--XhDIt1ZqED2V8RHq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTg0CSAAoJELSic+t+oim9LnIP/jKf2myalDiOFrynvKhgQ9wm
/PRj6ftMxpBo6vImL3k7jKCtUE9mAYdzR47+nmtsxMzhbKZYFEs+hIAyt/DD0WxI
EI7IZHqQfmepYJuut67y6YVKdg/ZNNjqVyD0574Ieu9JRTHplqZU7Bwr793i6rDB
xD03et1AsnPpCqKJvewypcOyIMcnIKB18lmqQyc2Sq3m5MFx5d5BoMFa6eOrYapZ
I2bSFGT3DQWRkH0B339pw7JGdf0+YxXJ+FRJa04x9dqN+d1Sxg+kWJo0CaAGUr/f
TTWZWPmE1+8KTATfkONPzlE+VszFP+MpLXujrNHBYvOPvUC2uKLFiItSU/EhYTZ9
fWBnxa3lxGUzLdv/gOGCDDY31e8PrnH35qAnz3VwEy5xEMUfnugGWsJjPyQ4FdrJ
rgDjh09OwbbmmcMvH5LN8O6VEtjHf4iem3s7OIUj+0pApVqc5A4eaoQIH4deTliP
uceAPgFG/gypzDR5IhcP0V7YAEtNkiyVLpuUrUbvDjwtkdov3VXPRIDOE2BWn6ku
9eZ+rV11hQ5lIAINlHAXApsa9BMfyF/sA753DKceZ0Pf6r2szk2J6koGgXbXoRFE
PKoIq4lGH+rG18685WzwrE0I2hfGCIhpUijeFwJm8jxOPdJbAiSRgWvk2bXOLn/R
xIKkucloMtyQGigvnPaB
=1yCu
-----END PGP SIGNATURE-----

--XhDIt1ZqED2V8RHq--

--===============4018543314505632271==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4018543314505632271==--
