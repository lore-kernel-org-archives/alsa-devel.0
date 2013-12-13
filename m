From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH] ASoC: tlv320aic3x: Correct S24_3LE support
Date: Fri, 13 Dec 2013 13:34:44 +0000
Message-ID: <20131213133444.GZ11044@sirena.org.uk>
References: <1386939499-5163-1-git-send-email-peter.ujfalusi@ti.com>
 <20131213130443.GY11044@sirena.org.uk> <52AB0BBD.2020001@ti.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7685491492398084375=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 98F8F261606
 for <alsa-devel@alsa-project.org>; Fri, 13 Dec 2013 14:34:47 +0100 (CET)
In-Reply-To: <52AB0BBD.2020001@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============7685491492398084375==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="yKkvi6mMqAM+MlBZ"
Content-Disposition: inline


--yKkvi6mMqAM+MlBZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 13, 2013 at 03:29:33PM +0200, Peter Ujfalusi wrote:
> On 12/13/2013 03:04 PM, Mark Brown wrote:

> > This should be adding the case for the new format rather than replacing
> > the old one shouldn't it?  They ought to turn out the same on the AIF so
> > the CODECs shouldn't care about the difference, ideally the core would
> > hide the difference from them.

> Not really since the codec has only field to specify the data format. The
> codec can not support S24_LE (S24_LE is basically S32_LE msbits==24) since we
> can not say to the codec to ignore the 8bit over the 24 bits of real data.
> In case of S24_3LE the I2S bus will have 24 clocks/per channel which can not
> be used to stream S24_LE either.

No, I'd expect the wire behaviour to be identical for any 24 bit samples
(that's certainly what most drivers are written for).  The memory layout
differences shouldn't be visible to CODEC drivers.

Like I say we ought to be handling this stuff in the core :/

--yKkvi6mMqAM+MlBZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJSqwzwAAoJELSic+t+oim9+HoQAIbVHSR0HDV6K1JGFl/VLSh3
Nz2oKr3ggpLCYhVlBaaTO6Sj8l5AkOVMtfmp4ujxyU6UFhzwFBawnG7iiJvVOuU6
iK9mWNV51J+MGk5u2IkFdvu6EWbIyngZITlZ+ZiLgSri0bIq0gto/EBkLTCNcGcN
mSRrmdzXtWRMlf0xQFP+kJD/w4kcwQFgw1UK8tAGqGCx4Vn7APLaXU6gxiByff+w
ffvNntJuoquYgXsi4z+nMw7rCTxZMHIQVzCpqIx9axnASxSMchu/i6xWwHo5dYFM
X1s8FarX5F15baie3Bp+RWkSuiTSeJXF9lScZPTrV5e6Z4ZRNT2fu10iPLQ5b0Tm
k90JisoJGLGMV+dwevCnk/3gjErlcnuzvM+dj1Q60ptLuj1DutJXoHPDm5om33ae
GD8Sg9KBSJf3FN9MFElPgqAjUBGpj3oX5SczFMxXZC10WvL5jx4hM8vVGxlT9748
7la+ZKc1fqhNwqw79Z7RHg5xpZSLEVM38ax8IsYQ47MG/KrA7F6EMZHlQXYYTYER
owNjaKGO+Bh54pZAxAqgOoab8kyCd1GwV8tDS1GVwkd0Bq4ESgmXxExBJvX6A+hF
GD+n+Bc8m5GmU68mqe1HCmYk5LDaLdHzpGwSNiq5/O4uypsmwxGuk14l03aew34W
zo/hdot9Xc5ZF1Q2d80I
=na/B
-----END PGP SIGNATURE-----

--yKkvi6mMqAM+MlBZ--

--===============7685491492398084375==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7685491492398084375==--
