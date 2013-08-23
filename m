From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v11 3/8] ASoC: generic: simple DT sound card
Date: Fri, 23 Aug 2013 10:58:16 +0100
Message-ID: <20130823095816.GF25263@sirena.org.uk>
References: <1376924761-4054-1-git-send-email-mpa@pengutronix.de>
 <1376924761-4054-4-git-send-email-mpa@pengutronix.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7192188151197915355=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 20678265561
 for <alsa-devel@alsa-project.org>; Fri, 23 Aug 2013 11:58:33 +0200 (CEST)
In-Reply-To: <1376924761-4054-4-git-send-email-mpa@pengutronix.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Markus Pargmann <mpa@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Grant Likely <grant.likely@secretlab.ca>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawn.guo@linaro.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org


--===============7192188151197915355==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="7mxbaLlpDEyR1+x6"
Content-Disposition: inline


--7mxbaLlpDEyR1+x6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 19, 2013 at 05:05:56PM +0200, Markus Pargmann wrote:
> Simple sound card initialized using DT. When used with AC97, ac97-codec
> is used to automatically discover the used codec.

I've held back a bit on this one.  The reason is that it's adding a
separate card to the generic card which doesn't seem like the obvious
thing to do - obviously they have very similar goals, it's just that one
is for DT usage and the other isn't.  What's the reason for not adding
DT support to the generic card?

--7mxbaLlpDEyR1+x6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSFzI1AAoJELSic+t+oim9n04P/RDZPAt8rib/e5RC19ypfk/i
j6nndIs1w4uWDBHMxfutqRSK0nkP8VmR785G5DEujmZK4JQxD7rKpNVd/LQG7C7H
NUTTCP1w+ZqaWp3c5A5ShP9UooAj45/w36CcqwkMCosVIPammZ7jdmyoqqkuSFpx
dMr6mVeH3dN9jdthu/7Td4Kel2+iXEo09ABPUIcLWdZLBULt5yi9GvM4IttagILA
T4GDBnAq53cSJ1cs5wMK5rzfIP6q1c/tnnL1CYV1ba72kEac7+rA6DFCkJHFf7bO
xG4MM/2m1VZ4i5d74Dkb3QP5cgyzRcDMpcHxXaIRSGep5j8CVT7HhoX51P01dwnK
wk4GlksnEaIEcMzafdDjSFe2ycgSI5Vn7OpjkJFYY0Tq4WeeHTS8nd+rXwzgqvax
jrVtQ92Il1+qzkfJKRIMuSLh1KyHX0w9LpRkkwTKZAWQwvNb20xZaYxlh01fw1YJ
vG1OP39OBrbnAGjd+LSPUzmexQcMQQ6tZsq/ORunsftqyEpbqklznLBjfLMZIXfN
aZvTUE+yvzINVDlaoaLSkyKMiit73h3HVr2itmGBGxdqSo+sj+Gf3f8qA7hvNq0N
KVHSKB3a8VbISj46Tzzb3icnXpEcnR05uMD6bPlfsAE/ZftK6oXRze/blt1/EFkP
OYFJNHjVFQVApZmMFnwk
=27jK
-----END PGP SIGNATURE-----

--7mxbaLlpDEyR1+x6--

--===============7192188151197915355==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7192188151197915355==--
