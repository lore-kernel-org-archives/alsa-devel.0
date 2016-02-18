From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v2 3/5] ASoC: adau17x1: Add adau17x1 bindings document
Date: Thu, 18 Feb 2016 08:37:31 -0600
Message-ID: <20160218143731.GR9654@rob-hp-laptop>
References: <1455627405-18155-1-git-send-email-andire@axis.com>
 <1455627405-18155-4-git-send-email-andire@axis.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1455627405-18155-4-git-send-email-andire@axis.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andreas =?iso-8859-1?Q?Irest=E5l?= <andreas.irestal@axis.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Andreas =?iso-8859-1?Q?Irest=E5l?= <andire@axis.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Feb 16, 2016 at 01:56:43PM +0100, Andreas Irest=E5l wrote:
> Signed-off-by: Andreas Irest=E5l <andire@axis.com>
> ---
>  .../devicetree/bindings/sound/adi,adau17x1.txt     | 24 ++++++++++++=
++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/adi,adau1=
7x1.txt
>=20
> diff --git a/Documentation/devicetree/bindings/sound/adi,adau17x1.txt=
 b/Documentation/devicetree/bindings/sound/adi,adau17x1.txt
> new file mode 100644
> index 0000000..8dbce0e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/adi,adau17x1.txt
> @@ -0,0 +1,24 @@
> +Analog Devices ADAU1361/ADAU1461/ADAU1761/ADAU1961/ADAU1381/ADAU1781
> +
> +Required properties:
> +
> + - compatible:		Should contain one of the following:
> +			"adi,adau1361"
> +			"adi,adau1461"
> +			"adi,adau1761"
> +			"adi,adau1961"
> +			"adi,adau1381"
> +			"adi,adau1781"
> +
> + - reg:			The i2c address. Value depends on the state of ADDR0
> +			and ADDR1, as wired in hardware.
> +
> +Examples:
> +#include <dt-bindings/sound/adau17x1.h>
> +
> +	i2c_bus {
> +		adau1361@38 {

codec@38

Otherwise:

Acked-by: Rob Herring <robh@kernel.org>


> +			compatible =3D "adi,adau1761";
> +			reg =3D <0x38>;
> +		};
> +	};
> --=20
> 2.1.4
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe devicetree"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
