From: =?ISO-8859-1?Q?P=E9ter_Ujfalusi?= <peter.ujfalusi@ti.com>
Subject: Re: [PATCH] ASoC: have unique stream_names in codecs
Date: Fri, 05 Oct 2012 17:47:43 +0300
Message-ID: <506EF30F.3070506@ti.com>
References: <1349446668-28299-1-git-send-email-pmeerw@pmeerw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog137.obsmtp.com (na3sys009aog137.obsmtp.com
 [74.125.149.18])
 by alsa0.perex.cz (Postfix) with ESMTP id 438372650C1
 for <alsa-devel@alsa-project.org>; Fri,  5 Oct 2012 16:46:29 +0200 (CEST)
Received: by mail-ob0-f179.google.com with SMTP id lz20so1681499obb.38
 for <alsa-devel@alsa-project.org>; Fri, 05 Oct 2012 07:46:27 -0700 (PDT)
In-Reply-To: <1349446668-28299-1-git-send-email-pmeerw@pmeerw.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Meerwald <pmeerw@pmeerw.net>
Cc: Peter Meerwald <p.meerwald@bct-electronic.com>, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

Hi,

On 10/05/2012 05:17 PM, Peter Meerwald wrote:
> From: Peter Meerwald <p.meerwald@bct-electronic.com>
> =

> for example, there are two 'Capture' stream_names in twl4030, resulting in
> =

> twl4030-codec twl4030-codec: ASoC: Failed to create Capture debugfs file
> =

