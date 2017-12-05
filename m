From: Chen-Yu Tsai <wens@csie.org>
Subject: Re: [PATCH 9/9] arm64: dts: allwinner: a64: Enable
 sound on Pine64 and SoPine
Date: Tue, 5 Dec 2017 11:24:44 +0800
Message-ID: <CAGb2v65XC=0zwYu3Wjv0OcYrHfLbycBfaA4eW=HNN_8CzmcvRA@mail.gmail.com>
References: <20171203204157.20829-1-anarsoul@gmail.com>
 <20171203204157.20829-10-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.csie.ntu.edu.tw (smtp.csie.ntu.edu.tw [140.112.30.61])
 by alsa0.perex.cz (Postfix) with ESMTP id 65768266E71
 for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2017 04:25:10 +0100 (CET)
Received: from mail-wr0-f173.google.com (mail-wr0-f173.google.com
 [209.85.128.173])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested) (Authenticated sender: b93043)
 by smtp.csie.ntu.edu.tw (Postfix) with ESMTPSA id E140827B99
 for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2017 11:25:07 +0800 (CST)
Received: by mail-wr0-f173.google.com with SMTP id g53so19491896wra.2
 for <alsa-devel@alsa-project.org>; Mon, 04 Dec 2017 19:25:07 -0800 (PST)
In-Reply-To: <20171203204157.20829-10-anarsoul@gmail.com>
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
Cc: Linux-ALSA <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Marcus Cooper <codekipper@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Maxime Ripard <maxime.ripard@free-electrons.com>, =?UTF-8?Q?Myl=C3=A8ne_Josserand?= <mylene.josserand@free-electrons.com>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Dec 4, 2017 at 4:41 AM, Vasily Khoruzhick <anarsoul@gmail.com> wrote:
> This commit enables I2S, digital and analog parts of audiocodec on
> Pine64 and SoPine boards.
>
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
> ---
>  arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts      | 16 ++++++++++++++++
>  .../boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts   | 16 ++++++++++++++++
>  2 files changed, 32 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> index 806442d3e846..369d9b749521 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pine64.dts
> @@ -64,6 +64,18 @@
>         };
>  };
>
> +&codec {
> +       status = "okay";
> +};
> +
> +&codec_analog {
> +       status = "okay";
> +};
> +
> +&dai {
> +       status = "okay";
> +};
> +
>  &ehci0 {
>         status = "okay";
>  };
> @@ -229,6 +241,10 @@
>         regulator-name = "vcc-rtc";
>  };
>
> +&sound {
> +       status = "okay";

This is missing all the board level widgets and routing.
Yes I know that it works right now, but that's because simple-card
isn't a strict card, i.e. it doesn't force the need for actual inputs
and outputs at both ends of the DAPM graph.

Later on you'll find that missing the routing leaves the microphone
unusable, because the microphone bias is not turned on.

ChenYu

> +};
> +
>  /* On Exp and Euler connectors */
>  &uart0 {
>         pinctrl-names = "default";
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> index 0eb2acedf8c3..9de5ddcc3656 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-sopine-baseboard.dts
> @@ -69,6 +69,18 @@
>         };
>  };
>
> +&codec {
> +       status = "okay";
> +};
> +
> +&codec_analog {
> +       status = "okay";
> +};
> +
> +&dai {
> +       status = "okay";
> +};
> +
>  &ehci0 {
>         status = "okay";
>  };
> @@ -133,6 +145,10 @@
>         regulator-name = "vcc-wifi";
>  };
>
> +&sound {
> +       status = "okay";
> +};
> +
>  &uart0 {
>         pinctrl-names = "default";
>         pinctrl-0 = <&uart0_pins_a>;
> --
> 2.15.0
>
