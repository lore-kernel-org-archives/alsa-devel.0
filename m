From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: fsl_ssi.c: Roberto's problem: ssi hangs after some
 number of samples
Date: Mon, 2 Nov 2015 18:51:04 +0100
Message-ID: <5637A288.4080807@tekno-soft.it>
References: <CAG5mAdxYEL22o=9AKQefb-vkf8KATEojH0qgPWzfAim+5fm5vQ@mail.gmail.com>
 <5634870A.4080206@tekno-soft.it>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.tekno-soft.it (li153-180.members.linode.com
 [109.74.206.180])
 by alsa0.perex.cz (Postfix) with ESMTP id D89252619D8
 for <alsa-devel@alsa-project.org>; Mon,  2 Nov 2015 18:51:24 +0100 (CET)
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
To: Caleb Crome <caleb@crome.org>
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shengjiu Wang <shengjiu.wang@freescale.com>, Nicolin Chen <nicoleotsuka@gmail.com>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Markus Pargmann <mpa@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>, Fabio Estevam <festevam@gmail.com>
List-Id: alsa-devel@alsa-project.org

On 10/31/2015 10:16 AM, Roberto Fichera wrote:
> And here's Nicolin's reply: On Fri, Oct 30, 2015 at 12:42:53PM +0100, Roberto Fichera wrote:
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
>>> At this time I should see the DMA callbacks called every burst_size words. This behaviour
>>> doesn't really happen as I wish because I can see from a proc file that such callbacks
>>> are called from 1 to 20000 times and then anymore. This is also confirmed by the fact that
>>> the interrupt 34 (sdma) doesn't increase anymore but matches my internal counters collected
>>> within my callbacks. Here is what I can inspect from the data I have collected:
>> Just for clarification, the behaviour doesn't happen as you wish
>> is just the DMA stopped? I remember you also mentioned bit clock
>> has stopped as you can check the clock status from the Codec chip.
> Sorry, maybe I've used a wrong sentence.
> All clocks to SLIC are currently ok, checked with a logical analyser and
> both are working as expected.
>
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

Below there is both SSI and SDMA status as soon as SDMA stops operating, I've also moved all
code to kernel v4.3 just published this morning:

root@voneus-domus-imx6sx:~# cat /proc/domus_ssi_stats
SSI TDM Info:
        PLL clk=66000000
        SSI baudclk=49152000
        ssi_phy=0x02028000
        irq=21
        fifo_depth=8
        tdm_frame_rate=8000
        tdm_slots=32 (real 2)
        tdm_word_size=8
        tdm_slots_enabled=00000000000000000000000000000011
        clk_frequency=2048000
        clock_running=yes
        DMA=yes
        Dual FIFO=no
        RX DMA frame count=33758
        RX DMA addr=0x9edad000
        RX DMA buffer len=16
        TX DMA frame count=33758
        TX DMA addr=0x9ed7f000
        TX DMA buffer len=16

SSI Registers:
        ssi_scr=0x0000009f
        ssi_sier=0x00500004
        ssi_stcr=0x000002e8
        ssi_srcr=0x00000288
        ssi_stccr=0x00007f0b
        ssi_srccr=0x00007f0b
        ssi_sfcsr=0x0088f088
        ssi_stmsk=0xfffffffc
        ssi_srmsk=0xfffffffc

SSI SISR Register:
        rfrc=0
        tfrc=0
        cmdau=0
        cmddu=0
        rxt=0
        rdr1=0
        rdr0=0
        tde1=0
        tde0=0
        roe1=0
        roe0=0
        tue1=0
        tue0=0
        tfs=0
        rfs=0
        tls=0
        rls=0
        rff1=0
        rff0=0
        tfe1=0
        tfe0=0

SDMA RX channel:
SDMA channel 4 status
        SDMA_H_STATSTOP=0x00000000
        SDMA_H_START=0x00000000
        SDMA_H_EVTOVR=0x00000001
        SDMA_H_EVTPEND=0x0000001a
        SDMA_H_EVTERR=0x00000018
        SDMA_H_DSPOVR=0xffffffff
        SDMA_H_HOSTOVR=0x00000000

SDMA TX channel:
SDMA channel 3 status
        SDMA_H_STATSTOP=0x00000000
        SDMA_H_START=0x00000000
        SDMA_H_EVTOVR=0x00000001
        SDMA_H_EVTPEND=0x0000001a
        SDMA_H_EVTERR=0x00000000
        SDMA_H_DSPOVR=0xffffffff
        SDMA_H_HOSTOVR=0x00000000


>
>> Overall, I don't see an obvious defect from you SSI side, but you
>> may also try to toggle TDMAE and RDMAE at the point that callback
>> stops -- re-raise the DMA requests by disabling and enabling TDMAE
>> and RDMAE again and see if it works. I think either something did
>> intervene register controls of SDMA or SSI, 
> I will try this one.

I will go over this tomorrow morning.

>
>> or SDMA have missed the request signals from SSI.
> This is my current thought. However since the SSI is not operating at so
> high
> rate and the Cabel's problem seems going to a solution then I think
> there is something
> else I'm missing.
>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@alsa-project.org
>> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
