From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v2] ASoC: rt5645: Add codec driver
Date: Mon, 5 May 2014 12:51:21 -0700
Message-ID: <20140505195121.GX22111@sirena.org.uk>
References: <1398686350-29771-1-git-send-email-oder_chiou@realtek.com>
 <20140503174237.GF22111@sirena.org.uk>
 <7EB0DE829A537248AF2ED30C97D1269436CBBD@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3495080016947294089=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 548AD265007
 for <alsa-devel@alsa-project.org>; Tue,  6 May 2014 02:57:24 +0200 (CEST)
In-Reply-To: <7EB0DE829A537248AF2ED30C97D1269436CBBD@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Oder Chiou <oder_chiou@realtek.com>
Cc: Bard Liao <bardliao@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============3495080016947294089==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wnJX2LVqXtdJquW1"
Content-Disposition: inline


--wnJX2LVqXtdJquW1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 05, 2014 at 11:15:24AM +0000, Oder Chiou wrote:
> > > +	/* I2S2 function select */
> > > +	SOC_SINGLE("I2S2 Func Switch", RT5645_GPIO_CTRL1, RT5645_I2S2_SEL_SFT,
> > > +		1, 1),

> > What functions is this switching?

> It is the pin share switch. The I2S data pins are the pin share to GPIO3/4/5/6.
> If we want to use the GPIO3/4/5/6, we need to set it. We will modify it using the
> platform data to set it.

Yes, please - this shouldn't be visible at runtime.

> > > +	/* TDM */
> > > +	SOC_ENUM("TDM Adc Slot0 1 Data", rt5645_tdm_adc_slot0_1_enum),
> > > +	SOC_ENUM("TDM Adc Slot2 3 Data", rt5645_tdm_adc_slot2_3_enum),
> > > +	SOC_ENUM("TDM Adc Slot4 5 Data", rt5645_tdm_adc_slot4_5_enum),
> > > +	SOC_ENUM("TDM Adc Slot6 7 Data", rt5645_tdm_adc_slot6_7_enum),
> > > +	SOC_ENUM("TDM IF1 ADC DATA Sel", rt5645_tdm_adc_sel_enum),
> > > +	SOC_SINGLE("TDM IF1_DAC1_L Sel", RT5645_TDM_CTRL_3, 12, 7, 0),
> > > +	SOC_SINGLE("TDM IF1_DAC1_R Sel", RT5645_TDM_CTRL_3, 8, 7, 0),
> > > +	SOC_SINGLE("TDM IF1_DAC2_L Sel", RT5645_TDM_CTRL_3, 4, 7, 0),
> > > +	SOC_SINGLE("TDM IF1_DAC2_R Sel", RT5645_TDM_CTRL_3, 0, 7, 0),

> > These look like they should be part of DAPM, they're about routing data as far as I
> > can tell.

> These are the data related controls with TDM function, not related the routing path.
> For instance, it likes the L and R channel data swap, or copy function.

These are very much routing controls - the routing operates at a mono
level.  Doing a left/right swap or stereo duplication of a mono control
is a routing thing.

--wnJX2LVqXtdJquW1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTZ+u2AAoJELSic+t+oim9qS0QAJSc5sDLL1XLdkK416KAr0b1
tsJoV+fYFFeR1a8h3fNGswsxahreSGgzRdTdNjTTacHOtL7oaNmb8ppdHoxh9aHJ
/J+KfRWEBg5GpXGLLaEBi9MN2a6/2yj8uHYzsfeIM2ojRsx6uOewXN3DQZpnqe0c
27TkXCLpTo10HA3kpzCYW9W87rnWMW17FdPwLSfGGEcatsls58nSLT7PJDMUlU1m
zwC51dEyGevm8wxGdhBUm3SAziZNJ2T+5tyPoZn96uZVu7nO1VYdlzXL6mBdhH+J
ixgjXqNWNFoKIdF0QXquyA+SnPw66XHOv3RnUY/aCJA1yVanaRyLiQ6mDCqmNf13
oP5D+dhli7x1voPDoeZkK6VfTSzDv7Ts8dLTwt6nSIA2nG9INP4OikGfyvZntwnZ
KnDNbN/y5p/e31Pt+0Kt4LKtLzqapOz4w+BI0zpnfR2vd4fK4TtZfIp8j70Y1zhC
eP15QEMhQvsXFljCyHeDrWv2T+1fmpEAB/XxxlpweoedAIvEkZuzPMmM5azNul2/
KpDE3r+I7OApJrG6g6FjsHiS/aDF4FqFJ5rHA0JXT1RKDI8fR7we2OYtP7nDQigo
YzAgHY4I1zJPbFOUbYKP6ADDNW/von9M8Ch6OB4/SnRsFFaRAmops1v3WLHLtwK+
B+UQiAzxWPxwsnxbhTvV
=Vxrc
-----END PGP SIGNATURE-----

--wnJX2LVqXtdJquW1--

--===============3495080016947294089==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3495080016947294089==--
