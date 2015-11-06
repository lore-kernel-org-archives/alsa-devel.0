From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: codecs: Add da7218 codec driver
Date: Fri, 6 Nov 2015 11:54:51 +0000
Message-ID: <20151106115451.GG18409@sirena.org.uk>
References: <cover.1446718490.git.Adam.Thomson.Opensource@diasemi.com>
 <01a9b6e96b66327cf9a27781c13aa50545380acb.1446718490.git.Adam.Thomson.Opensource@diasemi.com>
 <20151105152736.GO18409@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CA0C@SW-EX-MBX01.diasemi.com>
 <20151106112141.GE18409@sirena.org.uk>
 <2E89032DDAA8B9408CB92943514A0337D460CA3D@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3645066527042135256=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id EC5D6260420
 for <alsa-devel@alsa-project.org>; Fri,  6 Nov 2015 12:55:15 +0100 (CET)
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337D460CA3D@SW-EX-MBX01.diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Support Opensource <Support.Opensource@diasemi.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh+dt@kernel.org>, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


--===============3645066527042135256==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="FBBJgEOSAOerUJIT"
Content-Disposition: inline


--FBBJgEOSAOerUJIT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 06, 2015 at 11:53:00AM +0000, Opensource [Adam Thomson] wrote:
> On November 6, 2015 11:22, Mark Brown wrote:

> > > I can envisage in a system you may want to choose which capture channels can
> > > trigger level detection (if any), and this may change depending on the use-case
> > > at the time, so having it as a control makes sense to me.

> > What is a "capture channel" here?

> Input filters 1L/R and 2L/R, which are fed from either Mic1(ADC1) or DMic1L/R
> and Mic2(ADC2) or DMic2L/R.

Hang on, is this just recording a DC value with the ADC and then looking
at that?

--FBBJgEOSAOerUJIT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWPJUKAAoJECTWi3JdVIfQxaQH/j50PUeabXfcN2XeYnNIMCUC
Xrc1Ib5E9zhufAdCanT2O4B9j6JEpaTVjBF3S3BRDQJSWhC+ddhUG4P3JJ7iZ8pq
rYVXJ8DrqBe+aNzxvtMxMsrGufFrT2cTRgv0BzefW1VD6jurXogz9N+1aYXOBRBw
P1omRxkYBBAIykZnV1w4plu3nT3Q5yikIbz1EQS/NcdBxKzY8FQy0mDkFYEicDji
gKI2+d2w/Z5uFek/iuEsfQW7M1vnSlb0uKxJf533nKXrj5GRXB/i7yds10zxRcTb
z3VEULfzouC2+QqEyAL4OIbxWnoiV4WREaRMnPshXP+PEKLZbaLpqeKWrrbnRGQ=
=oCfq
-----END PGP SIGNATURE-----

--FBBJgEOSAOerUJIT--

--===============3645066527042135256==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3645066527042135256==--
