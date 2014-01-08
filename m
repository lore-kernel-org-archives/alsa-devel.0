From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v4 0/9] ASoC: fsl-ssi: offline/online configuration and
 cleanups
Date: Wed, 8 Jan 2014 17:21:44 +0000
Message-ID: <20140108172144.GP31886@sirena.org.uk>
References: <1387545096-2334-1-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2439319640379758739=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1387545096-2334-1-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Nicolin Chen <b42378@freescale.com>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, kernel@pengutronix.de, Shawn Guo <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============2439319640379758739==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eAWylJs5fPgxl6k6"
Content-Disposition: inline


--eAWylJs5fPgxl6k6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 20, 2013 at 02:11:27PM +0100, Markus Pargmann wrote:
> Hi,
>=20
> This patch series fixes some fsl-ssi code that does not act exactly as it=
 is
> described in the reference manuals.

I went ahead and applied all of the ASoC patches here however as I noted
on a couple of patches the new compatible strings need documenting.  Can
you please send a followup patch adding that?

--eAWylJs5fPgxl6k6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIbBAEBAgAGBQJSzYklAAoJELSic+t+oim9An8P+Og6wLHCPWktXG/EKNF9PFK4
+T74n76CE8jwbh+90MxCjDViz2URusKOyQ+O3zxzg0MmSozFbUuzV0z7qo0WPnDW
hNuWmStHEQEm9mWTJKQrQGdWWPEXqYlJ398BT69uDitcZYlLnzGs7A0w5FZs0R6P
WOr6+2JJSg1N6ZRYiBWBhG3/X/qRbqsrAb+w+WAyASm1sXHorUhV9UEC4fwrFlbL
Ot3bk/QGXI7WvuHEuEKHkhtbLOrSYVicstl2WflGliYNoXMZICYvARsQaenbEXMG
GsO9nldy1Oop6kkhHnGplf111B3sQPnI78aUKMhQaau5EkcAaSbWc6VnV2L5sNYe
mHOHBvCtrlxL2hLOy4uuAMAG/FuB00VWPSIazHVA/QNDwGia2dsNgg/75Mn3NQpf
Qm5JdyXnRxQOEfpvvGsNSH5cwrlKkJC+OaVu5V2cUOLj8AjOntLrsZgDlbrUgNH3
QYPxbpPv37cLLOw2amRrZgSNtoRR036Ld1KsmetM2aZHaLZ44AYYmhQG+06q9LPS
YJPAb9hPslEqrHrupzXBQTQY3NC1/woVCuLwCmPZzViuF2JBndve9FoAabbARb99
UnWxuWZhoLf+6D4VXtJJGgaIF555L095+XaHrJNtSqzZMVP4a+I//Apeyo3NKCO1
3RveSnAox4AMIwuZCFs=
=RsB1
-----END PGP SIGNATURE-----

--eAWylJs5fPgxl6k6--


--===============2439319640379758739==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============2439319640379758739==--
