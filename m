From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 2/5] ASoC: Davinci: McASP: add device tree
 support for McASP
Date: Fri, 17 Aug 2012 23:41:32 +0100
Message-ID: <20120817224131.GJ18871@opensource.wolfsonmicro.com>
References: <1344948125-5649-1-git-send-email-gururaja.hebbar@ti.com>
 <1344948125-5649-3-git-send-email-gururaja.hebbar@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============0941948419799903193=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D613E266195
 for <alsa-devel@alsa-project.org>; Sat, 18 Aug 2012 00:11:47 +0200 (CEST)
In-Reply-To: <1344948125-5649-3-git-send-email-gururaja.hebbar@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Hebbar, Gururaja" <gururaja.hebbar@ti.com>
Cc: alsa-devel@alsa-project.org, sudhakar.raj@ti.com, tony@atomide.com, nsekhar@ti.com, davinci-linux-open-source@linux.davincidsp.com, peter.ujfalusi@ti.com, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============0941948419799903193==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fwqqG+mf3f7vyBCB"
Content-Disposition: inline


--fwqqG+mf3f7vyBCB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Aug 14, 2012 at 06:12:02PM +0530, Hebbar, Gururaja wrote:

> +- op-mode : I2S/DIT ops mode.

This would normally be part of the machine binding since it needs to be
applied to both ends of the link.  When adding it could you come up with
a generic binding for this in terms of the current ASoC DAI paremeters
please?  That way we'll be able to have other machine drivers be
consistent with this one.

> +- tdm-slots : Slots for TDM operation.

This would normally also be a machine driver thing though it's less
normal to need to configure this on both ends.

--fwqqG+mf3f7vyBCB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAEBAgAGBQJQLsiQAAoJEFJkBDiqVpZ4/eIP/3L5DZq2Q0grulGhDp2oW8wV
QjVIre34DrR9S62ifj13IgRhwMVIYxx2eAzZ25FONYedOfHEy01pu58ylOaXUFZ0
x4iW9p90oXB+nsolY6+nwjMbibfo8qddKcEOerwiIOD4eWwsHZCtePqB8w1B3ypg
q1xyg9YzVxTKNZXg2nPWv582F+My7VqRM4RL7cYdZX2wbgUNveIbMX/KP3jJwO5S
vpIdN1CaZDPJBQV9fAi4UnBrcfdm6C7ITbyZYepzoEfvgY5MjOBJezOYwoZMsgwr
Al6pDDFLV72R7F5KkLbtk+kY7PG+FiZ2jpWkeZryqUrEOrOwR1uqaFYeo4Ig5OzW
qUTH+ZQz0f9KSz4VjyKl6lMt9mHIScKFY79XrsKfVm9EtTaLYPmad+OWX19LUlw7
/6gIGpr0MS4FVucZb6cTPRkJbKuHbqFz1flta+UcRIRjm9tux0O6t11ty0AXP0MY
MWb9g2nNzr2fa0mShh0h13/WHqT6LiqDuvyXjmtSf4cHzdH8VhcjTd9A8DlT354u
AMakUtR2Y6RwcSqjONEIZfLHE//x3ijbQdSliWmX4p5nw6e7u/D+j5rZ7i+f+Lsa
vjq6MJzWY22WipXIk/bPhXPZYFVB+lu71qfIeC6VNAXOyex/sST5S7rWv+TdMPbw
ONRjHsoLUbXi+eimLn+7
=N/NN
-----END PGP SIGNATURE-----

--fwqqG+mf3f7vyBCB--

--===============0941948419799903193==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0941948419799903193==--
