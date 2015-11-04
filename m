From: Roberto Fichera <kernel@tekno-soft.it>
Subject: Re: fsl_ssi.c: Roberto's problem: ssi hangs after some
 number of samples
Date: Wed, 4 Nov 2015 16:33:16 +0100
Message-ID: <563A253C.7080709@tekno-soft.it>
References: <CAG5mAdxYEL22o=9AKQefb-vkf8KATEojH0qgPWzfAim+5fm5vQ@mail.gmail.com>
 <5634870A.4080206@tekno-soft.it>
 <CAG5mAdwUMd5q3fKBv6_1Laag7vij19ZjeOcZzm-ZzLH0E6QjKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.tekno-soft.it (li153-180.members.linode.com
 [109.74.206.180])
 by alsa0.perex.cz (Postfix) with ESMTP id D9F8B260481
 for <alsa-devel@alsa-project.org>; Wed,  4 Nov 2015 16:33:36 +0100 (CET)
In-Reply-To: <CAG5mAdwUMd5q3fKBv6_1Laag7vij19ZjeOcZzm-ZzLH0E6QjKA@mail.gmail.com>
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

On 11/03/2015 10:26 PM, Caleb Crome wrote:
>>> or SDMA have missed the request signals from SSI.
>> This is my current thought. However since the SSI is not operating at so
>> high
>> rate and the Cabel's problem seems going to a solution then I think
>> there is something
>> else I'm missing.
> Is it possible that the event type below in the reference manual
> section 55.10.5 is happening?  It looks like the SDMA script is
> supposed to deal with it.  Perhaps there's a bug in the script?
>
> 55.10.5 External DMA Requests Mirror (SDMACORE_EVENTS)
> NOTE
> This register is very useful in the case of DMA requests that are
> active when a peripheral FIFO level is above the programmed
> watermark. The activation of the DMA request (rising edge) is
> detected by the SDMA logic and it can enable one or several
> channels. One of the channels accesses the peripheral and reads
> or writes a number of data that matches the watermark level
> (for example, if the watermark is four words, the channel reads
> or writes four words).
> If the channel is effectively executed long after the DMA
> request was received, reading or writing the watermark number
> of data may not be sufficient to reset the DMA request (for
> example, if the FIFO watermark is four and at the channel
> execution it already contains nine pieces of data). This means
> no new rising edge may be detected by the SDMA, although
> there still remains transfers to perform. Therefore, if the
> channel were terminated at that time, it would not be restarted,
> causing potential overrun or underrun of the peripheral.
> The proposed mechanism is for the channel to check this
> register after it has performed the "watermark" number of
> accesses to the peripheral. If the bit for the DMA request that
> triggers this channel is set, it means there is still another
> watermark number of data to transfer. This goes on until the bit
> is cleared. The same script can be used for multiple channels
> that require this behavior. The script can determine its channel
> number from the CCR register and infer the corresponding
> DMA request bit to check. It needs a reference table that is
> coherent with the request-channel matrix that the ARM
> platform programmed.
>

Maybe this is the cause! I've explored a bit what's going on with my DMA stall and
I've found that both RX and TX channels are getting an error, at least this is what
the EVTERR register is reporting. See the log below:

root@voneus-domus-imx6sx:~# cat /proc/domus_ssi_stats
SSI TDM Info:
        IPG clk=66000000
        SSI baudclk=8192000
        ssi_phy=0x02028000
        irq=21
        fifo_depth=10
        tdm_frame_rate=8000
        tdm_slots=32 (real 2)
        tdm_word_size=8
        tdm_slots_enabled=00000000000000000000000000000011
        clk_frequency=2048000
        clock_running=yes
        DMA=yes
        Dual FIFO=no
        *RX DMA frame count=36795*
        RX DMA addr=0x9ef0e000
        RX DMA buffer len=16
        *TX DMA frame count=36795*
        TX DMA addr=0x9ee49000
        TX DMA buffer len=16

