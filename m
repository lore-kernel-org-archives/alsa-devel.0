From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] ASoC: at91sam9g20ek: Automatically
 disconnect non-connected pins
Date: Mon, 13 Apr 2015 11:07:40 +0200
Message-ID: <552B875C.4070403@atmel.com>
References: <1428743923-26675-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from eusmtp01.atmel.com (eusmtp01.atmel.com [212.144.249.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 719E3261A83
 for <alsa-devel@alsa-project.org>; Mon, 13 Apr 2015 11:08:12 +0200 (CEST)
In-Reply-To: <1428743923-26675-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Le 11/04/2015 11:18, Lars-Peter Clausen a =E9crit :
> According to the schematics the both LHPOUT and RHPOUT are connected to t=
he
> external connector. RHPOUT is missing from the DAPM routes, but otherwise
> they seem to be complete.
> =

> This patch adds the missing route and then sets the fully_routed flag for
> the card. This allows to remove all the manual calls to
> snd_soc_dapm_nc_pin().
> =

> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

It seems good:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>  sound/soc/atmel/sam9g20_wm8731.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> =

> diff --git a/sound/soc/atmel/sam9g20_wm8731.c b/sound/soc/atmel/sam9g20_w=
m8731.c
> index 8de8361..d7469cd 100644
> --- a/sound/soc/atmel/sam9g20_wm8731.c
> +++ b/sound/soc/atmel/sam9g20_wm8731.c
> @@ -95,8 +95,9 @@ static const struct snd_soc_dapm_widget at91sam9g20ek_d=
apm_widgets[] =3D {
>  =

>  static const struct snd_soc_dapm_route intercon[] =3D {
>  =

> -	/* speaker connected to LHPOUT */
> +	/* speaker connected to LHPOUT/RHPOUT */
>  	{"Ext Spk", NULL, "LHPOUT"},
> +	{"Ext Spk", NULL, "RHPOUT"},
>  =

>  	/* mic is connected to Mic Jack, with WM8731 Mic Bias */
>  	{"MICIN", NULL, "Mic Bias"},
> @@ -108,9 +109,7 @@ static const struct snd_soc_dapm_route intercon[] =3D=
 {
>   */
>  static int at91sam9g20ek_wm8731_init(struct snd_soc_pcm_runtime *rtd)
>  {
> -	struct snd_soc_codec *codec =3D rtd->codec;
>  	struct snd_soc_dai *codec_dai =3D rtd->codec_dai;
> -	struct snd_soc_dapm_context *dapm =3D &codec->dapm;
>  	int ret;
>  =

>  	printk(KERN_DEBUG
> @@ -124,10 +123,6 @@ static int at91sam9g20ek_wm8731_init(struct snd_soc_=
pcm_runtime *rtd)
>  		return ret;
>  	}
>  =

> -	/* not connected */
> -	snd_soc_dapm_nc_pin(dapm, "RLINEIN");
> -	snd_soc_dapm_nc_pin(dapm, "LLINEIN");
> -
>  #ifndef ENABLE_MIC_INPUT
>  	snd_soc_dapm_nc_pin(&rtd->card->dapm, "Int Mic");
>  #endif
> @@ -158,6 +153,7 @@ static struct snd_soc_card snd_soc_at91sam9g20ek =3D {
>  	.num_dapm_widgets =3D ARRAY_SIZE(at91sam9g20ek_dapm_widgets),
>  	.dapm_routes =3D intercon,
>  	.num_dapm_routes =3D ARRAY_SIZE(intercon),
> +	.fully_routed =3D true,
>  };
>  =

>  static int at91sam9g20ek_audio_probe(struct platform_device *pdev)
> =



-- =

Nicolas Ferre
