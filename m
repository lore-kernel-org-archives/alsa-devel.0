From: zhangfei gao <zhangfei.gao@gmail.com>
Subject: Re: [PATCH v1 1/5] dmaengine: mmp_tdma: add mmp tdma
	support
Date: Thu, 7 Jun 2012 21:33:28 +0800
Message-ID: <CAMj5Bkj1846qGOyjghNHoW+rRnd+5705O_iwH+YTJWdgXmyFsA@mail.gmail.com>
References: <1338791851-21038-1-git-send-email-zhangfei.gao@marvell.com>
	<1338791851-21038-2-git-send-email-zhangfei.gao@marvell.com>
	<1339060961.1927.60.camel@vkoul-udesk3>
	<CAMj5BkhLTm1TwR=xDf831jjj9oh32fgiigmxKudZjWLvkmSw1g@mail.gmail.com>
	<1339068643.1927.88.camel@vkoul-udesk3>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wg0-f51.google.com (mail-wg0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id A006F2432F
	for <alsa-devel@alsa-project.org>;
	Thu,  7 Jun 2012 15:33:28 +0200 (CEST)
Received: by wgbed3 with SMTP id ed3so384401wgb.20
	for <alsa-devel@alsa-project.org>; Thu, 07 Jun 2012 06:33:28 -0700 (PDT)
In-Reply-To: <1339068643.1927.88.camel@vkoul-udesk3>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Vinod Koul <vinod.koul@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Eric Miao <eric.y.miao@gmail.com>, Leo Yan <leoy@marvell.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Haojian Zhuang <haojian.zhuang@gmail.com>, alsa-devel@vger.kernel.org, Qiao Zhou <zhouqiao@marvell.com>, linux-arm-kernel@lists.infradead.org, Liam Girdwood <lrg@ti.com>, Chao Xie <cxie4@marvell.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Jun 7, 2012 at 7:30 PM, Vinod Koul <vinod.koul@linux.intel.com> wro=
te:
> On Thu, 2012-06-07 at 18:39 +0800, zhangfei gao wrote:
>> >> +static int mmp_tdma_clear_chan_irq(struct mmp_tdma_chan *tdmac)
>> >> +{
>> >> + =A0 =A0 u32 reg =3D readl(tdmac->reg_base + TDISR);
>> >> +
>> >> + =A0 =A0 if (reg & TDISR_COMP) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 /* clear irq */
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 reg &=3D ~TDISR_COMP;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 writel(reg, tdmac->reg_base + TDISR);
>> >> +
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return 1;
>> > hrmm.?
>> This is local function used to check whether this channel has irq then r=
eturn 1.
>> Used by chan_handler.
> quite linux unlike.
>
>> >> +
>> >> +static dma_cookie_t mmp_tdma_tx_submit(struct dma_async_tx_descripto=
r *tx)
>> >> +{
>> >> + =A0 =A0 struct mmp_tdma_chan *tdmac =3D to_mmp_tdma_chan(tx->chan);
>> >> +
>> >> + =A0 =A0 mmp_tdma_chan_set_desc(tdmac, tdmac->desc_arr_phys);
>> > This seems odd. In submit you are supposed to move this to your pending
>> > list. Btw where is the .issue_pending handler?
>>
>> The driver is specifically for audio.
>> So we make it simple, only support cylic method and no pending list at a=
ll.
>> Only support sync mode.
>> tx_submit will directly write dma address with single descriptor chain.
>> .issue_pending will directly start the dma.
>> When dma started, it will keep process data from/to user.
> But then you are putting unnecessary limitation on its use.
> Limiation should be based on h/w caps
>>
>> >> +
>> >> + =A0 =A0 return 0;
>> >> +}
>> >> +
>> >> +static int mmp_tdma_alloc_chan_resources(struct dma_chan *chan)
>> >> +{
>> >> + =A0 =A0 struct mmp_tdma_chan *tdmac =3D to_mmp_tdma_chan(chan);
>> >> + =A0 =A0 int ret;
>> >> +
>> >> + =A0 =A0 dev_dbg(tdmac->dev, "%s: enter\n", __func__);
>> >> +
>> >> + =A0 =A0 dma_async_tx_descriptor_init(&tdmac->desc, chan);
>> >> + =A0 =A0 tdmac->desc.tx_submit =3D mmp_tdma_tx_submit;
>> >> +
>> >> + =A0 =A0 if (tdmac->irq) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 ret =3D devm_request_irq(tdmac->dev, tdmac-=
>irq,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mmp_tdma_chan_handler, IRQF=
_DISABLED, "tdma", tdmac);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto err_request_irq;
>> >> + =A0 =A0 }
>> >> +
>> >> + =A0 =A0 return 0;
>> > NO. This is supposed to return the number of descriptors allocated.
>> Thanks for remainder.
>>
>>
>> >> +static void mmp_tdma_free_chan_resources(struct dma_chan *chan)
>> >> +{
>> >> + =A0 =A0 struct mmp_tdma_chan *tdmac =3D to_mmp_tdma_chan(chan);
>> >> +
>> >> + =A0 =A0 dev_dbg(tdmac->dev, "%s: enter\n", __func__);
>> >> +
>> >> + =A0 =A0 if (tdmac->irq)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 devm_free_irq(tdmac->dev, tdmac->irq, tdmac=
);
>> >> + =A0 =A0 mmp_tdma_disable_chan(tdmac);
>> > channel should be already disabled, why do you need this here?
>>
>> Is there case directly call dma_put_channel without DMA_TERMINATE_ALL?
> in cyclic no, otherwise yes.
>>
>> >> + =A0 =A0 mmp_tdma_free_descriptor(tdmac);
>> >> + =A0 =A0 return;
>> >> +}
>> >> +
>> >> +
>> >> +static struct dma_async_tx_descriptor *mmp_tdma_prep_slave_sg(
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 struct dma_chan *chan, struct scatterlist *=
sgl,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned int sg_len, enum dma_transfer_dire=
ction direction,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 unsigned long flags, void *context)
>> >> +{
>> >> + =A0 =A0 /*
>> >> + =A0 =A0 =A0* This operation is not supported on the TDMA controller
>> >> + =A0 =A0 =A0*
>> >> + =A0 =A0 =A0* However, we need to provide the function pointer to al=
low the
>> >> + =A0 =A0 =A0* device_control() method to work.
>> >> + =A0 =A0 =A0*/
>> >> + =A0 =A0 return NULL;
>> >> +}
>> > Pls remove if not supported
>>
>> Got it, my mistake,
>> confused by
>> BUG_ON(dma_has_cap(DMA_SLAVE, device->cap_mask) &&
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 !device->device_control);
>>
>> >> +
>> >> +static int mmp_tdma_alloc_descriptor(struct mmp_tdma_chan *tdmac)
>> >> +{
>> >> + =A0 =A0 struct gen_pool *gpool;
>> >> + =A0 =A0 int size =3D tdmac->desc_num * sizeof(struct mmp_tdma_desc);
>> >> +
>> >> + =A0 =A0 dev_dbg(tdmac->dev, "%s: enter\n", __func__);
>> >> +
>> >> + =A0 =A0 gpool =3D sram_get_gpool("asram");
>> >> + =A0 =A0 if (!gpool)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> >> +
>> >> + =A0 =A0 tdmac->desc_arr =3D (void *)gen_pool_alloc(gpool, size);
>> >> + =A0 =A0 if (!tdmac->desc_arr)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> >> +
>> >> + =A0 =A0 tdmac->desc_arr_phys =3D gen_pool_virt_to_phys(gpool,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 (unsigned long)tdmac->desc_=
arr);
>> >> +
>> >> + =A0 =A0 return 0;
>> > this needs fix
>> Could you give more hints?
> return the descriptors allocated
>>
>> >> +}
>> >> +
>> >> +static struct dma_async_tx_descriptor *mmp_tdma_prep_dma_cyclic(
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 struct dma_chan *chan, dma_addr_t dma_addr,=
 size_t buf_len,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 size_t period_len, enum dma_transfer_direct=
ion direction,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 void *context)
>> >> +{
>> >> + =A0 =A0 struct mmp_tdma_chan *tdmac =3D to_mmp_tdma_chan(chan);
>> >> + =A0 =A0 int num_periods =3D buf_len / period_len;
>> >> + =A0 =A0 int i =3D 0, buf =3D 0;
>> >> + =A0 =A0 int ret;
>> >> +
>> >> + =A0 =A0 if (tdmac->status !=3D DMA_SUCCESS)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 return NULL;
>> >> +
>> >> + =A0 =A0 if (period_len > TDMA_MAX_XFER_BYTES) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 dev_err(tdmac->dev,
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 "maximum pe=
riod size exceeded: %d > %d\n",
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 period_len,=
 TDMA_MAX_XFER_BYTES);
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_out;
>> >> + =A0 =A0 }
>> >> +
>> >> + =A0 =A0 tdmac->status =3D DMA_IN_PROGRESS;
>> > ???
>> >> + =A0 =A0 tdmac->desc_num =3D num_periods;
>> >> + =A0 =A0 ret =3D mmp_tdma_alloc_descriptor(tdmac);
>> >> + =A0 =A0 if (ret < 0)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 goto err_out;
>> >> +
>> >> + =A0 =A0 while (buf < buf_len) {
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 struct mmp_tdma_desc *desc =3D &tdmac->desc=
_arr[i];
>> > what if i call prepare twice on the same channel?
>>
>> We use =A0tdmac->status to prevent calling again during transfering
>> except the resource is freed.
>> Usually once cyclic dma is build, only data comming and out, without
>> rebuild dma chain.
>> Here dma chain is simple, does not support asyn mode.
>>
>> > Better way would to manage a descriptor list, see other drivers for
>> > examples.
>> >> +
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 if (i + 1 =3D=3D num_periods)
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc->nxt_desc =3D tdmac->d=
esc_arr_phys;
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 else
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 desc->nxt_desc =3D tdmac->d=
esc_arr_phys +
>> >> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 sizeof(*des=
c) * (i + 1);
>> > pls use kernel link list, it is provided to you so that you dont have =
to
>> > do above.
>>
>> We have limitation for hardware.
>> SRAM has to be used for both dma buffer and dma descriptor.
>> While SRAM is very very limited on some platform,
>> as a result link node may not able to be allocated.
>> So we simply organize descriptor physically one by one.
> You can embed your h/w descriptor in your list structure, managing them
> becomes easy.

Thanks Vinod.

Our plan is keep this audio dma driver as simple as possible
Only support cyclic & sync mode,
And dma descriptor chain only build once, have no chance to re-organize.
Then cyclic dma keep running and consuming/generating data.
SRAM have to be used, which is limited, but SRAM can work at low power mode.
So maybe it is easier to organize statically.

We still have peripheral dma working on ddr, with different register
and free usage.
It support async mode and have to use pending list, etc.

>>
>>
>> >> +
>> >> +static void mmp_tdma_issue_pending(struct dma_chan *chan)
>> >> +{
>> >> + =A0 =A0 struct mmp_tdma_chan *tdmac =3D to_mmp_tdma_chan(chan);
>> >> +
>> >> + =A0 =A0 mmp_tdma_enable_chan(tdmac);
>> > can you queue the descriptors here? That was purpose to have separate
>> > issue pending and submit.
>>
>> Since the SRAM is limited, I am afraid it can not allocate memory for qu=
eue.
>> And to make it simple, we just arrange descriptor one by one.
>>
>>
>> >> +
>> >> +module_platform_driver(mmp_tdma_driver);
>> >> +
>> >> +MODULE_DESCRIPTION("MMP Two-Channel DMA Driver");
>> >> +MODULE_LICENSE("GPL");
>> > AUTHOR, ALIAS too pls
>> Thanks, got it.
>>
>> >
>> >> diff --git a/include/linux/platform_data/mmp_dma.h b/include/linux/pl=
atform_data/mmp_dma.h
>> >> new file mode 100644
>> >> index 0000000..4e21cf9
>> >> --- /dev/null
>> >> +++ b/include/linux/platform_data/mmp_dma.h
>> >> @@ -0,0 +1,20 @@
>> >> +/*
>> >> + * =A0MMP Platform DMA Management
>> >> + *
>> >> + * =A0Copyright (c) 2011 Marvell Semiconductors Inc.
>> >> + *
>> >> + * =A0This program is free software; you can redistribute it and/or =
modify
>> >> + * =A0it under the terms of the GNU General Public License version 2=
 as
>> >> + * =A0published by the Free Software Foundation.
>> >> + *
>> >> + */
>> >> +
>> >> +#ifndef MMP_DMA_H
>> >> +#define MMP_DMA_H
>> >> +
>> >> +struct mmp_tdma_data {
>> >> + =A0 =A0 u32 bus_size;
>> >> + =A0 =A0 u32 pack_mod;
>> >> +};
>> >> +
>> >> +#endif /* MMP_DMA_H */
>> > why do you need separate header for this?
>>
>> The structure is sharing private config between dma driver and pcm
>> driver under sound.
>> The header file will be expanded for other dma driver.
> Other?
>
> --
> ~Vinod
>
