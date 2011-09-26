From: =?ISO-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: sdp4430: Fix string for FM input name
Date: Mon, 26 Sep 2011 13:37:17 +0300
Message-ID: <1920082.xsvWOpj11N@barack>
References: <1309976285-25319-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog120.obsmtp.com (na3sys009aog120.obsmtp.com
	[74.125.149.140])
	by alsa0.perex.cz (Postfix) with ESMTP id 916AE2457A
	for <alsa-devel@alsa-project.org>;
	Mon, 26 Sep 2011 12:37:14 +0200 (CEST)
Received: by mail-bw0-f52.google.com with SMTP id 5so5811558bke.25
	for <alsa-devel@alsa-project.org>; Mon, 26 Sep 2011 03:37:12 -0700 (PDT)
In-Reply-To: <1309976285-25319-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: "Lopez Cruz, Misael" <misael.lopez@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, "Girdwood,
	Liam" <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

Hi Liam,

On Wednesday 06 July 2011 20:18:05 Ujfalusi, Peter wrote:
> The name contains invalid valid character (/), which
> causes problems when trying to create the debugfs
> directory structure:
> ASoC: Failed to create Aux/FM Stereo In debugfs file

Can you take a look at this, and ack it, so Mark can pick it up?

Thanks,
P=E9ter

> =

> Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
> ---
>  sound/soc/omap/sdp4430.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)
> =

> diff --git a/sound/soc/omap/sdp4430.c b/sound/soc/omap/sdp4430.c
> index a951774..d462f1a 100644
> --- a/sound/soc/omap/sdp4430.c
> +++ b/sound/soc/omap/sdp4430.c
> @@ -88,7 +88,7 @@ static const struct snd_soc_dapm_widget
> sdp4430_twl6040_dapm_widgets[] =3D { SND_SOC_DAPM_MIC("Headset Mic", NULL=
),
>  	SND_SOC_DAPM_HP("Headset Stereophone", NULL),
>  	SND_SOC_DAPM_SPK("Earphone Spk", NULL),
> -	SND_SOC_DAPM_INPUT("Aux/FM Stereo In"),
> +	SND_SOC_DAPM_INPUT("FM Stereo In"),
>  };
> =

>  static const struct snd_soc_dapm_route audio_map[] =3D {
> @@ -113,8 +113,8 @@ static const struct snd_soc_dapm_route audio_map[] =
=3D {
>  	{"Earphone Spk", NULL, "EP"},
> =

>  	/* Aux/FM Stereo In: AFML, AFMR */
> -	{"AFML", NULL, "Aux/FM Stereo In"},
> -	{"AFMR", NULL, "Aux/FM Stereo In"},
> +	{"AFML", NULL, "FM Stereo In"},
> +	{"AFMR", NULL, "FM Stereo In"},
>  };
> =

>  static int sdp4430_twl6040_init(struct snd_soc_pcm_runtime *rtd)
