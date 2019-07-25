From: Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH 02/11] MIPS: qi_lb60: Migrate to devicetree
Date: Thu, 25 Jul 2019 23:47:37 +0000
Message-ID: <20190725234735.h7qmtt26qpkjw3n6@pburton-laptop>
References: <20190725220215.460-1-paul@crapouillou.net>
 <20190725220215.460-3-paul@crapouillou.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190725220215.460-3-paul@crapouillou.net>
Content-Language: en-US
Content-ID: <D8ACA55FCC1F804CB7F8CE8CFDE41571@namprd22.prod.outlook.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Paul Cercueil <paul@crapouillou.net>
Cc: Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Vinod Koul <vkoul@kernel.org>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Lee Jones <lee.jones@linaro.org>, Miquel Raynal <miquel.raynal@bootlin.com>, Richard Weinberger <richard@nod.at>, Sebastian Reichel <sre@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, "od@zcrc.me" <od@zcrc.me>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dmaengine@vger.kernel.org" <dmaengin>
List-Id: alsa-devel@alsa-project.org

Hi Paul,

On Thu, Jul 25, 2019 at 06:02:06PM -0400, Paul Cercueil wrote:
> Move all the platform data to devicetree.

Nice! :)

> The only bit dropped is the PWM beeper, which requires the PWM driver
> to be updated. I figured it's okay to remove it here since it's really
> a non-critical device, and it'll be re-introduced soon enough.

OK, I can see that being a price worth paying. Though it's possible to
include the binding at least for that in this series I'd be even
happier. Actually I see we already have

  Documentation/devicetree/bindings/pwm/ingenic,jz47xx-pwm.txt

in mainline - what needs to change with it?

> +	spi {
> +		compatible =3D "spi-gpio";
> +		#address-cells =3D <1>;
> +		#size-cells =3D <0>;
> +
> +		sck-gpios =3D <&gpc 23 GPIO_ACTIVE_HIGH>;
> +		mosi-gpios =3D <&gpc 22 GPIO_ACTIVE_HIGH>;
> +		cs-gpios =3D <&gpc 21 GPIO_ACTIVE_LOW>;
> +		num-chipselects =3D <1>;
> +
> +		spi@0 {
> +			compatible =3D "ili8960";

Should this be "ilitek,ili8960"?

Is there a binding & driver for this submitted somewhere? If not then do
we need this at all? It doesn't look like the existing platform data
would actually lead to a driver being loaded so I'm wondering if we can
just drop this until such a driver (or at least a documented DT binding)
exists.

Thanks,
    Paul
