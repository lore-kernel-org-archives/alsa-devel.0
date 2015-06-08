From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: rx51: Automatically disconnect
	non-connected pins
Date: Mon, 8 Jun 2015 09:41:24 +0300
Message-ID: <55753914.6060407@ti.com>
References: <1433427231-21756-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from arroyo.ext.ti.com (arroyo.ext.ti.com [192.94.94.40])
 by alsa0.perex.cz (Postfix) with ESMTP id 402E5260568
 for <alsa-devel@alsa-project.org>; Mon,  8 Jun 2015 08:41:30 +0200 (CEST)
In-Reply-To: <1433427231-21756-1-git-send-email-lars@metafoo.de>
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
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

On 06/04/2015 05:13 PM, Lars-Peter Clausen wrote:
> According to the schematics the external speaker is differential, so the
> HPLCOM and HPRCOM pins of the CODEC should be connected to it.
> =

> Otherwise the routing looks complete, so add the missing routes and set t=
he
> fully_routed flag of the card instead of manually marking the unused inpu=
ts
> and outputs as not connected. This makes the code a bit shorter and
> cleaner.
> =

> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Reviewed-by: Peter Ujfalusi <peter.ujfalusi@ti.com>

> ---
>  sound/soc/omap/rx51.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
> =

> diff --git a/sound/soc/omap/rx51.c b/sound/soc/omap/rx51.c
> index fded993..3bebfb1 100644
> --- a/sound/soc/omap/rx51.c
> +++ b/sound/soc/omap/rx51.c
> @@ -245,6 +245,8 @@ static const struct snd_soc_dapm_widget aic34_dapm_wi=
dgets[] =3D {
>  static const struct snd_soc_dapm_route audio_map[] =3D {
>  	{"Ext Spk", NULL, "HPLOUT"},
>  	{"Ext Spk", NULL, "HPROUT"},
> +	{"Ext Spk", NULL, "HPLCOM"},
> +	{"Ext Spk", NULL, "HPRCOM"},
>  	{"Headphone Jack", NULL, "LLOUT"},
>  	{"Headphone Jack", NULL, "RLOUT"},
>  	{"FM Transmitter", NULL, "LLOUT"},
> @@ -288,15 +290,8 @@ static int rx51_aic34_init(struct snd_soc_pcm_runtim=
e *rtd)
>  	struct snd_soc_codec *codec =3D rtd->codec;
>  	struct snd_soc_card *card =3D rtd->card;
>  	struct rx51_audio_pdata *pdata =3D snd_soc_card_get_drvdata(card);
> -
> -	struct snd_soc_dapm_context *dapm =3D &codec->dapm;
>  	int err;
>  =

> -	/* Set up NC codec pins */
> -	snd_soc_dapm_nc_pin(dapm, "MIC3L");
> -	snd_soc_dapm_nc_pin(dapm, "MIC3R");
> -	snd_soc_dapm_nc_pin(dapm, "LINE1R");
> -
>  	err =3D tpa6130a2_add_controls(codec);
>  	if (err < 0) {
>  		dev_err(card->dev, "Failed to add TPA6130A2 controls\n");
> @@ -383,6 +378,7 @@ static struct snd_soc_card rx51_sound_card =3D {
>  	.num_aux_devs =3D ARRAY_SIZE(rx51_aux_dev),
>  	.codec_conf =3D rx51_codec_conf,
>  	.num_configs =3D ARRAY_SIZE(rx51_codec_conf),
> +	.fully_routed =3D true,
>  =

>  	.controls =3D aic34_rx51_controls,
>  	.num_controls =3D ARRAY_SIZE(aic34_rx51_controls),
> =



-- =

P=E9ter
