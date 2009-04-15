From: javier Martin <javier.martin@vista-silicon.com>
Subject: Re: ASoC: DMA Platform driver for i.mx27
Date: Wed, 15 Apr 2009 13:19:58 +0200
Message-ID: <eedb5540904150419p42979faeodc2cb94342050d57@mail.gmail.com>
References: <eedb5540904140917ic0f3626s5f6b98a2d22ec36b@mail.gmail.com>
	<20090414204243.GB6902@sirena.org.uk>
	<eedb5540904150210y68f08597p9f6c032ca17faa27@mail.gmail.com>
	<20090415094301.GC29399@sirena.org.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015174c17a8b17a9f04679620d3
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f166.google.com (mail-ew0-f166.google.com
	[209.85.219.166])
	by alsa0.perex.cz (Postfix) with ESMTP id BE0FA103887
	for <alsa-devel@alsa-project.org>;
	Wed, 15 Apr 2009 13:19:58 +0200 (CEST)
Received: by ewy10 with SMTP id 10so3226590ewy.32
	for <alsa-devel@alsa-project.org>; Wed, 15 Apr 2009 04:19:58 -0700 (PDT)
In-Reply-To: <20090415094301.GC29399@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--0015174c17a8b17a9f04679620d3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Patch submitted again.

Fixed a lot of coding style problems, debugging information now using
"pr_debug()"
and problem of freeing both dma's when closing pcm.

Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>

