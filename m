From: Lee Jones <lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 8/8] Documentation: Add WM8998/WM1814 device tree
 bindings
Date: Wed, 13 May 2015 13:29:42 +0100
Message-ID: <20150513122942.GW3394@x1>
References: <1430493319-23808-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1430493319-23808-9-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1430493319-23808-9-git-send-email-rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
Cc: broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, patches-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, ckeepax-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Fri, 01 May 2015, Richard Fitzgerald wrote:

> Signed-off-by: Richard Fitzgerald <rf-yzvPICuk2AATkU/dhu1WVueM+bqZidxxQQ4Iyu8u01E@public.gmane.org>
> ---
>  Documentation/devicetree/bindings/mfd/arizona.txt |   13 +++++++++--=
--
>  1 files changed, 9 insertions(+), 4 deletions(-)

Applied, thanks.

> diff --git a/Documentation/devicetree/bindings/mfd/arizona.txt b/Docu=
mentation/devicetree/bindings/mfd/arizona.txt
> index 7665aa9..64fa3b2 100644
> --- a/Documentation/devicetree/bindings/mfd/arizona.txt
> +++ b/Documentation/devicetree/bindings/mfd/arizona.txt
> @@ -10,6 +10,9 @@ Required properties:
>          "wlf,wm5110"
>          "wlf,wm8280"
>          "wlf,wm8997"
> +        "wlf,wm8998"
> +        "wlf,wm1814"
> +
>    - reg : I2C slave address when connected using I2C, chip select nu=
mber when
>      using SPI.
> =20
> @@ -31,10 +34,10 @@ Required properties:
>      as covered in Documentation/devicetree/bindings/regulator/regula=
tor.txt
> =20
>    - DBVDD2-supply, DBVDD3-supply : Additional databus power supplies=
 (wm5102,
> -    wm5110, wm8280)
> +    wm5110, wm8280, wm8998, wm1814)
> =20
>    - SPKVDDL-supply, SPKVDDR-supply : Speaker driver power supplies (=
wm5102,
> -    wm5110, wm8280)
> +    wm5110, wm8280, wm8998, wm1814)
> =20
>    - SPKVDD-supply : Speaker driver power supply (wm8997)
> =20
> @@ -53,8 +56,10 @@ Optional properties:
>      of input signals. Valid values are 0 (Differential), 1 (Single-e=
nded) and
>      2 (Digital Microphone). If absent, INn_MODE registers set to 0 b=
y default.
>      If present, values must be specified less than or equal to the n=
umber of
> -    input singals. If values less than the number of input signals, =
elements
> -    that has not been specifed are set to 0 by default.
> +    input signals. If values less than the number of input signals, =
elements
> +    that have not been specified are set to 0 by default. Entries ar=
e:
> +    <IN1, IN2, IN3, IN4> (wm5102, wm5110, wm8280, wm8997)
> +    <IN1A, IN2A, IN1B, IN2B> (wm8998, wm1814)
> =20
>    - wlf,dmic-ref : DMIC reference voltage source for each input, can=
 be
>      selected from either MICVDD or one of the MICBIAS's, defines

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
