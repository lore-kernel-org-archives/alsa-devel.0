From: Grazvydas Ignotas <notasas@gmail.com>
Subject: Re: [PATCH V2] ASoC - Add support for upto 16 channels
	on OMAP MCBSP
Date: Sat, 7 Nov 2009 22:11:38 +0200
Message-ID: <6ed0b2680911071211g311e6399va88ff7daff7b8ed1@mail.gmail.com>
References: <1257454808.3576.397.camel@odin>
	<20091106202400.a0ded9c3.jhnikula@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f221.google.com (mail-ew0-f221.google.com
	[209.85.219.221])
	by alsa0.perex.cz (Postfix) with ESMTP id D643C103891
	for <alsa-devel@alsa-project.org>; Sat,  7 Nov 2009 21:11:39 +0100 (CET)
Received: by ewy21 with SMTP id 21so6639239ewy.32
	for <alsa-devel@alsa-project.org>; Sat, 07 Nov 2009 12:11:38 -0800 (PST)
In-Reply-To: <20091106202400.a0ded9c3.jhnikula@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jarkko Nikula <jhnikula@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Peter Ujfalusi <peter.ujfalusi@nokia.com>, Graeme Gregory <gg@slimlogic.co.uk>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Fri, Nov 6, 2009 at 8:24 PM, Jarkko Nikula <jhnikula@gmail.com> wrote:
> On Thu, 05 Nov 2009 21:00:08 +0000
> Liam Girdwood <lrg@slimlogic.co.uk> wrote:
>
>> From: Graeme Gregory <gg@slimlogic.co.uk>
>>
>> This patch increases the number of supported audio channels from 4
>> to 16 and has been sponsored by Shotspotter Inc. It also fixes a
>> FSYNC rate calculation bug when McBSP is FSYNC master.
>>
> I would not call it as bug but more like an implementation
> restriction :-)
>
> But as the patch now requires that machine driver using OMAP as a
> master must provide the sample rate generator input clock frequency, I
> would like to hear how it will work on Pandora.
>
> Grazvydas: are you able to test is the Pandora still playing after applyi=
ng
> patch [1] to omap-mcbsp.c and my patch below to omap3pandora.c?
>
> I made an assumption that input clock frequency on Pandora is
> 8 * 32 * sample_rate.

Seems to be working fine, tried playing several different sample rates
and also recording path. FYI pandora has TWL4030 256FS clock connected
to OMAP's CLKS pin.

Tested-by: Grazvydas Ignotas <notasas@gmail.com>

>
> --
> Jarkko
>
> 1.
> http://mailman.alsa-project.org/pipermail/alsa-devel/2009-November/022797=
.html
>
> ---
> diff --git a/sound/soc/omap/omap3pandora.c b/sound/soc/omap/omap3pandora.c
> index ad219aa..d0949fe 100644
> --- a/sound/soc/omap/omap3pandora.c
> +++ b/sound/soc/omap/omap3pandora.c
> @@ -40,9 +40,12 @@
>
> =A0#define PREFIX "ASoC omap3pandora: "
>
> -static int omap3pandora_cmn_hw_params(struct snd_soc_dai *codec_dai,
> - =A0 =A0 =A0 struct snd_soc_dai *cpu_dai, unsigned int fmt)
> +static int omap3pandora_cmn_hw_params(struct snd_pcm_substream *substrea=
m,
> + =A0 =A0 =A0 struct snd_pcm_hw_params *params, unsigned int fmt)
> =A0{
> + =A0 =A0 =A0 struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
> + =A0 =A0 =A0 struct snd_soc_dai *codec_dai =3D rtd->dai->codec_dai;
> + =A0 =A0 =A0 struct snd_soc_dai *cpu_dai =3D rtd->dai->cpu_dai;
> =A0 =A0 =A0 =A0int ret;
>
> =A0 =A0 =A0 =A0/* Set codec DAI configuration */
> @@ -68,8 +71,9 @@ static int omap3pandora_cmn_hw_params(struct snd_soc_da=
i *codec_dai,
> =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0/* Set McBSP clock to external */
> - =A0 =A0 =A0 ret =3D snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_SYSCLK_C=
LKS_EXT, 0,
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 =A0 =A0 SND_SOC_CLOCK_IN);
> + =A0 =A0 =A0 ret =3D snd_soc_dai_set_sysclk(cpu_dai, OMAP_MCBSP_SYSCLK_C=
LKS_EXT,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
8 * 32 * params_rate(params),
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
SND_SOC_CLOCK_IN);
> =A0 =A0 =A0 =A0if (ret < 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pr_err(PREFIX "can't set cpu system clock\=
n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
> @@ -87,11 +91,7 @@ static int omap3pandora_cmn_hw_params(struct snd_soc_d=
ai *codec_dai,
> =A0static int omap3pandora_out_hw_params(struct snd_pcm_substream *substr=
eam,
> =A0 =A0 =A0 =A0struct snd_pcm_hw_params *params)
> =A0{
> - =A0 =A0 =A0 struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
> - =A0 =A0 =A0 struct snd_soc_dai *codec_dai =3D rtd->dai->codec_dai;
> - =A0 =A0 =A0 struct snd_soc_dai *cpu_dai =3D rtd->dai->cpu_dai;
> -
> - =A0 =A0 =A0 return omap3pandora_cmn_hw_params(codec_dai, cpu_dai,
> + =A0 =A0 =A0 return omap3pandora_cmn_hw_params(substream, params,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0SND_SOC_DAIFMT_I2S |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0SND_SOC_DAIFMT_IB_NF |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0SND_SOC_DAIFMT_CBS_CFS);
> @@ -100,11 +100,7 @@ static int omap3pandora_out_hw_params(struct snd_pcm=
_substream *substream,
> =A0static int omap3pandora_in_hw_params(struct snd_pcm_substream *substre=
am,
> =A0 =A0 =A0 =A0struct snd_pcm_hw_params *params)
> =A0{
> - =A0 =A0 =A0 struct snd_soc_pcm_runtime *rtd =3D substream->private_data;
> - =A0 =A0 =A0 struct snd_soc_dai *codec_dai =3D rtd->dai->codec_dai;
> - =A0 =A0 =A0 struct snd_soc_dai *cpu_dai =3D rtd->dai->cpu_dai;
> -
> - =A0 =A0 =A0 return omap3pandora_cmn_hw_params(codec_dai, cpu_dai,
> + =A0 =A0 =A0 return omap3pandora_cmn_hw_params(substream, params,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0SND_SOC_DAIFMT_I2S |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0SND_SOC_DAIFMT_NB_NF |
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0SND_SOC_DAIFMT_CBS_CFS);
>
