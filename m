From: Haojian Zhuang <haojian.zhuang@gmail.com>
Subject: Re: [PATCH 2/4] ASoC: Use dai_fmt in spitz machine
	driver
Date: Sat, 31 Dec 2011 08:17:47 +0800
Message-ID: <CAN1soZxxkFDuapcSRnnpw5cqj4yQzSoRaoVLSezcesARtOb2pg@mail.gmail.com>
References: <1325259714.4755.6.camel@phoenix> <1325259775.4755.7.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vx0-f179.google.com (mail-vx0-f179.google.com
	[209.85.220.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 21133103B21
	for <alsa-devel@alsa-project.org>; Sat, 31 Dec 2011 01:17:48 +0100 (CET)
Received: by vcbf13 with SMTP id f13so10047667vcb.38
	for <alsa-devel@alsa-project.org>; Fri, 30 Dec 2011 16:17:47 -0800 (PST)
In-Reply-To: <1325259775.4755.7.camel@phoenix>
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

On Fri, Dec 30, 2011 at 11:42 PM, Axel Lin <axel.lin@gmail.com> wrote:
> Signed-off-by: Axel Lin <axel.lin@gmail.com>
> ---
> =A0sound/soc/pxa/spitz.c | =A0 14 ++------------
> =A01 files changed, 2 insertions(+), 12 deletions(-)
>
> diff --git a/sound/soc/pxa/spitz.c b/sound/soc/pxa/spitz.c
> index bb06048..76288ad 100644
> --- a/sound/soc/pxa/spitz.c
> +++ b/sound/soc/pxa/spitz.c
> @@ -143,18 +143,6 @@ static int spitz_hw_params(struct snd_pcm_substream =
*substream,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0break;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 /* set codec DAI configuration */
> - =A0 =A0 =A0 ret =3D snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_I2S |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_C=
FS);
> - =A0 =A0 =A0 if (ret < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> -
> - =A0 =A0 =A0 /* set cpu DAI configuration */
> - =A0 =A0 =A0 ret =3D snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_I2S |
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBS_C=
FS);
> - =A0 =A0 =A0 if (ret < 0)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ret;
> -
> =A0 =A0 =A0 =A0/* set the codec system clock for DAC and ADC */
> =A0 =A0 =A0 =A0ret =3D snd_soc_dai_set_sysclk(codec_dai, WM8750_SYSCLK, c=
lk,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SND_SOC_CLOCK_IN);
> @@ -313,6 +301,8 @@ static struct snd_soc_dai_link spitz_dai =3D {
> =A0 =A0 =A0 =A0.platform_name =3D "pxa-pcm-audio",
> =A0 =A0 =A0 =A0.codec_name =3D "wm8750.0-001b",
> =A0 =A0 =A0 =A0.init =3D spitz_wm8750_init,
> + =A0 =A0 =A0 .dai_fmt =3D SND_SOC_DAIFMT_I2S | SND_SOC_DAIFMT_NB_NF |
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SND_SOC_DAIFMT_CBS_CFS,
> =A0 =A0 =A0 =A0.ops =3D &spitz_ops,
> =A0};
>
Acked-by: Haojian Zhuang <haojian.zhuang@gmail.com>