diff --git a/sound/soc/imx/imx27-pcm.c b/sound/soc/imx/imx27-pcm.c
new file mode 100644
index 0000000..ea00983
--- /dev/null
+++ b/sound/soc/imx/imx27-pcm.c
@@ -0,0 +1,555 @@
+/*
+ * linux/sound/arm/mx27-pcm.c -- ALSA SoC interface for the Freescale
i.MX27 CPU
+ *
+ * Copyright 2009 Vista Silicon S.L.
+ * Author: Javier Martin
+ *         javier.martin@vista-silicon.com
+ *
+ * Based on mxc-pcm.c by    Liam Girdwood, (C) 2006 Wolfson
Microelectronics PLC.
+ * and on mxc-alsa-mc13783 (C) 2006 Freescale.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+#include <linux/dma-mapping.h>
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+#include <asm/dma.h>
+#include <asm/hardware.h>
+
+#include "imx27-pcm.h"
+
+/* Just for debugging */
+#include "imx27-ssi.h"
+
+/* Taken from drivers/mxc/ssi/registers.h just provisionally */
+#define    MXC_SSI1STX0        0x00
+#define    MXC_SSI1SRX0        0x08
+#define    MXC_SSI2STX0        0x00
+#define    MXC_SSI2SRX0        0x08
+
+static const struct snd_pcm_hardware mx27_pcm_hardware =3D {
+    .info            =3D (SNDRV_PCM_INFO_INTERLEAVED |
+                   SNDRV_PCM_INFO_BLOCK_TRANSFER |
+                   SNDRV_PCM_INFO_MMAP |
+                   SNDRV_PCM_INFO_MMAP_VALID),
+    .formats        =3D SNDRV_PCM_FMTBIT_S16_LE,
+    .buffer_bytes_max    =3D 32 * 1024,
+    .period_bytes_min    =3D 64,
+    .period_bytes_max    =3D 8 * 1024,
+    .periods_min        =3D 2,
+    .periods_max        =3D 255,
+    .fifo_size        =3D 0,
+};
+
+struct mx27_runtime_data {
+    int dma_ch_tx; //DMA channel number for tx
+    int dma_ch_rx; //DMA channel number for rx
+    int active; //Is the stream active?
+    unsigned int period; //Period number
+    unsigned int periods; //=BF?
+    int tx_spin; //=BF?
+    spinlock_t dma_lock; //DMA spinlock
+    struct mx27_pcm_dma_param *dma_params; //FIXME this is SDMA api
+};
+
+/**
+  * This function stops the current dma transfer for playback
+  * and clears the dma pointers.
+  *
+  * @param    substream    pointer to the structure of the current stream.
+  *
+  */
+static int audio_stop_dma(struct snd_pcm_substream *substream)
+{
+    struct snd_pcm_runtime *runtime =3D substream->runtime;
+    struct mx27_runtime_data *prtd =3D runtime->private_data;
+    unsigned int dma_size =3D frames_to_bytes(runtime, runtime->period_siz=
e);
+    unsigned int offset  =3D dma_size * prtd->periods;
+    unsigned long flags;
+
+    spin_lock_irqsave(&prtd->dma_lock, flags);
+
+    pr_debug("MX27 : audio_stop_dma active =3D 0\n");
+
+    prtd->active =3D 0;
+    prtd->period =3D 0;
+    prtd->periods =3D 0;
+
+    /* this stops the dma channel and clears the buffer ptrs */
+
+    if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
+        if (mxc_dma_disable(prtd->dma_ch_tx) < 0)
+            printk(KERN_ERR "audio_stop_dma: error when stopping dma
transfer in channel %d \n",
+                prtd->dma_ch_tx);
+    } else {
+        if (mxc_dma_disable(prtd->dma_ch_rx) < 0)
+            printk(KERN_ERR "audio_stop_dma: error when stopping dma
transfer in channel %d \n",
+                prtd->dma_ch_rx);
+    }
+    spin_unlock_irqrestore(&prtd->dma_lock, flags);
+
+    return 0;
+}
+
+/**
+  * This function is called whenever a new audio block needs to be
+  * transferred to the codec. The function receives the address and the
size
+  * of the new block and start a new DMA transfer.
+  *
+  * @param    substream    pointer to the structure of the current stream.
+  *
+  */
+static int dma_new_period(struct snd_pcm_substream *substream)
+{
+    struct snd_pcm_runtime *runtime =3D  substream->runtime;
+    struct mx27_runtime_data *prtd =3D runtime->private_data;
+    unsigned int dma_size;
+    unsigned int offset;
+    int ret =3D 0;
+    mxc_dma_requestbuf_t dma_request;
+
+
+    if (prtd->active) {
+        memset(&dma_request, 0, sizeof(mxc_dma_requestbuf_t));;
+        dma_size =3D frames_to_bytes(runtime, runtime->period_size);
+
+        pr_debug("dma_new_period: prtd->period (%x) runtime->periods
(%d)\n",
+            prtd->period, runtime->periods);
+        pr_debug("dma_new_period: runtime->period_size (%d) dma_size
(%d)\n",
+            (unsigned int)runtime->period_size,
+            runtime->dma_bytes);
+
+        offset =3D dma_size * prtd->period;
+        snd_assert(dma_size <=3D mx27_pcm_hardware.period_bytes_max);
+
+        if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
+            pr_debug("\ndma_new_period (playback): runtime->dma_area =3D
%x\noffset =3D %x\ndma_size =3D %x\n",
+                runtime->dma_area, offset, dma_size);
+            pr_debug("\ndma_new_period : dma_addr is %x\n",
+                 (runtime->dma_addr + offset));
+
+            dma_request.src_addr =3D (dma_addr_t)(runtime->dma_addr +
offset);
+#ifdef CONFIG_SND_SOC_MX27_SSI1
+
+            dma_request.dst_addr =3D (dma_addr_t) (SSI1_BASE_ADDR +
MXC_SSI1STX0);
+
+            pr_debug("dst_addr is %x\n", dma_request.dst_addr);
+            pr_debug("src_addr is %x\n", dma_request.src_addr);
+#else
+            dma_request.dst_addr =3D
+                (dma_addr_t) (SSI2_BASE_ADDR + MXC_SSI2STX0);
+#endif
+        } else {
+            pr_debug("\ndma_new_period (capture): runtime->dma_area =3D
%x\noffset =3D %x\ndma_size =3D %x\n",
+                runtime->dma_area, offset, dma_size);
+            pr_debug("\ndma_new_period: dma_addr is %x\n",
+                (runtime->dma_addr + offset));
+
+            dma_request.dst_addr =3D (dma_addr_t) (runtime->dma_addr +
offset);
+#ifdef CONFIG_SND_SOC_MX27_SSI1
+            dma_request.src_addr =3D
+                (dma_addr_t) (SSI1_BASE_ADDR + MXC_SSI1SRX0);
+#else
+            dma_request.src_addr =3D
+                (dma_addr_t) (SSI2_BASE_ADDR + MXC_SSI2SRX0);
+#endif
+        }
+
+        dma_request.num_of_bytes =3D dma_size;
+        pr_debug("dma_new_period: Start DMA offset (%d) size (%d)\n",
+             offset, runtime->dma_bytes);
+        if (substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
+            pr_debug("dma_new_period: configuring tx dma\n");
+            ret =3D mxc_dma_config(prtd->dma_ch_tx, &dma_request, 1,
+                MXC_DMA_MODE_WRITE);
+            if (ret < 0) {
+                printk("dma_new_period: buffer could not be added for
playback transfer\n");
+                return ret;
+            }
+
+            pr_debug("dma_new_period: enable  tx dma transfer\n");
+            ret =3D mxc_dma_enable(prtd->dma_ch_tx);
+            if (ret < 0) {
+                printk("dma_new_period: cannot queue DMA buffer\
+                            (%i)\n", ret);
+                return ret;
+            }
+        } else {
+            ret =3D mxc_dma_config(prtd->dma_ch_rx, &dma_request, 1,
MXC_DMA_MODE_READ);
+            if (ret < 0) {
+                printk("dma_new_period: buffer could not be added for
capture transfer\n");
+                return ret;
+            }
+
+            pr_debug("dma_new_period: enable  dma transfer\n");
+            ret =3D mxc_dma_enable(prtd->dma_ch_rx);
+            if(ret<0) {
+                printk("dma_new_period: cannot queue DMA buffer\
+                            (%i)\n", ret);
+                return ret;
+            }
+        }
+
+        pr_debug("dma_new_period: transfer enabled\n src_addr =3D %x\n
dst_addr =3D %x\n num_of_byes =3D %d\n", (void *) dma_request.src_addr, (vo=
id *)
dma_request.dst_addr, dma_request.num_of_bytes);
+
+        prtd->tx_spin =3D 1; /* FGA little trick to retrieve DMA pos */
+        prtd->period++;
+        prtd->period %=3D runtime->periods;
+    }
+    return ret;
+}
+
+
+/**
+  * This is a callback which will be called
+  * when a TX transfer finishes. The call occurs
+  * in interrupt context.
+  *
+  * @param    dat    pointer to the structure of the current stream.
+  *
+  */
+static void audio_dma_irq(void *data, int error, unsigned int count)
+{
+    struct snd_pcm_substream *substream;
+    struct snd_pcm_runtime *runtime;
+    struct mx27_runtime_data *prtd;
+    unsigned int dma_size;
+    unsigned int previous_period;
+    unsigned int offset;
+
+    substream =3D data;
+    runtime =3D substream->runtime;
+    prtd =3D runtime->private_data;
+    previous_period  =3D prtd->periods;
+    dma_size =3D frames_to_bytes(runtime, runtime->period_size);
+    offset =3D dma_size * previous_period;
+
+    prtd->tx_spin =3D 0;
+    prtd->periods++;
+    prtd->periods %=3D runtime->periods;
+
+    pr_debug("audio_dma_irq: irq per %d offset %x\n", prtd->periods,
offset);
+
+    /*
+      * If we are getting a callback for an active stream then we inform
+      * the PCM middle layer we've finished a period
+      */
+     if (prtd->active)
+        snd_pcm_period_elapsed(substream);
+
+    /*
+      * Trig next DMA transfer
+      */
+    dma_new_period(substream);
+}
+
+/**
+  * This function configures the hardware to allow audio
+  * playback operations. It is called by ALSA framework.
+  *
+  * @param    substream    pointer to the structure of the current stream.
+  *
+  * @return              0 on success, -1 otherwise.
+  */
+static int
+snd_mxc_prepare(struct snd_pcm_substream *substream)
+{
+    struct snd_pcm_runtime *runtime =3D  substream->runtime;
+    struct mx27_runtime_data *prtd =3D runtime->private_data;
+
+    prtd->period =3D 0;
+    prtd->periods =3D 0;
+
+    return 0;
+}
+
+static int mxc_pcm_hw_params(struct snd_pcm_substream *substream,
+    struct snd_pcm_hw_params *hw_params)
+{
+    struct snd_pcm_runtime *runtime =3D substream->runtime;
+    struct mx27_runtime_data *prtd =3D runtime->private_data;
+    int ret;
+
+    if((ret=3Dsnd_pcm_lib_malloc_pages(substream,
params_buffer_bytes(hw_params))) < 0)
+    {
+        printk("imx27-pcm: failed to malloc pcm pages\n");
+        return ret;
+    }
+
+    pr_debug("mxc_pcm_hw_params: snd_pcm_lib_malloc pages has return
OK\n");
+    pr_debug("IMX27: snd_imx27_audio_hw_params runtime->dma_addr 0x(%x)\n"=
,
+         (unsigned int)runtime->dma_addr);
+    pr_debug("IMX27: snd_imx27_audio_hw_params runtime->dma_area 0x(%x)\n"=
,
+         (unsigned int)runtime->dma_area);
+    pr_debug("IMX27: snd_imx27_audio_hw_params runtime->dma_bytes
0x(%x)\n",
+         (unsigned int)runtime->dma_bytes);
+
+    return ret;
+}
+
+static int mxc_pcm_hw_free(struct snd_pcm_substream *substream)
+{
+    struct snd_pcm_runtime *runtime =3D substream->runtime;
+    struct mx27_runtime_data *prtd =3D runtime->private_data;
+
+
+    if(substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
+        mxc_dma_free(prtd->dma_ch_tx);
+    else
+        mxc_dma_free(prtd->dma_ch_rx);
+
+    snd_pcm_lib_free_pages(substream);
+
+    return 0;
+}
+
+static int mxc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+    struct mx27_runtime_data *prtd =3D substream->runtime->private_data;
+    int ret =3D 0;
+
+    switch (cmd) {
+    case SNDRV_PCM_TRIGGER_START:
+        prtd->tx_spin =3D 0;
+        /* requested stream startup */
+        prtd->active =3D 1;
+        pr_debug("mxc_pcm_trigger: starting dma_new_period\n");
+            ret =3D dma_new_period(substream);
+        break;
+    case SNDRV_PCM_TRIGGER_STOP:
+        /* requested stream shutdown */
+        pr_debug("mxc_pcm_trigger: stopping dma transfer\n");
+        ret =3D audio_stop_dma(substream);
+        break;
+    default:
+        ret =3D -EINVAL;
+        break;
+    }
+
+    return ret;
+}
+
+static snd_pcm_uframes_t mxc_pcm_pointer(struct snd_pcm_substream
*substream)
+{
+    struct snd_pcm_runtime *runtime =3D substream->runtime;
+    struct mx27_runtime_data *prtd =3D runtime->private_data;
+    unsigned int offset =3D 0;
+
+    pr_debug("mxc_pcm_pointer:\n runtime->period_size=3D%d\n
prtd->periods=3D%d\n runtime->buffer_size=3D%d\n prtd->tx_spin=3D%d\n",
+        runtime->period_size, prtd->periods, runtime->buffer_size,
prtd->tx_spin);
+    /* tx_spin value is used here to check if a transfer is active */
+    if (prtd->tx_spin){
+        offset =3D (runtime->period_size * (prtd->periods)) +
+                        (runtime->period_size >> 1);
+        if (offset >=3D runtime->buffer_size)
+            offset =3D runtime->period_size >> 1;
+    } else {
+        offset =3D (runtime->period_size * (prtd->periods));
+        if (offset >=3D runtime->buffer_size)
+            offset =3D 0;
+    }
+    pr_debug("mxc_pcm_pointer: pointer offset %x\n", offset);
+
+    return offset;
+}
+
+//Alocation of substream->runtime->private_data
+static int mxc_pcm_open(struct snd_pcm_substream *substream)
+{
+    struct snd_pcm_runtime *runtime =3D substream->runtime;
+    struct mx27_runtime_data *prtd;
+    int ret;
+
+    snd_soc_set_runtime_hwparams(substream, &mx27_pcm_hardware);
+
+    if ((ret =3D snd_pcm_hw_constraint_integer(runtime,
+                    SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
+        return ret;
+
+    if ((prtd =3D kzalloc(sizeof(struct mx27_runtime_data), GFP_KERNEL)) =
=3D=3D
NULL) {
+        ret =3D -ENOMEM;
+        goto out;
+    }
+
+    runtime->private_data =3D prtd;
+
+    if(substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
+    {
+
+#ifdef CONFIG_SND_SOC_MX27_SSI1
+        pr_debug("mxc_pcm_open: Requesting MXC_DMA_SSI1_16BIT_TX0 dma
channel\n");
+        prtd->dma_ch_tx  =3D mxc_dma_request(MXC_DMA_SSI1_16BIT_TX0, "ALSA=
 TX
DMA");
+#else
+        prtd->dma_ch_tx =3D mxc_dma_request(MXC_DMA_SSI2_16BIT_TX0, "ALSA =
TX
DMA");
+#endif
+        if(prtd->dma_ch_tx < 0)
+        {
+            printk("error requesting a write(dma to device) dma
channel\n");
+            return ret;
+        }
+
+        /* Set dma callback */
+        pr_debug("mxc_pcm_open: Setting tx dma callback function\n");
+        ret =3D mxc_dma_callback_set(prtd->dma_ch_tx, (mxc_dma_callback_t)
audio_dma_irq, (void *)substream);
+        if(ret < 0) {
+            printk("error setting dma callback function\n");
+            return ret;
+        }
+
+        return 0;
+    } else {
+#ifdef CONFIG_SND_SOC_MX27_SSI1
+        pr_debug("mxc_pcm_open: Requesting MXC_DMA_SSI1_16BIT_RX0 dma
channel\n");
+        prtd->dma_ch_rx  =3D mxc_dma_request(MXC_DMA_SSI1_16BIT_RX0, "ALSA=
 RX
DMA");
+#else
+        prtd->dma_ch_rx =3D mxc_dma_request(MXC_DMA_SSI2_16BIT_RX0, "ALSA =
RX
DMA");
+#endif
+        if (prtd->dma_ch_rx < 0) {
+            printk("error requesting a read(dma from device) dma
channel\n");
+            return ret;
+        }
+
+        //Set dma callback
+        pr_debug("mxc_pcm_open: Setting rx dma callback function\n");
+        if (mxc_dma_callback_set(prtd->dma_ch_rx, (mxc_dma_callback_t)
audio_dma_irq, (void *)substream)<0)
+            printk("error setting dma callback function\n");
+
+        return 0;
+    }
+
+
+
+ out:
+    return ret;
+}
+
+static int mxc_pcm_close(struct snd_pcm_substream *substream)
+{
+    struct snd_pcm_runtime *runtime =3D substream->runtime;
+    struct mxc_runtime_data *prtd =3D runtime->private_data;
+
+    kfree(prtd);
+
+    return 0;
+}
+
+static int
+mxc_pcm_mmap(struct snd_pcm_substream *substream, struct vm_area_struct
*vma)
+{
+    struct snd_pcm_runtime *runtime =3D substream->runtime;
+    return dma_mmap_writecombine(substream->pcm->card->dev, vma,
+                     runtime->dma_area,
+                     runtime->dma_addr,
+                     runtime->dma_bytes);
+}
+
+struct snd_pcm_ops mxc_pcm_ops =3D {
+    .open        =3D mxc_pcm_open,
+    .close        =3D mxc_pcm_close,
+    .ioctl        =3D snd_pcm_lib_ioctl,
+    .hw_params    =3D mxc_pcm_hw_params,
+    .hw_free    =3D mxc_pcm_hw_free,
+    .prepare    =3D snd_mxc_prepare,
+    .trigger    =3D mxc_pcm_trigger,
+    .pointer    =3D mxc_pcm_pointer,
+    .mmap        =3D mxc_pcm_mmap,
+};
+
+static u64 mxc_pcm_dmamask =3D 0xffffffff;
+
+static int imx31_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int
stream)
+{
+    struct snd_pcm_substream *substream =3D pcm->streams[stream].substream=
;
+    struct snd_dma_buffer *buf =3D &substream->dma_buffer;
+    size_t size =3D mx27_pcm_hardware.buffer_bytes_max;
+    buf->dev.type =3D SNDRV_DMA_TYPE_DEV;
+    buf->dev.dev =3D pcm->card->dev;
+    buf->private_data =3D NULL;
+
+    //Reserve uncached-buffered memory area for DMA
+    buf->area =3D dma_alloc_writecombine(pcm->card->dev, size,
+                       &buf->addr, GFP_KERNEL);
+
+    pr_debug("imx27_pcm: preallocate_dma_buffer: area=3D%p, addr=3D%p,
size=3D%d\n", (void *) buf->area, (void *) buf->addr, size);
+
+    if (!buf->area)
+        return -ENOMEM;
+
+    buf->bytes =3D size;
+    return 0;
+}
+
+static void imx31_pcm_free_dma_buffers(struct snd_pcm *pcm)
+{
+    struct snd_pcm_substream *substream;
+    struct snd_dma_buffer *buf;
+    int stream;
+
+    for (stream =3D 0; stream < 2; stream++) {
+        substream =3D pcm->streams[stream].substream;
+        if (!substream)
+            continue;
+
+        buf =3D &substream->dma_buffer;
+        if (!buf->area)
+            continue;
+
+        dma_free_writecombine(pcm->card->dev, buf->bytes,
+                      buf->area, buf->addr);
+        buf->area =3D NULL;
+    }
+}
+
+int mxc_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
+    struct snd_pcm *pcm)
+{
+    int ret =3D 0;
+
+    if (!card->dev->dma_mask)
+        card->dev->dma_mask =3D &mxc_pcm_dmamask;
+    if (!card->dev->coherent_dma_mask)
+        card->dev->coherent_dma_mask =3D 0xffffffff;
+
+    if (dai->playback.channels_min) {
+        ret =3D imx31_pcm_preallocate_dma_buffer(pcm,
+            SNDRV_PCM_STREAM_PLAYBACK);
+        printk("mxc_pcm_new: preallocate playback buffer\n");
+        if (ret)
+            goto out;
+    }
+
+    if (dai->capture.channels_min) {
+        ret =3D imx31_pcm_preallocate_dma_buffer(pcm,
+            SNDRV_PCM_STREAM_CAPTURE);
+        printk("mxc_pcm_new: preallocate capture buffer\n");
+        if (ret)
+            goto out;
+    }
+ out:
+    return ret;
+}
+
+struct snd_soc_platform imx27_soc_platform =3D {
+    .name        =3D "mxc-audio",
+    .pcm_ops     =3D &mxc_pcm_ops,
+    .pcm_new    =3D mxc_pcm_new,
+    .pcm_free    =3D imx31_pcm_free_dma_buffers,
+};
+
+EXPORT_SYMBOL_GPL(imx27_soc_platform);
+
+MODULE_AUTHOR("Javier Martin");
+MODULE_DESCRIPTION("Freescale i.MX27 PCM DMA module");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/imx/imx27-pcm.h b/sound/soc/imx/imx27-pcm.h
new file mode 100644
index 0000000..9852cff
--- /dev/null
+++ b/sound/soc/imx/imx27-pcm.h
@@ -0,0 +1,97 @@
+/*
+ * mxc-pcm.h :- ASoC platform header for Freescale i.MX
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _MXC_PCM_H
+#define _MXC_PCM_H
+
+#include <asm/arch/dma.h>
+
+/* AUDMUX regs definition - MOVE to asm/arch when stable
+#define AUDMUX_IO_BASE_ADDR    IO_ADDRESS(AUDMUX_BASE_ADDR)
+
+#define DAM_PTCR1    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x00)))
+#define DAM_PDCR1    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x04)))
+#define DAM_PTCR2    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x08)))
+#define DAM_PDCR2    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x0C)))
+#define DAM_PTCR3    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x10)))
+#define DAM_PDCR3    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x14)))
+#define DAM_PTCR4    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x18)))
+#define DAM_PDCR4    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x1C)))
+#define DAM_PTCR5    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x20)))
+#define DAM_PDCR5    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x24)))
+#define DAM_PTCR6    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x28)))
+#define DAM_PDCR6    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x2C)))
+#define DAM_PTCR7    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x30)))
+#define DAM_PDCR7    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x34)))
+#define DAM_CNMCR    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x38)))
+#define DAM_PTCR(a)    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + a*8)))
+#define DAM_PDCR(a)    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 4 + a*8))=
)
+
+
+#define AUDMUX_PTCR_TFSDIR        (1 << 31)
+#define AUDMUX_PTCR_TFSSEL(x, y)        ((x << 30) | (((y - 1) & 0x7) <<
27))
+#define AUDMUX_PTCR_TCLKDIR        (1 << 26)
+#define AUDMUX_PTCR_TCSEL(x, y)        ((x << 25) | (((y - 1) & 0x7) <<
22))
+#define AUDMUX_PTCR_RFSDIR        (1 << 21)
+#define AUDMUX_PTCR_RFSSEL(x, y)        ((x << 20) | (((y - 1) & 0x7) <<
17))
+#define AUDMUX_PTCR_RCLKDIR        (1 << 16)
+#define AUDMUX_PTCR_RCSEL(x, y)        ((x << 15) | (((y - 1) & 0x7) <<
12))
+#define AUDMUX_PTCR_SYN        (1 << 11)
+
+#define AUDMUX_FROM_TXFS    0
+#define AUDMUX_FROM_RXFS    1
+
+#define AUDMUX_PDCR_RXDSEL(x)        (((x - 1) & 0x7) << 13)
+#define AUDMUX_PDCR_TXDXEN        (1 << 12)
+#define AUDMUX_PDCR_MODE(x)        (((x) & 0x3) << 8)
+#define AUDMUX_PDCR_INNMASK(x)        (((x) & 0xff) << 0)
+
+#define AUDMUX_CNMCR_CEN        (1 << 18)
+#define AUDMUX_CNMCR_FSPOL        (1 << 17)
+#define AUDMUX_CNMCR_CLKPOL        (1 << 16)
+#define AUDMUX_CNMCR_CNTHI(x)        (((x) & 0xff) << 8)
+#define AUDMUX_CNMCR_CNTLOW(x)        (((x) & 0xff) << 0)
+*/
+
+/* Previous defines are only valid for imx31 */
+#define AUDMUX_IO_BASE_ADDR    IO_ADDRESS(AUDMUX_BASE_ADDR)
+
+#define DAM_HPCR1    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x00)))
+#define DAM_HPCR2    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x04)))
+#define DAM_HPCR3    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x08)))
+#define DAM_PPCR1    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x10)))
+#define DAM_PPCR2    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x14)))
+#define DAM_PPCR3    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x1C)))
+
+#define AUDMUX_HPCR_TFSDIR    (1 << 31)
+#define AUDMUX_HPCR_TCLKDIR    (1 << 30)
+#define AUDMUX_HPCR_TFCSEL(x)    (((x) & 0xff) << 26)
+#define AUDMUX_HPCR_RXDSEL(x)    (((x) & 0x7) << 13)
+#define AUDMUX_HPCR_SYN        (1 << 12)
+
+#define AUDMUX_PPCR_TFSDIR    (1 << 31)
+#define AUDMUX_PPCR_TCLKDIR    (1 << 30)
+#define AUDMUX_PPCR_TFCSEL(x)    (((x) & 0xff) << 26)
+#define AUDMUX_PPCR_RXDSEL(x)    (((x) & 0x7) << 13)
+#define AUDMUX_PPCR_SYN        (1 << 12)
+
+
+
+struct mx27_pcm_dma_params {
+    char *name;            /* stream identifier */
+    mxc_dma_requestbuf_t buf_params; /*DMA buffer params */
+
+};
+
+extern struct snd_soc_dai mxc_ssi_dai[3];
+
+/* platform data */
+extern struct snd_soc_platform imx27_soc_platform;
+
+
+#endif

--0015174c17a8b17a9f04679620d3
Content-Type: application/octet-stream; name="imx27-pcm.patch"
Content-Disposition: attachment; filename="imx27-pcm.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ftjxkdw00

UGF0Y2ggc3VibWl0dGVkIGFnYWluLg0KDQpGaXhlZCBhIGxvdCBvZiBjb2Rpbmcgc3R5bGUgcHJv
YmxlbXMsIGRlYnVnZ2luZyBpbmZvcm1hdGlvbiBub3cgdXNpbmcgInByX2RlYnVnKCkiDQphbmQg
cHJvYmxlbSBvZiBmcmVlaW5nIGJvdGggZG1hJ3Mgd2hlbiBjbG9zaW5nIHBjbS4NCg0KU2lnbmVk
LW9mZi1ieTogSmF2aWVyIE1hcnRpbiA8amF2aWVyLm1hcnRpbkB2aXN0YS1zaWxpY29uLmNvbT4N
Cg0KZGlmZiAtLWdpdCBhL3NvdW5kL3NvYy9pbXgvaW14MjctcGNtLmMgYi9zb3VuZC9zb2MvaW14
L2lteDI3LXBjbS5jDQpuZXcgZmlsZSBtb2RlIDEwMDY0NA0KaW5kZXggMDAwMDAwMC4uZWEwMDk4
Mw0KLS0tIC9kZXYvbnVsbA0KKysrIGIvc291bmQvc29jL2lteC9pbXgyNy1wY20uYw0KQEAgLTAs
MCArMSw1NTUgQEANCisvKg0KKyAqIGxpbnV4L3NvdW5kL2FybS9teDI3LXBjbS5jIC0tIEFMU0Eg
U29DIGludGVyZmFjZSBmb3IgdGhlIEZyZWVzY2FsZSBpLk1YMjcgQ1BVDQorICoNCisgKiBDb3B5
cmlnaHQgMjAwOSBWaXN0YSBTaWxpY29uIFMuTC4NCisgKiBBdXRob3I6IEphdmllciBNYXJ0aW4N
CisgKiAgICAgICAgIGphdmllci5tYXJ0aW5AdmlzdGEtc2lsaWNvbi5jb20NCisgKg0KKyAqIEJh
c2VkIG9uIG14Yy1wY20uYyBieQlMaWFtIEdpcmR3b29kLCAoQykgMjAwNiBXb2xmc29uIE1pY3Jv
ZWxlY3Ryb25pY3MgUExDLg0KKyAqIGFuZCBvbiBteGMtYWxzYS1tYzEzNzgzIChDKSAyMDA2IEZy
ZWVzY2FsZS4NCisgKg0KKyAqIFRoaXMgcHJvZ3JhbSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2Fu
IHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5DQorICogaXQgdW5kZXIgdGhlIHRlcm1zIG9m
IHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSB2ZXJzaW9uIDIgYXMNCisgKiBwdWJsaXNo
ZWQgYnkgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlvbi4NCisgKg0KKyAqDQorICovDQorDQor
I2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0KKyNpbmNsdWRlIDxsaW51eC9pbml0Lmg+DQorI2lu
Y2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KKyNpbmNsdWRlIDxsaW51eC9zbGFiLmg+
DQorI2luY2x1ZGUgPGxpbnV4L2RtYS1tYXBwaW5nLmg+DQorI2luY2x1ZGUgPHNvdW5kL2RyaXZl
ci5oPg0KKyNpbmNsdWRlIDxzb3VuZC9jb3JlLmg+DQorI2luY2x1ZGUgPHNvdW5kL3BjbS5oPg0K
KyNpbmNsdWRlIDxzb3VuZC9wY21fcGFyYW1zLmg+DQorI2luY2x1ZGUgPHNvdW5kL3NvYy5oPg0K
KyNpbmNsdWRlIDxhc20vZG1hLmg+DQorI2luY2x1ZGUgPGFzbS9oYXJkd2FyZS5oPg0KKw0KKyNp
bmNsdWRlICJpbXgyNy1wY20uaCINCisNCisvKiBKdXN0IGZvciBkZWJ1Z2dpbmcgKi8NCisjaW5j
bHVkZSAiaW14Mjctc3NpLmgiDQorDQorLyogVGFrZW4gZnJvbSBkcml2ZXJzL214Yy9zc2kvcmVn
aXN0ZXJzLmgganVzdCBwcm92aXNpb25hbGx5ICovDQorI2RlZmluZSAgICBNWENfU1NJMVNUWDAJ
CTB4MDANCisjZGVmaW5lICAgIE1YQ19TU0kxU1JYMAkJMHgwOA0KKyNkZWZpbmUgICAgTVhDX1NT
STJTVFgwCQkweDAwDQorI2RlZmluZSAgICBNWENfU1NJMlNSWDAJCTB4MDgNCisNCitzdGF0aWMg
Y29uc3Qgc3RydWN0IHNuZF9wY21faGFyZHdhcmUgbXgyN19wY21faGFyZHdhcmUgPSB7DQorCS5p
bmZvCQkJPSAoU05EUlZfUENNX0lORk9fSU5URVJMRUFWRUQgfA0KKwkJCQkgICBTTkRSVl9QQ01f
SU5GT19CTE9DS19UUkFOU0ZFUiB8DQorCQkJCSAgIFNORFJWX1BDTV9JTkZPX01NQVAgfA0KKwkJ
CQkgICBTTkRSVl9QQ01fSU5GT19NTUFQX1ZBTElEKSwNCisJLmZvcm1hdHMJCT0gU05EUlZfUENN
X0ZNVEJJVF9TMTZfTEUsDQorCS5idWZmZXJfYnl0ZXNfbWF4CT0gMzIgKiAxMDI0LA0KKwkucGVy
aW9kX2J5dGVzX21pbgk9IDY0LA0KKwkucGVyaW9kX2J5dGVzX21heAk9IDggKiAxMDI0LA0KKwku
cGVyaW9kc19taW4JCT0gMiwNCisJLnBlcmlvZHNfbWF4CQk9IDI1NSwNCisJLmZpZm9fc2l6ZQkJ
PSAwLA0KK307DQorDQorc3RydWN0IG14MjdfcnVudGltZV9kYXRhIHsNCisJaW50IGRtYV9jaF90
eDsgLy9ETUEgY2hhbm5lbCBudW1iZXIgZm9yIHR4DQorCWludCBkbWFfY2hfcng7IC8vRE1BIGNo
YW5uZWwgbnVtYmVyIGZvciByeA0KKwlpbnQgYWN0aXZlOyAvL0lzIHRoZSBzdHJlYW0gYWN0aXZl
Pw0KKwl1bnNpZ25lZCBpbnQgcGVyaW9kOyAvL1BlcmlvZCBudW1iZXINCisJdW5zaWduZWQgaW50
IHBlcmlvZHM7IC8vvz8NCisJaW50IHR4X3NwaW47IC8vvz8NCisJc3BpbmxvY2tfdCBkbWFfbG9j
azsgLy9ETUEgc3BpbmxvY2sNCisJc3RydWN0IG14MjdfcGNtX2RtYV9wYXJhbSAqZG1hX3BhcmFt
czsgLy9GSVhNRSB0aGlzIGlzIFNETUEgYXBpDQorfTsNCisNCisvKioNCisgICogVGhpcyBmdW5j
dGlvbiBzdG9wcyB0aGUgY3VycmVudCBkbWEgdHJhbnNmZXIgZm9yIHBsYXliYWNrDQorICAqIGFu
ZCBjbGVhcnMgdGhlIGRtYSBwb2ludGVycy4NCisgICoNCisgICogQHBhcmFtCXN1YnN0cmVhbQlw
b2ludGVyIHRvIHRoZSBzdHJ1Y3R1cmUgb2YgdGhlIGN1cnJlbnQgc3RyZWFtLg0KKyAgKg0KKyAg
Ki8NCitzdGF0aWMgaW50IGF1ZGlvX3N0b3BfZG1hKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAq
c3Vic3RyZWFtKQ0KK3sNCisJc3RydWN0IHNuZF9wY21fcnVudGltZSAqcnVudGltZSA9IHN1YnN0
cmVhbS0+cnVudGltZTsNCisJc3RydWN0IG14MjdfcnVudGltZV9kYXRhICpwcnRkID0gcnVudGlt
ZS0+cHJpdmF0ZV9kYXRhOw0KKwl1bnNpZ25lZCBpbnQgZG1hX3NpemUgPSBmcmFtZXNfdG9fYnl0
ZXMocnVudGltZSwgcnVudGltZS0+cGVyaW9kX3NpemUpOw0KKwl1bnNpZ25lZCBpbnQgb2Zmc2V0
ICA9IGRtYV9zaXplICogcHJ0ZC0+cGVyaW9kczsNCisJdW5zaWduZWQgbG9uZyBmbGFnczsNCisN
CisJc3Bpbl9sb2NrX2lycXNhdmUoJnBydGQtPmRtYV9sb2NrLCBmbGFncyk7DQorDQorCXByX2Rl
YnVnKCJNWDI3IDogYXVkaW9fc3RvcF9kbWEgYWN0aXZlID0gMFxuIik7DQorDQorCXBydGQtPmFj
dGl2ZSA9IDA7DQorCXBydGQtPnBlcmlvZCA9IDA7DQorCXBydGQtPnBlcmlvZHMgPSAwOw0KKw0K
KwkvKiB0aGlzIHN0b3BzIHRoZSBkbWEgY2hhbm5lbCBhbmQgY2xlYXJzIHRoZSBidWZmZXIgcHRy
cyAqLw0KKw0KKwlpZiAoc3Vic3RyZWFtLT5zdHJlYW0gPT0gU05EUlZfUENNX1NUUkVBTV9QTEFZ
QkFDSykgew0KKwkJaWYgKG14Y19kbWFfZGlzYWJsZShwcnRkLT5kbWFfY2hfdHgpIDwgMCkNCisJ
CQlwcmludGsoS0VSTl9FUlIgImF1ZGlvX3N0b3BfZG1hOiBlcnJvciB3aGVuIHN0b3BwaW5nIGRt
YSB0cmFuc2ZlciBpbiBjaGFubmVsICVkIFxuIiwNCisJCQkJcHJ0ZC0+ZG1hX2NoX3R4KTsNCisJ
fSBlbHNlIHsNCisJCWlmIChteGNfZG1hX2Rpc2FibGUocHJ0ZC0+ZG1hX2NoX3J4KSA8IDApDQor
CQkJcHJpbnRrKEtFUk5fRVJSICJhdWRpb19zdG9wX2RtYTogZXJyb3Igd2hlbiBzdG9wcGluZyBk
bWEgdHJhbnNmZXIgaW4gY2hhbm5lbCAlZCBcbiIsDQorCQkJCXBydGQtPmRtYV9jaF9yeCk7DQor
CX0NCisJc3Bpbl91bmxvY2tfaXJxcmVzdG9yZSgmcHJ0ZC0+ZG1hX2xvY2ssIGZsYWdzKTsNCisN
CisJcmV0dXJuIDA7DQorfQ0KKw0KKy8qKg0KKyAgKiBUaGlzIGZ1bmN0aW9uIGlzIGNhbGxlZCB3
aGVuZXZlciBhIG5ldyBhdWRpbyBibG9jayBuZWVkcyB0byBiZQ0KKyAgKiB0cmFuc2ZlcnJlZCB0
byB0aGUgY29kZWMuIFRoZSBmdW5jdGlvbiByZWNlaXZlcyB0aGUgYWRkcmVzcyBhbmQgdGhlIHNp
emUNCisgICogb2YgdGhlIG5ldyBibG9jayBhbmQgc3RhcnQgYSBuZXcgRE1BIHRyYW5zZmVyLg0K
KyAgKg0KKyAgKiBAcGFyYW0Jc3Vic3RyZWFtCXBvaW50ZXIgdG8gdGhlIHN0cnVjdHVyZSBvZiB0
aGUgY3VycmVudCBzdHJlYW0uDQorICAqDQorICAqLw0KK3N0YXRpYyBpbnQgZG1hX25ld19wZXJp
b2Qoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0pDQorew0KKwlzdHJ1Y3Qgc25k
X3BjbV9ydW50aW1lICpydW50aW1lID0gIHN1YnN0cmVhbS0+cnVudGltZTsNCisJc3RydWN0IG14
MjdfcnVudGltZV9kYXRhICpwcnRkID0gcnVudGltZS0+cHJpdmF0ZV9kYXRhOw0KKwl1bnNpZ25l
ZCBpbnQgZG1hX3NpemU7DQorCXVuc2lnbmVkIGludCBvZmZzZXQ7DQorCWludCByZXQgPSAwOw0K
KwlteGNfZG1hX3JlcXVlc3RidWZfdCBkbWFfcmVxdWVzdDsNCisNCisNCisJaWYgKHBydGQtPmFj
dGl2ZSkgew0KKwkJbWVtc2V0KCZkbWFfcmVxdWVzdCwgMCwgc2l6ZW9mKG14Y19kbWFfcmVxdWVz
dGJ1Zl90KSk7Ow0KKwkJZG1hX3NpemUgPSBmcmFtZXNfdG9fYnl0ZXMocnVudGltZSwgcnVudGlt
ZS0+cGVyaW9kX3NpemUpOw0KKw0KKwkJcHJfZGVidWcoImRtYV9uZXdfcGVyaW9kOiBwcnRkLT5w
ZXJpb2QgKCV4KSBydW50aW1lLT5wZXJpb2RzICglZClcbiIsDQorCQkJcHJ0ZC0+cGVyaW9kLCBy
dW50aW1lLT5wZXJpb2RzKTsNCisJCXByX2RlYnVnKCJkbWFfbmV3X3BlcmlvZDogcnVudGltZS0+
cGVyaW9kX3NpemUgKCVkKSBkbWFfc2l6ZSAoJWQpXG4iLA0KKwkJCSh1bnNpZ25lZCBpbnQpcnVu
dGltZS0+cGVyaW9kX3NpemUsDQorCQkJcnVudGltZS0+ZG1hX2J5dGVzKTsNCisNCisJCW9mZnNl
dCA9IGRtYV9zaXplICogcHJ0ZC0+cGVyaW9kOw0KKwkJc25kX2Fzc2VydChkbWFfc2l6ZSA8PSBt
eDI3X3BjbV9oYXJkd2FyZS5wZXJpb2RfYnl0ZXNfbWF4KTsNCisNCisJCWlmIChzdWJzdHJlYW0t
PnN0cmVhbSA9PSBTTkRSVl9QQ01fU1RSRUFNX1BMQVlCQUNLKSB7DQorCQkJcHJfZGVidWcoIlxu
ZG1hX25ld19wZXJpb2QgKHBsYXliYWNrKTogcnVudGltZS0+ZG1hX2FyZWEgPSAleFxub2Zmc2V0
ID0gJXhcbmRtYV9zaXplID0gJXhcbiIsDQorCQkJCXJ1bnRpbWUtPmRtYV9hcmVhLCBvZmZzZXQs
IGRtYV9zaXplKTsNCisJCQlwcl9kZWJ1ZygiXG5kbWFfbmV3X3BlcmlvZCA6IGRtYV9hZGRyIGlz
ICV4XG4iLA0KKwkJCQkgKHJ1bnRpbWUtPmRtYV9hZGRyICsgb2Zmc2V0KSk7DQorDQorCQkJZG1h
X3JlcXVlc3Quc3JjX2FkZHIgPSAoZG1hX2FkZHJfdCkocnVudGltZS0+ZG1hX2FkZHIgKyBvZmZz
ZXQpOw0KKyNpZmRlZiBDT05GSUdfU05EX1NPQ19NWDI3X1NTSTENCisNCisJCQlkbWFfcmVxdWVz
dC5kc3RfYWRkciA9IChkbWFfYWRkcl90KSAoU1NJMV9CQVNFX0FERFIgKyBNWENfU1NJMVNUWDAp
Ow0KKw0KKwkJCXByX2RlYnVnKCJkc3RfYWRkciBpcyAleFxuIiwgZG1hX3JlcXVlc3QuZHN0X2Fk
ZHIpOw0KKwkJCXByX2RlYnVnKCJzcmNfYWRkciBpcyAleFxuIiwgZG1hX3JlcXVlc3Quc3JjX2Fk
ZHIpOw0KKyNlbHNlDQorCQkJZG1hX3JlcXVlc3QuZHN0X2FkZHIgPQ0KKwkJCSAgICAoZG1hX2Fk
ZHJfdCkgKFNTSTJfQkFTRV9BRERSICsgTVhDX1NTSTJTVFgwKTsNCisjZW5kaWYNCisJCX0gZWxz
ZSB7DQorCQkJcHJfZGVidWcoIlxuZG1hX25ld19wZXJpb2QgKGNhcHR1cmUpOiBydW50aW1lLT5k
bWFfYXJlYSA9ICV4XG5vZmZzZXQgPSAleFxuZG1hX3NpemUgPSAleFxuIiwNCisJCQkJcnVudGlt
ZS0+ZG1hX2FyZWEsIG9mZnNldCwgZG1hX3NpemUpOw0KKwkJCXByX2RlYnVnKCJcbmRtYV9uZXdf
cGVyaW9kOiBkbWFfYWRkciBpcyAleFxuIiwNCisJCQkJKHJ1bnRpbWUtPmRtYV9hZGRyICsgb2Zm
c2V0KSk7DQorDQorCQkJZG1hX3JlcXVlc3QuZHN0X2FkZHIgPSAoZG1hX2FkZHJfdCkgKHJ1bnRp
bWUtPmRtYV9hZGRyICsgb2Zmc2V0KTsNCisjaWZkZWYgQ09ORklHX1NORF9TT0NfTVgyN19TU0kx
DQorCQkJZG1hX3JlcXVlc3Quc3JjX2FkZHIgPQ0KKwkJCSAgICAoZG1hX2FkZHJfdCkgKFNTSTFf
QkFTRV9BRERSICsgTVhDX1NTSTFTUlgwKTsNCisjZWxzZQ0KKwkJCWRtYV9yZXF1ZXN0LnNyY19h
ZGRyID0NCisJCQkgICAgKGRtYV9hZGRyX3QpIChTU0kyX0JBU0VfQUREUiArIE1YQ19TU0kyU1JY
MCk7DQorI2VuZGlmDQorCQl9DQorDQorCQlkbWFfcmVxdWVzdC5udW1fb2ZfYnl0ZXMgPSBkbWFf
c2l6ZTsNCisJCXByX2RlYnVnKCJkbWFfbmV3X3BlcmlvZDogU3RhcnQgRE1BIG9mZnNldCAoJWQp
IHNpemUgKCVkKVxuIiwNCisJCQkgb2Zmc2V0LCBydW50aW1lLT5kbWFfYnl0ZXMpOw0KKwkJaWYg
KHN1YnN0cmVhbS0+c3RyZWFtID09IFNORFJWX1BDTV9TVFJFQU1fUExBWUJBQ0spIHsNCisJCQlw
cl9kZWJ1ZygiZG1hX25ld19wZXJpb2Q6IGNvbmZpZ3VyaW5nIHR4IGRtYVxuIik7DQorCQkJcmV0
ID0gbXhjX2RtYV9jb25maWcocHJ0ZC0+ZG1hX2NoX3R4LCAmZG1hX3JlcXVlc3QsIDEsDQorCQkJ
CU1YQ19ETUFfTU9ERV9XUklURSk7DQorCQkJaWYgKHJldCA8IDApIHsNCisJCQkJcHJpbnRrKCJk
bWFfbmV3X3BlcmlvZDogYnVmZmVyIGNvdWxkIG5vdCBiZSBhZGRlZCBmb3IgcGxheWJhY2sgdHJh
bnNmZXJcbiIpOw0KKwkJCQlyZXR1cm4gcmV0Ow0KKwkJCX0NCisNCisJCQlwcl9kZWJ1ZygiZG1h
X25ld19wZXJpb2Q6IGVuYWJsZSAgdHggZG1hIHRyYW5zZmVyXG4iKTsNCisJCQlyZXQgPSBteGNf
ZG1hX2VuYWJsZShwcnRkLT5kbWFfY2hfdHgpOw0KKwkJCWlmIChyZXQgPCAwKSB7DQorCQkJCXBy
aW50aygiZG1hX25ld19wZXJpb2Q6IGNhbm5vdCBxdWV1ZSBETUEgYnVmZmVyXA0KKwkJCQkJCQko
JWkpXG4iLCByZXQpOw0KKwkJCQlyZXR1cm4gcmV0Ow0KKwkJCX0NCisJCX0gZWxzZSB7DQorCQkJ
cmV0ID0gbXhjX2RtYV9jb25maWcocHJ0ZC0+ZG1hX2NoX3J4LCAmZG1hX3JlcXVlc3QsIDEsIE1Y
Q19ETUFfTU9ERV9SRUFEKTsNCisJCQlpZiAocmV0IDwgMCkgew0KKwkJCQlwcmludGsoImRtYV9u
ZXdfcGVyaW9kOiBidWZmZXIgY291bGQgbm90IGJlIGFkZGVkIGZvciBjYXB0dXJlIHRyYW5zZmVy
XG4iKTsNCisJCQkJcmV0dXJuIHJldDsNCisJCQl9DQorDQorCQkJcHJfZGVidWcoImRtYV9uZXdf
cGVyaW9kOiBlbmFibGUgIGRtYSB0cmFuc2ZlclxuIik7DQorCQkJcmV0ID0gbXhjX2RtYV9lbmFi
bGUocHJ0ZC0+ZG1hX2NoX3J4KTsNCisJCQlpZihyZXQ8MCkgew0KKwkJCQlwcmludGsoImRtYV9u
ZXdfcGVyaW9kOiBjYW5ub3QgcXVldWUgRE1BIGJ1ZmZlclwNCisJCQkJCQkJKCVpKVxuIiwgcmV0
KTsNCisJCQkJcmV0dXJuIHJldDsNCisJCQl9DQorCQl9DQorDQorCQlwcl9kZWJ1ZygiZG1hX25l
d19wZXJpb2Q6IHRyYW5zZmVyIGVuYWJsZWRcbiBzcmNfYWRkciA9ICV4XG4gZHN0X2FkZHIgPSAl
eFxuIG51bV9vZl9ieWVzID0gJWRcbiIsICh2b2lkICopIGRtYV9yZXF1ZXN0LnNyY19hZGRyLCAo
dm9pZCAqKSBkbWFfcmVxdWVzdC5kc3RfYWRkciwgZG1hX3JlcXVlc3QubnVtX29mX2J5dGVzKTsN
CisNCisJCXBydGQtPnR4X3NwaW4gPSAxOyAvKiBGR0EgbGl0dGxlIHRyaWNrIHRvIHJldHJpZXZl
IERNQSBwb3MgKi8NCisJCXBydGQtPnBlcmlvZCsrOw0KKwkJcHJ0ZC0+cGVyaW9kICU9IHJ1bnRp
bWUtPnBlcmlvZHM7DQorICAgIH0NCisJcmV0dXJuIHJldDsNCit9DQorDQorDQorLyoqDQorICAq
IFRoaXMgaXMgYSBjYWxsYmFjayB3aGljaCB3aWxsIGJlIGNhbGxlZA0KKyAgKiB3aGVuIGEgVFgg
dHJhbnNmZXIgZmluaXNoZXMuIFRoZSBjYWxsIG9jY3Vycw0KKyAgKiBpbiBpbnRlcnJ1cHQgY29u
dGV4dC4NCisgICoNCisgICogQHBhcmFtCWRhdAlwb2ludGVyIHRvIHRoZSBzdHJ1Y3R1cmUgb2Yg
dGhlIGN1cnJlbnQgc3RyZWFtLg0KKyAgKg0KKyAgKi8NCitzdGF0aWMgdm9pZCBhdWRpb19kbWFf
aXJxKHZvaWQgKmRhdGEsIGludCBlcnJvciwgdW5zaWduZWQgaW50IGNvdW50KQ0KK3sNCisJc3Ry
dWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW07DQorCXN0cnVjdCBzbmRfcGNtX3J1bnRp
bWUgKnJ1bnRpbWU7DQorCXN0cnVjdCBteDI3X3J1bnRpbWVfZGF0YSAqcHJ0ZDsNCisJdW5zaWdu
ZWQgaW50IGRtYV9zaXplOw0KKwl1bnNpZ25lZCBpbnQgcHJldmlvdXNfcGVyaW9kOw0KKwl1bnNp
Z25lZCBpbnQgb2Zmc2V0Ow0KKw0KKwlzdWJzdHJlYW0gPSBkYXRhOw0KKwlydW50aW1lID0gc3Vi
c3RyZWFtLT5ydW50aW1lOw0KKwlwcnRkID0gcnVudGltZS0+cHJpdmF0ZV9kYXRhOw0KKwlwcmV2
aW91c19wZXJpb2QgID0gcHJ0ZC0+cGVyaW9kczsNCisJZG1hX3NpemUgPSBmcmFtZXNfdG9fYnl0
ZXMocnVudGltZSwgcnVudGltZS0+cGVyaW9kX3NpemUpOw0KKwlvZmZzZXQgPSBkbWFfc2l6ZSAq
IHByZXZpb3VzX3BlcmlvZDsNCisNCisJcHJ0ZC0+dHhfc3BpbiA9IDA7DQorCXBydGQtPnBlcmlv
ZHMrKzsNCisJcHJ0ZC0+cGVyaW9kcyAlPSBydW50aW1lLT5wZXJpb2RzOw0KKw0KKwlwcl9kZWJ1
ZygiYXVkaW9fZG1hX2lycTogaXJxIHBlciAlZCBvZmZzZXQgJXhcbiIsIHBydGQtPnBlcmlvZHMs
IG9mZnNldCk7DQorDQorCS8qDQorCSAgKiBJZiB3ZSBhcmUgZ2V0dGluZyBhIGNhbGxiYWNrIGZv
ciBhbiBhY3RpdmUgc3RyZWFtIHRoZW4gd2UgaW5mb3JtDQorCSAgKiB0aGUgUENNIG1pZGRsZSBs
YXllciB3ZSd2ZSBmaW5pc2hlZCBhIHBlcmlvZA0KKwkgICovDQorIAlpZiAocHJ0ZC0+YWN0aXZl
KQ0KKwkJc25kX3BjbV9wZXJpb2RfZWxhcHNlZChzdWJzdHJlYW0pOw0KKw0KKwkvKg0KKwkgICog
VHJpZyBuZXh0IERNQSB0cmFuc2Zlcg0KKwkgICovDQorCWRtYV9uZXdfcGVyaW9kKHN1YnN0cmVh
bSk7DQorfQ0KKw0KKy8qKg0KKyAgKiBUaGlzIGZ1bmN0aW9uIGNvbmZpZ3VyZXMgdGhlIGhhcmR3
YXJlIHRvIGFsbG93IGF1ZGlvDQorICAqIHBsYXliYWNrIG9wZXJhdGlvbnMuIEl0IGlzIGNhbGxl
ZCBieSBBTFNBIGZyYW1ld29yay4NCisgICoNCisgICogQHBhcmFtCXN1YnN0cmVhbQlwb2ludGVy
IHRvIHRoZSBzdHJ1Y3R1cmUgb2YgdGhlIGN1cnJlbnQgc3RyZWFtLg0KKyAgKg0KKyAgKiBAcmV0
dXJuICAgICAgICAgICAgICAwIG9uIHN1Y2Nlc3MsIC0xIG90aGVyd2lzZS4NCisgICovDQorc3Rh
dGljIGludA0KK3NuZF9teGNfcHJlcGFyZShzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0
cmVhbSkNCit7DQorCXN0cnVjdCBzbmRfcGNtX3J1bnRpbWUgKnJ1bnRpbWUgPSAgc3Vic3RyZWFt
LT5ydW50aW1lOw0KKwlzdHJ1Y3QgbXgyN19ydW50aW1lX2RhdGEgKnBydGQgPSBydW50aW1lLT5w
cml2YXRlX2RhdGE7DQorDQorCXBydGQtPnBlcmlvZCA9IDA7DQorCXBydGQtPnBlcmlvZHMgPSAw
Ow0KKw0KKwlyZXR1cm4gMDsNCit9DQorDQorc3RhdGljIGludCBteGNfcGNtX2h3X3BhcmFtcyhz
dHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwNCisJc3RydWN0IHNuZF9wY21faHdf
cGFyYW1zICpod19wYXJhbXMpDQorew0KKwlzdHJ1Y3Qgc25kX3BjbV9ydW50aW1lICpydW50aW1l
ID0gc3Vic3RyZWFtLT5ydW50aW1lOw0KKwlzdHJ1Y3QgbXgyN19ydW50aW1lX2RhdGEgKnBydGQg
PSBydW50aW1lLT5wcml2YXRlX2RhdGE7DQorCWludCByZXQ7DQorDQorCWlmKChyZXQ9c25kX3Bj
bV9saWJfbWFsbG9jX3BhZ2VzKHN1YnN0cmVhbSwgcGFyYW1zX2J1ZmZlcl9ieXRlcyhod19wYXJh
bXMpKSkgPCAwKQ0KKwl7DQorCQlwcmludGsoImlteDI3LXBjbTogZmFpbGVkIHRvIG1hbGxvYyBw
Y20gcGFnZXNcbiIpOw0KKwkJcmV0dXJuIHJldDsNCisJfQ0KKw0KKwlwcl9kZWJ1ZygibXhjX3Bj
bV9od19wYXJhbXM6IHNuZF9wY21fbGliX21hbGxvYyBwYWdlcyBoYXMgcmV0dXJuIE9LXG4iKTsN
CisJcHJfZGVidWcoIklNWDI3OiBzbmRfaW14MjdfYXVkaW9faHdfcGFyYW1zIHJ1bnRpbWUtPmRt
YV9hZGRyIDB4KCV4KVxuIiwNCisJCSAodW5zaWduZWQgaW50KXJ1bnRpbWUtPmRtYV9hZGRyKTsN
CisJcHJfZGVidWcoIklNWDI3OiBzbmRfaW14MjdfYXVkaW9faHdfcGFyYW1zIHJ1bnRpbWUtPmRt
YV9hcmVhIDB4KCV4KVxuIiwNCisJCSAodW5zaWduZWQgaW50KXJ1bnRpbWUtPmRtYV9hcmVhKTsN
CisJcHJfZGVidWcoIklNWDI3OiBzbmRfaW14MjdfYXVkaW9faHdfcGFyYW1zIHJ1bnRpbWUtPmRt
YV9ieXRlcyAweCgleClcbiIsDQorCQkgKHVuc2lnbmVkIGludClydW50aW1lLT5kbWFfYnl0ZXMp
Ow0KKw0KKwlyZXR1cm4gcmV0Ow0KK30NCisNCitzdGF0aWMgaW50IG14Y19wY21faHdfZnJlZShz
dHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSkNCit7DQorCXN0cnVjdCBzbmRfcGNt
X3J1bnRpbWUgKnJ1bnRpbWUgPSBzdWJzdHJlYW0tPnJ1bnRpbWU7DQorCXN0cnVjdCBteDI3X3J1
bnRpbWVfZGF0YSAqcHJ0ZCA9IHJ1bnRpbWUtPnByaXZhdGVfZGF0YTsNCisJDQorDQorCWlmKHN1
YnN0cmVhbS0+c3RyZWFtID09IFNORFJWX1BDTV9TVFJFQU1fUExBWUJBQ0spDQorCQlteGNfZG1h
X2ZyZWUocHJ0ZC0+ZG1hX2NoX3R4KTsNCisJZWxzZQ0KKwkJbXhjX2RtYV9mcmVlKHBydGQtPmRt
YV9jaF9yeCk7DQorDQorCXNuZF9wY21fbGliX2ZyZWVfcGFnZXMoc3Vic3RyZWFtKTsNCisNCisJ
cmV0dXJuIDA7DQorfQ0KKw0KK3N0YXRpYyBpbnQgbXhjX3BjbV90cmlnZ2VyKHN0cnVjdCBzbmRf
cGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtLCBpbnQgY21kKQ0KK3sNCisJc3RydWN0IG14MjdfcnVu
dGltZV9kYXRhICpwcnRkID0gc3Vic3RyZWFtLT5ydW50aW1lLT5wcml2YXRlX2RhdGE7DQorCWlu
dCByZXQgPSAwOw0KKw0KKwlzd2l0Y2ggKGNtZCkgew0KKwljYXNlIFNORFJWX1BDTV9UUklHR0VS
X1NUQVJUOg0KKwkJcHJ0ZC0+dHhfc3BpbiA9IDA7DQorCQkvKiByZXF1ZXN0ZWQgc3RyZWFtIHN0
YXJ0dXAgKi8NCisJCXBydGQtPmFjdGl2ZSA9IDE7DQorCQlwcl9kZWJ1ZygibXhjX3BjbV90cmln
Z2VyOiBzdGFydGluZyBkbWFfbmV3X3BlcmlvZFxuIik7DQorICAgICAgICAJcmV0ID0gZG1hX25l
d19wZXJpb2Qoc3Vic3RyZWFtKTsNCisJCWJyZWFrOw0KKwljYXNlIFNORFJWX1BDTV9UUklHR0VS
X1NUT1A6DQorCQkvKiByZXF1ZXN0ZWQgc3RyZWFtIHNodXRkb3duICovDQorCQlwcl9kZWJ1Zygi
bXhjX3BjbV90cmlnZ2VyOiBzdG9wcGluZyBkbWEgdHJhbnNmZXJcbiIpOw0KKwkJcmV0ID0gYXVk
aW9fc3RvcF9kbWEoc3Vic3RyZWFtKTsNCisJCWJyZWFrOw0KKwlkZWZhdWx0Og0KKwkJcmV0ID0g
LUVJTlZBTDsNCisJCWJyZWFrOw0KKwl9DQorDQorCXJldHVybiByZXQ7DQorfQ0KKw0KK3N0YXRp
YyBzbmRfcGNtX3VmcmFtZXNfdCBteGNfcGNtX3BvaW50ZXIoc3RydWN0IHNuZF9wY21fc3Vic3Ry
ZWFtICpzdWJzdHJlYW0pDQorew0KKwlzdHJ1Y3Qgc25kX3BjbV9ydW50aW1lICpydW50aW1lID0g
c3Vic3RyZWFtLT5ydW50aW1lOw0KKwlzdHJ1Y3QgbXgyN19ydW50aW1lX2RhdGEgKnBydGQgPSBy
dW50aW1lLT5wcml2YXRlX2RhdGE7DQorCXVuc2lnbmVkIGludCBvZmZzZXQgPSAwOw0KKw0KKwlw
cl9kZWJ1ZygibXhjX3BjbV9wb2ludGVyOlxuIHJ1bnRpbWUtPnBlcmlvZF9zaXplPSVkXG4gcHJ0
ZC0+cGVyaW9kcz0lZFxuIHJ1bnRpbWUtPmJ1ZmZlcl9zaXplPSVkXG4gcHJ0ZC0+dHhfc3Bpbj0l
ZFxuIiwNCisJCXJ1bnRpbWUtPnBlcmlvZF9zaXplLCBwcnRkLT5wZXJpb2RzLCBydW50aW1lLT5i
dWZmZXJfc2l6ZSwgcHJ0ZC0+dHhfc3Bpbik7DQorCS8qIHR4X3NwaW4gdmFsdWUgaXMgdXNlZCBo
ZXJlIHRvIGNoZWNrIGlmIGEgdHJhbnNmZXIgaXMgYWN0aXZlICovDQorCWlmIChwcnRkLT50eF9z
cGluKXsNCisJCW9mZnNldCA9IChydW50aW1lLT5wZXJpb2Rfc2l6ZSAqIChwcnRkLT5wZXJpb2Rz
KSkgKw0KKwkJCQkJCShydW50aW1lLT5wZXJpb2Rfc2l6ZSA+PiAxKTsNCisJCWlmIChvZmZzZXQg
Pj0gcnVudGltZS0+YnVmZmVyX3NpemUpDQorCQkJb2Zmc2V0ID0gcnVudGltZS0+cGVyaW9kX3Np
emUgPj4gMTsNCisJfSBlbHNlIHsNCisJCW9mZnNldCA9IChydW50aW1lLT5wZXJpb2Rfc2l6ZSAq
IChwcnRkLT5wZXJpb2RzKSk7DQorCQlpZiAob2Zmc2V0ID49IHJ1bnRpbWUtPmJ1ZmZlcl9zaXpl
KQ0KKwkJCW9mZnNldCA9IDA7DQorCX0NCisJcHJfZGVidWcoIm14Y19wY21fcG9pbnRlcjogcG9p
bnRlciBvZmZzZXQgJXhcbiIsIG9mZnNldCk7DQorCQ0KKwlyZXR1cm4gb2Zmc2V0Ow0KK30NCisN
CisvL0Fsb2NhdGlvbiBvZiBzdWJzdHJlYW0tPnJ1bnRpbWUtPnByaXZhdGVfZGF0YQ0KK3N0YXRp
YyBpbnQgbXhjX3BjbV9vcGVuKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtKQ0K
K3sNCisJc3RydWN0IHNuZF9wY21fcnVudGltZSAqcnVudGltZSA9IHN1YnN0cmVhbS0+cnVudGlt
ZTsNCisJc3RydWN0IG14MjdfcnVudGltZV9kYXRhICpwcnRkOw0KKwlpbnQgcmV0Ow0KKw0KKwlz
bmRfc29jX3NldF9ydW50aW1lX2h3cGFyYW1zKHN1YnN0cmVhbSwgJm14MjdfcGNtX2hhcmR3YXJl
KTsNCisNCisJaWYgKChyZXQgPSBzbmRfcGNtX2h3X2NvbnN0cmFpbnRfaW50ZWdlcihydW50aW1l
LA0KKwkJCQkJU05EUlZfUENNX0hXX1BBUkFNX1BFUklPRFMpKSA8IDApDQorCQlyZXR1cm4gcmV0
Ow0KKw0KKwlpZiAoKHBydGQgPSBremFsbG9jKHNpemVvZihzdHJ1Y3QgbXgyN19ydW50aW1lX2Rh
dGEpLCBHRlBfS0VSTkVMKSkgPT0gTlVMTCkgew0KKwkJcmV0ID0gLUVOT01FTTsNCisJCWdvdG8g
b3V0Ow0KKwl9DQorDQorCXJ1bnRpbWUtPnByaXZhdGVfZGF0YSA9IHBydGQ7DQorDQorCWlmKHN1
YnN0cmVhbS0+c3RyZWFtID09IFNORFJWX1BDTV9TVFJFQU1fUExBWUJBQ0spDQorCXsNCisJCQ0K
KyNpZmRlZiBDT05GSUdfU05EX1NPQ19NWDI3X1NTSTENCisJCXByX2RlYnVnKCJteGNfcGNtX29w
ZW46IFJlcXVlc3RpbmcgTVhDX0RNQV9TU0kxXzE2QklUX1RYMCBkbWEgY2hhbm5lbFxuIik7DQor
CQlwcnRkLT5kbWFfY2hfdHggID0gbXhjX2RtYV9yZXF1ZXN0KE1YQ19ETUFfU1NJMV8xNkJJVF9U
WDAsICJBTFNBIFRYIERNQSIpOw0KKyNlbHNlDQorCQlwcnRkLT5kbWFfY2hfdHggPSBteGNfZG1h
X3JlcXVlc3QoTVhDX0RNQV9TU0kyXzE2QklUX1RYMCwgIkFMU0EgVFggRE1BIik7DQorI2VuZGlm
DQorCQlpZihwcnRkLT5kbWFfY2hfdHggPCAwKQ0KKwkJeyANCisJCQlwcmludGsoImVycm9yIHJl
cXVlc3RpbmcgYSB3cml0ZShkbWEgdG8gZGV2aWNlKSBkbWEgY2hhbm5lbFxuIik7DQorCQkJcmV0
dXJuIHJldDsNCisJCX0NCisNCisJCS8qIFNldCBkbWEgY2FsbGJhY2sgKi8NCisJCXByX2RlYnVn
KCJteGNfcGNtX29wZW46IFNldHRpbmcgdHggZG1hIGNhbGxiYWNrIGZ1bmN0aW9uXG4iKTsNCisJ
CXJldCA9IG14Y19kbWFfY2FsbGJhY2tfc2V0KHBydGQtPmRtYV9jaF90eCwgKG14Y19kbWFfY2Fs
bGJhY2tfdCkgYXVkaW9fZG1hX2lycSwgKHZvaWQgKilzdWJzdHJlYW0pOw0KKwkJaWYocmV0IDwg
MCkgew0KKwkJCXByaW50aygiZXJyb3Igc2V0dGluZyBkbWEgY2FsbGJhY2sgZnVuY3Rpb25cbiIp
Ow0KKwkJCXJldHVybiByZXQ7DQorCQl9DQorDQorCQlyZXR1cm4gMDsNCisJfSBlbHNlIHsNCisj
aWZkZWYgQ09ORklHX1NORF9TT0NfTVgyN19TU0kxDQorCQlwcl9kZWJ1ZygibXhjX3BjbV9vcGVu
OiBSZXF1ZXN0aW5nIE1YQ19ETUFfU1NJMV8xNkJJVF9SWDAgZG1hIGNoYW5uZWxcbiIpOw0KKwkJ
cHJ0ZC0+ZG1hX2NoX3J4ICA9IG14Y19kbWFfcmVxdWVzdChNWENfRE1BX1NTSTFfMTZCSVRfUlgw
LCAiQUxTQSBSWCBETUEiKTsNCisjZWxzZQ0KKwkJcHJ0ZC0+ZG1hX2NoX3J4ID0gbXhjX2RtYV9y
ZXF1ZXN0KE1YQ19ETUFfU1NJMl8xNkJJVF9SWDAsICJBTFNBIFJYIERNQSIpOw0KKyNlbmRpZg0K
KwkJaWYgKHBydGQtPmRtYV9jaF9yeCA8IDApIHsgDQorCQkJcHJpbnRrKCJlcnJvciByZXF1ZXN0
aW5nIGEgcmVhZChkbWEgZnJvbSBkZXZpY2UpIGRtYSBjaGFubmVsXG4iKTsNCisJCQlyZXR1cm4g
cmV0Ow0KKwkJfQ0KKw0KKwkJLy9TZXQgZG1hIGNhbGxiYWNrDQorCQlwcl9kZWJ1ZygibXhjX3Bj
bV9vcGVuOiBTZXR0aW5nIHJ4IGRtYSBjYWxsYmFjayBmdW5jdGlvblxuIik7DQorCQlpZiAobXhj
X2RtYV9jYWxsYmFja19zZXQocHJ0ZC0+ZG1hX2NoX3J4LCAobXhjX2RtYV9jYWxsYmFja190KSBh
dWRpb19kbWFfaXJxLCAodm9pZCAqKXN1YnN0cmVhbSk8MCkNCisJCQlwcmludGsoImVycm9yIHNl
dHRpbmcgZG1hIGNhbGxiYWNrIGZ1bmN0aW9uXG4iKTsNCisNCisJCXJldHVybiAwOw0KKwl9DQor
DQorDQorDQorIG91dDoNCisJcmV0dXJuIHJldDsNCit9DQorDQorc3RhdGljIGludCBteGNfcGNt
X2Nsb3NlKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtKQ0KK3sNCisJc3RydWN0
IHNuZF9wY21fcnVudGltZSAqcnVudGltZSA9IHN1YnN0cmVhbS0+cnVudGltZTsNCisJc3RydWN0
IG14Y19ydW50aW1lX2RhdGEgKnBydGQgPSBydW50aW1lLT5wcml2YXRlX2RhdGE7DQorDQorCWtm
cmVlKHBydGQpOw0KKw0KKwlyZXR1cm4gMDsNCit9DQorDQorc3RhdGljIGludA0KK214Y19wY21f
bW1hcChzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwgc3RydWN0IHZtX2FyZWFf
c3RydWN0ICp2bWEpDQorew0KKwlzdHJ1Y3Qgc25kX3BjbV9ydW50aW1lICpydW50aW1lID0gc3Vi
c3RyZWFtLT5ydW50aW1lOw0KKwlyZXR1cm4gZG1hX21tYXBfd3JpdGVjb21iaW5lKHN1YnN0cmVh
bS0+cGNtLT5jYXJkLT5kZXYsIHZtYSwNCisJCQkJICAgICBydW50aW1lLT5kbWFfYXJlYSwNCisJ
CQkJICAgICBydW50aW1lLT5kbWFfYWRkciwNCisJCQkJICAgICBydW50aW1lLT5kbWFfYnl0ZXMp
Ow0KK30NCisNCitzdHJ1Y3Qgc25kX3BjbV9vcHMgbXhjX3BjbV9vcHMgPSB7DQorCS5vcGVuCQk9
IG14Y19wY21fb3BlbiwNCisJLmNsb3NlCQk9IG14Y19wY21fY2xvc2UsDQorCS5pb2N0bAkJPSBz
bmRfcGNtX2xpYl9pb2N0bCwNCisJLmh3X3BhcmFtcwk9IG14Y19wY21faHdfcGFyYW1zLA0KKwku
aHdfZnJlZQk9IG14Y19wY21faHdfZnJlZSwNCisJLnByZXBhcmUJPSBzbmRfbXhjX3ByZXBhcmUs
DQorCS50cmlnZ2VyCT0gbXhjX3BjbV90cmlnZ2VyLA0KKwkucG9pbnRlcgk9IG14Y19wY21fcG9p
bnRlciwNCisJLm1tYXAJCT0gbXhjX3BjbV9tbWFwLA0KK307DQorDQorc3RhdGljIHU2NCBteGNf
cGNtX2RtYW1hc2sgPSAweGZmZmZmZmZmOw0KKw0KK3N0YXRpYyBpbnQgaW14MzFfcGNtX3ByZWFs
bG9jYXRlX2RtYV9idWZmZXIoc3RydWN0IHNuZF9wY20gKnBjbSwgaW50IHN0cmVhbSkNCit7DQor
CXN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vic3RyZWFtID0gcGNtLT5zdHJlYW1zW3N0cmVh
bV0uc3Vic3RyZWFtOw0KKwlzdHJ1Y3Qgc25kX2RtYV9idWZmZXIgKmJ1ZiA9ICZzdWJzdHJlYW0t
PmRtYV9idWZmZXI7DQorCXNpemVfdCBzaXplID0gbXgyN19wY21faGFyZHdhcmUuYnVmZmVyX2J5
dGVzX21heDsNCisJYnVmLT5kZXYudHlwZSA9IFNORFJWX0RNQV9UWVBFX0RFVjsNCisJYnVmLT5k
ZXYuZGV2ID0gcGNtLT5jYXJkLT5kZXY7DQorCWJ1Zi0+cHJpdmF0ZV9kYXRhID0gTlVMTDsNCisN
CisJLy9SZXNlcnZlIHVuY2FjaGVkLWJ1ZmZlcmVkIG1lbW9yeSBhcmVhIGZvciBETUENCisJYnVm
LT5hcmVhID0gZG1hX2FsbG9jX3dyaXRlY29tYmluZShwY20tPmNhcmQtPmRldiwgc2l6ZSwNCisJ
CQkJCSAgICZidWYtPmFkZHIsIEdGUF9LRVJORUwpOw0KKw0KKwlwcl9kZWJ1ZygiaW14MjdfcGNt
OiBwcmVhbGxvY2F0ZV9kbWFfYnVmZmVyOiBhcmVhPSVwLCBhZGRyPSVwLCBzaXplPSVkXG4iLCAo
dm9pZCAqKSBidWYtPmFyZWEsICh2b2lkICopIGJ1Zi0+YWRkciwgc2l6ZSk7DQorDQorCWlmICgh
YnVmLT5hcmVhKQ0KKwkJcmV0dXJuIC1FTk9NRU07DQorCQkNCisJYnVmLT5ieXRlcyA9IHNpemU7
DQorCXJldHVybiAwOw0KK30NCisNCitzdGF0aWMgdm9pZCBpbXgzMV9wY21fZnJlZV9kbWFfYnVm
ZmVycyhzdHJ1Y3Qgc25kX3BjbSAqcGNtKQ0KK3sNCisJc3RydWN0IHNuZF9wY21fc3Vic3RyZWFt
ICpzdWJzdHJlYW07DQorCXN0cnVjdCBzbmRfZG1hX2J1ZmZlciAqYnVmOw0KKwlpbnQgc3RyZWFt
Ow0KKw0KKwlmb3IgKHN0cmVhbSA9IDA7IHN0cmVhbSA8IDI7IHN0cmVhbSsrKSB7DQorCQlzdWJz
dHJlYW0gPSBwY20tPnN0cmVhbXNbc3RyZWFtXS5zdWJzdHJlYW07DQorCQlpZiAoIXN1YnN0cmVh
bSkNCisJCQljb250aW51ZTsNCisNCisJCWJ1ZiA9ICZzdWJzdHJlYW0tPmRtYV9idWZmZXI7DQor
CQlpZiAoIWJ1Zi0+YXJlYSkNCisJCQljb250aW51ZTsNCisNCisJCWRtYV9mcmVlX3dyaXRlY29t
YmluZShwY20tPmNhcmQtPmRldiwgYnVmLT5ieXRlcywNCisJCQkJICAgICAgYnVmLT5hcmVhLCBi
dWYtPmFkZHIpOw0KKwkJYnVmLT5hcmVhID0gTlVMTDsNCisJfQ0KK30NCisNCitpbnQgbXhjX3Bj
bV9uZXcoc3RydWN0IHNuZF9jYXJkICpjYXJkLCBzdHJ1Y3Qgc25kX3NvY19kYWkgKmRhaSwNCisJ
c3RydWN0IHNuZF9wY20gKnBjbSkNCit7DQorCWludCByZXQgPSAwOw0KKw0KKwlpZiAoIWNhcmQt
PmRldi0+ZG1hX21hc2spDQorCQljYXJkLT5kZXYtPmRtYV9tYXNrID0gJm14Y19wY21fZG1hbWFz
azsNCisJaWYgKCFjYXJkLT5kZXYtPmNvaGVyZW50X2RtYV9tYXNrKQ0KKwkJY2FyZC0+ZGV2LT5j
b2hlcmVudF9kbWFfbWFzayA9IDB4ZmZmZmZmZmY7DQorDQorCWlmIChkYWktPnBsYXliYWNrLmNo
YW5uZWxzX21pbikgew0KKwkJcmV0ID0gaW14MzFfcGNtX3ByZWFsbG9jYXRlX2RtYV9idWZmZXIo
cGNtLA0KKwkJCVNORFJWX1BDTV9TVFJFQU1fUExBWUJBQ0spOw0KKwkJcHJpbnRrKCJteGNfcGNt
X25ldzogcHJlYWxsb2NhdGUgcGxheWJhY2sgYnVmZmVyXG4iKTsNCisJCWlmIChyZXQpDQorCQkJ
Z290byBvdXQ7DQorCX0NCisNCisJaWYgKGRhaS0+Y2FwdHVyZS5jaGFubmVsc19taW4pIHsNCisJ
CXJldCA9IGlteDMxX3BjbV9wcmVhbGxvY2F0ZV9kbWFfYnVmZmVyKHBjbSwNCisJCQlTTkRSVl9Q
Q01fU1RSRUFNX0NBUFRVUkUpOw0KKwkJcHJpbnRrKCJteGNfcGNtX25ldzogcHJlYWxsb2NhdGUg
Y2FwdHVyZSBidWZmZXJcbiIpOw0KKwkJaWYgKHJldCkNCisJCQlnb3RvIG91dDsNCisJfQ0KKyBv
dXQ6DQorCXJldHVybiByZXQ7DQorfQ0KKw0KK3N0cnVjdCBzbmRfc29jX3BsYXRmb3JtIGlteDI3
X3NvY19wbGF0Zm9ybSA9IHsNCisJLm5hbWUJCT0gIm14Yy1hdWRpbyIsDQorCS5wY21fb3BzIAk9
ICZteGNfcGNtX29wcywNCisJLnBjbV9uZXcJPSBteGNfcGNtX25ldywNCisJLnBjbV9mcmVlCT0g
aW14MzFfcGNtX2ZyZWVfZG1hX2J1ZmZlcnMsDQorfTsNCisNCitFWFBPUlRfU1lNQk9MX0dQTChp
bXgyN19zb2NfcGxhdGZvcm0pOw0KKw0KK01PRFVMRV9BVVRIT1IoIkphdmllciBNYXJ0aW4iKTsN
CitNT0RVTEVfREVTQ1JJUFRJT04oIkZyZWVzY2FsZSBpLk1YMjcgUENNIERNQSBtb2R1bGUiKTsN
CitNT0RVTEVfTElDRU5TRSgiR1BMIik7DQpkaWZmIC0tZ2l0IGEvc291bmQvc29jL2lteC9pbXgy
Ny1wY20uaCBiL3NvdW5kL3NvYy9pbXgvaW14MjctcGNtLmgNCm5ldyBmaWxlIG1vZGUgMTAwNjQ0
DQppbmRleCAwMDAwMDAwLi45ODUyY2ZmDQotLS0gL2Rldi9udWxsDQorKysgYi9zb3VuZC9zb2Mv
aW14L2lteDI3LXBjbS5oDQpAQCAtMCwwICsxLDk3IEBADQorLyoNCisgKiBteGMtcGNtLmggOi0g
QVNvQyBwbGF0Zm9ybSBoZWFkZXIgZm9yIEZyZWVzY2FsZSBpLk1YDQorICoNCisgKiBUaGlzIHBy
b2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3RyaWJ1dGUgaXQgYW5kL29yIG1v
ZGlmeQ0KKyAqIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExp
Y2Vuc2UgdmVyc2lvbiAyIGFzDQorICogcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZv
dW5kYXRpb24uDQorICovDQorDQorI2lmbmRlZiBfTVhDX1BDTV9IDQorI2RlZmluZSBfTVhDX1BD
TV9IDQorDQorI2luY2x1ZGUgPGFzbS9hcmNoL2RtYS5oPg0KKw0KKy8qIEFVRE1VWCByZWdzIGRl
ZmluaXRpb24gLSBNT1ZFIHRvIGFzbS9hcmNoIHdoZW4gc3RhYmxlIA0KKyNkZWZpbmUgQVVETVVY
X0lPX0JBU0VfQUREUglJT19BRERSRVNTKEFVRE1VWF9CQVNFX0FERFIpDQorDQorI2RlZmluZSBE
QU1fUFRDUjEJKCooKHZvbGF0aWxlIHUzMiAqKShBVURNVVhfSU9fQkFTRV9BRERSICsgMHgwMCkp
KQ0KKyNkZWZpbmUgREFNX1BEQ1IxCSgqKCh2b2xhdGlsZSB1MzIgKikoQVVETVVYX0lPX0JBU0Vf
QUREUiArIDB4MDQpKSkNCisjZGVmaW5lIERBTV9QVENSMgkoKigodm9sYXRpbGUgdTMyICopKEFV
RE1VWF9JT19CQVNFX0FERFIgKyAweDA4KSkpDQorI2RlZmluZSBEQU1fUERDUjIJKCooKHZvbGF0
aWxlIHUzMiAqKShBVURNVVhfSU9fQkFTRV9BRERSICsgMHgwQykpKQ0KKyNkZWZpbmUgREFNX1BU
Q1IzCSgqKCh2b2xhdGlsZSB1MzIgKikoQVVETVVYX0lPX0JBU0VfQUREUiArIDB4MTApKSkNCisj
ZGVmaW5lIERBTV9QRENSMwkoKigodm9sYXRpbGUgdTMyICopKEFVRE1VWF9JT19CQVNFX0FERFIg
KyAweDE0KSkpDQorI2RlZmluZSBEQU1fUFRDUjQJKCooKHZvbGF0aWxlIHUzMiAqKShBVURNVVhf
SU9fQkFTRV9BRERSICsgMHgxOCkpKQ0KKyNkZWZpbmUgREFNX1BEQ1I0CSgqKCh2b2xhdGlsZSB1
MzIgKikoQVVETVVYX0lPX0JBU0VfQUREUiArIDB4MUMpKSkNCisjZGVmaW5lIERBTV9QVENSNQko
Kigodm9sYXRpbGUgdTMyICopKEFVRE1VWF9JT19CQVNFX0FERFIgKyAweDIwKSkpDQorI2RlZmlu
ZSBEQU1fUERDUjUJKCooKHZvbGF0aWxlIHUzMiAqKShBVURNVVhfSU9fQkFTRV9BRERSICsgMHgy
NCkpKQ0KKyNkZWZpbmUgREFNX1BUQ1I2CSgqKCh2b2xhdGlsZSB1MzIgKikoQVVETVVYX0lPX0JB
U0VfQUREUiArIDB4MjgpKSkNCisjZGVmaW5lIERBTV9QRENSNgkoKigodm9sYXRpbGUgdTMyICop
KEFVRE1VWF9JT19CQVNFX0FERFIgKyAweDJDKSkpDQorI2RlZmluZSBEQU1fUFRDUjcJKCooKHZv
bGF0aWxlIHUzMiAqKShBVURNVVhfSU9fQkFTRV9BRERSICsgMHgzMCkpKQ0KKyNkZWZpbmUgREFN
X1BEQ1I3CSgqKCh2b2xhdGlsZSB1MzIgKikoQVVETVVYX0lPX0JBU0VfQUREUiArIDB4MzQpKSkN
CisjZGVmaW5lIERBTV9DTk1DUgkoKigodm9sYXRpbGUgdTMyICopKEFVRE1VWF9JT19CQVNFX0FE
RFIgKyAweDM4KSkpDQorI2RlZmluZSBEQU1fUFRDUihhKQkoKigodm9sYXRpbGUgdTMyICopKEFV
RE1VWF9JT19CQVNFX0FERFIgKyBhKjgpKSkNCisjZGVmaW5lIERBTV9QRENSKGEpCSgqKCh2b2xh
dGlsZSB1MzIgKikoQVVETVVYX0lPX0JBU0VfQUREUiArIDQgKyBhKjgpKSkNCisNCisNCisjZGVm
aW5lIEFVRE1VWF9QVENSX1RGU0RJUgkJKDEgPDwgMzEpDQorI2RlZmluZSBBVURNVVhfUFRDUl9U
RlNTRUwoeCwgeSkJCSgoeCA8PCAzMCkgfCAoKCh5IC0gMSkgJiAweDcpIDw8IDI3KSkNCisjZGVm
aW5lIEFVRE1VWF9QVENSX1RDTEtESVIJCSgxIDw8IDI2KQ0KKyNkZWZpbmUgQVVETVVYX1BUQ1Jf
VENTRUwoeCwgeSkJCSgoeCA8PCAyNSkgfCAoKCh5IC0gMSkgJiAweDcpIDw8IDIyKSkNCisjZGVm
aW5lIEFVRE1VWF9QVENSX1JGU0RJUgkJKDEgPDwgMjEpDQorI2RlZmluZSBBVURNVVhfUFRDUl9S
RlNTRUwoeCwgeSkJCSgoeCA8PCAyMCkgfCAoKCh5IC0gMSkgJiAweDcpIDw8IDE3KSkNCisjZGVm
aW5lIEFVRE1VWF9QVENSX1JDTEtESVIJCSgxIDw8IDE2KQ0KKyNkZWZpbmUgQVVETVVYX1BUQ1Jf
UkNTRUwoeCwgeSkJCSgoeCA8PCAxNSkgfCAoKCh5IC0gMSkgJiAweDcpIDw8IDEyKSkNCisjZGVm
aW5lIEFVRE1VWF9QVENSX1NZTgkJKDEgPDwgMTEpDQorDQorI2RlZmluZSBBVURNVVhfRlJPTV9U
WEZTCTANCisjZGVmaW5lIEFVRE1VWF9GUk9NX1JYRlMJMQ0KKw0KKyNkZWZpbmUgQVVETVVYX1BE
Q1JfUlhEU0VMKHgpCQkoKCh4IC0gMSkgJiAweDcpIDw8IDEzKQ0KKyNkZWZpbmUgQVVETVVYX1BE
Q1JfVFhEWEVOCQkoMSA8PCAxMikNCisjZGVmaW5lIEFVRE1VWF9QRENSX01PREUoeCkJCSgoKHgp
ICYgMHgzKSA8PCA4KQ0KKyNkZWZpbmUgQVVETVVYX1BEQ1JfSU5OTUFTSyh4KQkJKCgoeCkgJiAw
eGZmKSA8PCAwKQ0KKw0KKyNkZWZpbmUgQVVETVVYX0NOTUNSX0NFTgkJKDEgPDwgMTgpDQorI2Rl
ZmluZSBBVURNVVhfQ05NQ1JfRlNQT0wJCSgxIDw8IDE3KQ0KKyNkZWZpbmUgQVVETVVYX0NOTUNS
X0NMS1BPTAkJKDEgPDwgMTYpDQorI2RlZmluZSBBVURNVVhfQ05NQ1JfQ05USEkoeCkJCSgoKHgp
ICYgMHhmZikgPDwgOCkNCisjZGVmaW5lIEFVRE1VWF9DTk1DUl9DTlRMT1coeCkJCSgoKHgpICYg
MHhmZikgPDwgMCkNCisqLw0KKw0KKy8qIFByZXZpb3VzIGRlZmluZXMgYXJlIG9ubHkgdmFsaWQg
Zm9yIGlteDMxICovDQorI2RlZmluZSBBVURNVVhfSU9fQkFTRV9BRERSCUlPX0FERFJFU1MoQVVE
TVVYX0JBU0VfQUREUikNCisNCisjZGVmaW5lIERBTV9IUENSMQkoKigodm9sYXRpbGUgdTMyICop
KEFVRE1VWF9JT19CQVNFX0FERFIgKyAweDAwKSkpDQorI2RlZmluZSBEQU1fSFBDUjIJKCooKHZv
bGF0aWxlIHUzMiAqKShBVURNVVhfSU9fQkFTRV9BRERSICsgMHgwNCkpKQ0KKyNkZWZpbmUgREFN
X0hQQ1IzCSgqKCh2b2xhdGlsZSB1MzIgKikoQVVETVVYX0lPX0JBU0VfQUREUiArIDB4MDgpKSkN
CisjZGVmaW5lIERBTV9QUENSMQkoKigodm9sYXRpbGUgdTMyICopKEFVRE1VWF9JT19CQVNFX0FE
RFIgKyAweDEwKSkpDQorI2RlZmluZSBEQU1fUFBDUjIJKCooKHZvbGF0aWxlIHUzMiAqKShBVURN
VVhfSU9fQkFTRV9BRERSICsgMHgxNCkpKQ0KKyNkZWZpbmUgREFNX1BQQ1IzCSgqKCh2b2xhdGls
ZSB1MzIgKikoQVVETVVYX0lPX0JBU0VfQUREUiArIDB4MUMpKSkNCisNCisjZGVmaW5lIEFVRE1V
WF9IUENSX1RGU0RJUgkoMSA8PCAzMSkNCisjZGVmaW5lIEFVRE1VWF9IUENSX1RDTEtESVIJKDEg
PDwgMzApDQorI2RlZmluZSBBVURNVVhfSFBDUl9URkNTRUwoeCkJKCgoeCkgJiAweGZmKSA8PCAy
NikNCisjZGVmaW5lIEFVRE1VWF9IUENSX1JYRFNFTCh4KQkoKCh4KSAmIDB4NykgPDwgMTMpDQor
I2RlZmluZSBBVURNVVhfSFBDUl9TWU4JCSgxIDw8IDEyKQ0KKw0KKyNkZWZpbmUgQVVETVVYX1BQ
Q1JfVEZTRElSCSgxIDw8IDMxKQ0KKyNkZWZpbmUgQVVETVVYX1BQQ1JfVENMS0RJUgkoMSA8PCAz
MCkNCisjZGVmaW5lIEFVRE1VWF9QUENSX1RGQ1NFTCh4KQkoKCh4KSAmIDB4ZmYpIDw8IDI2KQ0K
KyNkZWZpbmUgQVVETVVYX1BQQ1JfUlhEU0VMKHgpCSgoKHgpICYgMHg3KSA8PCAxMykNCisjZGVm
aW5lIEFVRE1VWF9QUENSX1NZTgkJKDEgPDwgMTIpDQorDQorDQorDQorc3RydWN0IG14MjdfcGNt
X2RtYV9wYXJhbXMgew0KKwljaGFyICpuYW1lOwkJCS8qIHN0cmVhbSBpZGVudGlmaWVyICovDQor
CW14Y19kbWFfcmVxdWVzdGJ1Zl90IGJ1Zl9wYXJhbXM7IC8qRE1BIGJ1ZmZlciBwYXJhbXMgKi8N
CisNCit9Ow0KKw0KK2V4dGVybiBzdHJ1Y3Qgc25kX3NvY19kYWkgbXhjX3NzaV9kYWlbM107DQor
DQorLyogcGxhdGZvcm0gZGF0YSAqLw0KK2V4dGVybiBzdHJ1Y3Qgc25kX3NvY19wbGF0Zm9ybSBp
bXgyN19zb2NfcGxhdGZvcm07DQorDQorDQorI2VuZGlmDQo=
--0015174c17a8b17a9f04679620d3
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0015174c17a8b17a9f04679620d3--
