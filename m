From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH 3/3] ASoC: omap-mcbsp: Use macro to create
 the McBSP2/3 ST controls
Date: Tue, 21 Aug 2012 17:46:56 +0300
Message-ID: <50339F60.6030102@ti.com>
References: <1345560123-23959-1-git-send-email-peter.ujfalusi@ti.com>
 <1345560123-23959-4-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog116.obsmtp.com (na3sys009aog116.obsmtp.com
 [74.125.149.240])
 by alsa0.perex.cz (Postfix) with ESMTP id A0246265FE9
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 16:47:18 +0200 (CEST)
Received: by wibhr14 with SMTP id hr14so4302131wib.3
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 07:47:01 -0700 (PDT)
In-Reply-To: <1345560123-23959-4-git-send-email-peter.ujfalusi@ti.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On 08/21/2012 05:42 PM, Peter Ujfalusi wrote:
> To remove duplicated code from the driver.
> =

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  sound/soc/omap/omap-mcbsp.c |   39 +++++++++++++++----------------------=
--
>  1 files changed, 15 insertions(+), 24 deletions(-)
> =

> diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
> index c964f68..be52f26 100644
> --- a/sound/soc/omap/omap-mcbsp.c
> +++ b/sound/soc/omap/omap-mcbsp.c
> @@ -688,31 +688,22 @@ static int omap_mcbsp_st_get_mode(struct snd_kcontr=
ol *kcontrol,
>  	return 0;
>  }
>  =

> -static const struct snd_kcontrol_new omap_mcbsp2_st_controls[] =3D {
> -	SOC_SINGLE_EXT("McBSP2 Sidetone Switch", 1, 0, 1, 0,
> -			omap_mcbsp_st_get_mode, omap_mcbsp_st_put_mode),
> -	OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP2 Sidetone Channel 0 Volume",
> -				      -32768, 32767,
> -				      omap_mcbsp_get_st_ch0_volume,
> -				      omap_mcbsp_set_st_ch0_volume),
> -	OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP2 Sidetone Channel 1 Volume",
> -				      -32768, 32767,
> -				      omap_mcbsp_get_st_ch1_volume,
> -				      omap_mcbsp_set_st_ch1_volume),
> -};
> +#define OMAP_MCBSP_ST_CONTROLS(port) \
> +static const struct snd_kcontrol_new omap_mcbsp##port##_st_controls[] =
=3D { \
> +SOC_SINGLE_EXT("McBSP##port## Sidetone Switch", 1, 0, 1, 0,		  \
> +	       omap_mcbsp_st_get_mode, omap_mcbsp_st_put_mode),		  \
> +OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP##port## Sidetone Channel 0 Volume",=
  \
> +			      -32768, 32767,				  \
> +			      omap_mcbsp_get_st_ch0_volume,		  \
> +			      omap_mcbsp_set_st_ch0_volume),		  \
> +OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP##port## Sidetone Channel 1 Volume",=
  \
> +			      -32768, 32767,				  \
> +			      omap_mcbsp_get_st_ch1_volume,		  \
> +			      omap_mcbsp_set_st_ch1_volume),		  \
> +}

This macro does not work correctly, I get this:
amixer | grep McBSP
Simple mixer control 'McBSP##port## Sidetone',0
Simple mixer control 'McBSP##port## Sidetone Channel 0',0
Simple mixer control 'McBSP##port## Sidetone Channel 1',0

as control names...

Please ignore this patch, I'll fix it or drop this.

>  =

> -static const struct snd_kcontrol_new omap_mcbsp3_st_controls[] =3D {
> -	SOC_SINGLE_EXT("McBSP3 Sidetone Switch", 2, 0, 1, 0,
> -			omap_mcbsp_st_get_mode, omap_mcbsp_st_put_mode),
> -	OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP3 Sidetone Channel 0 Volume",
> -				      -32768, 32767,
> -				      omap_mcbsp_get_st_ch0_volume,
> -				      omap_mcbsp_set_st_ch0_volume),
> -	OMAP_MCBSP_SOC_SINGLE_S16_EXT("McBSP3 Sidetone Channel 1 Volume",
> -				      -32768, 32767,
> -				      omap_mcbsp_get_st_ch1_volume,
> -				      omap_mcbsp_set_st_ch1_volume),
> -};
> +OMAP_MCBSP_ST_CONTROLS(2);
> +OMAP_MCBSP_ST_CONTROLS(3);
>  =

>  int omap_mcbsp_st_add_controls(struct snd_soc_pcm_runtime *rtd)
>  {
> =



-- =

P=E9ter
