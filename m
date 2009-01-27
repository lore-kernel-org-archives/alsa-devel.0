From: Vasily Khoruzhick <anarsoul@gmail.com>
Subject: Re: asoc: s3c24xx+uda1380 - some questions
Date: Tue, 27 Jan 2009 17:19:53 +0200
Message-ID: <200901271720.03880.anarsoul@gmail.com>
References: <200901271519.47119.anarsoul@gmail.com>
	<20090127150040.GD11870@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8980562050097815150=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by alsa0.perex.cz (Postfix) with ESMTP id D787D1037F0
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 16:20:13 +0100 (CET)
Received: by ug-out-1314.google.com with SMTP id m2so481298uge.24
	for <alsa-devel@alsa-project.org>; Tue, 27 Jan 2009 07:20:13 -0800 (PST)
In-Reply-To: <20090127150040.GD11870@sirena.org.uk>
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
Cc: alsa-devel@alsa-project.org, Philipp Zabel <philipp.zabel@gmail.com>
List-Id: alsa-devel@alsa-project.org

--===============8980562050097815150==
Content-Type: multipart/signed;
  boundary="nextPart14875850.hkmWoLh8a2";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart14875850.hkmWoLh8a2
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Tuesday 27 January 2009 17:00:41 Mark Brown wrote:

> CCing in Philipp Zabel who wrote the UDA1380 driver.  Assuming you mean
> control to cut the power to the chip the most standard way of doing it
> would be with the regulator API but if the chip isn't being used much in
> new designs it might not be worth it.

Uh-oh, I didn't thought that it will be so complicated to decide when turn =
one=20
gpio line to 0 or 1 :) Btw, I'm thinking about using own write- and read-=20
wrappers for uda1380, in this way I can check on each read/write whether=20
codec power is enabled.

> That sounds like something in the teardown path should be done on
> startup as well.  Can't think of any obvious gotchas there, though I'd
> be looking at the codec and machine drivers since the CPU driver for the
> S3C24xx is used in quite a few designs.

Sorry, but what is "teardown path"?

Regards
Vasily

--nextPart14875850.hkmWoLh8a2
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBJfyYjRM6pQpltKE4RAvR8AJ0QAVtBTr+QoVMfd4A2j04vNfWKTQCfe0x1
wu/HvsO5WKTrLAIZ6y+EW/w=
=h9+p
-----END PGP SIGNATURE-----

--nextPart14875850.hkmWoLh8a2--

--===============8980562050097815150==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============8980562050097815150==--
