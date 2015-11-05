From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 2/5] mfd: arizona: Update DT bindings to add CS47L24
 and WM1831
Date: Thu, 5 Nov 2015 08:35:15 -0600
Message-ID: <20151105143515.GA26865@rob-hp-laptop>
References: <1446563316-28878-1-git-send-email-rf@opensource.wolfsonmicro.com>
 <1446563316-28878-3-git-send-email-rf@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-gpio-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1446563316-28878-3-git-send-email-rf@opensource.wolfsonmicro.com>
Sender: linux-gpio-owner@vger.kernel.org
To: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Cc: lee.jones@linaro.org, linus.walleij@linaro.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-gpio@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 03, 2015 at 03:08:33PM +0000, Richard Fitzgerald wrote:
> This updates the Arizona MFD device tree bindings to add the
> Cirrus Logic CS47L24 and WM1831 codecs. Note that unlike all the
> other codecs the DCVDD-supply and MICVDD-supply are mandatory.
> 
> Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
> ---
>  Documentation/devicetree/bindings/mfd/arizona.txt | 9 ++++++++-

Acked-by: Rob Herring <robh@kernel.org>

>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/arizona.txt b/Documentation/devicetree/bindings/mfd/arizona.txt
> index 18be0cb..84e1af5 100644
> --- a/Documentation/devicetree/bindings/mfd/arizona.txt
> +++ b/Documentation/devicetree/bindings/mfd/arizona.txt
> @@ -1,4 +1,4 @@
> -Wolfson Arizona class audio SoCs
> +Cirrus Logic/Wolfson Microelectronics Arizona class audio SoCs
>  
>  These devices are audio SoCs with extensive digital capabilites and a range
>  of analogue I/O.
> @@ -6,12 +6,14 @@ of analogue I/O.
>  Required properties:
>  
>    - compatible : One of the following chip-specific strings:
> +        "cirrus,cs47l24"
>          "wlf,wm5102"
>          "wlf,wm5110"
>          "wlf,wm8280"
>          "wlf,wm8997"
>          "wlf,wm8998"
>          "wlf,wm1814"
> +        "wlf,wm1831"
>  
>    - reg : I2C slave address when connected using I2C, chip select number when
>      using SPI.
> @@ -41,6 +43,10 @@ Required properties:
>  
>    - SPKVDD-supply : Speaker driver power supply (wm8997)
>  
> +  - DCVDD-supply : Main power supply (cs47l24, wm1831)
> +
> +  - MICVDD-supply : Microphone power supply (cs47l24, wm1831)
> +

We normally do lower case, but I guess these aren't new...

Rob
