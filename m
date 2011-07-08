From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 02/10] ASoc: mxs: add mxs-saif driver
Date: Sat, 9 Jul 2011 02:35:30 +0800
Message-ID: <CAA+hA=Td0+yf3rXWjb2Y7aH4fXgnDy3GQi15JLFMnYiExsg5Uw@mail.gmail.com>
References: <1310140790-2132-1-git-send-email-b29396@freescale.com>
	<1310140790-2132-3-git-send-email-b29396@freescale.com>
	<20110708161918.GJ6069@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110708161918.GJ6069@pengutronix.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sascha Hauer <s.hauer@pengutronix.de>
Cc: alsa-devel@alsa-project.org, Dong Aisheng <b29396@freescale.com>, lrg@ti.com, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

2011/7/9 Sascha Hauer <s.hauer@pengutronix.de>:
> On Fri, Jul 08, 2011 at 11:59:42PM +0800, Dong Aisheng wrote:
>> Signed-off-by: Dong Aisheng <b29396@freescale.com>
>> ---
>> =A0sound/soc/mxs/mxs-saif.c | =A0524 +++++++++++++++++++++++++++++++++++=
+++++++++++
>> =A0sound/soc/mxs/mxs-saif.h | =A0124 +++++++++++
>> =A02 files changed, 648 insertions(+), 0 deletions(-)
>>
>> diff --git a/sound/soc/mxs/mxs-saif.c b/sound/soc/mxs/mxs-saif.c
>> new file mode 100644
>> index 0000000..afc6e57
>> --- /dev/null
>> +++ b/sound/soc/mxs/mxs-saif.c
>> @@ -0,0 +1,524 @@
>> +/*
>> + * Copyright 2011 Freescale Semiconductor, Inc.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License al=
ong
>> + * with this program; if not, write to the Free Software Foundation, In=
c.,
>> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>> + */
>> +
>> +#include <linux/module.h>
>> +#include <linux/init.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/slab.h>
>> +#include <linux/dma-mapping.h>
>> +#include <linux/clk.h>
>> +#include <linux/delay.h>
>> +#include <sound/core.h>
>> +#include <sound/pcm.h>
>> +#include <sound/pcm_params.h>
>> +#include <sound/soc.h>
>> +#include <mach/dma.h>
>> +#include <asm/mach-types.h>
>> +#include <mach/hardware.h>
>> +#include <mach/mx28.h>
>
> Is this include really needed?
Thanks a lot for your quick review.
i checked and it's not needed.
Including mxs.h would be ok for using MXS_CLR_ADDR.

>> +
>> +#include "mxs-saif.h"
>> +
>> +/*
>> +* SAIF system clock configuration.
>> +* Should only be called when port is inactive.
>> +*/
>> +static int mxs_saif_set_dai_sysclk(struct snd_soc_dai *cpu_dai,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int clk_id, unsigned int freq,=
 int dir)
