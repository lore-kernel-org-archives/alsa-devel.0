From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 9/9] ARM: dts: Model IPQ LPASS audio hardware
Date: Tue, 25 Nov 2014 22:08:59 +0000
Message-ID: <20141125220859.GY7712@sirena.org.uk>
References: <1416423169-21865-1-git-send-email-kwestfie@codeaurora.org>
 <1416423169-21865-10-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fsAKpJoU5qKzlS83"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1416423169-21865-10-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


--fsAKpJoU5qKzlS83
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 19, 2014 at 10:52:49AM -0800, Kenneth Westfield wrote:

> --- a/arch/arm/boot/dts/qcom-ipq8064.dtsi
> +++ b/arch/arm/boot/dts/qcom-ipq8064.dtsi

> +		sound {
> +			compatible = "qcom,ipq806x-snd-card";
> +			status = "disabled";
> +			clocks = <&lcc AHBIX_CLK>;
> +			clock-names = "ahbix_clk";
> +			asoc-platform = <&pcm0>;
> +			asoc-platform-names = "lpass-pcm-mi2s";
> +			asoc-cpu = <&dai_mi2s>;
> +			asoc-cpu-names = "lpass-cpu-dai";
> +		};

This appears to be part of the board but...

> +		lpass-lpaif {
> +			compatible = "qcom,lpass-lpaif";
> +			status = "disabled";
> +			reg = <0x28100000 0x10000>;
> +			reg-names = "lpass-lpaif-mem";
> +			interrupts = <0 85 1>;
> +			interrupt-names = "lpass-lpaif-irq";
> +		};
> +
> +		dai_mi2s: lpass-cpu-dai {
> +			compatible = "qcom,lpass-cpu-dai";
> +			status = "disabled";
> +			clocks = <&lcc MI2S_OSR_CLK>, <&lcc MI2S_BIT_CLK>;
> +			clock-names = "mi2s_osr_clk", "mi2s_bit_clk";
> +		};
> +
> +		pcm0: lpass-pcm-mi2s {
> +			compatible = "qcom,lpass-pcm-mi2s";
> +			status = "disabled";
> +		};
> +

...these are all part of the SoC.  I'd expect these to go into separate
files.

--fsAKpJoU5qKzlS83
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdP36AAoJECTWi3JdVIfQJJAH/3zKFY10GIQCWlZYRPehEOTC
aiPtf+pNBG1YAlWT/OCSZGpV4BXI4Zbtlq5OYkOt0ctpAmxjDeLL+RtHHTMFEUgw
SL8v4fgPcSSVxE73d8cQPHPcfS9gbgGscqrHTnt1nScJimB06xME1gDC/cfPc/g4
mq9w8i3pCcuFIqHIZgTToSub171CpcrlBXOWzGrpQ3gYY+VON7q5b3NmVNtUpU5A
clrmQF+XjODWGRH0fe7M8LH2wNTpuwNFqlsBfi/8P1g4M/2dHpp3JDzWx/SfP0+Z
9b7gkpsqVofyNy1blb1Zz7Q7ZtLHIBIZSUO7tBafqcXI6OrnNeglvlYjYMB1NHs=
=K0tj
-----END PGP SIGNATURE-----

--fsAKpJoU5qKzlS83--
