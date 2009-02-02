From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: asoc: s3c24xx+uda1380 - some questions
Date: Tue, 3 Feb 2009 01:46:32 +0200
Message-ID: <200902030146.38863.anarsoul@gmail.com>
References: <200901271519.47119.anarsoul@gmail.com>
	<74d0deb30901271149g40ac1842wfc28828377c27794@mail.gmail.com>
	<200901272232.17752.anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7536396698737602999=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f11.google.com (mail-ew0-f11.google.com
	[209.85.219.11]) by alsa0.perex.cz (Postfix) with ESMTP id EE2A6243EC
	for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2009 00:46:59 +0100 (CET)
Received: by ewy4 with SMTP id 4so2001406ewy.8
	for <alsa-devel@alsa-project.org>; Mon, 02 Feb 2009 15:46:59 -0800 (PST)
In-Reply-To: <200901272232.17752.anarsoul@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: pHilipp Zabel <philipp.zabel@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

--===============7536396698737602999==
Content-Type: multipart/signed;
  boundary="nextPart2369335.agbB4c0QiQ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart2369335.agbB4c0QiQ
Content-Type: multipart/mixed;
  boundary="Boundary-01=_ZX4hJv0sl8CB5f7"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_ZX4hJv0sl8CB5f7
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 27 January 2009 22:32:11 Vasily Khoruzhick wrote:
> On 27 January 2009 21:49:01 pHilipp Zabel wrote:
> > The uda1380 data sheet says that the reset time should be at least 1
> > =B5s - could that be a problem?
> >
> > regards
> > Philipp
>
> Nope, added mdelay(10) in reset sequence, but it didn't help.
>
> Regards
> Vasily

Here's patch that fixes 2nd bug I've mentioned (there's a sound only on sec=
ond=20
and later aplay). It's bug in uda1380 driver (probably, just a typo), drive=
r=20
switches to WSPLL in uda1380_pcm_prepare even if SYSCLK was chosen=20
(uda1380_pcm_prepare modifies UDA1380_CLK register before flushing reg cach=
e,=20
but doesn't restore its value later)

One more question: it seems that my rx1950 clocked in a way that I can't ge=
t=20
precise divisor for 44100 and 22050 rates, but uda1380 driver propose them=
=20
(look UDA1380_RATES define and struct snd_soc_dai uda1380_dai[].
How to exclude all rates except 16000 and 48000? Should I declare my own=20
snd_soc_dai and copy necessary members from uda1380's one?

Regards
Vasily

--Boundary-01=_ZX4hJv0sl8CB5f7
Content-Type: text/x-patch;
  charset="iso-8859-15";
  name="0001-Fix-typo-in-uda1380-driver.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-Fix-typo-in-uda1380-driver.patch"

=46rom ad025e64d006dc86b7a669b8f5ab611b0b33b292 Mon Sep 17 00:00:00 2001
=46rom: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Tue, 3 Feb 2009 01:34:09 +0200
Subject: [PATCH] Fix typo in uda1380 driver


Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
=2D--
 sound/soc/codecs/uda1380.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index a69ee72..a4d32b1 100644
=2D-- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -433,7 +433,7 @@ static int uda1380_pcm_prepare(struct snd_pcm_substream=
 *substream)
 	}
=20
 	/* FIXME enable DAC_CLK */
=2D	uda1380_write(codec, UDA1380_CLK, clk | R00_DAC_CLK);
+	uda1380_write(codec, UDA1380_CLK, clk);
=20
 	return 0;
 }
=2D-=20
1.6.1.1


--Boundary-01=_ZX4hJv0sl8CB5f7--

--nextPart2369335.agbB4c0QiQ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmHhd4ACgkQRM6pQpltKE61FACfRldImXRsGQW03C/PxjojVuhi
3p0AoMo7ic3IRpImax/JR6Djbmxb6OiT
=e1vc
-----END PGP SIGNATURE-----

--nextPart2369335.agbB4c0QiQ--

--===============7536396698737602999==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============7536396698737602999==--