>> +{
>> + =A0 =A0 struct mxs_saif *saif =3D snd_soc_dai_get_drvdata(cpu_dai);
>> +
>> + =A0 =A0 switch (clk_id) {
>> + =A0 =A0 case MXS_SAIF_SYS_CLK:
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk_set_rate(saif->clk, freq);
>> + =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(saif->clk);
>
> This clk_enable is unbalanced. You enabled the clock in probe() already.
Yes, will fix it.

>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> + =A0 =A0 return 0;
>> +}
>> +
>> +/*
>> + * SAIF Clock dividers
>> + * Should only be called when port is inactive.
>> + */
>> +static int mxs_saif_set_dai_clkdiv(struct snd_soc_dai *cpu_dai,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 int div_id=
, int div)
>> +{
>> + =A0 =A0 u32 scr;
>> + =A0 =A0 struct mxs_saif *saif =3D snd_soc_dai_get_drvdata(cpu_dai);
>> +
>> + =A0 =A0 scr =3D __raw_readl(saif->base + SAIF_CTRL);
>> + =A0 =A0 scr &=3D ~BM_SAIF_CTRL_BITCLK_MULT_RATE;
>> + =A0 =A0 scr &=3D ~BM_SAIF_CTRL_BITCLK_BASE_RATE;
>> +
>> + =A0 =A0 switch (div_id) {
>> + =A0 =A0 case MXS_SAIF_MCLK:
>> + =A0 =A0 =A0 =A0 =A0 =A0 switch (div) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 case 32:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scr |=3D BF_SAIF_CTRL_BITCLK_M=
ULT_RATE(4);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scr &=3D ~BM_SAIF_CTRL_BITCLK_=
BASE_RATE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case 64:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scr |=3D BF_SAIF_CTRL_BITCLK_M=
ULT_RATE(3);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scr &=3D ~BM_SAIF_CTRL_BITCLK_=
BASE_RATE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case 128:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scr |=3D BF_SAIF_CTRL_BITCLK_M=
ULT_RATE(2);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scr &=3D ~BM_SAIF_CTRL_BITCLK_=
BASE_RATE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case 256:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scr |=3D BF_SAIF_CTRL_BITCLK_M=
ULT_RATE(1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scr &=3D ~BM_SAIF_CTRL_BITCLK_=
BASE_RATE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case 512:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scr |=3D BF_SAIF_CTRL_BITCLK_M=
ULT_RATE(0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scr &=3D ~BM_SAIF_CTRL_BITCLK_=
BASE_RATE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case 48:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scr |=3D BF_SAIF_CTRL_BITCLK_M=
ULT_RATE(3);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scr |=3D BM_SAIF_CTRL_BITCLK_B=
ASE_RATE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case 96:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scr |=3D BF_SAIF_CTRL_BITCLK_M=
ULT_RATE(2);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scr |=3D BM_SAIF_CTRL_BITCLK_B=
ASE_RATE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case 192:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scr |=3D BF_SAIF_CTRL_BITCLK_M=
ULT_RATE(1);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scr |=3D BM_SAIF_CTRL_BITCLK_B=
ASE_RATE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 case 384:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scr |=3D BF_SAIF_CTRL_BITCLK_M=
ULT_RATE(0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 scr |=3D BM_SAIF_CTRL_BITCLK_B=
ASE_RATE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 =A0 =A0 =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 __raw_writel(scr, saif->base + SAIF_CTRL);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +/*
>> + * SAIF DAI format configuration.
>> + * Should only be called when port is inactive.
>> + * Note: We don't use the I2S modes but instead manually configure the
>> + * SAIF for I2S.
>> + */
>> +static int mxs_saif_set_dai_fmt(struct snd_soc_dai *cpu_dai, unsigned i=
nt fmt)
>> +{
>> + =A0 =A0 u32 scr, stat;
>> + =A0 =A0 u32 scr0;
>> + =A0 =A0 struct mxs_saif *saif =3D snd_soc_dai_get_drvdata(cpu_dai);
>> +
>> + =A0 =A0 stat =3D __raw_readl(saif->base + SAIF_STAT);
>> + =A0 =A0 if (stat & BM_SAIF_STAT_BUSY)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return 0;
>
> Returning succesfully doesn't seem right here.
Will replace with -EBUSY.

>> +
>> + =A0 =A0 scr0 =3D __raw_readl(saif->base + SAIF_CTRL);
>> + =A0 =A0 scr0 =3D scr0 & ~BM_SAIF_CTRL_BITCLK_EDGE & ~BM_SAIF_CTRL_LRCL=
K_POLARITY \
>> + =A0 =A0 =A0 =A0 =A0 =A0 & ~BM_SAIF_CTRL_JUSTIFY & ~BM_SAIF_CTRL_DELAY;
>> + =A0 =A0 scr =3D 0;
>> +
>> + =A0 =A0 /* DAI mode */
>> + =A0 =A0 switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
>> + =A0 =A0 case SND_SOC_DAIFMT_I2S:
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* data frame low 1clk before data */
>> + =A0 =A0 =A0 =A0 =A0 =A0 scr |=3D BM_SAIF_CTRL_DELAY;
>> + =A0 =A0 =A0 =A0 =A0 =A0 scr &=3D ~BM_SAIF_CTRL_LRCLK_POLARITY;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case SND_SOC_DAIFMT_LEFT_J:
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* data frame high with data */
>> + =A0 =A0 =A0 =A0 =A0 =A0 scr &=3D ~BM_SAIF_CTRL_DELAY;
>> + =A0 =A0 =A0 =A0 =A0 =A0 scr &=3D ~BM_SAIF_CTRL_LRCLK_POLARITY;
>> + =A0 =A0 =A0 =A0 =A0 =A0 scr &=3D ~BM_SAIF_CTRL_JUSTIFY;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> =A0 =A0 =A0 =A0default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
Will add.

>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* DAI clock inversion */
>> + =A0 =A0 switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
>> + =A0 =A0 case SND_SOC_DAIFMT_IB_IF:
>> + =A0 =A0 =A0 =A0 =A0 =A0 scr |=3D BM_SAIF_CTRL_BITCLK_EDGE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 scr |=3D BM_SAIF_CTRL_LRCLK_POLARITY;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case SND_SOC_DAIFMT_IB_NF:
>> + =A0 =A0 =A0 =A0 =A0 =A0 scr |=3D BM_SAIF_CTRL_BITCLK_EDGE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 scr &=3D ~BM_SAIF_CTRL_LRCLK_POLARITY;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case SND_SOC_DAIFMT_NB_IF:
>> + =A0 =A0 =A0 =A0 =A0 =A0 scr &=3D ~BM_SAIF_CTRL_BITCLK_EDGE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 scr |=3D BM_SAIF_CTRL_LRCLK_POLARITY;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case SND_SOC_DAIFMT_NB_NF:
>> + =A0 =A0 =A0 =A0 =A0 =A0 scr &=3D ~BM_SAIF_CTRL_BITCLK_EDGE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 scr &=3D ~BM_SAIF_CTRL_LRCLK_POLARITY;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>
> A question more for Liam and Mark: Would it make sense to add individual
> masks for the clock inversion and frame sync inversion? I code like the
> above in every driver, and I think this could become simpler.
>
>
>> +
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Note: We simply just support master mode since SAIF TX on=
ly supports
>> + =A0 =A0 =A0* master mode.
>> + =A0 =A0 =A0*/
>
> When this is true...
It's hw limitation.
Defined in MX28 spec 35.2.1.
i quote it as follows;
For transmit, BITCLK and LRCLK are always driven by the SAIF.
...
Coniguring the SAIF for transmit makes it the master by default.
....

>> + =A0 =A0 switch (fmt & SND_SOC_DAIFMT_MASTER_MASK) {
>> + =A0 =A0 case SND_SOC_DAIFMT_CBS_CFS:
>> + =A0 =A0 =A0 =A0 =A0 =A0 scr &=3D ~BM_SAIF_CTRL_SLAVE_MODE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(scr | scr0, saif->base + SAIF_CTR=
L);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case SND_SOC_DAIFMT_CBM_CFS:
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case SND_SOC_DAIFMT_CBS_CFM:
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> You should return an error here.
Will add.

>> + =A0 =A0 case SND_SOC_DAIFMT_CBM_CFM:
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int mxs_saif_startup(struct snd_pcm_substream *substream,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_soc_dai *cpu=
_dai)
>> +{
>> + =A0 =A0 struct mxs_saif *saif =3D snd_soc_dai_get_drvdata(cpu_dai);
>> + =A0 =A0 snd_soc_dai_set_dma_data(cpu_dai, substream, &saif->dma_param);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +/*
>> + * Should only be called when port is inactive.
>> + * although can be called multiple times by upper layers.
>> + */
>> +static int mxs_saif_hw_params(struct snd_pcm_substream *substream,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_pcm_hw_p=
arams *params,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_soc_dai =
*cpu_dai)
>> +{
>> + =A0 =A0 struct mxs_saif *saif =3D snd_soc_dai_get_drvdata(cpu_dai);
>> + =A0 =A0 u32 scr;
>> +
>> + =A0 =A0 scr =3D __raw_readl(saif->base + SAIF_CTRL);
>> +
>> + =A0 =A0 /* cant change any parameters when SAIF is running */
>> + =A0 =A0 /* DAI data (word) size */
>> + =A0 =A0 scr &=3D ~BM_SAIF_CTRL_WORD_LENGTH;
>> + =A0 =A0 scr &=3D ~BM_SAIF_CTRL_BITCLK_48XFS_ENABLE;
>> + =A0 =A0 switch (params_format(params)) {
>> + =A0 =A0 case SNDRV_PCM_FORMAT_S16_LE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 scr |=3D BF_SAIF_CTRL_WORD_LENGTH(0);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case SNDRV_PCM_FORMAT_S20_3LE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 scr |=3D BF_SAIF_CTRL_WORD_LENGTH(4);
>> + =A0 =A0 =A0 =A0 =A0 =A0 scr |=3D BM_SAIF_CTRL_BITCLK_48XFS_ENABLE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case SNDRV_PCM_FORMAT_S24_LE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 scr |=3D BF_SAIF_CTRL_WORD_LENGTH(8);
>> + =A0 =A0 =A0 =A0 =A0 =A0 scr |=3D BM_SAIF_CTRL_BITCLK_48XFS_ENABLE;
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>
> =A0 =A0 =A0 =A0default:
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
Will add.

>> + =A0 =A0 }
>> +
>> + =A0 =A0 /* Tx/Rx config */
>> + =A0 =A0 if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* enable TX mode */
>> + =A0 =A0 =A0 =A0 =A0 =A0 scr &=3D ~BM_SAIF_CTRL_READ_MODE;
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* enable RX mode */
>> + =A0 =A0 =A0 =A0 =A0 =A0 scr |=3D BM_SAIF_CTRL_READ_MODE;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 __raw_writel(scr, saif->base + SAIF_CTRL);
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int mxs_saif_prepare(struct snd_pcm_substream *substream,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_soc_dai *cpu=
_dai)
>> +{
>> + =A0 =A0 struct mxs_saif *saif =3D snd_soc_dai_get_drvdata(cpu_dai);
>> + =A0 =A0 __raw_writel(BM_SAIF_CTRL_CLKGATE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 saif->base + SAIF_CTRL + MXS_CLR_ADDR);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static int mxs_saif_trigger(struct snd_pcm_substream *substream, int cm=
d,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct snd_soc=
_dai *cpu_dai)
>> +{
>> + =A0 =A0 struct mxs_saif *saif =3D snd_soc_dai_get_drvdata(cpu_dai);
>> +
>> + =A0 =A0 switch (cmd) {
>> + =A0 =A0 case SNDRV_PCM_TRIGGER_START:
>> + =A0 =A0 case SNDRV_PCM_TRIGGER_RESUME:
>> + =A0 =A0 case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (substream->stream =3D=3D SNDRV_PCM_STREAM_=
PLAYBACK)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*write a data to saif data re=
gister to trigger
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 the transfer*/
>
> /* multiline comments
> =A0* like this please
> =A0*/
Got it.

>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_writel(0, saif->base + S=
AIF_DATA);
>> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*read a data from saif data r=
egister to trigger
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 the receive*/
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 __raw_readl(saif->base + SAIF_=
DATA);
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 case SNDRV_PCM_TRIGGER_SUSPEND:
>> + =A0 =A0 case SNDRV_PCM_TRIGGER_STOP:
>> + =A0 =A0 case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
>> + =A0 =A0 =A0 =A0 =A0 =A0 break;
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +#define MXS_SAIF_RATES =A0 =A0 =A0 =A0 =A0 =A0 =A0 SNDRV_PCM_RATE_8000_=
192000
>> +#define MXS_SAIF_FORMATS \
>> + =A0 =A0 (SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S20_3LE | \
>> + =A0 =A0 SNDRV_PCM_FMTBIT_S24_LE)
>> +
>> +static struct snd_soc_dai_ops mxs_saif_dai_ops =3D {
>> + =A0 =A0 .startup =3D mxs_saif_startup,
>> + =A0 =A0 .trigger =3D mxs_saif_trigger,
>> + =A0 =A0 .prepare =3D mxs_saif_prepare,
>> + =A0 =A0 .hw_params =3D mxs_saif_hw_params,
>> + =A0 =A0 .set_sysclk =3D mxs_saif_set_dai_sysclk,
>> + =A0 =A0 .set_clkdiv =3D mxs_saif_set_dai_clkdiv,
>> + =A0 =A0 .set_fmt =3D mxs_saif_set_dai_fmt,
>> +};
>> +
>> +static int mxs_saif_dai_probe(struct snd_soc_dai *dai)
>> +{
>> + =A0 =A0 struct mxs_saif *saif =3D dev_get_drvdata(dai->dev);
>> +
>> + =A0 =A0 snd_soc_dai_set_drvdata(dai, saif);
>> +
>> + =A0 =A0 /* Reset */
>> + =A0 =A0 __raw_writel(BM_SAIF_CTRL_SFTRST,
>> + =A0 =A0 =A0 =A0 =A0 =A0 saif->base + SAIF_CTRL + MXS_CLR_ADDR);
>> +
>> + =A0 =A0 /* enable MCLK output early since codec may need it */
>> + =A0 =A0 __raw_writel(BM_SAIF_CTRL_CLKGATE,
>> + =A0 =A0 =A0 =A0 =A0 =A0 saif->base + SAIF_CTRL + MXS_CLR_ADDR);
>> + =A0 =A0 __raw_writel(BM_SAIF_CTRL_RUN,
>> + =A0 =A0 =A0 =A0 =A0 =A0 saif->base + SAIF_CTRL + MXS_SET_ADDR);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static struct snd_soc_dai_driver mxs_saif_dai =3D {
>> + =A0 =A0 .name =3D "mxs-saif",
>> + =A0 =A0 .probe =3D mxs_saif_dai_probe,
>> + =A0 =A0 .playback =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .channels_min =3D 2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .channels_max =3D 2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .rates =3D MXS_SAIF_RATES,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .formats =3D MXS_SAIF_FORMATS,
>> + =A0 =A0 },
>> + =A0 =A0 .capture =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .channels_min =3D 2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .channels_max =3D 2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .rates =3D MXS_SAIF_RATES,
>> + =A0 =A0 =A0 =A0 =A0 =A0 .formats =3D MXS_SAIF_FORMATS,
>> + =A0 =A0 },
>> + =A0 =A0 .ops =3D &mxs_saif_dai_ops,
>> +};
>> +
>> +static irqreturn_t mxs_saif_irq(int irq, void *dev_id)
>> +{
>> + =A0 =A0 struct mxs_saif *saif =3D dev_id;
>> +
>> + =A0 =A0 if (saif->fifo_err_counter++ % 100 =3D=3D 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "saif_irq SAIF_STAT %x SAIF_CT=
RL %x \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fifo_errs=3D%d \n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__raw_readl(saif->base + SAIF_S=
TAT),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__raw_readl(saif->base + SAIF_C=
TRL),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0saif->fifo_err_counter);
>> + =A0 =A0 __raw_writel(BM_SAIF_STAT_FIFO_UNDERFLOW_IRQ |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BM_SAIF_STAT_FIFO_OVERFLOW_IRQ,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 saif->base + SAIF_STAT + MXS_C=
LR_ADDR);
>> +
>> + =A0 =A0 return IRQ_HANDLED;
>> +}
>> +
>> +static int mxs_saif_probe(struct platform_device *pdev)
>> +{
>> + =A0 =A0 struct resource *res;
>> + =A0 =A0 struct mxs_saif *saif;
>> + =A0 =A0 int ret =3D 0;
>> +
>> + =A0 =A0 saif =3D kzalloc(sizeof(*saif), GFP_KERNEL);
>> + =A0 =A0 if (!saif)
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>
> Consider using devm_kzalloc and friends, it makes the error path less
> error prone.
Will use it. Thanks for the suggestion.

>> +
>> + =A0 =A0 saif->irq =3D platform_get_irq(pdev, 0);
>> + =A0 =A0 if (saif->irq < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D saif->irq;
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to get irq resourc=
e: %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto failed_get_irq1;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 saif->fifo_err_counter =3D 0;
>> + =A0 =A0 ret =3D request_irq(saif->irq, mxs_saif_irq, 0, "mxs-saif", sa=
if);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to request irq\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto failed_req_irq;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 saif->dma_param.chan_irq =3D platform_get_irq(pdev, 1);
>> + =A0 =A0 if (saif->dma_param.chan_irq < 0) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D saif->dma_param.chan_irq;
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to get dma irq res=
ource: %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto failed_get_irq2;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 saif->clk =3D clk_get(&pdev->dev, NULL);
>> + =A0 =A0 if (IS_ERR(saif->clk)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D PTR_ERR(saif->clk);
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "Cannot get the clock: %d\=
n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto failed_clk;
>> + =A0 =A0 }
>> + =A0 =A0 clk_set_rate(saif->clk, 12000000);
>> + =A0 =A0 clk_enable(saif->clk);
>> +
>> + =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> + =A0 =A0 if (!res) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to get io resource=
: %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto failed_get_resource;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 if (!request_mem_region(res->start, resource_size(res), "mxs-s=
aif")) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "request_mem_region failed=
\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -EBUSY;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto failed_get_resource;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 saif->base =3D ioremap(res->start, resource_size(res));
>> + =A0 =A0 if (!saif->base) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "ioremap failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto failed_ioremap;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 res =3D platform_get_resource(pdev, IORESOURCE_DMA, 0);
>> + =A0 =A0 if (!res) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to get dma resourc=
e: %d\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret);
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto failed_get_resource;
>> + =A0 =A0 }
>> + =A0 =A0 saif->dma_param.chan_num =3D res->start;
>> +
>> + =A0 =A0 platform_set_drvdata(pdev, saif);
>> +
>> + =A0 =A0 ret =3D snd_soc_register_dai(&pdev->dev, &mxs_saif_dai);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "register DAI failed\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto failed_register;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 saif->soc_platform_pdev =3D platform_device_alloc(
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 "mxs-pcm-audio", pdev->id);
>> + =A0 =A0 if (!saif->soc_platform_pdev) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto failed_pdev_alloc;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 platform_set_drvdata(saif->soc_platform_pdev, saif);
>> + =A0 =A0 ret =3D platform_device_add(saif->soc_platform_pdev);
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(&pdev->dev, "failed to add soc platfor=
m device\n");
>> + =A0 =A0 =A0 =A0 =A0 =A0 goto failed_pdev_add;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 return 0;
>> +
>> +failed_pdev_add:
>> + =A0 =A0 platform_device_put(saif->soc_platform_pdev);
>> +failed_pdev_alloc:
>> + =A0 =A0 snd_soc_unregister_dai(&pdev->dev);
>> +failed_register:
>> + =A0 =A0 iounmap(saif->base);
>> +failed_ioremap:
>> + =A0 =A0 release_mem_region(res->start, resource_size(res));
>> +failed_get_resource:
>> + =A0 =A0 clk_disable(saif->clk);
>> + =A0 =A0 clk_put(saif->clk);
>> +failed_clk:
>> +failed_get_irq2:
>> + =A0 =A0 free_irq(saif->irq, saif);
>> +failed_req_irq:
>> +failed_get_irq1:
>> + =A0 =A0 kfree(saif);
>> +
>> + =A0 =A0 return ret;
>> +}
>> +
>> +static int __devexit mxs_saif_remove(struct platform_device *pdev)
>> +{
>> + =A0 =A0 struct resource *res =3D platform_get_resource(pdev, IORESOURC=
E_MEM, 0);
>> + =A0 =A0 struct mxs_saif *saif =3D platform_get_drvdata(pdev);
>> +
>> + =A0 =A0 platform_device_unregister(saif->soc_platform_pdev);
>> +
>> + =A0 =A0 snd_soc_unregister_dai(&pdev->dev);
>> +
>> + =A0 =A0 iounmap(saif->base);
>> + =A0 =A0 release_mem_region(res->start, resource_size(res));
>> + =A0 =A0 free_irq(saif->irq, saif);
>> +
>> + =A0 =A0 clk_disable(saif->clk);
>> + =A0 =A0 clk_put(saif->clk);
>> +
>> + =A0 =A0 kfree(saif);
>> +
>> + =A0 =A0 return 0;
>> +}
>> +
>> +static struct platform_driver mxs_saif_driver =3D {
>> + =A0 =A0 .probe =3D mxs_saif_probe,
>> + =A0 =A0 .remove =3D __devexit_p(mxs_saif_remove),
>> +
>> + =A0 =A0 .driver =3D {
>> + =A0 =A0 =A0 =A0 =A0 =A0 .name =3D "mxs-saif",
>> + =A0 =A0 =A0 =A0 =A0 =A0 .owner =3D THIS_MODULE,
>> + =A0 =A0 },
>> +};
>> +
>> +static int __init mxs_saif_init(void)
>> +{
>> + =A0 =A0 return platform_driver_register(&mxs_saif_driver);
>> +}
>> +
>> +static void __exit mxs_saif_exit(void)
>> +{
>> + =A0 =A0 platform_driver_unregister(&mxs_saif_driver);
>> +}
>> +
>> +module_init(mxs_saif_init);
>> +module_exit(mxs_saif_exit);
>> +MODULE_AUTHOR("Freescale Semiconductor, Inc.");
>> +MODULE_DESCRIPTION("MXS ASoC SAIF driver");
>> +MODULE_LICENSE("GPL");
>> diff --git a/sound/soc/mxs/mxs-saif.h b/sound/soc/mxs/mxs-saif.h
>> new file mode 100644
>> index 0000000..dd26b37
>> --- /dev/null
>> +++ b/sound/soc/mxs/mxs-saif.h
>> @@ -0,0 +1,124 @@
>> +/*
>> + * Copyright (C) 2011 Freescale Semiconductor, Inc. All Rights Reserved.
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License as published by
>> + * the Free Software Foundation; either version 2 of the License, or
>> + * (at your option) any later version.
>> + *
>> + * This program is distributed in the hope that it will be useful,
>> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
>> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =A0See the
>> + * GNU General Public License for more details.
>> + *
>> + * You should have received a copy of the GNU General Public License al=
ong
>> + * with this program; if not, write to the Free Software Foundation, In=
c.,
>> + * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
>> + */
>> +
>> +
>> +#ifndef _MXS_SAIF_H
>> +#define _MXS_SAIF_H
>> +
>> +#define SAIF_CTRL =A0 =A00x0
>> +#define SAIF_STAT =A0 =A00x10
>> +#define SAIF_DATA =A0 =A00x20
>> +#define SAIF_VERSION 0X30
>> +
>> +/* SAIF_CTRL */
>> +#define BM_SAIF_CTRL_SFTRST =A0 =A0 =A0 =A0 =A00x80000000
>> +#define BM_SAIF_CTRL_CLKGATE =A0 =A0 =A0 =A0 0x40000000
>> +#define BP_SAIF_CTRL_BITCLK_MULT_RATE =A0 =A0 =A0 =A027
>> +#define BM_SAIF_CTRL_BITCLK_MULT_RATE =A0 =A0 =A0 =A00x38000000
>> +#define BF_SAIF_CTRL_BITCLK_MULT_RATE(v) \
>> + =A0 =A0 =A0 =A0 =A0 =A0 (((v) << 27) & BM_SAIF_CTRL_BITCLK_MULT_RATE)
>> +#define BM_SAIF_CTRL_BITCLK_BASE_RATE =A0 =A0 =A0 =A00x04000000
>> +#define BM_SAIF_CTRL_FIFO_ERROR_IRQ_EN =A0 =A0 =A0 0x02000000
>> +#define BM_SAIF_CTRL_FIFO_SERVICE_IRQ_EN =A0 =A0 0x01000000
>> +#define BP_SAIF_CTRL_RSRVD2 =A0 =A0 =A0 =A0 =A021
>> +#define BM_SAIF_CTRL_RSRVD2 =A0 =A0 =A0 =A0 =A00x00E00000
>> +
>> +#define BP_SAIF_CTRL_DMAWAIT_COUNT =A0 16
>> +#define BM_SAIF_CTRL_DMAWAIT_COUNT =A0 0x001F0000
>> +#define BF_SAIF_CTRL_DMAWAIT_COUNT(v) \
>> + =A0 =A0 =A0 =A0 =A0 =A0 (((v) << 16) & BM_SAIF_CTRL_DMAWAIT_COUNT)
>> +#define BP_SAIF_CTRL_CHANNEL_NUM_SELECT 14
>> +#define BM_SAIF_CTRL_CHANNEL_NUM_SELECT 0x0000C000
>> +#define BF_SAIF_CTRL_CHANNEL_NUM_SELECT(v) \
>> + =A0 =A0 =A0 =A0 =A0 =A0 (((v) << 14) & BM_SAIF_CTRL_CHANNEL_NUM_SELECT)
>> +#define BM_SAIF_CTRL_LRCLK_PULSE =A0 =A0 0x00002000
>> +#define BM_SAIF_CTRL_BIT_ORDER =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x00001000
>> +#define BM_SAIF_CTRL_DELAY =A0 =A0 =A0 =A0 =A0 0x00000800
>> +#define BM_SAIF_CTRL_JUSTIFY =A0 =A0 =A0 =A0 0x00000400
>> +#define BM_SAIF_CTRL_LRCLK_POLARITY =A00x00000200
>> +#define BM_SAIF_CTRL_BITCLK_EDGE =A0 =A0 0x00000100
>> +#define BP_SAIF_CTRL_WORD_LENGTH =A0 =A0 4
>> +#define BM_SAIF_CTRL_WORD_LENGTH =A0 =A0 0x000000F0
>> +#define BF_SAIF_CTRL_WORD_LENGTH(v) \
>> + =A0 =A0 =A0 =A0 =A0 =A0 (((v) << 4) & BM_SAIF_CTRL_WORD_LENGTH)
>> +#define BM_SAIF_CTRL_BITCLK_48XFS_ENABLE =A0 =A0 0x00000008
>> +#define BM_SAIF_CTRL_SLAVE_MODE =A0 =A0 =A0 =A0 =A0 =A0 =A00x00000004
>> +#define BM_SAIF_CTRL_READ_MODE =A0 =A0 =A0 =A0 =A0 =A0 =A0 0x00000002
>> +#define BM_SAIF_CTRL_RUN =A0 =A0 =A0 =A0 =A0 =A0 0x00000001
>> +
>> +/* SAIF_STAT */
>> +#define BM_SAIF_STAT_PRESENT =A0 =A0 =A0 =A0 0x80000000
>> +#define BP_SAIF_STAT_RSRVD2 =A0 =A0 =A0 =A0 =A017
>> +#define BM_SAIF_STAT_RSRVD2 =A0 =A0 =A0 =A0 =A00x7FFE0000
>> +#define BF_SAIF_STAT_RSRVD2(v) \
>> + =A0 =A0 =A0 =A0 =A0 =A0 (((v) << 17) & BM_SAIF_STAT_RSRVD2)
>> +#define BM_SAIF_STAT_DMA_PREQ =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00010000
>> +#define BP_SAIF_STAT_RSRVD1 =A0 =A0 =A0 =A0 =A07
>> +#define BM_SAIF_STAT_RSRVD1 =A0 =A0 =A0 =A0 =A00x0000FF80
>> +#define BF_SAIF_STAT_RSRVD1(v) \
>> + =A0 =A0 =A0 =A0 =A0 =A0 (((v) << 7) & BM_SAIF_STAT_RSRVD1)
>> +
>> +#define BM_SAIF_STAT_FIFO_UNDERFLOW_IRQ 0x00000040
>> +#define BM_SAIF_STAT_FIFO_OVERFLOW_IRQ =A0 =A0 =A0 0x00000020
>> +#define BM_SAIF_STAT_FIFO_SERVICE_IRQ =A0 =A0 =A0 =A00x00000010
>> +#define BP_SAIF_STAT_RSRVD0 =A0 =A0 =A0 =A0 =A01
>> +#define BM_SAIF_STAT_RSRVD0 =A0 =A0 =A0 =A0 =A00x0000000E
>> +#define BF_SAIF_STAT_RSRVD0(v) \
>> + =A0 =A0 =A0 =A0 =A0 =A0 (((v) << 1) & BM_SAIF_STAT_RSRVD0)
>> +#define BM_SAIF_STAT_BUSY =A0 =A0 =A0 =A0 =A0 =A00x00000001
>> +
>> +/* SAFI_DATA */
>> +#define BP_SAIF_DATA_PCM_RIGHT =A0 =A0 =A0 =A0 =A0 =A0 =A0 16
>> +#define BM_SAIF_DATA_PCM_RIGHT =A0 =A0 =A0 =A0 =A0 =A0 =A0 0xFFFF0000
>> +#define BF_SAIF_DATA_PCM_RIGHT(v) \
>> + =A0 =A0 =A0 =A0 =A0 =A0 (((v) << 16) & BM_SAIF_DATA_PCM_RIGHT)
>> +#define BP_SAIF_DATA_PCM_LEFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00
>> +#define BM_SAIF_DATA_PCM_LEFT =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x0000FFFF
>> +#define BF_SAIF_DATA_PCM_LEFT(v) =A0 =A0 \
>> + =A0 =A0 =A0 =A0 =A0 =A0 (((v) << 0) & BM_SAIF_DATA_PCM_LEFT)
>> +
>> +/* SAIF_VERSION */
>> +#define BP_SAIF_VERSION_MAJOR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A024
>> +#define BM_SAIF_VERSION_MAJOR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00xFF000000
>> +#define BF_SAIF_VERSION_MAJOR(v) \
>> + =A0 =A0 =A0 =A0 =A0 =A0 (((v) << 24) & BM_SAIF_VERSION_MAJOR)
>> +#define BP_SAIF_VERSION_MINOR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A016
>> +#define BM_SAIF_VERSION_MINOR =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A00x00FF0000
>> +#define BF_SAIF_VERSION_MINOR(v) \
>> + =A0 =A0 =A0 =A0 =A0 =A0 (((v) << 16) & BM_SAIF_VERSION_MINOR)
>> +#define BP_SAIF_VERSION_STEP =A0 =A0 =A0 =A0 0
>> +#define BM_SAIF_VERSION_STEP =A0 =A0 =A0 =A0 0x0000FFFF
>> +#define BF_SAIF_VERSION_STEP(v) \
>> + =A0 =A0 =A0 =A0 =A0 =A0 (((v) << 0) & BM_SAIF_VERSION_STEP)
>> +
>> +#define MXS_SAIF_SYS_CLK =A0 =A0 0
>> +#define MXS_SAIF_MCLK =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A01
>> +
>> +#include "mxs-pcm.h"
>> +
>> +struct mxs_saif {
>> + =A0 =A0 struct clk *clk;
>> + =A0 =A0 void __iomem *base;
>> + =A0 =A0 int irq;
>> + =A0 =A0 struct mxs_pcm_dma_params dma_param;
>> +
>> + =A0 =A0 struct platform_device *soc_platform_pdev;
>> + =A0 =A0 u32 fifo_err_counter;
>> +};
>> +
>> +#endif
>> --
>> 1.7.0.4
>>
>>
>>
>
> --
> Pengutronix e.K. =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 |
> Industrial Linux Solutions =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 | http://www.p=
engutronix.de/ =A0|
> Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0 =A0=
 =A0|
> Amtsgericht Hildesheim, HRA 2686 =A0 =A0 =A0 =A0 =A0 | Fax: =A0 +49-5121-=
206917-5555 |
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
