From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Document DAI signal polarity
Date: Wed, 30 Sep 2015 23:33:30 +0100
Message-ID: <20150930223330.GE15635@sirena.org.uk>
References: <1441054258-33200-1-git-send-email-anatol.pomozov@gmail.com>
 <20150918135427.GI12027@sirena.org.uk>
 <CAOMFOmW3RCcrGn6o0xsQWREz5gqVT_ucjO5uDAf=zexZrxWEdA@mail.gmail.com>
 <20150930181004.GN15635@sirena.org.uk>
 <CAOMFOmXX67Uktd4cVJ==1w-nfHzFF_HaKwVb+sqLMp4WPt0Knw@mail.gmail.com>
 <CA+sos78W2Ni2b3naiunBm5Z83XiDp=rd+D1jvVPoLcousCinFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6179172114266505954=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 7522A26644E
 for <alsa-devel@alsa-project.org>; Thu,  1 Oct 2015 00:33:40 +0200 (CEST)
In-Reply-To: <CA+sos78W2Ni2b3naiunBm5Z83XiDp=rd+D1jvVPoLcousCinFg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: =?iso-8859-1?Q?Beno=EEt_Th=E9baudeau?= <benoit.thebaudeau.dev@gmail.com>
Cc: liam.r.girdwood@linux.intel.com, =?utf-8?B?6Zmz56uL5bOw?= <albertchen@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>, Anatol Pomozov <anatol.pomozov@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============6179172114266505954==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="Q4+B1pX2h4duw/kc"
Content-Disposition: inline


--Q4+B1pX2h4duw/kc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 30, 2015 at 09:22:18PM +0200, Beno=EEt Th=E9baudeau wrote:

> Most CODEC datasheets describe the regular left/right justified
> formats as having the left channel starting on the rising edge of
> FSYNC, like for DSP A/B and AC'97. I=B2S is the only exception here.

Interesting, yes - I just did a quick survey of ones I have and that
does seem to be the case for the random selection I picked.  I have to
say I've never paid very much attention to those modes since they are so
rarely used (a quick survey of machine drivers suggests zero actual
users in mainline unless there's some DT selecting them).

--Q4+B1pX2h4duw/kc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWDGM5AAoJECTWi3JdVIfQvpUH/0fX+dkcejWjV7wyDsz4fQww
X7VmjhOk3i1Xih+leEKdxOocKDqcMc75LgueRxbYW3kyt6xRJ9/kZxA17qCs+rfO
94GlNhnfLTBu2s1kHUwo/G9DTSDoywJmWWwYnKmbeEMNdlfyJ7ooNpCgNvUGHAAO
Jis6y1ZyyVIoX0c4xIOcW64g+StJVgPLOsSRMXZ0nEnbpT2kwK1LxsysqQ2P7IAN
nv4h2Yx9fLtyx9YSnz6FTet4uBnS/pl7v1lVlhtTnUVtHDSaNjwMJj5ziUpWcyRT
woYlaUSeg12t/vO8zXSnqBBmDfyQFvgbZyzVGxVxpBzRCfXMxfvOkQ8K95jA2Ok=
=WaOk
-----END PGP SIGNATURE-----

--Q4+B1pX2h4duw/kc--

--===============6179172114266505954==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6179172114266505954==--
