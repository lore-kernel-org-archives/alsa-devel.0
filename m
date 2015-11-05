From: Caleb Crome <caleb@crome.org>
Subject: Re: fsl_ssi.c: Roberto's problem: ssi hangs after some
 number of samples
Date: Thu, 5 Nov 2015 13:34:51 -0800
Message-ID: <CAG5mAdz+RDM8r1o+Q5WHhQM134Lp7Dxn78+ixX1D_u7G=WqE8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wi0-f175.google.com (mail-wi0-f175.google.com
 [209.85.212.175])
 by alsa0.perex.cz (Postfix) with ESMTP id 25C20260616
 for <alsa-devel@alsa-project.org>; Thu,  5 Nov 2015 22:35:11 +0100 (CET)
Received: by wicll6 with SMTP id ll6so17782862wic.1
 for <alsa-devel@alsa-project.org>; Thu, 05 Nov 2015 13:35:10 -0800 (PST)
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
Cc: Fabio Estevam <fabio.estevam@freescale.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Shengjiu Wang <shengjiu.wang@freescale.com>, Caleb Crome <caleb@crome.org>, Nicolin Chen <nicoleotsuka@gmail.com>, "arnaud.mouiche@invoxia.com" <arnaud.mouiche@invoxia.com>, Markus Pargmann <mpa@pengutronix.de>, "shawn.guo@linaro.org" <shawn.guo@linaro.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 5, 2015 at 3:48 AM, Roberto Fichera <kernel@tekno-soft.it> wrote:
> On 11/05/2015 12:30 PM, Fabio Estevam wrote:
>> On Thu, Nov 5, 2015 at 8:03 AM, Roberto Fichera <kernel@tekno-soft.it> wrote:
>>
>>> Following your suggestion, I've increased the buffer size to 2K and set the period to fifo_length - 2 (13),
>>> with that I'm now running substantially smooth except 3 EVTERR on RX DMA over 4 million of interrupts.
>>>
>>> Thanks Nicolin! I'm quite happy now!
>> That's good progress, Roberto.
>>
>> It would be nice if you and Caleb could post the patches to the mailing list.
>>

Yes, when I get something quite solid, I'd like to submit it all to
the list, and hope to get it into the kernel so nobody else has to go
through this pain again.

>
> Indeed! Now the TDM is stable, I've also found the reason of the EVTERRs, which was related to some stale
> code I've used to enable and disable both RDMAE and TDMAE bits to try to reset the transfers.
> Once removed that code everything is looks ok now.
>
> Regarding patches, well, from my side there isn't nothing special compared to the original fsl_ssi.c code.
> I'm basically running against a very skinny fsl_ssi.c version, I've just setup a bit larger DMA buffer, from
> 16bytes to 2K, and now reduced the DMA period to 8 because I'm mostly comfortable with that size to simplify
> sampling exchange against DAHDI subsystem within my DMA callbacks.
>
> In a few words, my problem was related due to a DMA buffer too small.
>
> What eventually might be interesting to have is the INTRMASK and EVTERR DMA setting to trigger DMA
> related errors, but I guess this need to be discussed elsewhere.

I have implemented roberto's patch on the 4.2 kernel, and I get a huge
number of EVTERR interrupts.  Something like 7200/second at 16kHz
sample rate.  But strangely, the audio seems to be correct.

My patch is slightly different in that it just enables EVTERR for all
channels, not just for the SSI.  Might as well see if there are any
other problems.

And it puts the stats file at
/sys/kernel/debug/20ec000.sdma/stats

When I aplay a file for 10 seconds I get ~366 EVTERR interrupts.
When I arecord for 10 seconds, I get 1 EVTERR interrupt
When I run my application for 10 seconds, which does full duplex, I
get 72703 EVTERR interrupts, but the data integrity checks out okay.

Interstingly, when I enable dual fifo, it goes from about 7200
EVTERR's/sec to about 18 EVTERRs/sec.  Much better, but still a long
way from working perfectly.

