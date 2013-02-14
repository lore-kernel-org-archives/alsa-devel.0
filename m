From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Subject: Re: [PATCH V6 02/10] ASoC: SAMSUNG: Add DT support for i2s
Date: Thu, 14 Feb 2013 11:29:24 +0100
Message-ID: <511CBC84.6080504@samsung.com>
References: <1358509629-20471-1-git-send-email-padma.v@samsung.com>
 <1358509629-20471-3-git-send-email-padma.v@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1358509629-20471-3-git-send-email-padma.v@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Padmavathi Venna <padma.v@samsung.com>
Cc: padma.kvr@gmail.com, linux-samsung-soc@vger.kernel.org, alsa-devel@alsa-project.org, devicetree-discuss@lists.ozlabs.org, sbkim73@samsung.com, broonie@opensource.wolfsonmicro.com, vinod.koul@intel.com, grant.likely@secretlab.ca, swarren@nvidia.com, boojin.kim@samsung.com, kgene.kim@samsung.com, jassisinghbrar@gmail.com, thomas.abraham@linaro.org, lrg@ti.com, tiwai@suse.de, ben-linux@fluff.org
List-Id: alsa-devel@alsa-project.org

Hi,

On 01/18/2013 12:47 PM, Padmavathi Venna wrote:
> Add support for device based discovery.
> 
> Signed-off-by: Padmavathi Venna <padma.v@samsung.com>
> ---
>  .../devicetree/bindings/sound/samsung-i2s.txt      |   63 ++++++
>  sound/soc/samsung/dma.c                            |    3 +-
>  sound/soc/samsung/dma.h                            |    1 +
>  sound/soc/samsung/i2s.c                            |  209 +++++++++++++++-----
>  4 files changed, 230 insertions(+), 46 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/sound/samsung-i2s.txt
> 
> diff --git a/Documentation/devicetree/bindings/sound/samsung-i2s.txt 
> b/Documentation/devicetree/bindings/sound/samsung-i2s.txt
> new file mode 100644
> index 0000000..3070046
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/samsung-i2s.txt
> @@ -0,0 +1,63 @@
> +* Samsung I2S controller
> +
...
> +Required Board Specific Properties:
> +
> +- gpios: The gpio specifier for data out,data in, LRCLK, CDCLK and SCLK
> +  interface lines. The format of the gpio specifier depends on the gpio
> +  controller.
> +  The syntax of samsung gpio specifier is
> +	<[phandle of the gpio controller node]
> +	 [pin number within the gpio controller]
> +	 [mux function]
> +	 [flags and pull up/down]
> +	 [drive strength]>

I don't think there is a need to copy the gpio specifier documentation
over to this file. Moreover this gpio specifier was supposed to be temporary,
until pinctrl support is added. Now Exynos4 uses generic gpio specifiers
and pinctrl for pin muxing and Exynos5 is still not converted to that,
although I believe this wouldn't require much effort now.

> +Example:
> +
...
> +- Board Specific Portion:
> +
> +i2s@03830000 {
> +	gpios = <&gpz 0 2 0 0>, /* I2S_0_SCLK */
> +		<&gpz 1 2 0 0>, /* I2S_0_CDCLK */
> +		<&gpz 2 2 0 0>, /* I2S_0_LRCK */
> +		<&gpz 3 2 0 0>, /* I2S_0_SDI */
> +		<&gpz 4 2 0 0>, /* I2S_0_SDO[1] */
> +		<&gpz 5 2 0 0>, /* I2S_0_SDO[2] */
> +		<&gpz 6 2 0 0>; /* I2S_0_SDO[3] */
> +};

We should switch to pinctrl instead. Most of work now seems to be
to define pinctrl nodes for each Exynos5 device, so there is proper
pinctrl support for Exynos5.

--

Thanks,
Sylwester
