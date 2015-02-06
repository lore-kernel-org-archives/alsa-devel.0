From: =?UTF-8?B?VXJzIEbDpHNzbGVy?= <urs.fassler@bytesatwork.ch>
Subject: [PATCH 1/2] davinci-mcasp: use bclk_master flag to
 decide if the SOC is clock master
Date: Fri, 06 Feb 2015 10:22:07 +0100
Message-ID: <54D487BF.2050602@bytesatwork.ch>
References: <1423212723-15307-1-git-send-email-urs.fassler@bytesatwork.ch>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7000549439665609788=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bytesatwork.ch (bytesatwork.ch [91.135.72.15])
 by alsa0.perex.cz (Postfix) with ESMTP id A0BF7260584
 for <alsa-devel@alsa-project.org>; Fri,  6 Feb 2015 10:22:21 +0100 (CET)
In-Reply-To: <1423212723-15307-1-git-send-email-urs.fassler@bytesatwork.ch>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: perex@perex.cz, tiwai@suse.de
Cc: urs.fassler@bytesatwork.ch, alsa-devel@alsa-project.org, lgirdwood@gmail.com, jsarha@ti.com, linux-kernel@vger.kernel.org, peter.ujfalusi@ti.com, broonie@kernel.org, misael.lopez@ti.com
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============7000549439665609788==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="i6DpNkxI85exBUlL3caTa2Gxs14dHC1Qx"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i6DpNkxI85exBUlL3caTa2Gxs14dHC1Qx
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Signed-off-by: Urs F=C3=A4ssler <urs.fassler@bytesatwork.ch>
---
 sound/soc/davinci/davinci-mcasp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/davinci/davinci-mcasp.c
b/sound/soc/davinci/davinci-mcasp.c
index 30b94d4..396cdec 100644
--- a/sound/soc/davinci/davinci-mcasp.c
+++ b/sound/soc/davinci/davinci-mcasp.c
@@ -541,7 +541,7 @@ static int davinci_mcasp_set_sysclk(struct
snd_soc_dai *dai, int clk_id,
 {
 	struct davinci_mcasp *mcasp =3D snd_soc_dai_get_drvdata(dai);
 -	if (dir =3D=3D SND_SOC_CLOCK_OUT) {
+	if (mcasp->bclk_master) {
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKXCTL_REG, AHCLKXE);
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_AHCLKRCTL_REG, AHCLKRE);
 		mcasp_set_bits(mcasp, DAVINCI_MCASP_PDIR_REG, AHCLKX);
--=20
2.1.4



--i6DpNkxI85exBUlL3caTa2Gxs14dHC1Qx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJU1Ie/AAoJEKKADLnESIBjET0P/AuW78Fpob69b2L+Iu9fVjQ4
e+TK4i6nyr70j0LX9ndZXgXsnhDHLviQYyxmaf1HvRINwkyE3lY1Nhn5pBrJaeCa
kN42lutio3AJKg3027ibY0wJsDxwUKPPD4Umq1aDLW3I1G4kDJ7VGERCAvmpmT+g
p+yPTGBpBPo9IFhlswklZWqkGn0TpehKwsI4Jpw7Hp86GIW0SN/yHE2jHtqOVUMk
BHP3igkagW0xsS2dCu0lB1Puio8QeI7VSU8WSkiiI1GJSaQApQNqDRjE+cMKE//c
JFlk4iWve8rE5XCeGK436/SKTTV+Bg9pDY3yo+ZEg1o8UekbObRQ/xmlk2dXvwi4
2f30wdxAQ1tOdUKGwtF+Tk77AXN/Fn/LmuwSYSpejSrOCAIQfI3+f9EmHnZBkgMY
YmgeedcEdoOdVmUlK+SmczOCJ3Tk1Ua+uz7v+xgVF0troeKEinADmFs6ZKIH4NXI
Im3C3joi/uNfyQpgW2oSjr8gExPAkxKdoQoVvUoEG9YmS1N2isNtovkC0dAxrgN6
RzFBpPOlXZTXMmXfH8bu8G7KP4SnzsD57nwZf0cTGGU/4Iu8il9mSiOFtv/VzUsh
lrNCQTaQRQSqsvbv+DzXhq7noevt4T+IJI33ONkmfbmv9WLOQy4RsDZakfZZlqKN
QPAXmYz9Mjpa4qpZ+ySl
=5qHN
-----END PGP SIGNATURE-----

--i6DpNkxI85exBUlL3caTa2Gxs14dHC1Qx--

--===============7000549439665609788==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7000549439665609788==--
