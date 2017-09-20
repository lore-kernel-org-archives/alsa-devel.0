From: Charles Keepax <ckeepax@opensource.cirrus.com>
Subject: Re: [Resend] [PATCH 3/4] ASoC: dapm: Avoid creating
 kcontrol for params
Date: Wed, 20 Sep 2017 12:05:34 +0100
Message-ID: <20170920110534.exix6dqf4la2nday@localhost.localdomain>
References: <1505896116-43310-1-git-send-email-yesanishhere@gmail.com>
 <1505896116-43310-4-git-send-email-yesanishhere@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id AF190266B21
 for <alsa-devel@alsa-project.org>; Wed, 20 Sep 2017 13:05:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1505896116-43310-4-git-send-email-yesanishhere@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: yesanishhere@gmail.com
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

On Wed, Sep 20, 2017 at 01:28:35AM -0700, yesanishhere@gmail.com wrote:
> From: anish kumar <yesanishhere@gmail.com>
> 
> Currently in codec to codec dai link if there are multiple
> params defined then dapm can use created kcontrol to
> decide which param to apply at runtime.
> 
> However, in case there is only single param configuration
> then there is no point in creating the kcontrol and also there
> is no point in allocating memory for kcontrol.
> 
> In the snd_soc_dapm_new_pcm function, there is memory
> allocation happening for kcontrol which is later used
> or not used based on num_param. It is better to not
> allocate memory when there is only a single configuration.
> This change is to remedy that anomaly.
> 
> Signed-off-by: anish kumar <yesanishhere@gmail.com>
> ---

This does make the code look quite a bit nicer, I think there is
one small issue below.

<snip>

> +int snd_soc_dapm_new_pcm(struct snd_soc_card *card,
> +			 const struct snd_soc_pcm_stream *params,
> +			 unsigned int num_params,
> +			 struct snd_soc_dapm_widget *source,
> +			 struct snd_soc_dapm_widget *sink)
> +{
> +	struct snd_soc_dapm_widget template;
> +	struct snd_soc_dapm_widget *w;
> +	char *link_name;
> +	int ret;
> +
> +	link_name = devm_kasprintf(card->dev, GFP_KERNEL, "%s-%s",
> +				   source->name, sink->name);
> +	if (!link_name)
> +		return -ENOMEM;
>  
> +	memset(&template, 0, sizeof(template));
> +	template.reg = SND_SOC_NOPM;
> +	template.id = snd_soc_dapm_dai_link;
> +	template.name = link_name;
> +	template.event = snd_soc_dai_link_event;
> +	template.event_flags = SND_SOC_DAPM_PRE_PMU | SND_SOC_DAPM_POST_PMU |
> +		SND_SOC_DAPM_PRE_PMD;
> +	template.kcontrol_news = NULL;
> +
> +	/* allocate memory for control, only in case of multiple configs */
> +	if (num_params > 1) {
> +		template.num_kcontrols = 1;
> +		template.kcontrol_news =
> +					snd_soc_dapm_alloc_kcontrol(card,
> +						link_name, params, num_params);
> +		if (!template.kcontrol_news) {
> +			ret = -ENOMEM;
> +			goto outfree_link_name;
> +		}
> +	}
>  	dev_dbg(card->dev, "ASoC: adding %s widget\n", link_name);
>  
>  	w = snd_soc_dapm_new_control_unlocked(&card->dapm, &template);

If we fail this call or the call to snd_soc_dapm_add_path that
follows it we don't clean up all the stuff we allocated in
snd_soc_dapm_alloc_kcontrol. We probably need to add a de-alloc
function for the error paths as well.

Thanks,
Charles
