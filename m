From: Andre Przywara <andre.przywara@arm.com>
Subject: Re: [PATCH] ASoC: sunxi: rename SND_SUNXI_ADDA_PR_REGMAP to
 SND_SUN8I_ADDA_PR_REGMAP
Date: Mon, 5 Nov 2018 09:43:04 +0000
Message-ID: <20181105094304.3ce0d12c@donnerap.cambridge.arm.com>
References: <20181103042651.6641-1-anarsoul@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181103042651.6641-1-anarsoul@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Vasily Khoruzhick <anarsoul@gmail.com>
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Maxime Ripard <maxime.ripard@bootlin.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Fri,  2 Nov 2018 21:26:51 -0700
Vasily Khoruzhick <anarsoul@gmail.com> wrote:

> SND_SUN50I_CODEC_ANALOG selects SND_SUNXI_ADDA_PR_REGMAP which is
> leftover of renaming SND_SUNXI_ADDA_PR_REGMAP to
> SND_SUN8I_ADDA_PR_REGMAP. Replace it with SND_SUN8I_ADDA_PR_REGMAP to
> fix possible link errors for some configurations:

> 
> sound/soc/sunxi/sun50i-codec-analog.o: In function `sun50i_codec_analog_probe':
> sun50i-codec-analog.c:(.text+0x62): undefined reference to `sun8i_adda_pr_regmap_init'
> 
> Fixes: 42371f327df0 ("ASoC: sunxi: Add new driver for Allwinner A64 codec's analog path controls")
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Just stumbled over the same thing when building 4.20-rc1.

Reviewed-by: Andre Przywara <andre.przywara@arm.com>

Thanks!
Andre.

---
>  sound/soc/sunxi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/sunxi/Kconfig b/sound/soc/sunxi/Kconfig
> index 66aad0d3f9c7..8134c3c94229 100644
> --- a/sound/soc/sunxi/Kconfig
> +++ b/sound/soc/sunxi/Kconfig
> @@ -31,7 +31,7 @@ config SND_SUN8I_CODEC_ANALOG
>  config SND_SUN50I_CODEC_ANALOG
>  	tristate "Allwinner sun50i Codec Analog Controls Support"
>  	depends on (ARM64 && ARCH_SUNXI) || COMPILE_TEST
> -	select SND_SUNXI_ADDA_PR_REGMAP
> +	select SND_SUN8I_ADDA_PR_REGMAP
>  	help
>  	  Say Y or M if you want to add support for the analog
> controls for the codec embedded in Allwinner A64 SoC.
