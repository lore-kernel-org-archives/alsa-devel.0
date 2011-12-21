From: Tomoya MORINAGA <tomoya.rohm@gmail.com>
Subject: Re: [PATCH 3/3 v2] sound/soc/lapis: add platform
 driver for ML7213 IOH I2S
Date: Wed, 21 Dec 2011 20:22:56 +0900
Message-ID: <CANKRQng8N3oS2o17HPUZeonXB3KLBK9oNQj-zd9+aUUvWcTo0A@mail.gmail.com>
References: <1324349144-12784-1-git-send-email-tomoya.rohm@gmail.com>
	<1324349144-12784-3-git-send-email-tomoya.rohm@gmail.com>
	<20111220132314.GQ2866@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pz0-f51.google.com (mail-pz0-f51.google.com
	[209.85.210.51]) by alsa0.perex.cz (Postfix) with ESMTP id 7DD46243FB
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2011 12:22:58 +0100 (CET)
Received: by dajy12 with SMTP id y12so4708771daj.38
	for <alsa-devel@alsa-project.org>; Wed, 21 Dec 2011 03:22:56 -0800 (PST)
In-Reply-To: <20111220132314.GQ2866@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Dimitris Papastamos <dp@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>, Mike Frysinger <vapier@gentoo.org>, qi.wang@intel.com, Takashi Iwai <tiwai@suse.de>, linux-kernel@vger.kernel.org, yong.y.wang@intel.com, kok.howg.ewe@intel.com, Daniel Mack <zonque@gmail.com>, Liam Girdwood <lrg@ti.com>, joel.clark@intel.com
List-Id: alsa-devel@alsa-project.org

2011/12/20 Mark Brown <broonie@opensource.wolfsonmicro.com>:
> On Tue, Dec 20, 2011 at 11:45:44AM +0900, Tomoya MORINAGA wrote:
>
>> +static int ignore_overrun =3D 1;
>> +module_param(ignore_overrun, int, 0444);
>> +MODULE_PARM_DESC(ignore_overrun, "ignore RX overruns (default=3D0)");
>
> This shouldn't be a driver specific thing, and if we were to have such a
> feature a module parameter doesn't seem like a great way of doing it.

I'll delete this parameter.

>
>> +/**********************************************************************=
*******
>> + * =A0 I2S HAL (Hardware Abstruction Layer)
>> + **********************************************************************=
*******/
>
> Please follow the kernel coding style in terms of comments.
I' ll modify this.