SSI Registers:
        ssi_scr=0x0000109f
        ssi_sier=0x00500504
        ssi_stcr=0x000002e8
        ssi_srcr=0x00000288
        ssi_stccr=0x00007f01
        ssi_srccr=0x00007f01
        ssi_sfcsr=0x00aaf0aa
        ssi_stmsk=0xfffffffc
        ssi_srmsk=0xfffffffc

SDMA RX channel:
SDMA channel 4 status
        SDMA_H_STATSTOP=0x00000000
        SDMA_H_START=0x00000000
        SDMA_H_EVTOVR=0x00000001
        SDMA_H_EVTPEND=0x0000001a
        SDMA_H_EVTERR=0x00000000
        SDMA_H_DSPOVR=0xffffffff
        SDMA_H_HOSTOVR=0x00000000
        SDMA_H_INTR=0x00000000
        SDMA_H_INTRMSK=0x00000018
        SDMACORE_EVENTS=0x00000000
        SDMACORE_EVENTS2=0x00000000

SDMA EVTERR channel counters:
*        003 = 1**
**        004 = 1*

SDMA TX channel:
SDMA channel 3 status
        SDMA_H_STATSTOP=0x00000000
        SDMA_H_START=0x00000000
        SDMA_H_EVTOVR=0x00000001
        SDMA_H_EVTPEND=0x0000001a
        SDMA_H_EVTERR=0x00000000
        SDMA_H_DSPOVR=0xffffffff
        SDMA_H_HOSTOVR=0x00000000
        SDMA_H_INTR=0x00000000
        SDMA_H_INTRMSK=0x00000018
        SDMACORE_EVENTS=0x00000000
        SDMACORE_EVENTS2=0x00000000

SDMA EVTERR channel counters:
*        003 = 1**
**        004 = 1*

root@voneus-domus-imx6sx:~# cat /proc/interrupts
           CPU0
 16:      39485       GPC  55 Edge      i.MX Timer Tick
 20:       2310       GPC  26 Edge      2020000.serial
 21:          0       GPC  46 Edge      ssi-tdm
 39:          0  gpio-mxc  12 Edge      si3217x-irq
123:          0  gpio-mxc  28 Edge      2194000.usdhc cd
266:          0       GPC  49 Edge      imx_thermal
271:          0       GPC  19 Edge      rtc alarm
*277:      36800       GPC   2 Edge      sdma*
278:          0       GPC  43 Edge      2184000.usb
279:       2994       GPC  23 Edge      mmc0
280:        245       GPC  25 Edge      mmc1
283:          9       GPC 109 Edge      21e4000.qspi
284:          0       GPC  27 Edge      21e8000.serial
287:      50274       GPC  18 Edge      228c000.ecspi
IPI0:          0  CPU wakeup interrupts
IPI1:          0  Timer broadcast interrupts
IPI2:          0  Rescheduling interrupts
IPI3:          0  Function call interrupts
IPI4:          0  Single function call interrupts
IPI5:          0  CPU stop interrupts
IPI6:          1  IRQ work interrupts
IPI7:          0  completion interrupts
Err:          0

This is the relevant part of the dmesg

