From: Dong Aisheng <dongas86@gmail.com>
Subject: Re: [PATCH 02/10] ASoc: mxs: add mxs-saif driver
Date: Sun, 10 Jul 2011 16:17:13 +0800
Message-ID: <CAA+hA=S0HTqNt+OxprdaqZMF8_9NF8G54UKJprcWc2DCbGf0xA@mail.gmail.com>
References: <1310140790-2132-1-git-send-email-b29396@freescale.com>
	<1310140790-2132-3-git-send-email-b29396@freescale.com>
	<20110709025252.GC26900@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110709025252.GC26900@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, Dong Aisheng <b29396@freescale.com>, s.hauer@pengutronix.de, linux-arm-kernel@lists.infradead.org, lrg@ti.com
List-Id: alsa-devel@alsa-project.org

2011/7/9 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Fri, Jul 08, 2011 at 11:59:42PM +0800, Dong Aisheng wrote:
>> Signed-off-by: Dong Aisheng <b29396@freescale.com>
>
> Again, *always* CC maintainers on patches.
Will add in the updated patch.

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
> How would one turn this clock off?
Currenty simply enable clock always.
The problem is that the codec may use the MCLK supplied by SAIF as its
system clock for normal operations such as i2c r/w.
If we disable it after playback or capture. The automatic dapm
operations of codec may fail on i2c r/w. Will check if dapm has any
machnism to avoid this.
Can you share your experience ont this issue?

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
>
> No, this stuff should all be figured out automatically by the driver -
> the user shouldn't have to manually set the ratio, especially if they've
> already set the master clock.
Yes, that's a good point and i will try to do it in the updated patch.

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
>> + =A0 =A0 }
>
> This should return an error if the parameters are invalid. =A0The rest of
> the code has many other instances of this missing check.
Will add them.

>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Note: We simply just support master mode since SAIF TX on=
ly supports
>> + =A0 =A0 =A0* master mode.
>> + =A0 =A0 =A0*/
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
> This is clearly wrong, you're doing exactly the same thing for two
> different inputs.
Will fix in next patch.

>> +static int mxs_saif_startup(struct snd_pcm_substream *substream,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_soc_dai *cpu=
_dai)
>> +{
>> + =A0 =A0 struct mxs_saif *saif =3D snd_soc_dai_get_drvdata(cpu_dai);
>> + =A0 =A0 snd_soc_dai_set_dma_data(cpu_dai, substream, &saif->dma_param);
>> +
>> + =A0 =A0 return 0;
>> +}
>
> Remove empty functions.
This is to set dma param.

>> +/*
>> + * Should only be called when port is inactive.
>> + * although can be called multiple times by upper layers.
>> + */
>> +static int mxs_saif_hw_params(struct snd_pcm_substream *substream,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_pcm_hw_p=
arams *params,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0struct snd_soc_dai =
*cpu_dai)
>
> The requirement for the port to be inactive is totally unreasonable,
> especially given that the params are configured by applications and you
> support simultaneous playback and record.
Yes, i will remove it. Finally we will support simultaneous playback and re=
cord.

>> +static irqreturn_t mxs_saif_irq(int irq, void *dev_id)
>> +{
>> + =A0 =A0 struct mxs_saif *saif =3D dev_id;
>> +
>> + =A0 =A0 if (saif->fifo_err_counter++ % 100 =3D=3D 0)
>
> The rate limit looks awfully suspicious...
Originally it's just for printing less error messages when the issue happen=
s.
I could remove the rate limit.

>> + =A0 =A0 =A0 =A0 =A0 =A0 printk(KERN_ERR "saif_irq SAIF_STAT %x SAIF_CT=
RL %x \
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 fifo_errs=3D%d \n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__raw_readl(saif->base + SAIF_S=
TAT),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0__raw_readl(saif->base + SAIF_C=
TRL),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0saif->fifo_err_counter);
>
> dev_err()
Will change.

>> + =A0 =A0 __raw_writel(BM_SAIF_STAT_FIFO_UNDERFLOW_IRQ |
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 BM_SAIF_STAT_FIFO_OVERFLOW_IRQ,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 saif->base + SAIF_STAT + MXS_C=
LR_ADDR);
>> +
>> + =A0 =A0 return IRQ_HANDLED;
>
> You're not actually checking that the relevant interrupt fired...
I will add the checking for different errors.

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
>
> How did you pick this clock rate and why does it need to be set? =A0It's
> not an obvious audio rate...
It's initial clock rate for normal operations of codecs based on MCLK.
We found the default MCLK ouput(only about 7.3Khz) can not work for codecs =
like
sgtl5000 for its initialization since its clock range is 8Mhz~27Mhz.
So we set a common working clock 12Mhz here.
Maybe i should try to set it elsewhere or just set it via platform data.

> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
