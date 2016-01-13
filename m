From: Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH] ASoC: atmel_ssc_dai: distinguish the different SSC
Date: Wed, 13 Jan 2016 16:08:02 +0100
Message-ID: <56966852.8050205@atmel.com>
References: <1452666910-23586-1-git-send-email-songjun.wu@atmel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1452666910-23586-1-git-send-email-songjun.wu@atmel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Songjun Wu <songjun.wu@atmel.com>, broonie@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Le 13/01/2016 07:35, Songjun Wu a =E9crit :
> Cpu_dai id always equals 0, can't distinguish the
> different SSC. Use platform_device id to record
> and distinguish the different SSC.
>=20
> Signed-off-by: Songjun Wu <songjun.wu@atmel.com>

It seems okay:
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

> ---
>=20
>  drivers/misc/atmel-ssc.c        |    1 +
>  sound/soc/atmel/atmel_ssc_dai.c |   27 ++++++++++++++++++---------
>  2 files changed, 19 insertions(+), 9 deletions(-)
>=20
> diff --git a/drivers/misc/atmel-ssc.c b/drivers/misc/atmel-ssc.c
> index e11a0bd..0516ecd 100644
> --- a/drivers/misc/atmel-ssc.c
> +++ b/drivers/misc/atmel-ssc.c
> @@ -34,6 +34,7 @@ struct ssc_device *ssc_request(unsigned int ssc_num=
)
>  		if (ssc->pdev->dev.of_node) {
>  			if (of_alias_get_id(ssc->pdev->dev.of_node, "ssc")
>  				=3D=3D ssc_num) {
> +				ssc->pdev->id =3D ssc_num;
>  				ssc_valid =3D 1;
>  				break;
>  			}
> diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_=
ssc_dai.c
> index ba8def5..2768970 100644
> --- a/sound/soc/atmel/atmel_ssc_dai.c
> +++ b/sound/soc/atmel/atmel_ssc_dai.c
> @@ -285,7 +285,8 @@ static int atmel_ssc_hw_rule_rate(struct snd_pcm_=
hw_params *params,
>  static int atmel_ssc_startup(struct snd_pcm_substream *substream,
>  			     struct snd_soc_dai *dai)
>  {
> -	struct atmel_ssc_info *ssc_p =3D &ssc_info[dai->id];
> +	struct platform_device *pdev =3D to_platform_device(dai->dev);
> +	struct atmel_ssc_info *ssc_p =3D &ssc_info[pdev->id];
>  	struct atmel_pcm_dma_params *dma_params;
>  	int dir, dir_mask;
>  	int ret;
> @@ -346,7 +347,8 @@ static int atmel_ssc_startup(struct snd_pcm_subst=
ream *substream,
>  static void atmel_ssc_shutdown(struct snd_pcm_substream *substream,
>  			       struct snd_soc_dai *dai)
>  {
> -	struct atmel_ssc_info *ssc_p =3D &ssc_info[dai->id];
> +	struct platform_device *pdev =3D to_platform_device(dai->dev);
> +	struct atmel_ssc_info *ssc_p =3D &ssc_info[pdev->id];
>  	struct atmel_pcm_dma_params *dma_params;
>  	int dir, dir_mask;
> =20
> @@ -392,7 +394,8 @@ static void atmel_ssc_shutdown(struct snd_pcm_sub=
stream *substream,
>  static int atmel_ssc_set_dai_fmt(struct snd_soc_dai *cpu_dai,
>  		unsigned int fmt)
>  {
> -	struct atmel_ssc_info *ssc_p =3D &ssc_info[cpu_dai->id];
> +	struct platform_device *pdev =3D to_platform_device(cpu_dai->dev);
> +	struct atmel_ssc_info *ssc_p =3D &ssc_info[pdev->id];
> =20
>  	ssc_p->daifmt =3D fmt;
>  	return 0;
> @@ -404,7 +407,8 @@ static int atmel_ssc_set_dai_fmt(struct snd_soc_d=
ai *cpu_dai,
>  static int atmel_ssc_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
>  	int div_id, int div)
>  {
> -	struct atmel_ssc_info *ssc_p =3D &ssc_info[cpu_dai->id];
> +	struct platform_device *pdev =3D to_platform_device(cpu_dai->dev);
> +	struct atmel_ssc_info *ssc_p =3D &ssc_info[pdev->id];
> =20
>  	switch (div_id) {
>  	case ATMEL_SSC_CMR_DIV:
> @@ -445,7 +449,8 @@ static int atmel_ssc_hw_params(struct snd_pcm_sub=
stream *substream,
>  	struct snd_pcm_hw_params *params,
>  	struct snd_soc_dai *dai)
>  {
> -	int id =3D dai->id;
> +	struct platform_device *pdev =3D to_platform_device(dai->dev);
> +	int id =3D pdev->id;
>  	struct atmel_ssc_info *ssc_p =3D &ssc_info[id];
>  	struct ssc_device *ssc =3D ssc_p->ssc;
>  	struct atmel_pcm_dma_params *dma_params;
> @@ -772,7 +777,8 @@ static int atmel_ssc_hw_params(struct snd_pcm_sub=
stream *substream,
>  static int atmel_ssc_prepare(struct snd_pcm_substream *substream,
>  			     struct snd_soc_dai *dai)
>  {
> -	struct atmel_ssc_info *ssc_p =3D &ssc_info[dai->id];
> +	struct platform_device *pdev =3D to_platform_device(dai->dev);
> +	struct atmel_ssc_info *ssc_p =3D &ssc_info[pdev->id];
>  	struct atmel_pcm_dma_params *dma_params;
>  	int dir;
> =20
> @@ -795,7 +801,8 @@ static int atmel_ssc_prepare(struct snd_pcm_subst=
ream *substream,
>  static int atmel_ssc_trigger(struct snd_pcm_substream *substream,
>  			     int cmd, struct snd_soc_dai *dai)
>  {
> -	struct atmel_ssc_info *ssc_p =3D &ssc_info[dai->id];
> +	struct platform_device *pdev =3D to_platform_device(dai->dev);
> +	struct atmel_ssc_info *ssc_p =3D &ssc_info[pdev->id];
>  	struct atmel_pcm_dma_params *dma_params;
>  	int dir;
> =20
> @@ -824,11 +831,12 @@ static int atmel_ssc_trigger(struct snd_pcm_sub=
stream *substream,
>  static int atmel_ssc_suspend(struct snd_soc_dai *cpu_dai)
>  {
>  	struct atmel_ssc_info *ssc_p;
> +	struct platform_device *pdev =3D to_platform_device(cpu_dai->dev);
> =20
>  	if (!cpu_dai->active)
>  		return 0;
> =20
> -	ssc_p =3D &ssc_info[cpu_dai->id];
> +	ssc_p =3D &ssc_info[pdev->id];
> =20
>  	/* Save the status register before disabling transmit and receive *=
/
>  	ssc_p->ssc_state.ssc_sr =3D ssc_readl(ssc_p->ssc->regs, SR);
> @@ -852,12 +860,13 @@ static int atmel_ssc_suspend(struct snd_soc_dai=
 *cpu_dai)
>  static int atmel_ssc_resume(struct snd_soc_dai *cpu_dai)
>  {
>  	struct atmel_ssc_info *ssc_p;
> +	struct platform_device *pdev =3D to_platform_device(cpu_dai->dev);
>  	u32 cr;
> =20
>  	if (!cpu_dai->active)
>  		return 0;
> =20
> -	ssc_p =3D &ssc_info[cpu_dai->id];
> +	ssc_p =3D &ssc_info[pdev->id];
> =20
>  	/* restore SSC register settings */
>  	ssc_writel(ssc_p->ssc->regs, TFMR, ssc_p->ssc_state.ssc_tfmr);
>=20


--=20
Nicolas Ferre
