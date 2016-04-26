From: "Andrew F. Davis" <afd@ti.com>
Subject: Re: [PATCH v3 2/2] ASoC: codecs: add support for
 TAS5720 digital amplifier
Date: Tue, 26 Apr 2016 12:19:05 -0500
Message-ID: <571FA309.7080809@ti.com>
References: <1461615456-19510-1-git-send-email-dannenberg@ti.com>
 <1461615456-19510-3-git-send-email-dannenberg@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bear.ext.ti.com (bear.ext.ti.com [192.94.94.41])
 by alsa0.perex.cz (Postfix) with ESMTP id 7C28B2612CC
 for <alsa-devel@alsa-project.org>; Tue, 26 Apr 2016 19:19:08 +0200 (CEST)
In-Reply-To: <1461615456-19510-3-git-send-email-dannenberg@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Andreas Dannenberg <dannenberg@ti.com>, alsa-devel@alsa-project.org, devicetree@vger.kernel.org
Cc: Mark Rutland <mark.rutland@arm.com>, Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Kumar Gala <galak@codeaurora.org>
List-Id: alsa-devel@alsa-project.org

On 04/25/2016 03:17 PM, Andreas Dannenberg wrote:
> The Texas Instruments TAS5720L/M device is a high-efficiency mono
> Class-D audio power amplifier optimized for high transient power
> capability to use the dynamic power headroom of small loudspeakers.
> Its digital time division multiplexed (TDM) interface enables up to
> 16 devices to share the same bus.
> 
> Signed-off-by: Andreas Dannenberg <dannenberg@ti.com>
> ---
>  sound/soc/codecs/Kconfig   |  10 +
>  sound/soc/codecs/Makefile  |   2 +
>  sound/soc/codecs/tas5720.c | 638 +++++++++++++++++++++++++++++++++++++++++++++
>  sound/soc/codecs/tas5720.h |  90 +++++++
>  4 files changed, 740 insertions(+)
>  create mode 100644 sound/soc/codecs/tas5720.c
>  create mode 100644 sound/soc/codecs/tas5720.h
> 
> diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
> index 290f921..3949dae 100644
> --- a/sound/soc/codecs/Kconfig
> +++ b/sound/soc/codecs/Kconfig
> @@ -125,6 +125,7 @@ config SND_SOC_ALL_CODECS
>  	select SND_SOC_TAS2552 if I2C
>  	select SND_SOC_TAS5086 if I2C
>  	select SND_SOC_TAS571X if I2C
> +	select SND_SOC_TAS5720 if I2C
>  	select SND_SOC_TFA9879 if I2C
>  	select SND_SOC_TLV320AIC23_I2C if I2C
>  	select SND_SOC_TLV320AIC23_SPI if SPI_MASTER
> @@ -748,6 +749,15 @@ config SND_SOC_TAS571X
>  	tristate "Texas Instruments TAS5711/TAS5717/TAS5719/TAS5721 power amplifiers"
>  	depends on I2C
>  
> +config SND_SOC_TAS5720
> +	tristate "Texas Instruments TAS5720 Mono Audio amplifier"
> +	depends on I2C
> +	help
> +	  Enable support for Texas Instruments TAS5720L/M high-efficiency mono
> +	  Class-D audio power amplifiers. The devices use an I2C interface for
> +	  setup/control and support an optional GPIO interrupt signal for fault
> +	  reporting.

If fault reporting is no longer interrupt based could this be re-worded?

[...]

> +
> +static struct i2c_driver tas5720_i2c_driver = {
> +	.driver = {
> +		.name = "tas5720",
> +		.owner = THIS_MODULE,

This shouldn't be needed.

Andrew
