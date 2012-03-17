From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v3 09/11] ASoC: fsl: remove the fatal error checking on
 codec-handle
Date: Sat, 17 Mar 2012 21:42:52 +0000
Message-ID: <20120317214252.GF3315@opensource.wolfsonmicro.com>
References: <20120313234638.GY3177@opensource.wolfsonmicro.com>
 <4F6008FA.3040805@freescale.com>
 <20120314122723.GC3133@opensource.wolfsonmicro.com>
 <4F612319.50302@freescale.com>
 <20120315130253.GA6065@S2101-09.ap.freescale.net>
 <4F61F080.4090800@freescale.com>
 <20120315142115.GB6065@S2101-09.ap.freescale.net>
 <4F621D09.2080806@freescale.com>
 <20120316012711.GD6065@S2101-09.ap.freescale.net>
 <4F629D71.3050102@freescale.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5395700714028699265=="
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <4F629D71.3050102@freescale.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tabi Timur-B04825 <B04825@freescale.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shawn Guo <shawn.guo@linaro.org>, Sascha Hauer <s.hauer@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org


--===============5395700714028699265==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GLp9dJVi+aaipsRk"
Content-Disposition: inline


--GLp9dJVi+aaipsRk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 16, 2012 at 01:55:01AM +0000, Tabi Timur-B04825 wrote:

> I'm just concerned that if there's no standard way to create bindings for=
=20
> machine drivers, we're going to end up with some kind of mess down the ro=
ad.

I think that we'll be able to deal with that by adding helpers for
common cases (as has already started to happen with some of the nVidia
inspired changes like the auto_nc_pins() stuff) - approach the problem
by extracting the good practice and putting it into helpers to encourage
use.  Fortunately machine drivers are by their nature system specific so
so if they are messed up they impact a limited subset of systems.

--GLp9dJVi+aaipsRk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPZQU8AAoJEBus8iNuMP3dVZ4P/jBjT9yXcxpGnCjqeIv+4zjr
9Gaf+IJvcHurOJFlSUJV2AeZGOY5ZQnprO/0xMy+Vub5dcso0XtTRv6LN6j4r6Sp
+0jsFuzHPMAXJmVjrOvWYSvB+tf63K5vGzmFvB8H4/4RSAlVOYXFkETaQfhmYLcu
3skiQk7ShI/DTxou9k8m3lTiC5wehBZ/ZevI2EsoJW3Cktd8KnzqtpL4k/YrR+os
uyt9RIEZ8mG2W2+Kb+n500plWcmyX375UDhLc50iwNo/LpMuR8P1IgXu0HxjITUX
JXbBW7s15tsLBfYSQJnx/0dNHSm7UP7yfcDFq+WdGi7GjRSMoHiUWh09Y3nstU7R
vBQKDZeKG8VtUZje/nz907COXZn2tHgaEn7IixBV/Th5MkxUxVHIEZ5JnyMI55e6
FNC0+eEdM4l42eQ5JWLUEUV6BUSO4YjDLo+tXceZr0yHn5mfKWPdSDL7FvunjsuQ
uLOscp9LH40v7BgOhqVASThkfxI0JDhSBX+7QWINpCrh3DosFvnaDv/lwiJUTuDp
h9cYabGIwwgwJ3eq5rQfnWd+a9j2a/A2WCcLwI1jx/gUpwiC8M9+jrznnlnHQw2E
bRgrAmNQZkbFMe9/Fol4FgF5zYumdET0fFOJ1jwbvertsIQTJmCgX3PPzF8jmXNx
s0vOfpGC9RuponVXzT4H
=yWL8
-----END PGP SIGNATURE-----

--GLp9dJVi+aaipsRk--


--===============5395700714028699265==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

--===============5395700714028699265==--
