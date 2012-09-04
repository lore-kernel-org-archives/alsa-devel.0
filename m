From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: [ASoC] Fix: Revert 'ASoC: imx-ssi: Remove mono support'.
Date: Tue, 4 Sep 2012 11:09:20 +0200
Message-ID: <CACKLOr1nobfaKRnVVuiODAfCUugCYJ2=pDvbz6wn1Yexy7qb6A@mail.gmail.com>
References: <1346660831-9662-1-git-send-email-javier.martin@vista-silicon.com>
	<5045A11B.3070300@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5045A11B.3070300@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: =?ISO-8859-1?Q?Ga=EBtan_Carlier?= <gcembed@gmail.com>
Cc: linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, broonie@opensource.wolfsonmicro.com, fabio.estevam@freescale.com, s.hauer@pengutronix.de
List-Id: alsa-devel@alsa-project.org

On 4 September 2012 08:35, Ga=EBtan Carlier <gcembed@gmail.com> wrote:
> Hi Javier,
>
> On 09/03/2012 10:27 AM, Javier Martin wrote:
>>
>> The following commit should be reverted:
>> 0865a75d4166bddc533fd50831829ceefb94f9b0
>>
>> The bug this patch is meant to solve doesn't occur in Visstrim_M10 b=
oards.
>> Furthermore, after applying this patch sound in Visstrim_M10 is play=
ed
>> at slower rates.
>>
>> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
>> ---
>> diff --git b/sound/soc/fsl/imx-ssi.c a/sound/soc/fsl/imx-ssi.c
>> index ac337ac..28dd76c 100644
>> --- b/sound/soc/fsl/imx-ssi.c
>> +++ a/sound/soc/fsl/imx-ssi.c
>> @@ -380,13 +380,13 @@ static int imx_ssi_dai_probe(struct snd_soc_da=
i
>> *dai)
>>   static struct snd_soc_dai_driver imx_ssi_dai =3D {
>>         .probe =3D imx_ssi_dai_probe,
>>         .playback =3D {
>> -               .channels_min =3D 2,
>> +               .channels_min =3D 1,
>>                 .channels_max =3D 2,
>>                 .rates =3D SNDRV_PCM_RATE_8000_96000,
>>                 .formats =3D SNDRV_PCM_FMTBIT_S16_LE,
>>         },
>>         .capture =3D {
>> -               .channels_min =3D 2,
>> +               .channels_min =3D 1,
>>                 .channels_max =3D 2,
>>                 .rates =3D SNDRV_PCM_RATE_8000_96000,
>>                 .formats =3D SNDRV_PCM_FMTBIT_S16_LE,
>>
> When applied on linux-next-20120824, the patch failed because origina=
l
> imx-ssi.c file looks like :
>
> static struct snd_soc_dai_driver imx_ssi_dai =3D {
>         .probe =3D imx_ssi_dai_probe,
>         .playback =3D {
>                 /* The SSI does not support monaural audio. */
>
>                 .channels_min =3D 2,
>                 .channels_max =3D 2,
>                 .rates =3D SNDRV_PCM_RATE_8000_96000,
>                 .formats =3D SNDRV_PCM_FMTBIT_S16_LE,
>         },
>         .capture =3D {
>                 .channels_min =3D 2,
>                 .channels_max =3D 2,
>                 .rates =3D SNDRV_PCM_RATE_8000_96000,
>                 .formats =3D SNDRV_PCM_FMTBIT_S16_LE,
>         },
>         .ops =3D &imx_ssi_pcm_dai_ops,
> };
>
> The comment line is missing in your patch. Here is the right patch :
>
> @@ -378,18 +378,17 @@ static int imx_ssi_dai_probe(struct snd_soc_dai=
 *dai)
>
>  }
>
>  static struct snd_soc_dai_driver imx_ssi_dai =3D {
>         .probe =3D imx_ssi_dai_probe,
>         .playback =3D {
> -               /* The SSI does not support monaural audio. */
>
> -               .channels_min =3D 2,
> +               .channels_min =3D 1,
>                 .channels_max =3D 2,
>                 .rates =3D SNDRV_PCM_RATE_8000_96000,
>                 .formats =3D SNDRV_PCM_FMTBIT_S16_LE,
>         },
>         .capture =3D {
> -               .channels_min =3D 2,
> +               .channels_min =3D 1,
>                 .channels_max =3D 2,
>                 .rates =3D SNDRV_PCM_RATE_8000_96000,
>                 .formats =3D SNDRV_PCM_FMTBIT_S16_LE,
>         },
>         .ops =3D &imx_ssi_pcm_dai_ops,
>
> Regards,
> Ga=EBtan Carlier.


Mark,
could you pick up the fixed patch sent by Ga=EBtan?

Regards.

--=20
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