>
>> +static void ioh_i2s_enable_interrupts(int ch, enum dma_data_direction d=
ir)
>> +{
>> + =A0 =A0 unsigned int intr_lines;
>> +
>> + =A0 =A0 if (dir)
>> + =A0 =A0 =A0 =A0 =A0 =A0 intr_lines =3D 1 << (I2S_IMASK_RX_BIT_START + =
ch);
>> +
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 intr_lines =3D 1 << (I2S_IMASK_TX_BIT_START + =
ch);
>
> I'd expect a switch statement corresponding to the enum, not an if
> statement.
"if" will replace "switch".

>
>> +static void ioh_i2s_disable_interrupts(int ch, enum dma_data_direction =
dir)
>> +{
>> + =A0 =A0 unsigned int intr_lines;
>> +
>> + =A0 =A0 /*intr_lines&=3DI2S_ALL_INTERRUPT_BITS; */
>> + =A0 =A0 intr_lines =3D ioread32(i2s_data->iobase + I2SIMASK_OFFSET);
>
> What's this commented out code for? =A0Also as a coding style thing
> you should have a space between /* and the text in the comment (this
> applies throughout the driver).
I'll delete.

>
>> + =A0 =A0 /*disable interrupts for specified channel */
>> + =A0 =A0 if (dir)
>> + =A0 =A0 =A0 =A0 =A0 =A0 intr_lines |=3D 1 << (I2S_IMASK_RX_BIT_START +=
 ch);
>> + =A0 =A0 else
>> + =A0 =A0 =A0 =A0 =A0 =A0 intr_lines |=3D 1 << (I2S_IMASK_TX_BIT_START +=
 ch);
>> +
>> + =A0 =A0 /*Mask the specific interrupt bits */
>> + =A0 =A0 iowrite32(intr_lines, i2s_data->iobase + I2SIMASK_OFFSET);
>
> What ensures that this read/modify/write cycle can't race with another
> caller?
I'll add exclusive processing like spin-lock.

>
>> +/* Clear interrupt status */
>> +static void ioh_i2s_clear_tx_sts_ir(int ch)
>> +{
>> + =A0 =A0 int offset =3D ch * 0x800;
>> +
>> + =A0 =A0 iowrite32(I2S_TX_FINT | I2S_TX_AFINT | I2S_TX_EINT | I2S_TX_AE=
INT,
>> + =A0 =A0 =A0 =A0 =A0 =A0 i2s_data->iobase + I2SISTTX_OFFSET + offset);
>> +}
>
> This appears to unconditionally acknowledge all interrupts, generally
> you should only acknowledge interrupts that have been handled.
> Otherwise it's possible that interrupts may be dropped if they're
> flagged between the status read and acknowledgement write.

I can understand your saying.
If following your saying, only called by i2s_dma_tx_complete is enough.

However I think adding clearing interrupt status at both before and
after i2s communicating start/finish is better.


>
>> +/**********************************************************************=
*******
>> + * =A0 I2S Middle ware
>> + **********************************************************************=
*******/
>
> I'm really not convinced of the value of these layers, reading the code
> it really feels incredibly verbose in comparison with what I'd expect
> from such a driver and I can't help that think that a lot of this
> verbosity is down to muddling through these abstraction layers.
>
>> +static bool filter(struct dma_chan *chan, void *slave)
>
> This needs a better name. =A0It's not namespaced and it's not clear what
> it's filtering.

In case of using Linux standard DMA API, function "filter" is the most
popular name.
Almost drivers which use standard use "filter".


>
>> +static struct dma_chan *ioh_request_dma_channel(
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0int ch, struct ioh_i2s_dma *dma, enum d=
ma_data_direction dir)
>> +{
>> + =A0 =A0 dma_cap_mask_t mask;
>> + =A0 =A0 struct dma_chan *chan;
>> + =A0 =A0 struct pci_dev *dma_dev;
>> + =A0 =A0 dma_cap_zero(mask);
>> + =A0 =A0 dma_cap_set(DMA_SLAVE, mask);
>> +
>> + =A0 =A0 dma_dev =3D pci_get_bus_and_slot(2, PCI_DEVFN(0, 1)); /* Get D=
MA's dev
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 information */
>> +
>> + =A0 =A0 if (dir =3D=3D DMA_FROM_DEVICE) { /* Rx */
>
> switch statement to select between multiple options in the enum. =A0This
> applies throughout the code.
"if" will replace "switch".

>
>> +static void
>> +ioh_i2s_write(struct snd_pcm_substream *substream, const void *data, in=
t len)
>> +{
>> + =A0 =A0 int rem1;
>> + =A0 =A0 int rem2;
>
> What is this supposed to do? =A0There's an awful lot of it, and it looks
> like it's supposed to be rewriting the data format for some reason which
> isn't something that a driver ought to be doing (apart from anything
> else it does rather defeat the point of DMA).

This driver has buffer which is for preventing noisy sound  by jitter
So, this buffer is variable.

>
>> +static void ioh_i2s_configure_i2s_regs(int ch, enum ioh_direction dir)
>> +{
>> + =A0 =A0 int offset =3D ch * 0x800;
>
> You should have a function to map the channel into a number.
understand.

>
>> +
>> + =A0 =A0 if (dir) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Rx register */
>> + =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(I2S_AFULL_THRESH / 2,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 i2s_data->iobase + I2SAFRX=
_OFFSET + offset);
>> + =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(0x1F, i2s_data->iobase + I2SAERX_OFF=
SET + offset);
>> + =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(0x1F, i2s_data->iobase + I2SMSKRX_OF=
FSET + offset);
>> + =A0 =A0 =A0 =A0 =A0 =A0 iowrite32(0xC, i2s_data->iobase + I2SISTRX_OFF=
SET + offset);
>
> Lots of magic numbers here and given that the function is called just
> "configure" it's not clear what the intended purpose is. =A0This needs to
> be clarified.
understand.

>
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Rx configuration */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (atomic_read(&dma->rx_busy)) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(i2s_data->dev, "rx i2s=
%dalready opened\n", ch);
>
> ...
>
>> + =A0 =A0 } else {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Tx configuration */
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (atomic_read(&dma->tx_busy)) {
>
> There's a *lot* of duplicate code in the driver for TX and RX, it should
> be possible to abstract out much more common code.
I'll study.

>
>> +static void i2s_tx_almost_empty_ir(int ch)
>> +{
>> + =A0 =A0 struct dma_async_tx_descriptor *desc;
>> + =A0 =A0 int num;
>> + =A0 =A0 int tx_comp_index;
>> + =A0 =A0 struct ioh_i2s_dma *dma =3D &dmadata[ch];
>> + =A0 =A0 struct scatterlist *sg =3D dma->sg_tx_p;
>> + =A0 =A0 void *cb_ch;
>> +
>> + =A0 =A0 dev_dbg(i2s_data->dev, "%s: data_head=3D%p data_complete=3D%p\=
n", __func__,
>> + =A0 =A0 =A0 =A0 =A0 =A0 dma->tx_data_head, dma->tx_complete);
>> +
>> + =A0 =A0 num =3D ((int)dma->tx_avail) / (I2S_AEMPTY_THRESH * 4);
>
> That case looks *very* suspect.
This is correct.
Why do you think so ?

>
>> + =A0 =A0 tx_comp_index =3D (((int)(dma->tx_complete - dma->tx_head))) /\
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (I2S_AEMPTY_THRESH * 4);
>
> There is very rarely any need for line continuations outside of macros.
>
>> +static inline void ioh_i2s_interrupt_sub_tx(int ch)
>> +{
>> + =A0 =A0 unsigned int status;
>> + =A0 =A0 int offset =3D ch * 0x800;
>> +
>> + =A0 =A0 status =3D ioread32(i2s_data->iobase + I2SISTTX_OFFSET + offse=
t);
>> + =A0 =A0 if (status & I2S_TX_EINT)
>> + =A0 =A0 =A0 =A0 =A0 =A0 i2s_tx_empty_ir(ch);
>> + =A0 =A0 if (status & I2S_TX_AEINT)
>> + =A0 =A0 =A0 =A0 =A0 =A0 i2s_tx_almost_empty_ir(ch);
>
> Given that all you're doing is logging just open code the log message.
Understand.

>
>> + =A0 =A0 default:
>> + =A0 =A0 =A0 =A0 =A0 =A0 return -1;
>
> Return error codes, you EPERM almost certainly isn't the error you meant
> to report.
I'll modify.

>
>> +static int ioh_i2s_pci_suspend(struct pci_dev *pdev, pm_message_t state)
>> +{
>> + =A0 =A0 int ret;
>> +
>> + =A0 =A0 ioh_i2s_save_reg_conf(pdev);
>
> You should be doing this in ASoC suspend/resume callbacks, not in PCI
> ones.
Understand.


thanks,
tomoya
