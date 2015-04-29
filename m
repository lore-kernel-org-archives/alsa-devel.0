From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [alsa-devel] [PATCH v2 2/2] mfd: arizona: Update DT binding to
 support hpdet channel
Date: Wed, 29 Apr 2015 11:57:37 +0100
Message-ID: <20150429105737.GZ9169@x1>
References: <1429589505-11954-1-git-send-email-ideal.song@samsung.com>
 <1429589505-11954-3-git-send-email-ideal.song@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1429589505-11954-3-git-send-email-ideal.song@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Inha Song <ideal.song@samsung.com>
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, patches@opensource.wolfsonmicro.com, cw00.choi@samsung.com, broonie@kernel.org, ckeepax@opensource.wolfsonmicro.com, rf@opensource.wolfsonmicro.com, robh+dt@kernel.org, pawel.moll@arm.com, mark.rutland@arm.com, ijc+devicetree@hellion.org.uk
List-Id: alsa-devel@alsa-project.org

Does this looks okay to you Charles?

> This patch add device tree bindings for the pdata needed to configure
> the Accessory Detect Mode select when Headphone detection.

Isn't the idea of headphone detection that it headphones are detected
i.e. automatically?

> Signed-off-by: Inha Song <ideal.song@samsung.com>
> ---
>  Documentation/devicetree/bindings/mfd/arizona.txt | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/mfd/arizona.txt b/Docu=
mentation/devicetree/bindings/mfd/arizona.txt
> index 7bd1273..3529592 100644
> --- a/Documentation/devicetree/bindings/mfd/arizona.txt
> +++ b/Documentation/devicetree/bindings/mfd/arizona.txt
> @@ -49,6 +49,12 @@ Optional properties:
>      input singals. If values less than the number of input signals, =
elements
>      that has not been specifed are set to 0 by default.
> =20
> +  - wlf,hpdet-channel : Headphone detection channel.
> +	1 or ARIZONA_ACCDET_MODE_HPL - Headphone detect mode is set to HPDE=
TL
> +	2 or ARIZONA_ACCDET_MODE_HPR - Headphone detect mode is set to HPDE=
TR
> +	If this node is not mentioned or if the value is unknown, then
> +	headphone detection mode is set to MICDET.
> +
>    - DCVDD-supply, MICVDD-supply : Power supplies, only need to be sp=
ecified if
>      they are being externally supplied. As covered in
>      Documentation/devicetree/bindings/regulator/regulator.txt

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
