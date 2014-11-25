From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/9] ASoC: qcom: Add device tree binding docs
Date: Tue, 25 Nov 2014 21:26:28 +0000
Message-ID: <20141125212628.GS7712@sirena.org.uk>
References: <1416423169-21865-1-git-send-email-kwestfie@codeaurora.org>
 <1416423169-21865-3-git-send-email-kwestfie@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5Zxee1w1CL9fzjN4"
Return-path: <linux-arm-msm-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1416423169-21865-3-git-send-email-kwestfie@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Kenneth Westfield <kwestfie@codeaurora.org>
Cc: ALSA Mailing List <alsa-devel@alsa-project.org>, Device Tree Mailing List <devicetree@vger.kernel.org>, MSM Mailing List <linux-arm-msm@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, Greg KH <gregkh@linuxfoundation.org>, David Brown <davidb@codeaurora.org>, Bryan Huntsman <bryanh@codeaurora.org>, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>
List-Id: alsa-devel@alsa-project.org


--5Zxee1w1CL9fzjN4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 19, 2014 at 10:52:42AM -0800, Kenneth Westfield wrote:

> +* Qualcomm Technologies IPQ806x SoundCard
> +
> +This node models the Qualcomm Technologies IPQ806x LPASS Audio SoundCard,
> +with a connection between the CPU MI2S DAI and the external DAC.

> +Required properties:
> +- compatible        : "qcom,ipq806x-snd-card"
> +- qcom,model        : The user-visible name of this sound card
> +- pinctrl-0         : The default state of the MI2S pins
> +- pinctrl-names     : The name of the default state

Why is a sound card doing pin control?  I would expect that the
component devices would do their own pin control.  Also if you have
named pin control states the set of valid names should be specified.

> +- dac-gpios         : GPIO specifier to the GPIO -> DAC SDMODE pin

Simiarly why is a sound card controlling the DAC GPIOs, is this not part
of the CODEC?

> +- clocks            : A list of clock specifiers in the following order:
> +                        * AHBIX bus clock
> +- clock-names       : A list of names in the following order:
> +                        * ahbix_clk

Again I'd really expect any devices on the AHB to be controlling the AHB
related clocks rather than a sound card doing it.

> +asoc-platform       : This is phandle list containing the references to platform device
> +                      nodes that are used as part of the sound card dai-links.
> +asoc-platform-names : This property contains list of platform names. The order of
> +                      the platform names should match to that of the phandle order
> +                      given in "asoc-platform".

The device tree bindings should be OS neutral but ASoC is a Linux thing.
This needs to be written in terms of the hardware it's describing.

> +Required properties:
> +- compatible  : "qcom,lpass-cpu-dai"
> +- clocks      : A list of clock specifiers in the following order:
> +                        * MI2S OSR clock
> +                        * MI2S Bit clock
> +- clock-names : A list of names in the following order:
> +                        * mi2s_osr_clk
> +                        * mi2s_bit_clk

If there are names (which is good) why is the ordering important?  The
whole point in having a mandatory list of names is to remove the
ordering and completeness requirements.

> +Required properties:
> +- compatible      : "qcom,lpass-lpaif"
> +- reg             : Address space for the LPASS subsystem registers
> +- reg-names       : The name of the LPASS subsystem register address space
> +- interrupts      : Phandle to the LPASS interrupt
> +- interrupt-names : The names of the LPASS interrupt

Again you need to document the valid names.

> index 0000000000000000000000000000000000000000..d2ff501d44f7b7aa790cdadc8ba75c6a8bf37ccd
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/qcom,lpass-pcm-mi2s.txt
> @@ -0,0 +1,12 @@
> +* Qualcomm Technologies IPQ806x PCM audio interface
> +
> +This node models the Qualcomm Technologies IPQ806x PCM audio interface.
> +
> +Required properties:
> +- compatible: "qcom,lpass-pcm-mi2s"
> +
> +Example:
> +
> +lpass-pcm-mi2s {
> +	compatible = "qcom,lpass-pcm-mi2s";
> +};

This doesn't appear to describe hardware - there are no register
addresses or anything.  I'd guess this is most likely part of another
hardware block and should be handled by the driver for that device.

--5Zxee1w1CL9fzjN4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJUdPQDAAoJECTWi3JdVIfQ1i4H/0pI1VFahaYWrWxJt7QGBDd6
sITPJ0NMafCdfc+2bvUgV49y8K6KeU8cZ8Fj3Y8eGJAHw05j3m0laenLEmhZbwh1
yoJVOgZWTvg2hBJkKdweDMDL1m4R4WqDVqUm4iomSFR9rj4CLqhLePI2ry58gioJ
8QwzPpIGfuZD5ZHxNhFgj3rQG7tdZMbM4ruBI1ZWJTKoCc/jnDZG7eadYkTrzQ8N
2LwoO/lFs1dm27fDqawWeyK/bo4rQ2s/K+BhmW2J2NsOcut3AZXFA1kEHUJNkbKD
24Uis8gUYkL5wQlBE4BHJze9+XSzoL1QeWCywXMtnXYG2gFJfu5Cg5I+FOQNaR8=
=vRS3
-----END PGP SIGNATURE-----

--5Zxee1w1CL9fzjN4--
