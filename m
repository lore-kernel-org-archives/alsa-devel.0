From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 1/2] ASoC: rt5670: Revert Keep sysclk on
	patch
Date: Mon, 9 Mar 2015 12:19:31 +0000
Message-ID: <20150309121931.GH28806@sirena.org.uk>
References: <1425891323-21445-1-git-send-email-bardliao@realtek.com>
 <20150309104952.GF28806@sirena.org.uk>
 <ABFD875FF5FB574BA706497D987D48D7010591A9@RTITMBSV03.realtek.com.tw>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7845989298648923153=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 46EE32605EA
 for <alsa-devel@alsa-project.org>; Mon,  9 Mar 2015 13:19:42 +0100 (CET)
In-Reply-To: <ABFD875FF5FB574BA706497D987D48D7010591A9@RTITMBSV03.realtek.com.tw>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: Oder Chiou <oder_chiou@realtek.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "lars@metafoo.de" <lars@metafoo.de>, "mengdong.lin@intel.com" <mengdong.lin@intel.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, John Lin <john.lin@realtek.com>, "yao.jin@intel.com" <yao.jin@intel.com>, Flove <flove@realtek.com>
List-Id: alsa-devel@alsa-project.org


--===============7845989298648923153==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="jOtImjXIA9XXnHrK"
Content-Disposition: inline


--jOtImjXIA9XXnHrK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Mar 09, 2015 at 12:13:04PM +0000, Bard Liao wrote:

> System clock is needed for rt5670 jack detection function. Usually,
> the system clock source is from MCLK. But some platform such as
> Intel BSW will turn off MCLK in idle mode. So rt5670 need to switch the
> system clock source to its internal clock. The action is done by machine
> driver.

OK...  but if this is the case why does your patch not update any
machine drivers?

> There is a PLL power in rt5670. It should be on if we want to use
> PLL as the system clock source. So we call force enable/disable pin
> in rt5670_set_dai_sysclk. However, cht_bsw_rt5672.c call
> snd_soc_dai_set_sysclk in platform_clock_control which is the dapm
> event of "Platform Clock" widget. In that case,
> snd_soc_dapm_disable_pin and snd_soc_dapm_sync are called
> within a dapm event. I think it is not valid.

This is very unusual, normally such system clock reconfiguration would
be done in the set_bias_level() callback not in a DAPM event.  Doing it
in a DAPM event sounds unreliable as there are only weak guarantees
about the state of the system.

--jOtImjXIA9XXnHrK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJU/Y/SAAoJECTWi3JdVIfQsXMH/A2l8lgdYc2dYEUBo1fpF1og
8/Cdw8M2jjhex9MpICEkLES4nuQf5zinbmQBu6OeMcB/rqLqD8UqCvpgcK86pSLw
EvUq3QYeIHNb4uQARJ+rmCPzBzyqDUKxXLEgDv//uvtBgDib3Q4kgffbr9Go24eV
EwfbxVaaEgH3AlOEJNdXc6FBhKn8rXmKycw95FeadCFMg2sbkYVZ5X6aXMllGSzG
B2/u60+Kcm55uBpUJjnVFq3fjxdQ2GMxJh0BHycF5U4VTVC8HkKGNUMywVUXpE/N
jI+ckjuNAP+dLTBOstA/WbEenLuIzgjk/h7w4YH96pMvV4AVe1u2CLkC01f8y1c=
=M0u2
-----END PGP SIGNATURE-----

--jOtImjXIA9XXnHrK--

--===============7845989298648923153==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7845989298648923153==--
