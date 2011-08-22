From: Liam Girdwood <lrg@ti.com>
Subject: Re: [PATCH] ASoC: Allow idle_bias_off to be specified
	in CODEC drivers
Date: Mon, 22 Aug 2011 21:07:35 +0100
Message-ID: <4E52B707.8070607@ti.com>
References: <1314034854-24549-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from devils.ext.ti.com (devils.ext.ti.com [198.47.26.153])
	by alsa0.perex.cz (Postfix) with ESMTP id 058FF2458A
	for <alsa-devel@alsa-project.org>;
	Mon, 22 Aug 2011 22:07:42 +0200 (CEST)
In-Reply-To: <1314034854-24549-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "patches@opensource.wolfsonmicro.com" <patches@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

On 22/08/11 18:40, Mark Brown wrote:
> If devices can unconditionally support idle_bias_off let them flag it in
> their driver structure.
> 
> Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

Acked-by: Liam Girdwood <lrg@ti.com>

> ---
>  include/sound/soc.h  |    1 +
>  sound/soc/soc-core.c |    2 ++
>  2 files changed, 3 insertions(+), 0 deletions(-)
> 
> diff --git a/include/sound/soc.h b/include/sound/soc.h
> index 3fe658e..6da55a1 100644
> --- a/include/sound/soc.h
> +++ b/include/sound/soc.h
> @@ -633,6 +633,7 @@ struct snd_soc_codec_driver {
>  	/* codec bias level */
>  	int (*set_bias_level)(struct snd_soc_codec *,
>  			      enum snd_soc_bias_level level);
> +	bool idle_bias_off;
>  
>  	void (*seq_notifier)(struct snd_soc_dapm_context *,
>  			     enum snd_soc_dapm_type, int);
> diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
> index ae93aa8..f8f985a 100644
> --- a/sound/soc/soc-core.c
> +++ b/sound/soc/soc-core.c
> @@ -956,6 +956,8 @@ static int soc_probe_codec(struct snd_soc_card *card,
>  		snd_soc_dapm_new_controls(&codec->dapm, driver->dapm_widgets,
>  					  driver->num_dapm_widgets);
>  
> +	codec->dapm.idle_bias_off = driver->idle_bias_off;
> +
>  	if (driver->probe) {
>  		ret = driver->probe(codec);
>  		if (ret < 0) {
