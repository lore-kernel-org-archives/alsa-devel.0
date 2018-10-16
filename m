From: Maxime Ripard <maxime.ripard@bootlin.com>
Subject: Re: [PATCH v4 0/9] Add support for audiocodec in
	Allwinner A64
Date: Tue, 16 Oct 2018 13:49:45 +0200
Message-ID: <20181016114945.ghigmd5oxm2je7jc@flea>
References: <20181016030239.15449-1-anarsoul@gmail.com>
 <20181016070843.j6vnmk6qij6rdjbm@flea>
 <CA+E=qVdA06n3Q=UP_gp05Ah2tf2UC-hOUCS471D_D6d2v-yF2A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.bootlin.com (mail.bootlin.com [62.4.15.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 65C23267526
 for <alsa-devel@alsa-project.org>; Tue, 16 Oct 2018 13:49:56 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <CA+E=qVdA06n3Q=UP_gp05Ah2tf2UC-hOUCS471D_D6d2v-yF2A@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Mylene JOSSERAND <mylene.josserand@free-electrons.com>, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Marcus Cooper <codekipper@gmail.com>, Mark Brown <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org, Jerome Brunet <jbrunet@baylibre.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Oct 16, 2018 at 12:13:26AM -0700, Vasily Khoruzhick wrote:
> On Tue, Oct 16, 2018, 00:09 Maxime Ripard <[1]maxime.ripard@bootlin.com> =
wrote:
> =

>     Hi,
> =

>     On Mon, Oct 15, 2018 at 08:02:30PM -0700, Vasily Khoruzhick wrote:
>     > This series adds Allwinner A64 audiocodec support into sun4i-i2s,
>     > sun8i-codec drivers, introduces new sun50i-codec-analog driver and
>     enables
>     > sound on Pine64, SoPine boards and Pinebook.
>     >
>     > I2S for audiocodec in A64 is different from other 3 I2S modules but
>     > similar to one in A10, digital part of codec is compatible with A33=
 and
>     > analog controls part is completely different from other SoCs - it s=
hares
>     > only few bits in few registers, so adding support for it into exist=
ing
>     > sun8i-codec-analog would mean duplicating all the widgets, controls=
 and
>     > some routes and making it hard to read. Therefore it makes sense to
>     > introduce new driver.
>     >
>     > v2: - Use simple-amplifier for speaker amp on Pinebook
>     >=A0 =A0 =A0- Rename sun50i-a64-i2s to sun50i-a64-codec-i2s to preser=
ve
>     compatible
>     >=A0 =A0 =A0 =A0string for other 3 I2S modules in A64 in case if ther=
e's any
>     >=A0 =A0 =A0 =A0incompatibility with H3
>     > v3: - renamed sunxi-adda-pr-regmap to sun8i-adda-pr-regmap
>     >=A0 =A0 =A0- use ilog2() to calculate reg value for LRCK div instead=
 of using a
>     >=A0 =A0 =A0 =A0table
>     > v4: - dts: don't use 'Mic' and 'Headset Mic' widgets from sun8i-cod=
ec,
>     >=A0 =A0 =A0 =A0define our board-level widgets instead.
> =

>     You also need to collect the tags that are given by the various people
>     involved in that review :)
> =

> =

> My bad. Do you want me to send v5 with all the tags?

Yep, please, thankS!

Maxime

-- =

Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
