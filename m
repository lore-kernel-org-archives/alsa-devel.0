From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: Document DAI signal polarity
Date: Wed, 30 Sep 2015 20:28:25 +0100
Message-ID: <20150930192825.GB15635@sirena.org.uk>
References: <1441054258-33200-1-git-send-email-anatol.pomozov@gmail.com>
 <20150918135427.GI12027@sirena.org.uk>
 <CAOMFOmW3RCcrGn6o0xsQWREz5gqVT_ucjO5uDAf=zexZrxWEdA@mail.gmail.com>
 <20150930181004.GN15635@sirena.org.uk>
 <CAOMFOmXX67Uktd4cVJ==1w-nfHzFF_HaKwVb+sqLMp4WPt0Knw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7703576230477321292=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A675266415
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 21:28:33 +0200 (CEST)
In-Reply-To: <CAOMFOmXX67Uktd4cVJ==1w-nfHzFF_HaKwVb+sqLMp4WPt0Knw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Anatol Pomozov <anatol.pomozov@gmail.com>
Cc: liam.r.girdwood@linux.intel.com, =?utf-8?B?6Zmz56uL5bOw?= <albertchen@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org


--===============7703576230477321292==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="bgVZo3zXaTQrZhjg"
Content-Disposition: inline


--bgVZo3zXaTQrZhjg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 30, 2015 at 12:08:20PM -0700, Anatol Pomozov wrote:

> To clarify, you propose following definition of normal FSYNC polarity:
>  - for I2S/left/right justified - frame starts with falling FSYNC edge
>  - for DSP A/B - frame starts with rising edge of FSYNC edge (plus offset)

Yes.

>  - for AC97 my guess it is the same as DSP - frame starts with rising
> FSYNC edge.

For AC'97 we don't support any kind of non-standard framing and would
push back strongly against anyone who wants it but I guess yes.

--bgVZo3zXaTQrZhjg
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWDDfYAAoJECTWi3JdVIfQbUAH/2LnGO7NpZStEUFqWTMjtX44
5Z5DwSGJX1m2nkMDPDGOu30EuWbiyE7JfWB+PAmmTcDTps12e5o/Dnx183L1Ep4z
yJ6NcbVNaT48V7/QwkB4XYkl8WYKSKixgjeViCPG04dRapf21Zr8V7/bYaTVi+cZ
5L0sUTDJAQ67rsWUG4PMh70ejhauwdL2EFR2KHGPdrmCgxpEI7jePQebkJEEMoyK
y5fx05r1mPBcPE6h/0zQdGEENdSwyuuM44lzTM8D5B38Tn9ufr3oBR9edgSM0sBQ
I1wG9OMf3QElYJMUZIntq4ySFUsHg2R7vSudunEjEdTooBiX3RHKKQ9D2H9/DaM=
=onEU
-----END PGP SIGNATURE-----

--bgVZo3zXaTQrZhjg--

--===============7703576230477321292==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7703576230477321292==--
