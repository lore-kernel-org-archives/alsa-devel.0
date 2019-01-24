From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH][V2] ASoC: Intel: make const arrays static, reduces object
 code size
Date: Thu, 24 Jan 2019 12:40:00 -0600
Message-ID: <5dc23c74-2098-2876-38b1-e5bee620aa42@linux.intel.com>
References: <20190124173735.13669-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190124173735.13669-1-colin.king@canonical.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Colin King <colin.king@canonical.com>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Jie Yang <yang.jie@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Hans de Goede <hdegoede@redhat.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


On 1/24/19 11:37 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>
> Don't populate the const arrays on the stack but instead make
> it static. Makes the object code smaller, for example:
>
> Before:
>     text    data     bss     dec     hex filename
>    14107    8832     224   23163    5a7b bytcht_es8316.o
>
> After:
>     text    data     bss     dec     hex filename
>    14015    8896     224   23135    5a5f bytcht_es8316.o
>
> (gcc version 8.2.0 x86_64)
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Acked-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
> ---
>
> V2: also fix up bytcr_rt5640.c and bytcr_rt5651.c, thanks to
> Pierre-Louis Bossart for noticing these two.
>
> ---
>   sound/soc/intel/boards/bytcht_es8316.c | 2 +-
>   sound/soc/intel/boards/bytcr_rt5640.c  | 2 +-
>   sound/soc/intel/boards/bytcr_rt5651.c  | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/sound/soc/intel/boards/bytcht_es8316.c b/sound/soc/intel/boards/bytcht_es8316.c
> index fa9c4cf97686..1364e4e601d8 100644
> --- a/sound/soc/intel/boards/bytcht_es8316.c
> +++ b/sound/soc/intel/boards/bytcht_es8316.c
> @@ -437,7 +437,7 @@ static const struct acpi_gpio_mapping byt_cht_es8316_gpios[] = {
>   
>   static int snd_byt_cht_es8316_mc_probe(struct platform_device *pdev)
>   {
> -	const char * const mic_name[] = { "in1", "in2" };
> +	static const char * const mic_name[] = { "in1", "in2" };
>   	struct byt_cht_es8316_private *priv;
>   	struct device *dev = &pdev->dev;
>   	struct snd_soc_acpi_mach *mach;
> diff --git a/sound/soc/intel/boards/bytcr_rt5640.c b/sound/soc/intel/boards/bytcr_rt5640.c
> index ca8b4d5ff70f..a79466c8fb29 100644
> --- a/sound/soc/intel/boards/bytcr_rt5640.c
> +++ b/sound/soc/intel/boards/bytcr_rt5640.c
> @@ -1149,7 +1149,7 @@ struct acpi_chan_package {   /* ACPICA seems to require 64 bit integers */
>   
>   static int snd_byt_rt5640_mc_probe(struct platform_device *pdev)
>   {
> -	const char * const map_name[] = { "dmic1", "dmic2", "in1", "in3" };
> +	static const char * const map_name[] = { "dmic1", "dmic2", "in1", "in3" };
>   	const struct dmi_system_id *dmi_id;
>   	struct byt_rt5640_private *priv;
>   	struct snd_soc_acpi_mach *mach;
> diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
> index b618d984e2d5..e6945d11c8ab 100644
> --- a/sound/soc/intel/boards/bytcr_rt5651.c
> +++ b/sound/soc/intel/boards/bytcr_rt5651.c
> @@ -919,7 +919,7 @@ struct acpi_chan_package {   /* ACPICA seems to require 64 bit integers */
>   
>   static int snd_byt_rt5651_mc_probe(struct platform_device *pdev)
>   {
> -	const char * const mic_name[] = { "dmic", "in1", "in2", "in12" };
> +	static const char * const mic_name[] = { "dmic", "in1", "in2", "in12" };
>   	struct byt_rt5651_private *priv;
>   	struct snd_soc_acpi_mach *mach;
>   	struct device *codec_dev;
