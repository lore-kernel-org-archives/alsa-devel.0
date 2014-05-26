From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 3/4] ASoC: davinci-evm: Replace instances
 of rtd->codec->card with rtd->card
Date: Mon, 26 May 2014 10:08:30 +0300
Message-ID: <5382E86E.3050000@ti.com>
References: <1400492508-2732-1-git-send-email-lars@metafoo.de>
 <1400492508-2732-3-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 0FFA1264F0F
 for <alsa-devel@alsa-project.org>; Mon, 26 May 2014 09:08:36 +0200 (CEST)
In-Reply-To: <1400492508-2732-3-git-send-email-lars@metafoo.de>
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
Cc: Fabio Baltieri <fabio.baltieri@linaro.org>, alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>, Stephen Warren <swarren@wwwdotorg.org>
List-Id: alsa-devel@alsa-project.org

On 05/19/2014 12:41 PM, Lars-Peter Clausen wrote:
> No need to go via the CODEC to get a pointer to the card. This will help =
to
> eventually remove the card field from the snd_soc_codec struct.
> =

> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
>  sound/soc/davinci/davinci-evm.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> =

> diff --git a/sound/soc/davinci/davinci-evm.c b/sound/soc/davinci/davinci-=
evm.c
> index cab98a5..a50010e 100644
> --- a/sound/soc/davinci/davinci-evm.c
> +++ b/sound/soc/davinci/davinci-evm.c
> @@ -38,7 +38,7 @@ struct snd_soc_card_drvdata_davinci {
>  static int evm_startup(struct snd_pcm_substream *substream)
>  {
>  	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
> -	struct snd_soc_card *soc_card =3D rtd->codec->card;
> +	struct snd_soc_card *soc_card =3D rtd->card;
>  	struct snd_soc_card_drvdata_davinci *drvdata =3D
>  		snd_soc_card_get_drvdata(soc_card);
>  =

> @@ -51,7 +51,7 @@ static int evm_startup(struct snd_pcm_substream *substr=
eam)
>  static void evm_shutdown(struct snd_pcm_substream *substream)
>  {
>  	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
> -	struct snd_soc_card *soc_card =3D rtd->codec->card;
> +	struct snd_soc_card *soc_card =3D rtd->card;
>  	struct snd_soc_card_drvdata_davinci *drvdata =3D
>  		snd_soc_card_get_drvdata(soc_card);
>  =

> @@ -65,8 +65,7 @@ static int evm_hw_params(struct snd_pcm_substream *subs=
tream,
>  	struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
>  	struct snd_soc_dai *codec_dai =3D rtd->codec_dai;
>  	struct snd_soc_dai *cpu_dai =3D rtd->cpu_dai;
> -	struct snd_soc_codec *codec =3D rtd->codec;
> -	struct snd_soc_card *soc_card =3D codec->card;
> +	struct snd_soc_card *soc_card =3D rtd->card;
>  	int ret =3D 0;
>  	unsigned sysclk =3D ((struct snd_soc_card_drvdata_davinci *)
>  			   snd_soc_card_get_drvdata(soc_card))->sysclk;
> @@ -125,7 +124,7 @@ static int evm_aic3x_init(struct snd_soc_pcm_runtime =
*rtd)
>  {
>  	struct snd_soc_card *card =3D rtd->card;
>  	struct snd_soc_codec *codec =3D rtd->codec;
> -	struct device_node *np =3D codec->card->dev->of_node;
> +	struct device_node *np =3D card->dev->of_node;
>  	int ret;
>  =

>  	/* Add davinci-evm specific widgets */
> =



-- =

P=E9ter
