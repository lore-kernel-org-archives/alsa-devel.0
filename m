From: Caleb Crome <caleb@crome.org>
Subject: Re: [PATCH 0/5] ASoC: fsl_ssi: Fixing various channel
 slips and bad samples insertions
Date: Thu, 14 Jan 2016 06:25:56 -0800
Message-ID: <CAG5mAdwaY=GqQj10-13ZZNqE_qvZB=LjboXLqpNTesGVV3k4Pw@mail.gmail.com>
References: <1448546842-4584-1-git-send-email-arnaud.mouiche@invoxia.com>
 <CAG5mAdw_+BiDppzpKF0ZBG1NXreGob6+jZd6SLjS1+zdmEE4ZA@mail.gmail.com>
 <5690E8CF.8070700@invoxia.com>
 <CAG5mAdw3HKwyMyX9O2NM=GRDy9nEcOH6FrB1BSYMFhM-kL-BZw@mail.gmail.com>
 <56966324.8090409@invoxia.com>
 <CAG5mAdytoCqchFAh2J1t-oXZbwzxVs2U8amP=EfX1AEZSCtfQg@mail.gmail.com>
 <CAG5mAdzgAHPcqp5o12m+Ba5d69qx3ocWaa5s=ns5A60BWfcm7g@mail.gmail.com>
 <56975F0C.3080906@invoxia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f193.google.com (mail-io0-f193.google.com
 [209.85.223.193])
 by alsa0.perex.cz (Postfix) with ESMTP id C31DD260524
 for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2016 15:26:17 +0100 (CET)
Received: by mail-io0-f193.google.com with SMTP id q21so33163146iod.3
 for <alsa-devel@alsa-project.org>; Thu, 14 Jan 2016 06:26:17 -0800 (PST)
In-Reply-To: <56975F0C.3080906@invoxia.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lgirdwood@gmail.com>, Markus Pargmann <mpa@pengutronix.de>, Mark Brown <broonie@kernel.org>, Roberto Fichera <kernel@tekno-soft.it>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Jan 14, 2016 at 12:40 AM, arnaud.mouiche@invoxia.com
<arnaud.mouiche@invoxia.com> wrote:
>
> [..]
>>
>>
>> SUCCESS!  So far...
>
> Great :)
>
> I'm preparing a v3 of my patches including the SOR register + rebased on top
> of v4.4.
> I will let you propose the water mark / maxburst patch.
> But it looks obvious to me that triggering the DMA when only 2 words are
> left in the FIFO can lead to DMA xruns at such data rate.
>
> The downside is an increased number of DMA requests.
> So I don't know if you should propose a configuration through the device
> tree, or a static configuration as done in your patch.
>

Sounds to me like the device tree is the right place for it. I'll submit an RFC.

For some reason... looks like it can't yet quite keep up at 48kHz.  it
was working reliably for a while, but now I can only get it reliable
at 32kHz.  It seems it's the TX that's broken at 48k.

I'll dig in to see where the failure is.

-C