[  993.283774] dahdi: Version:
[  993.317161] dahdi: Telephony Interface Registered on major 196
[  997.013802] si3217x_audmux_probe: AUDMUX base is 0xa0b10000
*[  999.313971] sdma_disable_channel: Disabling EVTERR for channel 3**
**[  999.320620] sdma_disable_channel: Disabling EVTERR for channel 4*
[  999.326866] si3217x_ssi_probe: SSI base is 0xa0b20000 clock rate is 2048000Hz, TDM Frame rate 8000Hz, channels 32
having 8 bits word length
[ 1002.733512] si3217x_probe: SPI setup mode 3, 8 bits/w, 10000000 Hz max
[ 1002.740962] RX: prepare for the DMA.
*[ 1002.744960] sdma_enable_channel: Enabling EVTERR for channel 4*
[ 1002.752305] TX: prepare for the DMA.
*[ 1002.756111] sdma_enable_channel: Enabling EVTERR for channel 3*
[ 1002.762739] si3217x_ssi_set_clock: BIT_CLK=8192000, IPGCLK=66000000, PM=1
[ 1003.278453] Si3217x: isVerifiedProslic : chan(0) REG PCMTXHI VAL = 00
[ 1003.285624] Si3217x: isVerifiedProslic : Not a VDAA chan(0) REG PCMMODE VAL = 05
[ 1003.306492] SLIC verification OK
[ 1003.310461] SPI ret=0, MSTRSTAT=0x1f
[ 1003.314068]  PCLK_VALID       = 1
[ 1003.317115]  FS_VALID         = 1
[ 1003.319850]  FS_DETECT        = 1
[ 1003.322661]  PLL_LOCK         = 1
[ 1003.325385]  SRAM_CLR         = 1
[ 1003.328181]  PCLK_FAULT       = 0
[ 1003.331083]  FS_FAULT         = 0
[ 1003.333807]  PLL_FAULT        = 0
[ 1003.341485] Si3217x: isVerifiedProslic : chan(0) REG PCMTXHI VAL = 00
[ 1003.349140] Si3217x: isVerifiedProslic : Not a VDAA chan(0) REG PCMMODE VAL = 05
[ 1003.356601] Si3217x: Channel 0 : Type = PROSLIC
[ 1003.362536] Si3217x: isVerifiedProslic : chan(1) REG PCMTXHI VAL = 40
[ 1003.369863] Si3217x: Channel 1 : Type = DAA
[ 1003.374358] si3217x: Channel 0 : Type = 26
[ 1003.378515] si3217x: Channel 0 : Rev  = 1
[ 1003.385623] Si3217x: loading patch: 12102012
[ 1007.624105] Si3217x: Channel 0 : VBAT Up = 62.754 v
[ 1008.556990] Si3217x: PCMStart
[ 1008.560526] Channel 0: FXS model Si32178
[ 1008.567449] Channel 1: FXO model Si32919 rev A
[ 1008.591259] Found: Quadplay FXS/FXO Card

Basically for every DMA channel attached to a SSI peripheral I will enable the corresponding EVTERR bit
for the given channel in order to detect if a DMA overflow condition might happen or not.

With the patch below I'm able to see the error happening. And more likely it happen just just afterwards
the EVTERR notify the problem to the ISR. At this point the DMA simply stalls due to some problems, most
likely because the SSI FIFO is in overflow or underflow condition. I will do add the code to dump the SSI
registers once EVTERR is triggered.

I think that at this point we should in theory restart the DMA channel, but however how to fix this and
why this is happening?


diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 9d375bc..b9faf2d 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -50,6 +50,8 @@
 
 /* SDMA registers */
 #define SDMA_H_C0PTR        0x000
+#define SDMACORE_EVENTS        0x005
+#define SDMACORE_EVENTS2    0x01f
 #define SDMA_H_INTR        0x004
 #define SDMA_H_STATSTOP        0x008
 #define SDMA_H_START        0x00c
