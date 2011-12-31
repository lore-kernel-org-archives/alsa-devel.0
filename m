From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH 3/4] ASoC: Use dai_fmt in tavorevb3 machine
	driver
Date: Sat, 31 Dec 2011 08:18:37 +0800
Message-ID: <CAN1soZzOFmhempkLy30EgRYeqezhV+CVGvNi28wc+oECD3a9kw@mail.gmail.com>
References: <1325259714.4755.6.camel@phoenix> <1325259824.4755.8.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id C0F3C103B21
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2011 01:18:37 +0100 (CET)
Received: by vcbf13 with SMTP id f13so10047833vcb.38
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2011 16:18:37 -0800 (PST)
In-Reply-To: <1325259824.4755.8.camel@phoenix>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Eric Miao <eric.y.miao@gmail.com>, Haojian Zhuang <haojian.zhuang@marvell.com>, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 30, 2011 at 11:43 PM, Axel Lin <axel.lin@gmail.com> wrote:
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> =A0sound/soc/pxa/tavorevb3.c | =A0 12 ++----------
> =A01 files changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/sound/soc/pxa/tavorevb3.c b/sound/soc/pxa/tavorevb3.c
> index 4bef12c..46ac1fe 100644
> --- a/sound/soc/pxa/tavorevb3.c
> +++ b/sound/soc/pxa/tavorevb3.c
> @@ -92,16 +92,6 @@ static int evb3_i2s_hw_params(struct snd_pcm_substream=
 *substream,
> =A0 =A0 =A0 =A0if (ret < 0)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return ret;
>
> - =A0 =A0 =A0 ret =3D snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SND_SOC_DAIFMT_NB_NF | SND_=
SOC_DAIFMT_CBM_CFM);
> - =A0 =A0 =A0 if (ret < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> -
> - =A0 =A0 =A0 ret =3D snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SND_SOC_DAIFMT_NB_NF | SND_=
SOC_DAIFMT_CBM_CFM);
> - =A0 =A0 =A0 if (ret < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> -
> =A0 =A0 =A0 =A0ret =3D snd_soc_dai_set_tdm_slot(cpu_dai, 3, 3, 2, width);
> =A0 =A0 =A0 =A0return ret;
> =A0}
> @@ -119,6 +109,8 @@ static struct snd_soc_dai_link evb3_dai[] =3D {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.platform_name =A0=3D "pxa-pcm-audio",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.codec_name =A0 =A0 =3D "88pm860x-codec",
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.init =A0 =A0 =A0 =A0 =A0 =3D evb3_pm860x_=
init,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 .dai_fmt =A0 =A0 =A0 =A0=3D SND_SOC_DAIFMT_=
I2S | SND_SOC_DAIFMT_NB_NF |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 SND_SOC=
_DAIFMT_CBM_CFM,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0.ops =A0 =A0 =A0 =A0 =A0 =A0=3D &evb3_i2s_=
ops,
> =A0 =A0 =A0 =A0},
> =A0};
> --
Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
