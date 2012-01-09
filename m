From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] ASoC: Route Mic Bias in Visstrim_M10 board.
Date: Mon, 09 Jan 2012 20:10:13 +0100
Message-ID: <4F0B3B95.7050302@metafoo.de>
References: <1326106908-28026-1-git-send-email-javier.martin@vista-silicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailhost.informatik.uni-hamburg.de
	(mailhost.informatik.uni-hamburg.de [134.100.9.70])
	by alsa0.perex.cz (Postfix) with ESMTP id 11FD4243E9
	for <alsa-devel@alsa-project.org>; Mon,  9 Jan 2012 20:10:56 +0100 (CET)
In-Reply-To: <1326106908-28026-1-git-send-email-javier.martin@vista-silicon.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Javier Martin <javier.martin@vista-silicon.com>
Cc: alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

On 01/09/2012 12:01 PM, Javier Martin wrote:
> [...]
> diff --git a/sound/soc/imx/mx27vis-aic32x4.c b/sound/soc/imx/mx27vis-aic32x4.c
> index 054110b..7e55a99 100644
> --- a/sound/soc/imx/mx27vis-aic32x4.c
> +++ b/sound/soc/imx/mx27vis-aic32x4.c
> @@ -74,6 +74,43 @@ static struct snd_soc_ops mx27vis_aic32x4_snd_ops = {
[...]
> +static const struct snd_soc_dapm_route audio_map[] = {

I know this is can be found in may drivers as well, but aic32x4_dapm_routes
would be a much better name.

> +};
> +
> +static int mx27vis_aic32x4_dai_init(struct snd_soc_pcm_runtime *rtd)
> +{
> +	struct snd_soc_codec *codec = rtd->codec;
> +	struct snd_soc_dapm_context *dapm = &codec->dapm;
> +	int err = 0;
> +
> +	snd_soc_dapm_new_controls(dapm, aic32x4_dapm_widgets,
> +				  ARRAY_SIZE(aic32x4_dapm_widgets));
> +
> +	err = snd_soc_add_controls(codec, mx27vis_aic32x4_controls,
> +				   ARRAY_SIZE(mx27vis_aic32x4_controls));
> +	if (err < 0)
> +		return err;
> +
> +	snd_soc_dapm_add_routes(dapm, audio_map, ARRAY_SIZE(audio_map));
> +

Use the snd_soc_card's controls, dapm_widgets and dapm_routes fields to
register these instead of open coding it here.