@@ -385,6 +387,7 @@ struct sdma_engine {
     const struct sdma_driver_data    *drvdata;
     u32                spba_start_addr;
     u32                spba_end_addr;
+        u32                             evterrchannel[MAX_DMA_CHANNELS];
 };
 
 static struct sdma_driver_data sdma_imx31 = {
@@ -562,7 +565,17 @@ static int sdma_config_ownership(struct sdma_channel *sdmac,
 
 static void sdma_enable_channel(struct sdma_engine *sdma, int channel)
 {
+        struct sdma_channel *sdmac = &sdma->channel[channel];
+
     writel(BIT(channel), sdma->regs + SDMA_H_START);
+
+        if ( sdmac->peripheral_type == IMX_DMATYPE_SSI_SP )
+        {
+            u32 msk = readl(sdma->regs + SDMA_H_INTRMSK);
+
+            writel(msk | BIT(channel), sdma->regs + SDMA_H_INTRMSK);
+            printk("%s: Enabling EVTERR for channel %d\n", __func__, channel);
+        }
 }
 
 /*
@@ -725,12 +738,26 @@ static irqreturn_t sdma_int_handler(int irq, void *dev_id)
 {
     struct sdma_engine *sdma = dev_id;
     unsigned long stat;
+        u32 evterr;
+
+        /* read the EVTERR register */
+        evterr = readl_relaxed(sdma->regs + SDMA_H_EVTERR);
+        if ( evterr )
+        {
+           int bitnr;
+
+           for_each_set_bit(bitnr, &evterr, sizeof(u32) * BITS_PER_BYTE)
+                sdma->evterrchannel[bitnr]++;
+        }
 
     stat = readl_relaxed(sdma->regs + SDMA_H_INTR);
     /* not interested in channel 0 interrupts */
     stat &= ~1;
     writel_relaxed(stat, sdma->regs + SDMA_H_INTR);
 
+        /* we are interested only to channels not in error status */
+        stat &= ~evterr;
+
     while (stat) {
         int channel = fls(stat) - 1;
         struct sdma_channel *sdmac = &sdma->channel[channel];
@@ -908,6 +935,14 @@ static int sdma_disable_channel(struct dma_chan *chan)
     writel_relaxed(BIT(channel), sdma->regs + SDMA_H_STATSTOP);
     sdmac->status = DMA_ERROR;
 
+        if ( sdmac->peripheral_type == IMX_DMATYPE_SSI_SP )
+        {
+            u32 msk = readl(sdma->regs + SDMA_H_INTRMSK);
+
+            writel(msk & ~(BIT(channel)), sdma->regs + SDMA_H_INTRMSK);
+            printk("%s: Disabling EVTERR for channel %d\n", __func__, channel);
+        }
+
     return 0;
 }
 
@@ -1650,6 +1685,44 @@ static struct dma_chan *sdma_xlate(struct of_phandle_args *dma_spec,
     return dma_request_channel(mask, sdma_filter_fn, &data);
 }
 
+#include <linux/seq_file.h>
+
+#define SDMA_SHOW_REG(reg) \
+    do { \
+                u32 _val = readl(sdma->regs + reg); \
+        seq_printf(s, "\t" #reg "=0x%08lx\n", _val); \
+    } while (0)
+
+void sdma_show_chan_status(struct seq_file *s, struct dma_chan *chan)
+{
+    struct sdma_channel *sdmac = to_sdma_chan(chan);
+    struct sdma_engine *sdma = sdmac->sdma;
+        int i;
+
+        seq_printf(s, "SDMA channel %d status\n", sdmac->channel);
+        SDMA_SHOW_REG(SDMA_H_STATSTOP);
+        SDMA_SHOW_REG(SDMA_H_START);
+        SDMA_SHOW_REG(SDMA_H_EVTOVR);
+        SDMA_SHOW_REG(SDMA_H_EVTPEND);
+        SDMA_SHOW_REG(SDMA_H_EVTERR);
+        SDMA_SHOW_REG(SDMA_H_DSPOVR);
+        SDMA_SHOW_REG(SDMA_H_HOSTOVR);
+        SDMA_SHOW_REG(SDMA_H_INTR);
+        SDMA_SHOW_REG(SDMA_H_INTRMSK);
+        SDMA_SHOW_REG(SDMACORE_EVENTS);
+        SDMA_SHOW_REG(SDMACORE_EVENTS2);
+
+        seq_printf(s, "\nSDMA EVTERR channel counters:\n");
+        for(i=0; i < MAX_DMA_CHANNELS; i++)
+        {
+            if (sdma->evterrchannel[i])
+            {
+                seq_printf(s, "\t%03d = %lu\n", i, sdma->evterrchannel[i]);
+            }
+        }
+}
+EXPORT_SYMBOL_GPL(sdma_show_chan_status);
+
 static int sdma_probe(struct platform_device *pdev)
 {
     const struct of_device_id *of_id =
