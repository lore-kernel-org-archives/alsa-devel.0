From: Caleb Crome <caleb@crome.org>
Subject: Re: fsl_ssi.c: Roberto's problem: ssi hangs after some
 number of samples
Date: Tue, 3 Nov 2015 13:26:22 -0800
Message-ID: <CAG5mAdwUMd5q3fKBv6_1Laag7vij19ZjeOcZzm-ZzLH0E6QjKA@mail.gmail.com>
References: <CAG5mAdxYEL22o=9AKQefb-vkf8KATEojH0qgPWzfAim+5fm5vQ@mail.gmail.com>
 <5634870A.4080206@tekno-soft.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wm0-f48.google.com (mail-wm0-f48.google.com [74.125.82.48])
 by alsa0.perex.cz (Postfix) with ESMTP id 262372614C2
 for <alsa-devel@alsa-project.org>; Tue,  3 Nov 2015 22:26:42 +0100 (CET)
Received: by wmeg8 with SMTP id g8so25991379wme.1
 for <alsa-devel@alsa-project.org>; Tue, 03 Nov 2015 13:26:41 -0800 (PST)
In-Reply-To: <5634870A.4080206@tekno-soft.it>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Roberto Fichera <kernel@tekno-soft.it>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shengjiu Wang <shengjiu.wang@freescale.com>, Nicolin Chen <nicoleotsuka@gmail.com>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Markus Pargmann <mpa@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Sat, Oct 31, 2015 at 2:16 AM, Roberto Fichera <kernel@tekno-soft.it> wrote:
> On 10/30/2015 07:01 PM, Caleb Crome wrote:
>> Hi All, is it okay of we split Roberto's problem from mine?  It's
>> getting difficult to track which response goes to which problem :-)
>>
>> I included Roberto's email, and Nicolin's reply below:
>>
>> So, this thread is for the hanging problem, the prehistory for this
>> thread is in, "fsl_ssi.c: Getting channel slips with fsl_ssi.c in TDM
>> (network) mode."
>
> That's fine! Thanks Calab!
>
>>
>> -Caleb
>>
>> On Fri, Oct 30, 2015 at 4:42 AM, Roberto Fichera <kernel@tekno-soft.it> wrote:
>>> On 10/30/2015 12:04 AM, Nicolin Chen wrote:
>>>> On Wed, Oct 28, 2015 at 09:11:39AM +0100, Roberto Fichera wrote:
>>>>
>>>>> I'm also having the same issue but employing SSI in TDM master mode against a SLIC Si32178
>>>>> using its PCM mode. PCLK is at 2048KHz, FSYNC is 8KHz slot length is 32 bits (SSI wants
>>>>> this since when in master mode) but valid data set to be 8bits in the SSI register.
>>>>> My Current situation is that I've a custom fsl_ssi.c driver to control the SSI in TDM master mode
>>>>> both PCLK and FSYNC works perfectly fine, the SLIC has a register that I can check via SPI for
>>>>> such purpose, I can see the clocking status from its side. The main problem I've is exactly the same
>>>>> Caleb is having, after a certain amount of SDMA transfers, roughly 1000 or so, everything stops
>>>>> without any apparent reason.
>>>> I will start to help you to figure out your problem. But it seems that
>>>> you are having a different issue here with clock generation. I don't
>>>> get why you said *same issue*. For double confirm, the the "everything
>>>> stops" mentioned, does it mean that clock from SSI stops?
>>>>
>>> Definitively yes! My problem is different than Caleb's one. Just to summarize the things.
>>> I've the SSI1 connected to a SiLabs SLIC Si32178 via AUDMUX6 padmux is below:
>>>
>>>         pinctrl_audmux_1: audmuxgrp-3 {
>>>             fsl,pins = <
>>>                 MX6SX_PAD_SD3_DATA1__AUDMUX_AUD6_TXC    0x130b0    /* PCLK */
>>>                 MX6SX_PAD_SD3_DATA2__AUDMUX_AUD6_TXFS   0x130b0    /* FSYNC */
>>>                 MX6SX_PAD_SD3_DATA0__AUDMUX_AUD6_RXD    0x130b0    /* DTX */
>>>                 MX6SX_PAD_SD3_DATA3__AUDMUX_AUD6_TXD    0x120b0    /* DRX */
>>>             >;
>>>         };
>>>
>>> The Si32178 is slave device so the SSI1 has to generate both BCLK and FSYNC. I've configured
>>> the AUDMUX as:
>>>
>>> int si3217x_audmux_config(unsigned int master, unsigned int slave)
>>> {
>>>   unsigned int ptcr, pdcr;
>>>
>>>   ptcr = IMX_AUDMUX_V2_PTCR_SYN |
>>>          IMX_AUDMUX_V2_PTCR_TFSDIR |
>>>          IMX_AUDMUX_V2_PTCR_TFSEL(master) |
>>>          IMX_AUDMUX_V2_PTCR_TCLKDIR |
>>>          IMX_AUDMUX_V2_PTCR_TCSEL(master);
>>>   pdcr = IMX_AUDMUX_V2_PDCR_RXDSEL(master);
>>>   si3217x_audmux_v2_configure_port(slave, ptcr, pdcr); /* configure internal port */
>>>
>>>   ptcr = IMX_AUDMUX_V2_PTCR_SYN;
>>>   pdcr = IMX_AUDMUX_V2_PDCR_RXDSEL(slave);
>>>   si3217x_audmux_v2_configure_port(master, ptcr, pdcr); /* configure external port */
>>>
>>>   return 0;
>>> }
>>>
>>> BCLK is 2048KHz, FSYNC@8KHz, frame is 32 slots at 8bits each. Looking at TXC and TXFS
>>> with a logical analyzer everything looks ok.
>>>
>>> The SSI is setup at beginning as:
>>>
>>>         unsigned long flags;
>>>         struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
>>>         u32 srcr;
>>>         u8 wm;
>>>
>>>         clk_prepare_enable(ssi_private->clk);
>>>
>>>         /*
>>>          * Section 16.5 of the MPC8610 reference manual says that the
>>>          * SSI needs to be disabled before updating the registers we set
>>>          * here.
>>>          */
>>>         write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_SSIEN, 0);
>>>
>>>         /*
>>>          * Program the SSI into I2S Master Network Synchronous mode.
>>>          * Also enable the transmit and receive FIFO.
>>>          */
>>>         write_ssi_mask(&ssi->scr,
>>>             CCSR_SSI_SCR_I2S_MODE_MASK | CCSR_SSI_SCR_SYN,
>>>             CCSR_SSI_SCR_I2S_MODE_NORMAL
>>>             | CCSR_SSI_SCR_SYN | CCSR_SSI_SCR_NET
>>>             | CCSR_SSI_SCR_SYS_CLK_EN);
>>>
>>>         /*
>>>          * TX falling edge PCLK is mandatory because the RX SLIC side works in this way
>>>          */
>>>         writel( CCSR_SSI_STCR_TXBIT0 /* LSB Aligned */
>>>               | CCSR_SSI_STCR_TFEN0  /* Enable TX FIFO0 */
>>>               | CCSR_SSI_STCR_TSCKP  /* Transmit Clock Polarity - Data Clocked out on falling edge */
>>>               | CCSR_SSI_STCR_TFDIR  /* Transmit Frame Direction Internal - generated internally */
>>>               | CCSR_SSI_STCR_TXDIR, /* Transmit Clock Direction Internal - generated internally */
>>>             &ssi->stcr);
>>>
>>>     srcr = readl(&ssi->srcr);
>>>
>>>         /*
>>>          * clear out RFDIR and RXDIR because the clock is synchronous
>>>          */
>>>     srcr &= ~(CCSR_SSI_SRCR_RFDIR | CCSR_SSI_SRCR_RXDIR);
>>>
>>>         srcr |= CCSR_SSI_SRCR_RXBIT0 /* LSB Aligned */
>>>              |  CCSR_SSI_SRCR_RFEN0  /* Enable RX FIFO0 */
>>>              |  CCSR_SSI_SRCR_RSCKP  /* Receive Clock Polarity - Data latched on rising edge */
>>>             ;
>>>
>>>     writel(srcr, &ssi->srcr);
>>>
>>>         /* do not service the isr yet */
>>>         writel(0, &ssi->sier);
>>>
>>>         /*
>>>          * Set the watermark for transmit FIFI 0 and receive FIFO 0. We
>>>          * don't use FIFO 1.  We program the transmit water to signal a
>>>          * DMA transfer if there are only two (or fewer) elements left
>>>          * in the FIFO.
>>>          */
>>>
>>>        /*
>>>         * tdm_real_slots is 2 because mask all except first 2 slots
>>>         * our buffer is 2 slots * 8 bytes each, so set watermarks to a multiple of it
>>>         * 8 words in our case
>>>         */
>>>
>>>         wm = ssi_private->tdm_real_slots * 4; //ssi_private->use_dma ? ssi_private->fifo_depth - 2 :
>>> ssi_private->fifo_depth;
>>>
>>>         writel(CCSR_SSI_SFCSR_TFWM0(wm) |
>>>                CCSR_SSI_SFCSR_RFWM0(wm) |
>>>                CCSR_SSI_SFCSR_TFWM1(wm) |
>>>                CCSR_SSI_SFCSR_RFWM1(wm),
>>>                &ssi->sfcsr);
>>>
>>>         /* enable one FIFO */
>>>         write_ssi_mask(&ssi->srcr, CCSR_SSI_SRCR_RFEN1, 0);
>>>         write_ssi_mask(&ssi->stcr, CCSR_SSI_STCR_TFEN1, 0);
>>>
>>>         /* disable SSI two-channel mode operation */
>>>         write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_TCH_EN, 0);
>>>
>>>         /*
>>>          * We keep the SSI disabled because if we enable it, then the
>>>          * DMA controller will start.  It's not supposed to start until
>>>          * the SCR.TE (or SCR.RE) bit is set, but it does anyway.  The
>>>          * DMA controller will transfer one "BWC" of data (i.e. the
>>>          * amount of data that the MR.BWC bits are set to).  The reason
>>>          * this is bad is because at this point, the PCM driver has not
>>>          * finished initializing the DMA controller.
>>>          */
>>>
>>>         /* Set default slot number -- 32 in our case */
>>>         write_ssi_mask(&ssi->stccr, CCSR_SSI_SxCCR_DC_MASK,
>>>             CCSR_SSI_SxCCR_DC(ssi_private->tdm_slots));
>>>         write_ssi_mask(&ssi->srccr, CCSR_SSI_SxCCR_DC_MASK,
>>>             CCSR_SSI_SxCCR_DC(ssi_private->tdm_slots));
>>>
>>>         /* Set default word length -- 8 bits */
>>>         write_ssi_mask(&ssi->stccr, CCSR_SSI_SxCCR_WL_MASK,
>>>             CCSR_SSI_SxCCR_WL(ssi_private->tdm_word_size));
>>>         write_ssi_mask(&ssi->srccr, CCSR_SSI_SxCCR_WL_MASK,
>>>             CCSR_SSI_SxCCR_WL(ssi_private->tdm_word_size));
>>>
>>>         /* enable the SSI */
>>>         write_ssi_mask(&ssi->scr, CCSR_SSI_SCR_SSIEN, CCSR_SSI_SCR_SSIEN);
>>>
>>>         /*
>>>          * we are interested only at first 2 slots
>>>          */
>>>         writel(~ssi_private->tdm_slots_enabled, &ssi->stmsk);
>>>         writel(~ssi_private->tdm_slots_enabled, &ssi->srmsk);
>>>
>>>        return 0;
>>> }
>>>
>>> SSI clock calculated and then enabled. Both TX and RX DMA channel are requested in the probe() function as below.
>>> and the corresponding TX and RX SDMA event in DTS are using the default from imx6sx.dtsi:
>>>
>>>             slave_config.direction = DMA_MEM_TO_DEV;
>>>             slave_config.dst_addr = ssi_private->ssi_phys + offsetof(struct ccsr_ssi, stx0);
>>>             slave_config.dst_addr_width = width;
>>>             slave_config.dst_maxburst = ssi_private->tdm_real_slots * 4;
>>>             ret = dmaengine_slave_config(ssi_private->tx_chan, &slave_config);
>>>
>>>             ssi_private->rx_chan = dma_request_slave_channel_reason(&pdev->dev, "rx");
>>>             slave_config.direction = DMA_DEV_TO_MEM;
>>>             slave_config.src_addr = ssi_private->ssi_phys + offsetof(struct ccsr_ssi, srx0);
>>>             slave_config.src_addr_width = width;
>>>             slave_config.src_maxburst = ssi_private->tdm_real_slots * 4;
>>>             ret = dmaengine_slave_config(ssi_private->rx_chan, &slave_config);
>>>
>>> and setup before RDMAE and TDMAE bits, like this:
>>>
>>>         ssi_private->tx_buf = dma_alloc_coherent(NULL, buffer_len,
>>>                                         &ssi_private->tx_dmaaddr, GFP_KERNEL);
>>>         desc = dmaengine_prep_dma_cyclic(ssi_private->tx_chan, ssi_private->tx_dmaaddr,
>>>                 buffer_len, ssi_private->tdm_real_slots*4,
>>>                 DMA_MEM_TO_DEV, DMA_PREP_INTERRUPT);
>>>
>>>         desc->callback = dma_tx_callback;
>>>         desc->callback_param = ssi_private;
>>>
>>>         printk("TX: prepare for the DMA.\n");
>>>         dmaengine_submit(desc);
>>>         dma_async_issue_pending(ssi_private->tx_chan);
>>>
>>>         ssi_private->rx_buf = dma_alloc_coherent(NULL, buffer_len,
>>>                                         &ssi_private->rx_dmaaddr, GFP_KERNEL);
>>>
>>>         desc = dmaengine_prep_dma_cyclic(ssi_private->rx_chan, ssi_private->rx_dmaaddr,
>>>                 buffer_len, ssi_private->tdm_real_slots*4,
>>>                 DMA_DEV_TO_MEM, DMA_PREP_INTERRUPT);
>>>
>>>         desc->callback = dma_rx_callback;
>>>         desc->callback_param = ssi_private;
>>>
>>>         printk("RX: prepare for the DMA.\n");
>>>         dmaengine_submit(desc);
>>>         dma_async_issue_pending(ssi_private->rx_chan);
>>>
>>> Finally, the SSI's TX and RX parts are now enabled
>>>
>>>     scr = readl(&ssi->scr);
>>>
>>>     scr |= CCSR_SSI_SCR_TE | CCSR_SSI_SCR_RE;   /* enable both TX and RX SSI sections */
>>>
>>>     writel(scr, &ssi->scr);
>>>
>>> Finally the SIER si programmed as:
>>>
>>>    struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
>>>     u32 sier = CCSR_SSI_SIER_RFF0_EN | CCSR_SSI_SIER_TFE0_EN;
>>>
>>>     /*
>>>      * if DMA is enabled than allow SSI request for DMA transfers
>>>      * otherwise normal interrupt requests
>>>      */
>>>
>>>     if (ssi_private->use_dma>0)
>>>     {
>>>       sier |= CCSR_SSI_SIER_RDMAE | CCSR_SSI_SIER_TDMAE;
>>>     }
>>>
>>>     if (ssi_private->use_dma>1 || !ssi_private->use_dma)
>>>     {
>>>       sier |= CCSR_SSI_SIER_RIE | CCSR_SSI_SIER_TIE;
>>>     }
>>>
>>>     sier &= ~(CCSR_SSI_SIER_TDE1_EN | CCSR_SSI_SIER_TFE1_EN |
>>>               CCSR_SSI_SIER_TFE0_EN | CCSR_SSI_SIER_TDE0_EN);
>>>
>>>     writel(sier, &ssi->sier);
>>>
>>> At this time I should see the DMA callbacks called every burst_size words. This behaviour
>>> doesn't really happen as I wish because I can see from a proc file that such callbacks
>>> are called from 1 to 20000 times and then anymore. This is also confirmed by the fact that
>>> the interrupt 34 (sdma) doesn't increase anymore but matches my internal counters collected
>>> within my callbacks. Here is what I can inspect from the data I have collected:
>>>
>>> root@voneus-domus-imx6sx:~# cat /proc/domus_ssi_stats
>>> SSI TDM Info:
>>>         PLL clk=66000000
>>>         SSI baudclk=49152000
>>>         ssi_phy=0x02028000
>>>         irq=78
>>>         fifo_depth=15 <---- this is what is read from DTS but not as watermark
>>>         tdm_frame_rate=8000
>>>         tdm_slots=32 (real 2)
>>>         tdm_word_size=8
>>>         tdm_slots_enabled=00000000000000000000000000000011
>>>         clk_frequency=2048000
>>>         clock_running=yes
>>>         DMA=yes
>>>         Dual FIFO=no
>>>         RX DMA frame count=17121
>>>         RX DMA addr=0x9c692000
>>>         RX DMA buffer len=16
>>>         TX DMA frame count=17121
>>>         TX DMA addr=0x9c4aa000
>>>         TX DMA buffer len=16
>>>
>>> SSI Registers:
>>>         ssi_scr=0x0000009f
>>>         ssi_sier=0x00500004
>>>         ssi_stcr=0x000002e8
>>>         ssi_srcr=0x00000288
>>>         ssi_stccr=0x00007f0b
>>>         ssi_srccr=0x00007f0b
>>>         ssi_sfcsr=0x0088f088
>>>         ssi_stmsk=0xfffffffc
>>>         ssi_srmsk=0xfffffffc
>>>
>>> Cheers,
>>> Roberto Fichera.
>>
>>
>> And here's Nicolin's reply:
>>
>> On Fri, Oct 30, 2015 at 12:42:53PM +0100, Roberto Fichera wrote:
>>
>>
>>>         /*
>>>          * Set the watermark for transmit FIFI 0 and receive FIFO 0. We
>>>          * don't use FIFO 1.  We program the transmit water to signal a
>>>          * DMA transfer if there are only two (or fewer) elements left
>>>          * in the FIFO.
>>>          */
>>> SSI clock calculated and then enabled. Both TX and RX DMA channel are requested in the probe() function as below.
>>> and the corresponding TX and RX SDMA event in DTS are using the default from imx6sx.dtsi:
>> Since you are using single FIFO configuration, which SDMA script
>> are you using? This should reflects in the Device Tree. As far as
>> I learned, FSL 3.14 is using number 22 for SSIs which is the one
>> for Dual FIFO Mode.
>
> No! Currently is 1. Here the Freescale's v3.14.28 GA imx6sx.dtsi entry
>
>                 ssi1: ssi@02028000 {
>                     compatible = "fsl,imx6sx-ssi", "fsl,imx21-ssi";
>                     reg = <0x02028000 0x4000>;
>                     interrupts = <GIC_SPI 46 IRQ_TYPE_LEVEL_HIGH>;
>                     clocks = <&clks IMX6SX_CLK_SSI1_IPG>,
>                          <&clks IMX6SX_CLK_SSI1>;
>                     clock-names = "ipg", "baud";
>                     dmas = <&sdma 37 1 0>, <&sdma 38 1 0>;
>                     dma-names = "rx", "tx";
>                     status = "disabled";
>                 };
>
>>
>>> At this time I should see the DMA callbacks called every burst_size words. This behaviour
>>> doesn't really happen as I wish because I can see from a proc file that such callbacks
>>> are called from 1 to 20000 times and then anymore. This is also confirmed by the fact that
>>> the interrupt 34 (sdma) doesn't increase anymore but matches my internal counters collected
>>> within my callbacks. Here is what I can inspect from the data I have collected:
>> Just for clarification, the behaviour doesn't happen as you wish
>> is just the DMA stopped? I remember you also mentioned bit clock
>> has stopped as you can check the clock status from the Codec chip.
>
> Sorry, maybe I've used a wrong sentence.
> All clocks to SLIC are currently ok, checked with a logical analyser and
> both are working as expected.
>
>>
>>> SSI Registers:
>>>         ssi_sfcsr=0x0088f088
>> At this point you have data in RxFIFO and get empty in TxFIFO, so
>> the DMA requests from both side should be issued. If the DMA stops
>> as you described, you must check those two channels from the SDMA
>> side by dumping SDMAARM_STOP_STAT, SDMAARM_HSTART, SDMAARM_EVTOVR,
>> SDMAARM_EVTPEND, SDMAARM_EVTERR, SDMAARM_DSPOVR and SDMAARM_HOSTOVR
>> registers.
> Ok! I will do! Should I do within the SDMA isr or do you prefer another
> place?
>
>> Overall, I don't see an obvious defect from you SSI side, but you
>> may also try to toggle TDMAE and RDMAE at the point that callback
>> stops -- re-raise the DMA requests by disabling and enabling TDMAE
>> and RDMAE again and see if it works. I think either something did
>> intervene register controls of SDMA or SSI,
>
> I will try this one.
>
>> or SDMA have missed the request signals from SSI.
>
> This is my current thought. However since the SSI is not operating at so
> high
> rate and the Cabel's problem seems going to a solution then I think
> there is something
> else I'm missing.