> Arnaud
>
>>
>> With your patches (including the latest SOR register update), plus
>> setting the watermark & DMA MAXBURST to 8, I don't get any more errors
>> at 48kHz ...  yet.
>>
>> Even in single fifo mode, 48kHz, 16-bits+16channels seems to work now.
>>
>> I'll keep you updated on if this really solves all the issues.
>> Here's the last patch for updating the watermark.
>>
>> commit b634014b831b9527df319b404ac50e54a3790742
>> Author: Caleb Crome <caleb@crome.org>
>> Date:   Wed Jan 13 13:12:37 2016 -0800
>>
>>      ASoC: fsl_ssi: Increase watermark and maxburst to allow SSI to work
>>      without slips at high data rates.
>>
>>      The DMA cannot keep up with the SSI consumpation with the watermark
>>      set to be fifo_depth-2 when running at 48kHz/16-bits/16-channels
>>      (12288 words/second).  By increasing the watermark to 8, the DMA can
>>      keep up with the SSI.
>>
>>      Signed-off-by: Caleb Crome <caleb@crome.org>
>>
>> diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
>> index 5cfc540..026df79 100644
>> --- a/sound/soc/fsl/fsl_ssi.c
>> +++ b/sound/soc/fsl/fsl_ssi.c
>> @@ -221,6 +221,12 @@ struct fsl_ssi_soc_data {
>>    * @dbg_stats: Debugging statistics
>>    *
>>    * @soc: SoC specific data
>> + *
>> + * @fifo_watermark: the FIFO watermark setting.  Notifies DMA when
>> + *             there are @fifo_watermark or fewer words in TX fifo or
>> + *             @fifo_watermark or more empty words in RX fifo.
>> + * @dma_maxburst: max number of words to transfer in one go.  So far,
>> + *             this is always the same as fifo_watermark.
>>    */
>>   struct fsl_ssi_private {
>>       struct regmap *regs;
>> @@ -259,6 +265,9 @@ struct fsl_ssi_private {
>>
>>       const struct fsl_ssi_soc_data *soc;
>>       struct device *dev;
>> +
>> +    u32 fifo_watermark;
>> +    u32 dma_maxburst;
>>   };
>>
>>   /*
>> @@ -1037,21 +1046,7 @@ static int _fsl_ssi_set_dai_fmt(struct device *dev,
>>       regmap_write(regs, CCSR_SSI_SRCR, srcr);
>>       regmap_write(regs, CCSR_SSI_SCR, scr);
>>
>> -    /*
>> -     * Set the watermark for transmit FIFI 0 and receive FIFO 0. We don't
>> -     * use FIFO 1. We program the transmit water to signal a DMA transfer
>> -     * if there are only two (or fewer) elements left in the FIFO. Two
>> -     * elements equals one frame (left channel, right channel). This
>> value,
>> -     * however, depends on the depth of the transmit buffer.
>> -     *
>> -     * We set the watermark on the same level as the DMA burstsize.  For
>> -     * fiq it is probably better to use the biggest possible watermark
>> -     * size.
>> -     */
>> -    if (ssi_private->use_dma)
>> -        wm = ssi_private->fifo_depth - 2;
>> -    else
>> -        wm = ssi_private->fifo_depth;
>> +    wm = ssi_private->watermark;
>>
>>       regmap_write(regs, CCSR_SSI_SFCSR,
>>               CCSR_SSI_SFCSR_TFWM0(wm) | CCSR_SSI_SFCSR_RFWM0(wm) |
>> @@ -1359,12 +1354,8 @@ static int fsl_ssi_imx_probe(struct
>> platform_device *pdev,
>>           dev_dbg(&pdev->dev, "could not get baud clock: %ld\n",
>>                PTR_ERR(ssi_private->baudclk));
>>
>> -    /*
>> -     * We have burstsize be "fifo_depth - 2" to match the SSI
>> -     * watermark setting in fsl_ssi_startup().
>> -     */
>> -    ssi_private->dma_params_tx.maxburst = ssi_private->fifo_depth - 2;
>> -    ssi_private->dma_params_rx.maxburst = ssi_private->fifo_depth - 2;
>> +    ssi_private->dma_params_tx.maxburst = ssi_private->dma_maxburst;
>> +    ssi_private->dma_params_rx.maxburst = ssi_private->dma_maxburst;
>>       ssi_private->dma_params_tx.addr = ssi_private->ssi_phys +
>> CCSR_SSI_STX0;
>>       ssi_private->dma_params_rx.addr = ssi_private->ssi_phys +
>> CCSR_SSI_SRX0;
>>
>> @@ -1518,6 +1509,42 @@ static int fsl_ssi_probe(struct platform_device
>> *pdev)
>>                   /* Older 8610 DTs didn't have the fifo-depth property */
>>           ssi_private->fifo_depth = 8;
>>
>> +    /*
>> +     * Set the watermark for transmit FIFI 0 and receive FIFO 0. We don't
>> +     * use FIFO 1. We program the transmit water to signal a DMA transfer
>> +     * if there are only two (or fewer) elements left in the FIFO. Two
>> +     * elements equals one frame (left channel, right channel). This
>> value,
>> +     * however, depends on the depth of the transmit buffer.
>> +     *
>> +     * We set the watermark on the same level as the DMA burstsize.  For
>> +     * fiq it is probably better to use the biggest possible watermark
>> +     * size.
>> +     */
>> +    switch (ssi_private->fifo_depth) {
>> +    case 15:
>> +        /*
>> +         * 2 samples is not enough when running at high data
>> +         * rates (like 48kHz @ 16 bits/channel, 16 channels)
>> +         * 8 seems to split things evenly and leave enough time
>> +         * for the DMA to fill the FIFO before it's over/under
>> +         * run.
>> +         */
>> +        ssi_private->fifo_watermark = 8;
>> +        ssi_private->dma_maxburst = 8;
>> +    case 8:
>> +    default:
>> +        /*
>> +         * maintain old behavior for older chips.
>> +         * Keeping it the same because I don't have an older
>> +         * board to test with.
>> +         * I suspect this could be changed to be something to
>> +         * leave some more space in the fifo.
>> +         */
>> +        ssi_private->fifo_watermark = ssi_private->fifo_depth - 2;
>> +        ssi_private->dma_maxburst = ssi_private->fifo_depth - 2;
>> +        break;
>> +    }
>> +
>>       dev_set_drvdata(&pdev->dev, ssi_private);
>>
>>       if (ssi_private->soc->imx) {
>
>
