From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
Subject: Re: [PATCH v4 0/8] Add SPDIF support for rockchip
Date: Tue, 13 Oct 2015 23:51:27 +0200
Message-ID: <2124073.EESlsqi0cG@diego>
References: <1444311079-2892-1-git-send-email-sjoerd.simons@collabora.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-clk-owner@vger.kernel.org>
In-Reply-To: <1444311079-2892-1-git-send-email-sjoerd.simons@collabora.co.uk>
Sender: linux-clk-owner@vger.kernel.org
To: Sjoerd Simons <sjoerd.simons@collabora.co.uk>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Olof Johansson <olof@lixom.net>, Javier Martinez Canillas <javier@osg.samsung.com>, Michael Turquette <mturquette@baylibre.com>
Cc: linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Pawel Moll <pawel.moll@arm.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Arnd Bergmann <arnd@arndb.de>, linux-clk@vger.kernel.org, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Stephen Boyd <sboyd@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

Am Donnerstag, 8. Oktober 2015, 15:31:11 schrieb Sjoerd Simons:
> This patchset adds support for the Rockchip SPDIF transceiver as present
> on RK3066, RK3188 and RK3288 boards and enables it on a Radxa rock pro.
> Tested on a Radxa Rock Pro board and Radxa Rock 2 Square board.
> 
> Quite a few changes since v3 (mostly based on review comment). One
> important addition is proper RK3288 SoC support; While according to the
> documentation it has 2 SPDIF "solutions" with the default being the old
> one, this variation doesn't actually work.. So support has been added
> to switch to the new SPDIF solution on RK3288.

[...]

> Sjoerd Simons (8):
>   ASoC: dt-bindings: add rockchip tranceiver bindings
>   ASoC: rockchip: Add rockchip SPDIF transceiver driver
>   ARM: dts: rockchip: Add SPDIF transceiver for RK3188
>   ARM: dts: rockchip: Add SPDIF optical out on Radxa Rock
>   clk: rockchip: Allow the RK3288 SPDIF clocks to change their parent
>   ARM: dts: rockchip: Add SPDIF transceiver for RK3288
>   ARM: dts: rockchip: Add SPDIF optical out on Radxa Rock2 Square
>   ARM: multi_v7_defconfig: Add rockchip audio support

After Mark took the two ASoC-specific patches, I've now picked up the 4 dts 
patches, after removing the #address- and #size-cells lines from them.

Sjoerd, are you sending a followup patch to Mark to also drop them from the 
binding doc?

Hopefully the clock patch will also find its way into the clock tree, together 
with the base series for the frac dividers.

And I guess we'll need to prod the armsoc-guys to take the defconfig change 
too :-)


Heiko
