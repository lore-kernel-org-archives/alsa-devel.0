From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: Re: [PATCH v8] ASoC: dapm: add code to configure dai
	link	parameters
Date: Fri, 16 Jan 2015 14:46:35 +0000
Message-ID: <20150116144635.GX14516@opensource.wolfsonmicro.com>
References: <1421330832-15449-1-git-send-email-nikesh@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2E032260511
 for <alsa-devel@alsa-project.org>; Fri, 16 Jan 2015 15:46:36 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <1421330832-15449-1-git-send-email-nikesh@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nikesh Oswal <nikesh@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 15, 2015 at 02:07:11PM +0000, Nikesh Oswal wrote:
> dai-link params for codec-codec links were fixed. The fixed
> link between codec and another chip which may be another codec,
> baseband, bluetooth codec etc may require run time configuaration
> changes. This change provides an optional alsa control to select
> one of the params from a list of params.
> 
> Signed-off-by: Nikesh Oswal <nikesh@opensource.wolfsonmicro.com>
> ---
>  include/sound/soc-dapm.h |    3 +
>  include/sound/soc.h      |    1 +
>  sound/soc/soc-core.c     |    6 +-
>  sound/soc/soc-dapm.c     |  155 ++++++++++++++++++++++++++++++++++++++++++++--
>  4 files changed, 157 insertions(+), 8 deletions(-)
> 
> diff --git a/include/sound/soc-dapm.h b/include/sound/soc-dapm.h
> index 5c0a798..a2098e4 100644
> @@ -3299,14 +3363,52 @@ int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
>  	struct snd_soc_dapm_widget *w;
>  	size_t len;
>  	char *link_name;
> -	int ret;
> +	int ret, count;
> +	unsigned long private_value;
> +	const char **w_param_text;
> +	struct soc_enum w_param_enum[] = {
> +		SOC_ENUM_SINGLE(0, 0, 0, NULL),
> +	};
> +	struct snd_kcontrol_new kcontrol_dai_link[] = {
> +		SOC_ENUM_EXT(NULL, w_param_enum[0],
> +			     snd_soc_dapm_dai_link_get,
> +			     snd_soc_dapm_dai_link_put),
> +	};
> +	const struct snd_soc_pcm_stream *config = params;
> +
> +	w_param_text = devm_kcalloc(card->dev, num_params,
> +					sizeof(char *), GFP_KERNEL);
> +	if (!w_param_text)
> +		return -ENOMEM;
>  
>  	len = strlen(source->name) + strlen(sink->name) + 2;
>  	link_name = devm_kzalloc(card->dev, len, GFP_KERNEL);
> -	if (!link_name)
> -		return -ENOMEM;
> +	if (!link_name) {
> +		ret = -ENOMEM;
> +		goto outfree_w_param;
> +	}
>  	snprintf(link_name, len, "%s-%s", source->name, sink->name);
>  
> +	for (count = 0 ; count < num_params; count++) {
> +		if (!config->stream_name) {
> +			dev_warn(card->dapm.dev,
> +				"ASoC: anonymous config %d for dai link %s\n",
> +				count, link_name);

The ALSA core doesn't like one of the string in the enum text
links being a NULL pointer so you will want to add some sort of
default text or something in this case.

> +		} else {
> +			w_param_text[count] = devm_kmemdup(card->dev,
> +						config->stream_name,
> +						strlen(config->stream_name) + 1,
> +						GFP_KERNEL);
> +			if (!w_param_text[count]) {
> +				ret = -ENOMEM;
> +				goto outfree_link_name;
> +			}
> +		}
> +		config++;
> +	}
> +	w_param_enum[0].items = num_params;
> +	w_param_enum[0].texts = w_param_text;
> +
>  	memset(&template, 0, sizeof(template));
>  	template.reg = SND_SOC_NOPM;
>  	template.id = snd_soc_dapm_dai_link;

Thanks,
Charles
