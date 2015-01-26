From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH_V2 2/4] dt: sound: jz4740: Add binding documentation for jz4740-i2s
Date: Mon, 26 Jan 2015 15:27:17 +0100
Message-ID: <5212689.3MTQUevMKn@wuerfel>
References: <1422278138-51097-1-git-send-email-Zubair.Kakakhel@imgtec.com> <1422278138-51097-3-git-send-email-Zubair.Kakakhel@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1422278138-51097-3-git-send-email-Zubair.Kakakhel@imgtec.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc: tiwai@suse.de, perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, lars@metafoo.de
List-Id: alsa-devel@alsa-project.org

On Monday 26 January 2015 13:15:36 Zubair Lutfullah Kakakhel wrote:
> +
> +Required properties:
> +- compatible : "ingenic,jz4740-i2s"
> +- reg : I2S registers location and length
> +- clocks : AIC and I2S PLL clock specifiers.
> +- clock-names: "aic" and "i2s"
> +
> +Example:
> +
> +i2s: i2s@10020000 {
> +       compatible = "ingenic,jz4740-i2s";
> +       reg = <0x10020000 0x94>;
> +
> +       clocks = <&cgu JZ4740_CLK_AIC>, <&cgu JZ4740_CLK_I2SPLL>;
> +       clock-names = "aic", "i2s";
> +
> +       dmas = <&dma 2>, <&dma 3>;
> +       dma-names = "tx", "rx";
> +
> 

Thanks for adding the dma entries to the example. Unfortunately you
have missed adding them to the list of required properties,
so please add those as well.

	Arnd
