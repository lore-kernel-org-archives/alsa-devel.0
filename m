From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Add max98371 codec driver
Date: Wed, 27 Apr 2016 17:42:47 +0100
Message-ID: <20160427164247.GE3217@sirena.org.uk>
References: <1460578847-8712-1-git-send-email-yesanishhere@gmail.com>
 <20160418164727.GI3217@sirena.org.uk>
 <CABCoZhDLyT_2xMhOqkiw5+9rOtA9FUqcvxy+1Pz=2QohAZEcHA@mail.gmail.com>
 <20160419094629.GP3217@sirena.org.uk>
 <CABCoZhAXqXTdMebSHLXTMbAUYCR-8H320F_0EOViYcGqMwisWQ@mail.gmail.com>
 <20160422153124.GH3217@sirena.org.uk>
 <CABCoZhCv0u72vDHkEbq--SuHcZGvQYggH9EbSSYLC3ByFdt-cA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2049600783426557968=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 5E2482665A9
 for <alsa-devel@alsa-project.org>; Wed, 27 Apr 2016 18:42:52 +0200 (CEST)
In-Reply-To: <CABCoZhCv0u72vDHkEbq--SuHcZGvQYggH9EbSSYLC3ByFdt-cA@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: anish kumar <yesanishhere@gmail.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============2049600783426557968==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Fj1pnwq+N6fJcV4q"
Content-Disposition: inline


--Fj1pnwq+N6fJcV4q
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 26, 2016 at 11:16:38AM -0700, anish kumar wrote:

> Discussion of this with hardware team revealed that dynamic headroom
> tracking is the feature which will be controlled with this gain.

> I am also adding two new controls for this: speaker gain min and DHT
> rotation point.

> I will be adding all of this as TLV as this should be configurable.

Sounds good.

--Fj1pnwq+N6fJcV4q
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXIOwHAAoJECTWi3JdVIfQTX8H/R4yh5lgHdRLkhn9nHxxoCCh
4h8rNzcxtaPmWEKL9Mjc+TZyr+NZAlFhD8d4eJj1bJKBUFOeec1gV0ycXTFMh6js
/fqrqH1KOWtwe9HX/KyWXI/477qhDlFc/wkK1LG4ltQdLEzWWCfi2mSn+Pluv3ek
cFgS4fI63d8LpNNvMtKc+uTCD7kaJQOLW9klKW9s+mQsbAdVeBiMjRfqjJFD1YmA
XTfKaXSehSrF51+ZqIq2OmUZNMGVwCk8YTqWPATFyIHaB7YBmGAsc5hNDpVRguDC
Y2wnrngqVUdrg2ppyFTIM/vmvIwlZ2pbw33wS7fI04CDSgHtsxv/q4pSj7ya9eo=
=xY3j
-----END PGP SIGNATURE-----

--Fj1pnwq+N6fJcV4q--

--===============2049600783426557968==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============2049600783426557968==--
