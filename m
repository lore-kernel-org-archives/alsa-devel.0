From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: asoc: s3c24xx+uda1380 - some questions
Date: Tue, 3 Feb 2009 15:52:56 +0200
Message-ID: <200902031553.03024.anarsoul@gmail.com>
References: <200901271519.47119.anarsoul@gmail.com>
	<200902031357.12297.anarsoul@gmail.com>
	<20090203120504.GC23827@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5423122184182552106=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.190])
	by alsa0.perex.cz (Postfix) with ESMTP id 95262103860
	for <alsa-devel@alsa-project.org>; Tue,  3 Feb 2009 14:53:20 +0100 (CET)
Received: by fk-out-0910.google.com with SMTP id 26so1711241fkx.0
	for <alsa-devel@alsa-project.org>; Tue, 03 Feb 2009 05:53:20 -0800 (PST)
In-Reply-To: <20090203120504.GC23827@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, pHilipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

--===============5423122184182552106==
Content-Type: multipart/signed;
  boundary="nextPart1435528.Vld82vyEVX";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1435528.Vld82vyEVX
Content-Type: multipart/mixed;
  boundary="Boundary-01=_4wEiJltaoXFb3+E"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_4wEiJltaoXFb3+E
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 03 February 2009 14:05:08 Mark Brown wrote:

> Please do.  You should at least include some text in the patch
> description explaining what you're doing.

One more version of patch, I've fixed patch description, but didn't removed=
=20
=46IXME's, just fixed one comment.

Btw, it would be nice to hear Philipp's opinion :)

Regards
Vasily

--Boundary-01=_4wEiJltaoXFb3+E
Content-Type: text/x-patch;
  charset="iso-8859-1";
  name="0001-UDA1380-driver-should-restore-UDA1380_CLK-register-v.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="0001-UDA1380-driver-should-restore-UDA1380_CLK-register-v.patch"

=46rom 507528459911f7cc5745274bffd652e2f5302889 Mon Sep 17 00:00:00 2001
=46rom: Vasily Khoruzhick <anarsoul@gmail.com>
Date: Tue, 3 Feb 2009 15:28:35 +0200
Subject: [PATCH] UDA1380 driver should restore UDA1380_CLK register value in
 uda1380_pcm_prepare instead of enabling R00_DAC_CLK.

Without this fix driver switches to WSPLL in uda1380_pcm_prepare
even if SYSCLK was chosen (uda1380_pcm_prepare modifies UDA1380_CLK
register to disable R00_DAC_CLK before flushing reg cache)

Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
=2D--
 sound/soc/codecs/uda1380.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
index a69ee72..eba034a 100644
=2D-- a/sound/soc/codecs/uda1380.c
+++ b/sound/soc/codecs/uda1380.c
@@ -432,8 +432,8 @@ static int uda1380_pcm_prepare(struct snd_pcm_substream=
 *substream)
 		uda1380_write(codec, reg, uda1380_read_reg_cache(codec, reg));
 	}
=20
=2D	/* FIXME enable DAC_CLK */
=2D	uda1380_write(codec, UDA1380_CLK, clk | R00_DAC_CLK);
+	/* FIXME restore DAC_CLK */
+	uda1380_write(codec, UDA1380_CLK, clk);
=20
 	return 0;
 }
=2D-=20
1.6.1.1


--Boundary-01=_4wEiJltaoXFb3+E--

--nextPart1435528.Vld82vyEVX
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmITD4ACgkQRM6pQpltKE4Q+gCgrCylDEMPAL6mkToEHBRZsZFO
cFYAnjsGwUzm9KcyKRRW+f1qrpAOj0fh
=Gz2V
-----END PGP SIGNATURE-----

--nextPart1435528.Vld82vyEVX--

--===============5423122184182552106==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============5423122184182552106==--
