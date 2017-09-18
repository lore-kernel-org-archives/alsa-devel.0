From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [RESENT PATCH v9 1/2] ASoC: rt5514: Add devicetree bindings for rt5514-spi
Date: Mon, 18 Sep 2017 11:30:17 +0200
Message-ID: <1972340.u0BEiYTrvM@phil>
References: <20170906025010.10750-1-jeffy.chen@rock-chips.com> <20170913172452.rqy2umufkuh26fzj@rob-hp-laptop> <59BF1FCD.3060501@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <59BF1FCD.3060501@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jeffy <jeffy.chen@rock-chips.com>
Cc: Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org, dgreid@chromium.org, briannorris@chromium.org, mka@chromium.org, dianders@chromium.org, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Mark Rutland <mark.rutland@arm.com>
List-Id: alsa-devel@alsa-project.org

Hi Jeffy,

Am Montag, 18. September 2017, 09:22:21 CEST schrieb jeffy:
> On 09/14/2017 01:24 AM, Rob Herring wrote:
> > On Wed, Sep 06, 2017 at 10:50:09AM +0800, Jeffy Chen wrote:
> >> diff --git a/Documentation/devicetree/bindings/sound/rt5514.txt b/Documentation/devicetree/bindings/sound/rt5514.txt
> >> index 929ca6756b02..841a1159e234 100644
> >> --- a/Documentation/devicetree/bindings/sound/rt5514.txt
> >> +++ b/Documentation/devicetree/bindings/sound/rt5514.txt
> >> @@ -4,7 +4,7 @@ This device supports I2C only.
> >
> > SPI support should be added to this document.
> ok, will do.
> >
> >>
> >>   Required properties:
> >>
> >> -- compatible : "realtek,rt5514".
> >> +- compatible : "realtek,rt5514" or "realtek,rt5514", "realtek,rt5514-i2c".
> >
> > There's no need for the -spi or -i2c compatibles. This is implied by
> > being a child of those controllers.
> heiko mentioned i should add it in the binding in:
> https://patchwork.kernel.org/patch/9918987/

If you add a new compatible you need to add it to the binding. I think what
Rob means is, that both the i2c and spi side can have the _same_
compatible without the -i2c or -spi, as you can check wether they are
children of either a spi or i2c controller in the code itself.


Heiko
