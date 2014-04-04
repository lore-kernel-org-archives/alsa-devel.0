From: Markus Pargmann <mpa@pengutronix.de>
Subject: Re: [PATCH v2 00/16] ASoC: fsl-ssi: Driver cleanup
Date: Fri, 4 Apr 2014 08:49:32 +0200
Message-ID: <20140404064932.GC20621@pengutronix.de>
References: <1394887464-969-1-git-send-email-mpa@pengutronix.de>
 <20140403221406.GI14763@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3609561549963282709=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
 [92.198.50.35]) by alsa0.perex.cz (Postfix) with ESMTP id 9F2E3265565
 for <alsa-devel@alsa-project.org>; Fri,  4 Apr 2014 08:49:43 +0200 (CEST)
In-Reply-To: <20140403221406.GI14763@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, alsa-devel@alsa-project.org, Timur Tabi <timur@tabi.org>, kernel@pengutronix.de, Nicolin Chen <Guangyu.Chen@freescale.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============3609561549963282709==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Apr 03, 2014 at 11:14:06PM +0100, Mark Brown wrote:
> On Sat, Mar 15, 2014 at 01:44:08PM +0100, Markus Pargmann wrote:
> > Hi,
> >=20
> > This new version of the cleanup is mainly a reordering of the patches. =
It moves
> > the regmap patch to the end of the series so none of the other patches =
depend
> > on it. This also fixes a bug I introduced in "Remove fsl_ssi_setup" whi=
ch also
> > removed the switching between network and normal mode depending on the =
number
> > of channels. I reversed this code removal. Another new patch was added =
"Fix
> > i2s_mode variable setup" which fixes the i2s_mode assignment in set_dai=
_fmt().
>=20
> It's been nearly three weeks with no response to this except for the
> last patch - I've got ahead and applied since it all looks sane (modulo
> the bugfix question), we can see if problems occur in -next after the
> merge window.  Thanks!

Thanks for applying this series, but could you please drop it for the
moment? We found some issues with the baud clock setup for i2s master
mode and have some fixed patches for the series. So it would be nice to
get this in without fixups if that's still possible? I could send a v3
next week.

Thanks,

Markus

--=20
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

--n8g4imXOkfNTN/H1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBAgAGBQJTPlX8AAoJEEpcgKtcEGQQ5GMP/RY7XlRYphFpcO71PK2IiC5H
XW1l3xvAGGmKITICrfQwSqwJpkFXW57XnwkubrMyoHtBVt8IJYKGex5xmbwPVnV9
93p6CtZKOZwV1HCjN4boExEMhUXoIE4Af7QQtVftvwFZKU0ncEjl7pO9RpIgffER
zckdd36WZs2qA1xc6jUQ27q+r0+IfLpEYwefCS42lSveTCv3gt+f6s7MzzfghA+6
AtdI1FwUx7+NDW5FPxtJKdCSDMkYQSmKu0mcWRUKsl1spMUm8n/IqH7TDTHDHM91
NGRbzQeQSI+IvRAoIes5wHJt8BxRlafwSg5/NPDd0YPhog9fquk0FoXzy7NeTgMo
EarI0sOVWUt2PdnbZNLL1yttgUvYuyzhyGunfE5ExH/2ugrw04N8ePnWzsedB1Z8
uzPJQe0aW3y2qz0ZB3q7p2+X6szu7bLURaZdvqwqjlM4exKEs2WjbtGaORXSstJv
jMemPpIoFXj97VTYxoshG55Ssc6MYVqXEsQn4rtFAqRHMzh9hyS0tRzOJxDJvjDX
9WEzRz1Md/isVb0NRNJrWc2zB5wVCuVDWNg31S2fv2gjhOz428CMNGGAd5vD17T7
Y5iV6iKV1KLRRRsAQO2Iuk0Of6Xq0dkrLdlF++e+wQBmGpA2Qj25Rgq1dlamLvey
KDM/s3VNGAZMQGg/EYOT
=7oME
-----END PGP SIGNATURE-----

--n8g4imXOkfNTN/H1--

--===============3609561549963282709==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3609561549963282709==--
