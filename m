From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: Re: [PATCH] ASoC: fsl-asoc-card: use different route
 map for AC'97 mode
Date: Sun, 20 Dec 2015 23:41:23 -0800
Message-ID: <20151221074122.GE3524@Asurada-CZ80>
References: <567710D5.5040405@maciej.szmigiero.name>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F778260663
 for <alsa-devel@alsa-project.org>; Mon, 21 Dec 2015 08:41:27 +0100 (CET)
Received: by mail-pa0-f54.google.com with SMTP id jx14so67173332pad.2
 for <alsa-devel@alsa-project.org>; Sun, 20 Dec 2015 23:41:27 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <567710D5.5040405@maciej.szmigiero.name>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Xiubo Li <Xiubo.Lee@gmail.com>, linux-kernel <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Timur Tabi <timur@tabi.org>, Mark Brown <broonie@kernel.org>, Fabio Estevam <festevam@gmail.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: alsa-devel@alsa-project.org

On Sun, Dec 20, 2015 at 09:34:29PM +0100, Maciej S. Szmigiero wrote:
> fsl_ssi uses different stream names ("AC97 Playback" / "AC97 Capture")
> in AC'97 mode so in this case fsl-asoc-card route map should
> also be using them.
> 
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

Acked-by: Nicolin Chen <nicoleotsuka@gmail.com>

> ---
>  sound/soc/fsl/fsl-asoc-card.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/sound/soc/fsl/fsl-asoc-card.c b/sound/soc/fsl/fsl-asoc-card.c
> index c63d89da51f1..562b3bd22d9a 100644
> --- a/sound/soc/fsl/fsl-asoc-card.c
> +++ b/sound/soc/fsl/fsl-asoc-card.c
> @@ -107,6 +107,13 @@ static const struct snd_soc_dapm_route audio_map[] = {
>  	{"CPU-Capture",  NULL, "Capture"},
>  };
>  
> +static const struct snd_soc_dapm_route audio_map_ac97[] = {
> +	{"AC97 Playback",  NULL, "ASRC-Playback"},
> +	{"Playback",  NULL, "AC97 Playback"},
> +	{"ASRC-Capture",  NULL, "AC97 Capture"},
> +	{"AC97 Capture",  NULL, "Capture"},
> +};
> +
>  /* Add all possible widgets into here without being redundant */
>  static const struct snd_soc_dapm_widget fsl_asoc_card_dapm_widgets[] = {
>  	SND_SOC_DAPM_LINE("Line Out Jack", NULL),
> @@ -579,7 +586,8 @@ static int fsl_asoc_card_probe(struct platform_device *pdev)
>  	priv->card.dev = &pdev->dev;
>  	priv->card.name = priv->name;
>  	priv->card.dai_link = priv->dai_link;
> -	priv->card.dapm_routes = audio_map;
> +	priv->card.dapm_routes = fsl_asoc_card_is_ac97(priv) ?
> +				 audio_map_ac97 : audio_map;
>  	priv->card.late_probe = fsl_asoc_card_late_probe;
>  	priv->card.num_dapm_routes = ARRAY_SIZE(audio_map);
>  	priv->card.dapm_widgets = fsl_asoc_card_dapm_widgets;
> 