When I get a 'hang' from my application (no more portaudio callbacks),
I'm actually getting repeated calls to sdma_prep_dma_cyclic, though I
don't know how that call gets triggered.  But once that starts
happening, no more audio data gets through.

Here is my version of Roberto's patch for reporting the EVTERR on a
4.2 kernel.  It includes Dual fifo.

The
/sys/kernel/debug/20ec000.sdma/stats
file is cleared by reading, so it's easy to check how many EVTERRs
since the last read of the file.


Thanks again for looking at this.

-Caleb

---------- Forwarded message ----------
From: Caleb Crome <caleb@crome.org>
Date: Thu, Nov 5, 2015 at 1:16 PM
Subject: [PATCH] DMA: imx-sdma: add reporting of EVTERR DMA errors to fsl dma.
To: ccrome@gmail.com
Cc: Caleb Crome <caleb@crome.org>


Add roberto's patch to the 4.x kernel for report EVTERR DMA errors in
SSI transfers.  From userspace, you can see errors in the

/sys/kernel/debug/20ec000.sdma/stats

file.
---
 drivers/dma/imx-sdma.c | 113 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 9d375bc..a3a2317 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -38,6 +38,8 @@
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/of_dma.h>
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>

 #include <asm/irq.h>
 #include <linux/platform_data/dma-imx-sdma.h>
@@ -50,6 +52,8 @@

 /* SDMA registers */
 #define SDMA_H_C0PTR           0x000
+#define SDMACORE_EVENTS         0x005
+#define SDMACORE_EVENTS2        0x01f
 #define SDMA_H_INTR            0x004
 #define SDMA_H_STATSTOP                0x008
 #define SDMA_H_START           0x00c
