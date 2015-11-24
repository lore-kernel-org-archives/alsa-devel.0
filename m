From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v3 2/5] mfd: arizona: Update DT bindings to add CS47L24
 and WM1831
Date: Tue, 24 Nov 2015 17:01:53 +0000
Message-ID: <20151124170153.GF12874@x1>
References: <1446563316-28878-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1446563316-28878-3-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1446563316-28878-3-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: linus.walleij@linaro.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, 03 Nov 2015, Richard Fitzgerald wrote:

> This updates the Arizona MFD device tree bindings to add the
> Cirrus Logic CS47L24 and WM1831 codecs. Note that unlike all the
> other codecs the DCVDD-supply and MICVDD-supply are mandatory.
>=20
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> ---
>  Documentation/devicetree/bindings/mfd/arizona.txt | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)

Applied, thanks.

> diff --git a/Documentation/devicetree/bindings/mfd/arizona.txt b/Docu=
mentation/devicetree/bindings/mfd/arizona.txt
> index 18be0cb..84e1af5 100644
> --- a/Documentation/devicetree/bindings/mfd/arizona.txt
> +++ b/Documentation/devicetree/bindings/mfd/arizona.txt
> @@ -1,4 +1,4 @@
> -Wolfson Arizona class audio SoCs
> +Cirrus Logic/Wolfson Microelectronics Arizona class audio SoCs
> =20
>  These devices are audio SoCs with extensive digital capabilites and =
a range
>  of analogue I/O.
> @@ -6,12 +6,14 @@ of analogue I/O.
>  Required properties:
> =20
>    - compatible : One of the following chip-specific strings:
> +        "cirrus,cs47l24"
>          "wlf,wm5102"
>          "wlf,wm5110"
>          "wlf,wm8280"
>          "wlf,wm8997"
>          "wlf,wm8998"
>          "wlf,wm1814"
> +        "wlf,wm1831"
> =20
>    - reg : I2C slave address when connected using I2C, chip select nu=
mber when
>      using SPI.
> @@ -41,6 +43,10 @@ Required properties:
> =20
>    - SPKVDD-supply : Speaker driver power supply (wm8997)
> =20
> +  - DCVDD-supply : Main power supply (cs47l24, wm1831)
> +
> +  - MICVDD-supply : Microphone power supply (cs47l24, wm1831)
> +
>  Optional properties:
> =20
>    - wlf,reset : GPIO specifier for the GPIO controlling /RESET
> @@ -69,6 +75,7 @@ Optional properties:
>    - DCVDD-supply, MICVDD-supply : Power supplies, only need to be sp=
ecified if
>      they are being externally supplied. As covered in
>      Documentation/devicetree/bindings/regulator/regulator.txt
> +    (wm5102, wm5110, wm8280, wm8997, wm8998, wm1814)
> =20
>  Also see child specific device properties:
>    Regulator - ../regulator/arizona-regulator.txt

--=20
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org =E2=94=82 Open source software for ARM SoCs
=46ollow Linaro: Facebook | Twitter | Blog
