From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: Re: [PATCH] SoC: intel: byt: Introduce new custom IN2
 map
Date: Wed, 18 Oct 2017 13:05:31 -0500
Message-ID: <b09a704c-bb3e-32c4-afcb-d11379b6a3b9@linux.intel.com>
References: <20171018164957.2270-1-carlo@caione.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id BD26A266EE0
 for <alsa-devel@alsa-project.org>; Wed, 18 Oct 2017 20:05:35 +0200 (CEST)
In-Reply-To: <20171018164957.2270-1-carlo@caione.org>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Carlo Caione <carlo@caione.org>, linux@endlessm.com, lgirdwood@gmail.com, broonie@kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Carlo Caione <carlo@endlessm.com>
List-Id: alsa-devel@alsa-project.org

On 10/18/17 11:49 AM, Carlo Caione wrote:
> From: Carlo Caione <carlo@endlessm.com>
> 
> Introduce a new custom dapm routes map to quirk platforms with the
> internal mic connected to IN2P.

LGTM. If we start getting more quirks for this codec, we should think of 
adding a module parameters to select them from the command line or with 
modprobe (as done in other machine drivers).

Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>

> 
> Signed-off-by: Carlo Caione <carlo@endlessm.com>
> ---
>   sound/soc/intel/boards/bytcr_rt5651.c | 16 +++++++++++++++-
>   1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/intel/boards/bytcr_rt5651.c b/sound/soc/intel/boards/bytcr_rt5651.c
> index 3076bfc0db5e..1dad5c98c9ef 100644
> --- a/sound/soc/intel/boards/bytcr_rt5651.c
> +++ b/sound/soc/intel/boards/bytcr_rt5651.c
> @@ -37,6 +37,7 @@
>   enum {
>   	BYT_RT5651_DMIC_MAP,
>   	BYT_RT5651_IN1_MAP,
> +	BYT_RT5651_IN2_MAP,
>   };
>   
>   #define BYT_RT5651_MAP(quirk)	((quirk) & GENMASK(7, 0))
> @@ -58,6 +59,8 @@ static void log_quirks(struct device *dev)
>   		dev_info(dev, "quirk DMIC_MAP enabled");
>   	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN1_MAP)
>   		dev_info(dev, "quirk IN1_MAP enabled");
> +	if (BYT_RT5651_MAP(byt_rt5651_quirk) == BYT_RT5651_IN2_MAP)
> +		dev_info(dev, "quirk IN2_MAP enabled");
>   	if (byt_rt5651_quirk & BYT_RT5651_DMIC_EN)
>   		dev_info(dev, "quirk DMIC enabled");
>   	if (byt_rt5651_quirk & BYT_RT5651_MCLK_EN)
> @@ -143,7 +146,6 @@ static const struct snd_soc_dapm_route byt_rt5651_audio_map[] = {
>   	{"ssp2 Rx", NULL, "AIF1 Capture"},
>   
>   	{"Headset Mic", NULL, "micbias1"}, /* lowercase for rt5651 */
> -	{"IN2P", NULL, "Headset Mic"},
>   	{"Headphone", NULL, "HPOL"},
>   	{"Headphone", NULL, "HPOR"},
>   	{"Speaker", NULL, "LOUTL"},
> @@ -151,15 +153,23 @@ static const struct snd_soc_dapm_route byt_rt5651_audio_map[] = {
>   };
>   
>   static const struct snd_soc_dapm_route byt_rt5651_intmic_dmic_map[] = {
> +	{"IN2P", NULL, "Headset Mic"},
>   	{"DMIC L1", NULL, "Internal Mic"},
>   	{"DMIC R1", NULL, "Internal Mic"},
>   };
>   
>   static const struct snd_soc_dapm_route byt_rt5651_intmic_in1_map[] = {
>   	{"Internal Mic", NULL, "micbias1"},
> +	{"IN2P", NULL, "Headset Mic"},
>   	{"IN1P", NULL, "Internal Mic"},
>   };
>   
> +static const struct snd_soc_dapm_route byt_rt5651_intmic_in2_map[] = {
> +	{"Internal Mic", NULL, "micbias1"},
> +	{"IN1P", NULL, "Headset Mic"},
> +	{"IN2P", NULL, "Internal Mic"},
> +};
> +
>   static const struct snd_kcontrol_new byt_rt5651_controls[] = {
>   	SOC_DAPM_PIN_SWITCH("Headphone"),
>   	SOC_DAPM_PIN_SWITCH("Headset Mic"),
> @@ -246,6 +256,10 @@ static int byt_rt5651_init(struct snd_soc_pcm_runtime *runtime)
>   		custom_map = byt_rt5651_intmic_in1_map;
>   		num_routes = ARRAY_SIZE(byt_rt5651_intmic_in1_map);
>   		break;
> +	case BYT_RT5651_IN2_MAP:
> +		custom_map = byt_rt5651_intmic_in2_map;
> +		num_routes = ARRAY_SIZE(byt_rt5651_intmic_in2_map);
> +		break;
>   	default:
>   		custom_map = byt_rt5651_intmic_dmic_map;
>   		num_routes = ARRAY_SIZE(byt_rt5651_intmic_dmic_map);
> 
