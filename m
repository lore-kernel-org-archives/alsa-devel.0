From: Lu Guanqun <guanqun.lu@intel.com>
Subject: Re: [PATCH V3 2/5] sound: asoc: Adding support for
 SPEAr13XX ASoC platform driver
Date: Mon, 11 Apr 2011 21:00:30 +0800
Message-ID: <20110411130030.GB11072@qtel.sh.intel.com>
References: <1302499804-24386-1-git-send-email-rajeev-dlh.kumar@st.com>
	<1302499804-24386-2-git-send-email-rajeev-dlh.kumar@st.com>
	<1302499804-24386-3-git-send-email-rajeev-dlh.kumar@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 0277510380F
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Apr 2011 15:01:25 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <1302499804-24386-3-git-send-email-rajeev-dlh.kumar@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rajeev Kumar <rajeev-dlh.kumar@st.com>
Cc: "tiwai@suse.de" <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, "lrg@slimlogic.co.uk" <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Mon, Apr 11, 2011 at 01:30:01PM +0800, Rajeev Kumar wrote:
> This patch adds the support for the SPEAr13XX Platform Driver (I2S based)
> as per the ASoC framework.
> 
> SPEAr13XX internally uses a Designware I2S IP and some glue logic on top
> of the same.
> 
> Signed-off-by: Rajeev Kumar <rajeev-dlh.kumar@st.com>
> ---
>  sound/soc/spear/spear13xx-i2s.c |  523 +++++++++++++++++++++++++++++++++++++++
>  sound/soc/spear/spear13xx-i2s.h |   19 ++
>  sound/soc/spear/spear13xx-pcm.c |  500 +++++++++++++++++++++++++++++++++++++
>  sound/soc/spear/spear13xx-pcm.h |   50 ++++
>  4 files changed, 1092 insertions(+), 0 deletions(-)
>  create mode 100644 sound/soc/spear/spear13xx-i2s.c
>  create mode 100644 sound/soc/spear/spear13xx-i2s.h
>  create mode 100644 sound/soc/spear/spear13xx-pcm.c
>  create mode 100644 sound/soc/spear/spear13xx-pcm.h
> 
> diff --git a/sound/soc/spear/spear13xx-i2s.c b/sound/soc/spear/spear13xx-i2s.c
> new file mode 100644
> index 0000000..33d2d11
> --- /dev/null
> +++ b/sound/soc/spear/spear13xx-i2s.c
> @@ -0,0 +1,523 @@
> +/*
> + * ALSA SoC I2S Audio Layer for ST spear13xx processor
> + *
> + * sound/soc/spear/spear13xx-i2s.c
> + *
> + * Copyright (C) 2011 ST Microelectronics
> + * Rajeev Kumar <rajeev-dlh.kumar@st.com>
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2. This program is licensed "as is" without any
> + * warranty of any kind, whether express or implied.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/init.h>
> +#include <linux/io.h>
> +#include <linux/interrupt.h>
> +#include <linux/module.h>
> +#include <linux/slab.h>
> +#include <mach/misc_regs.h>
> +#include <sound/pcm.h>
> +#include <sound/pcm_params.h>
> +#include <sound/core.h>
> +#include <sound/initval.h>
> +#include <sound/soc.h>
> +#include "spear13xx-pcm.h"
> +#include "spear13xx-i2s.h"
> +
> +/* common register for all channel */
> +#define IER            0x000
> +#define IRER           0x004
> +#define ITER           0x008
> +#define CER            0x00C
> +#define CCR            0x010
> +#define RXFFR          0x014
> +#define TXFFR          0x018
> +
> +/* I2STxRxRegisters for channel 0 */
> +#define LRBR0_LTHR0    0x020
> +#define RRBR0_RTHR0    0x024
> +#define RER0           0x028
> +#define TER0           0x02C
> +#define RCR0           0x030
> +#define TCR0           0x034
> +#define ISR0           0x038
> +#define IMR0           0x03C
> +#define ROR0           0x040
> +#define TOR0           0x044
> +#define RFCR0          0x048
> +#define TFCR0          0x04C
> +#define RFF0           0x050
> +#define TFF0           0x054
> +
> +/* I2STxRxRegisters for channel 1 */
> +#define LRBR1_LTHR1    0x060
> +#define RRBR1_RTHR1    0x064
> +#define RER1           0x068
> +#define TER1           0x06C
> +#define RCR1           0x070
> +#define TCR1           0x074
> +#define ISR1           0x078
> +#define IMR1           0x07C
> +#define ROR1           0x080
> +#define TOR1           0x084
> +#define RFCR1          0x088
> +#define TFCR1          0x08C
> +#define RFF1           0x090
> +#define TFF1           0x094
> +
> +/* I2STxRxRegisters for channel 2 */
> +#define LRBR2_LTHR2    0x0A0
> +#define RRBR2_RTHR2    0x0A4
> +#define RER2           0x0A8
> +#define TER2           0x0AC
> +#define RCR2           0x0B0
> +#define TCR2           0x0B4
> +#define ISR2           0x0B8
> +#define IMR2           0x0BC
> +#define ROR2           0x0C0
> +#define TOR2           0x0C4
> +#define RFCR2          0x0C8
> +#define TFCR2          0x0CC
> +#define RFF2           0x0D0
> +#define TFF2           0x0D4
> +
> +/* I2STxRxRegisters for channel 3*/
> +#define LRBR3_LTHR3    0x0E0
> +#define RRBR3_RTHR3    0x0E4
> +#define RER3           0x0E8
> +#define TER3           0x0EC
> +#define RCR3           0x0F0
> +#define TCR3           0x0F4
> +#define ISR3           0x0F8
> +#define IMR3           0x0FC
> +#define ROR3           0x100
> +#define TOR3           0x104
> +#define RFCR3          0x108
> +#define TFCR3          0x10C
> +#define RFF3           0x110
> +#define TFF3           0x114
> +
> +/* I2SDMARegisters */
> +#define RXDMA          0x01C0
> +#define RRXDMA         0x01C4
> +#define TXDMA          0x01C8
> +#define RTXDMA         0x01CC
> +
> +/* I2SCOMPRegisters */
> +#define I2S_COMP_PARAM_2       0x01F0
> +#define I2S_COMP_PARAM_1       0x01F4
> +#define I2S_COMP_VERSION       0x01F8
> +#define I2S_COMP_TYPE          0x01FC
> +
> +#define SPEAR13XX_I2S_RATES    SNDRV_PCM_RATE_8000_96000
> +#define SPEAR13XX_I2S_FORMAT   SNDRV_PCM_FMTBIT_S16_LE
> +#define MAX_CHANNEL_NUM                2
> +#define MIN_CHANNEL_NUM                2
> +
> +struct spear13xx_i2s_dev {
> +       void __iomem *i2s_base;
> +       struct resource *res;
> +       struct clk *clk;
> +       int play_irq;
> +       int mode;
> +       int active;
> +       int capture_irq;
> +       struct device *dev;
> +       struct spear13xx_pcm_dma_params *dma_params[2];
> +};
> +
> +void get_dma_start_addr(struct snd_pcm_substream *substream)
> +{
> +       struct snd_soc_pcm_runtime *rtd = substream->private_data;
> +       struct spear13xx_runtime_data *prtd = substream->runtime->private_data;
> +       struct spear13xx_i2s_dev *dev = snd_soc_dai_get_drvdata(rtd->cpu_dai);
> +
> +       prtd->txdma = dev->res->start + TXDMA;
> +       prtd->rxdma = dev->res->start + RXDMA;
> +
> +       substream->runtime->private_data = prtd;
> +}
> +
> +static inline void i2s_write_reg(void *io_base, int reg, u32 val)
> +{
> +       writel(val, io_base + reg);
> +}
> +
> +static inline u32 i2s_read_reg(void *io_base, int reg)
> +{
> +       return readl(io_base + reg);
> +}
> +
> +static void i2s_start_play(struct spear13xx_i2s_dev *dev,
> +               struct snd_pcm_substream *substream)
> +{
> +       u32 val; /*dma mode slection*/
> +
> +       val = readl(PERIP_CFG);
> +       val &= ~0xFFFFFFFC;
> +       i2s_write_reg(dev->i2s_base, TER0, 0);
> +       i2s_write_reg(dev->i2s_base, TER1, 0);
> +
> +       /* for 2.0 audio*/
> +       if (dev->mode <= 2) {
> +               if (!val) {
> +                       i2s_write_reg(dev->i2s_base, TCR0, 0x2);
> +                       i2s_write_reg(dev->i2s_base, TFCR0, 0x07);
> +                       i2s_write_reg(dev->i2s_base, IMR0, 0x00);
> +                       i2s_write_reg(dev->i2s_base, TER0, 1);
> +               } else {
> +                       i2s_write_reg(dev->i2s_base, TCR1, 0x2);
> +                       i2s_write_reg(dev->i2s_base, TFCR1, 0x07);
> +                       i2s_write_reg(dev->i2s_base, IMR1, 0x00);
> +                       i2s_write_reg(dev->i2s_base, TER1, 1);
> +               }
> +       } else { /*audio 2.0 onwards */
> +               i2s_write_reg(dev->i2s_base, TCR0, 0x5);
> +               i2s_write_reg(dev->i2s_base, TCR1, 0x5);
> +
> +               i2s_write_reg(dev->i2s_base, TFCR0, 0x07);
> +               i2s_write_reg(dev->i2s_base, TFCR1, 0x07);
> +               i2s_write_reg(dev->i2s_base, IMR0, 0x00);
> +               i2s_write_reg(dev->i2s_base, IMR1, 0x00);
> +               i2s_write_reg(dev->i2s_base, TER0, 1);
> +               i2s_write_reg(dev->i2s_base, TER1, 1);
> +       }
> +
> +       i2s_write_reg(dev->i2s_base, ITER, 1);
> +}
> +
> +static void i2s_start_rec(struct spear13xx_i2s_dev *dev,
> +               struct snd_pcm_substream *substream)
> +{
> +       u32 val; /*dma mode slection*/
> +
> +       val = readl(PERIP_CFG);
> +       val &= ~0xFFFFFFFC;
> +       i2s_write_reg(dev->i2s_base, RER0, 0);
> +       i2s_write_reg(dev->i2s_base, RER1, 0);
> +
> +       /* for 2.0 audio*/
> +       if (dev->mode <= 2) {
> +               if (!val) {
> +                       i2s_write_reg(dev->i2s_base, RCR0, 0x2);
> +                       i2s_write_reg(dev->i2s_base, RFCR0, 0x07);
> +                       i2s_write_reg(dev->i2s_base, IMR0, 0x00);
> +                       i2s_write_reg(dev->i2s_base, RER0, 1);
> +               } else {
> +                       i2s_write_reg(dev->i2s_base, RCR1, 0x2);
> +                       i2s_write_reg(dev->i2s_base, RFCR1, 0x07);
> +                       i2s_write_reg(dev->i2s_base, IMR1, 0x00);
> +                       i2s_write_reg(dev->i2s_base, TER1, 1);
> +               }
> +       } else { /*audio 2.0 onwards */
> +               i2s_write_reg(dev->i2s_base, RCR0, 0x5);
> +               i2s_write_reg(dev->i2s_base, RCR1, 0x5);
> +
> +               i2s_write_reg(dev->i2s_base, RFCR0, 0x07);
> +               i2s_write_reg(dev->i2s_base, RFCR1, 0x07);
> +               i2s_write_reg(dev->i2s_base, IMR0, 0x00);
> +               i2s_write_reg(dev->i2s_base, IMR1, 0x00);
> +               i2s_write_reg(dev->i2s_base, RER0, 1);
> +               i2s_write_reg(dev->i2s_base, RER1, 1);
> +       }
> +
> +       i2s_write_reg(dev->i2s_base, IRER, 1);
> +}
> +
> +static void i2s_stop(struct spear13xx_i2s_dev *dev,
> +               struct snd_pcm_substream *substream)
> +{
> +       if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +               i2s_write_reg(dev->i2s_base, ITER, 0);
> +               i2s_write_reg(dev->i2s_base, ITER, 1);
> +               i2s_write_reg(dev->i2s_base, IMR0, 0x30);
> +               i2s_write_reg(dev->i2s_base, IMR1, 0x30);
> +       } else {
> +               i2s_write_reg(dev->i2s_base, IRER, 0);
> +               i2s_write_reg(dev->i2s_base, IRER, 1);
> +               i2s_write_reg(dev->i2s_base, IMR0, 0x03);
> +               i2s_write_reg(dev->i2s_base, IMR1, 0x03);
> +       }
> +       if (!dev->active--) {
> +               i2s_write_reg(dev->i2s_base, CER, 0);
> +               i2s_write_reg(dev->i2s_base, IER, 0);
> +               dev->active = 0;
> +       }
> +
> +}
> +
> +static irqreturn_t i2s_play_irq(int irq, void *_dev)
> +{
> +       struct spear13xx_i2s_dev *dev = (struct spear13xx_i2s_dev *)_dev;
> +       u32 ch0, ch1;
> +
> +       /* check for the tx data overrun condition */
> +       ch0 = i2s_read_reg(dev->i2s_base, ISR0) & 0x20;
> +       ch1 = i2s_read_reg(dev->i2s_base, ISR1) & 0x20;
> +       if (ch0 || ch1) {
> +
> +               /* disable tx block */
> +               i2s_write_reg(dev->i2s_base, ITER, 0);
> +
> +               /* flush all the tx fifo */
> +               i2s_write_reg(dev->i2s_base, TXFFR, 1);
> +
> +               /* clear tx data overrun interrupt: channel 0 */
> +               i2s_read_reg(dev->i2s_base, TOR0);
> +
> +               /* clear tx data overrun interrupt: channel 1 */
> +               i2s_read_reg(dev->i2s_base, TOR1);
> +
> +       }
> +
> +       return IRQ_HANDLED;
> +}

I remember Mark had some comments on adding some logs when it's overrun,
how do you think?

-- 
guanqun