> with debug enabled (fails to create two sysfs entries named 'Capture' und=
er
> /sys/kernel/debug/asoc/omap3beagle/twl4030-codec/dapm

I have already sent patches for twl4040 and twl6040 and they should have be=
en
applied:
twl4030:
http://mailman.alsa-project.org/pipermail/alsa-devel/2012-September/055683.=
html

twl6040:
http://mailman.alsa-project.org/pipermail/alsa-devel/2012-September/055684.=
html
http://mailman.alsa-project.org/pipermail/alsa-devel/2012-October/055959.ht=
ml

Also: if you just change the stream name you might end up with non working
audio since the stream name matching will no longer work.

-- =

P=E9ter

> =

> this patch tries to avoid duplicate stream_names
> =

> Signed-off-by: Peter Meerwald <p.meerwald@bct-electronic.com>
> ---
>  sound/soc/codecs/stac9766.c |    4 ++--
>  sound/soc/codecs/twl4030.c  |    4 ++--
>  sound/soc/codecs/twl6040.c  |    2 +-
>  sound/soc/codecs/uda1380.c  |    4 ++--
>  sound/soc/codecs/wm8753.c   |    4 ++--
>  5 files changed, 9 insertions(+), 9 deletions(-)
> =

> diff --git a/sound/soc/codecs/stac9766.c b/sound/soc/codecs/stac9766.c
> index 33c0f3d..3379119 100644
> --- a/sound/soc/codecs/stac9766.c
> +++ b/sound/soc/codecs/stac9766.c
> @@ -300,14 +300,14 @@ static struct snd_soc_dai_driver stac9766_dai[] =3D=
 {
>  =

>  	/* stream cababilities */
>  	.playback =3D {
> -		.stream_name =3D "stac9766 analog",
> +		.stream_name =3D "stac9766 playback",
>  		.channels_min =3D 1,
>  		.channels_max =3D 2,
>  		.rates =3D SNDRV_PCM_RATE_8000_48000,
>  		.formats =3D SND_SOC_STD_AC97_FMTS,
>  	},
>  	.capture =3D {
> -		.stream_name =3D "stac9766 analog",
> +		.stream_name =3D "stac9766 capture",
>  		.channels_min =3D 1,
>  		.channels_max =3D 2,
>  		.rates =3D SNDRV_PCM_RATE_8000_48000,
> diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
> index 391fcfc..55582db 100644
> --- a/sound/soc/codecs/twl4030.c
> +++ b/sound/soc/codecs/twl4030.c
> @@ -2172,7 +2172,7 @@ static struct snd_soc_dai_driver twl4030_dai[] =3D {
>  		.formats =3D TWL4030_FORMATS,
>  		.sig_bits =3D 24,},
>  	.capture =3D {
> -		.stream_name =3D "Capture",
> +		.stream_name =3D "HiFi Capture",
>  		.channels_min =3D 2,
>  		.channels_max =3D 4,
>  		.rates =3D TWL4030_RATES,
> @@ -2189,7 +2189,7 @@ static struct snd_soc_dai_driver twl4030_dai[] =3D {
>  		.rates =3D SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
>  		.formats =3D SNDRV_PCM_FMTBIT_S16_LE,},
>  	.capture =3D {
> -		.stream_name =3D "Capture",
> +		.stream_name =3D "Voice Capture",
>  		.channels_min =3D 1,
>  		.channels_max =3D 2,
>  		.rates =3D SNDRV_PCM_RATE_8000 | SNDRV_PCM_RATE_16000,
> diff --git a/sound/soc/codecs/twl6040.c b/sound/soc/codecs/twl6040.c
> index c084c54..6f3a9cf 100644
> --- a/sound/soc/codecs/twl6040.c
> +++ b/sound/soc/codecs/twl6040.c
> @@ -1046,7 +1046,7 @@ static struct snd_soc_dai_driver twl6040_dai[] =3D {
>  {
>  	.name =3D "twl6040-ul",
>  	.capture =3D {
> -		.stream_name =3D "Capture",
> +		.stream_name =3D "Capture UL",
>  		.channels_min =3D 1,
>  		.channels_max =3D 2,
>  		.rates =3D TWL6040_RATES,
> diff --git a/sound/soc/codecs/uda1380.c b/sound/soc/codecs/uda1380.c
> index 2502214..d780fe7 100644
> --- a/sound/soc/codecs/uda1380.c
> +++ b/sound/soc/codecs/uda1380.c
> @@ -671,7 +671,7 @@ static struct snd_soc_dai_driver uda1380_dai[] =3D {
>  { /* playback only - dual interface */
>  	.name =3D "uda1380-hifi-playback",
>  	.playback =3D {
> -		.stream_name =3D "Playback",
> +		.stream_name =3D "Playback Only",
>  		.channels_min =3D 1,
>  		.channels_max =3D 2,
>  		.rates =3D UDA1380_RATES,
> @@ -682,7 +682,7 @@ static struct snd_soc_dai_driver uda1380_dai[] =3D {
>  { /* capture only - dual interface*/
>  	.name =3D "uda1380-hifi-capture",
>  	.capture =3D {
> -		.stream_name =3D "Capture",
> +		.stream_name =3D "Capture Only",
>  		.channels_min =3D 1,
>  		.channels_max =3D 2,
>  		.rates =3D UDA1380_RATES,
> diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
> index 13bff87..783ac20 100644
> --- a/sound/soc/codecs/wm8753.c
> +++ b/sound/soc/codecs/wm8753.c
> @@ -1400,7 +1400,7 @@ static struct snd_soc_dai_driver wm8753_dai[] =3D {
>  		.formats =3D WM8753_FORMATS
>  	},
>  	.capture =3D { /* dummy for fast DAI switching */
> -		.stream_name =3D "Capture",
> +		.stream_name =3D "HiFi Capture",
>  		.channels_min =3D 1,
>  		.channels_max =3D 2,
>  		.rates =3D WM8753_RATES,
> @@ -1418,7 +1418,7 @@ static struct snd_soc_dai_driver wm8753_dai[] =3D {
>  		.formats =3D WM8753_FORMATS,
>  	},
>  	.capture =3D {
> -		.stream_name =3D "Capture",
> +		.stream_name =3D "Voice Capture",
>  		.channels_min =3D 1,
>  		.channels_max =3D 2,
>  		.rates =3D WM8753_RATES,
> =
