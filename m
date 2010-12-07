From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: [PATCH 1/2] ASoC: omap: Add hardware constraint
	for HDMI and ABE
Date: Tue, 7 Dec 2010 10:57:24 +0200
Message-ID: <201012071057.24139.peter.ujfalusi@nokia.com>
References: <1889FA7136B567478A67D4B0F85B0CCEA4C52E80@dlee06.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-da02.nokia.com (smtp.nokia.com [147.243.128.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 98A1C1037FC
	for <alsa-devel@alsa-project.org>; Tue,  7 Dec 2010 09:57:28 +0100 (CET)
In-Reply-To: <1889FA7136B567478A67D4B0F85B0CCEA4C52E80@dlee06.ent.ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: "ext Olaya, Margarita" <magi.olaya@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Tuesday 07 December 2010 00:34:44 ext Olaya, Margarita wrote:
> From: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
> =

> The Audio Backend needs a step size of 24 * 4, while HDMI requires a
> step size of 32 * 4 bits to align the audio buffer.
> =

> Signed-off-by: Jorge Eduardo Candelaria <jorge.candelaria@ti.com>
> Signed-off-by: Margarita Olaya Cabrera <magi.olaya@ti.com>
> ---
>  sound/soc/omap/omap-pcm.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)
> =

> diff --git a/sound/soc/omap/omap-pcm.c b/sound/soc/omap/omap-pcm.c
> index 8caeb8d..6a21447 100644
> --- a/sound/soc/omap/omap-pcm.c
> +++ b/sound/soc/omap/omap-pcm.c
> @@ -280,6 +280,15 @@ static int omap_pcm_open(struct snd_pcm_substream
> *substream) if (ret < 0)
>  		goto out;
> =

> +	/*
> +	 * ABE needs a step of 24 * 4 data bits, and HDMI 32 * 4
> +	 * Ensure buffer size satisfies both constraints.
> +	 */
> +	ret =3D snd_pcm_hw_constraint_step(runtime, 0,
> +					 SNDRV_PCM_HW_PARAM_BUFFER_BYTES, 384);
> +	if (ret < 0)
> +		goto out;
> +

Few things:
This only applicable for OMAP4, so please make it so that it only applies t=
o =

OMAP4.
We have the other constraints set in the omap-mcbsp.c:omap_mcbsp_dai_startu=
p.
I think it would be better to keep them in a same place.

>  	prtd =3D kzalloc(sizeof(*prtd), GFP_KERNEL);
>  	if (prtd =3D=3D NULL) {
>  		ret =3D -ENOMEM;

-- =

P=E9ter