Is it possible that the event type below in the reference manual
section 55.10.5 is happening?  It looks like the SDMA script is
supposed to deal with it.  Perhaps there's a bug in the script?

55.10.5 External DMA Requests Mirror (SDMACORE_EVENTS)
NOTE
This register is very useful in the case of DMA requests that are
active when a peripheral FIFO level is above the programmed
watermark. The activation of the DMA request (rising edge) is
detected by the SDMA logic and it can enable one or several
channels. One of the channels accesses the peripheral and reads
or writes a number of data that matches the watermark level
(for example, if the watermark is four words, the channel reads
or writes four words).
If the channel is effectively executed long after the DMA
request was received, reading or writing the watermark number
of data may not be sufficient to reset the DMA request (for
example, if the FIFO watermark is four and at the channel
execution it already contains nine pieces of data). This means
no new rising edge may be detected by the SDMA, although
there still remains transfers to perform. Therefore, if the
channel were terminated at that time, it would not be restarted,
causing potential overrun or underrun of the peripheral.
The proposed mechanism is for the channel to check this
register after it has performed the "watermark" number of
accesses to the peripheral. If the bit for the DMA request that
triggers this channel is set, it means there is still another
watermark number of data to transfer. This goes on until the bit
is cleared. The same script can be used for multiple channels
that require this behavior. The script can determine its channel
number from the CCR register and infer the corresponding
DMA request bit to check. It needs a reference table that is
coherent with the request-channel matrix that the ARM
platform programmed.