@@ -385,6 +389,9 @@ struct sdma_engine {
        const struct sdma_driver_data   *drvdata;
        u32                             spba_start_addr;
        u32                             spba_end_addr;
+        u32                             evterrchannel[MAX_DMA_CHANNELS];
+       struct dentry *dbg_dir;
+       struct dentry *dbg_stats;
 };

 static struct sdma_driver_data sdma_imx31 = {
@@ -562,7 +569,19 @@ static int sdma_config_ownership(struct
sdma_channel *sdmac,

 static void sdma_enable_channel(struct sdma_engine *sdma, int channel)
 {
+       struct sdma_channel *sdmac = &sdma->channel[channel];
+       u32 msk;
+
        writel(BIT(channel), sdma->regs + SDMA_H_START);
+       /*
+        * enable EVTERR interrupts on this channel
+        */
+       if ((sdmac->peripheral_type == IMX_DMATYPE_SSI_SP) ||
+           (sdmac->peripheral_type == IMX_DMATYPE_SSI_DUAL)) {
+               msk = readl(sdma->regs + SDMA_H_INTRMSK);
+               writel(msk | BIT(channel), sdma->regs + SDMA_H_INTRMSK);
+               printk(KERN_INFO "%s: enabling EVTERR for channel
%d\n", __func__, channel);
+       }
 }

 /*
@@ -726,11 +745,25 @@ static irqreturn_t sdma_int_handler(int irq, void *dev_id)
        struct sdma_engine *sdma = dev_id;
        unsigned long stat;

+       long unsigned int evterr;
+
+        /* read the EVTERR register */
+        evterr = readl_relaxed(sdma->regs + SDMA_H_EVTERR);
+        if ( evterr )
+        {
+           int bitnr;
+           for_each_set_bit(bitnr, &evterr, sizeof(u32) * BITS_PER_BYTE)
+                  sdma->evterrchannel[bitnr]++;
+       }
+
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
@@ -904,10 +937,17 @@ static int sdma_disable_channel(struct dma_chan *chan)
        struct sdma_channel *sdmac = to_sdma_chan(chan);
        struct sdma_engine *sdma = sdmac->sdma;
        int channel = sdmac->channel;
+       u32 msk;

        writel_relaxed(BIT(channel), sdma->regs + SDMA_H_STATSTOP);
        sdmac->status = DMA_ERROR;

+       if ((sdmac->peripheral_type == IMX_DMATYPE_SSI_SP) ||
+           (sdmac->peripheral_type == IMX_DMATYPE_SSI_DUAL)) {
+               msk = readl(sdma->regs + SDMA_H_INTRMSK);
+               writel(msk & ~(BIT(channel)), sdma->regs + SDMA_H_INTRMSK);
+       }
+
        return 0;
 }

@@ -1166,6 +1206,8 @@ static struct dma_async_tx_descriptor *sdma_prep_slave_sg(

        dev_dbg(sdma->dev, "setting up %d entries for channel %d.\n",
                        sg_len, channel);
+       printk(KERN_INFO "setting up %d entries for channel %d.\n",
+                       sg_len, channel);

        sdmac->direction = direction;
        ret = sdma_load_context(sdmac);
@@ -1259,6 +1301,8 @@ static struct dma_async_tx_descriptor
*sdma_prep_dma_cyclic(

        dev_dbg(sdma->dev, "%s channel: %d\n", __func__, channel);

+       printk(KERN_INFO "%s channel: %d, periods = %d\n", __func__,
channel, num_periods);
+       printk(KERN_INFO "buf_len = %d, period_len = %d\n", buf_len,
period_len);
        if (sdmac->status == DMA_IN_PROGRESS)
                return NULL;

@@ -1650,6 +1694,71 @@ static struct dma_chan *sdma_xlate(struct
of_phandle_args *dma_spec,
        return dma_request_channel(mask, sdma_filter_fn, &data);
 }

+#define SDMA_SHOW_REG(reg) \
+    do { \
+                u32 _val = readl(sdma->regs + reg); \
+        seq_printf(s, "\t" #reg "=0x%08x\n", _val); \
+    } while (0)
+
+static int sdma_show_chan_status(struct seq_file *s, void *unused)
+{
+       struct sdma_engine *sdma = s->private;
+       // struct dma_chan *chan = (struct dma_chan *)priv;
+       //struct sdma_channel *sdmac = to_sdma_chan(chan);
+       //struct sdma_engine *sdma = sdmac->sdma;
+        int i;
+
+        //seq_printf(s, "SDMA channel %d status\n", sdmac->channel);
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
+               if (sdma->evterrchannel[i])  {
+                       seq_printf(s, "\t%03d = %u\n", i,
sdma->evterrchannel[i]);
+                       sdma->evterrchannel[i] = 0;
+               }
+
+       return 0;
+}
+
+static int fsl_sdma_stats_open(struct inode *inode, struct file *file)
+{
+       return single_open(file, sdma_show_chan_status, inode->i_private);
+}
+
+static const struct file_operations fsl_sdma_stats_ops = {
+       .open = fsl_sdma_stats_open,
+       .read = seq_read,
+       .llseek = seq_lseek,
+       .release = single_release,
+};
+
+int fsl_sdma_debugfs_create(struct sdma_engine *sdma, struct device *dev)
+{
+       sdma->dbg_dir = debugfs_create_dir(dev_name(dev), NULL);
+       if (!sdma->dbg_dir)
+               return -ENOMEM;
+
+       sdma->dbg_stats = debugfs_create_file("stats", S_IRUGO,
+                       sdma->dbg_dir, sdma, &fsl_sdma_stats_ops);
+       if (!sdma->dbg_stats) {
+               debugfs_remove(sdma->dbg_dir);
+               return -ENOMEM;
+       }
+       return 0;
+}
+
+
 static int sdma_probe(struct platform_device *pdev)
 {
        const struct of_device_id *of_id =
@@ -1785,6 +1894,10 @@ static int sdma_probe(struct platform_device *pdev)
                }
        }

+       ret = fsl_sdma_debugfs_create(sdma, &pdev->dev);
+       if (ret)
+               goto err_init;
+
        sdma->dma_device.dev = &pdev->dev;

        sdma->dma_device.device_alloc_chan_resources =
sdma_alloc_chan_resources;
--
2.1.4
