From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: cs4270: fix DAPM stream name
	mismatch
Date: Tue, 11 Oct 2016 15:23:20 +0200
Message-ID: <20161011132319.illdmbeqrjzc3kdv@sirena.org.uk>
References: <alpine.LNX.2.00.1610091322540.27835@acc-1004367-dev>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7200285894357025383=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F3A722666D2
 for <alsa-devel@alsa-project.org>; Tue, 11 Oct 2016 15:23:33 +0200 (CEST)
In-Reply-To: <alpine.LNX.2.00.1610091322540.27835@acc-1004367-dev>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: murray foster <mrafoster@gmail.com>
Cc: "Austin, Brian" <Brian.Austin@cirrus.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, "Handrigan,
 Paul" <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org


--===============7200285894357025383==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fmqjbsmb2bkef7o4"
Content-Disposition: inline


--fmqjbsmb2bkef7o4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 09, 2016 at 01:28:45PM -0700, murray foster wrote:

> Mismatching stream names in DAPM route and widget definitions are
> causing compilation errors. Fixing these names allows the cs4270
> driver to compile and function.

This commit log can't be right, we've got extensive build coverage and
there's no way build coverage could spot a mismatch between strings.
I'm assuming this happens at probe time?

--fmqjbsmb2bkef7o4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJX/OfHAAoJECTWi3JdVIfQdCAH/39m7kg5RYSYzpfzV5fyAmcD
xCMZTwPiXA/euhYlKMSHE3qX+Am/cf1X2n5vy7P0+fRG3Ai+zhgKo30Yzt+Fw1mY
QX8HIsKVocln99NzBU+7oe9xtfGwOjhqU9zfRn9lQNeRzLU+fZI/NqZBy0PmTtga
4Ot1HU2n3oJh3Q/jUvWt/Ekkem590Q+keRS1G3pQu4arqEoZGgxJuUKtW8oKNLhB
MWDVFDXFk1Su0/717BnZvd+PbaKMAJlu6GS486k++RbOu+8htcFf4AhsYcXLInzj
nGGF3U6FrxFuHulFIawrxX/JVfmJ3WDr5FVvilcFsbyrMu9hQWyVTAFCDekgsbM=
=aHla
-----END PGP SIGNATURE-----

--fmqjbsmb2bkef7o4--

--===============7200285894357025383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7200285894357025383==--
