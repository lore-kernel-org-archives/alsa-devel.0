From: javier Martin <javier.martin@vista-silicon.com>
Subject: ASoC: DMA Platform driver for i.mx27
Date: Tue, 14 Apr 2009 18:17:39 +0200
Message-ID: <eedb5540904140917ic0f3626s5f6b98a2d22ec36b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0015174c3c667e756d0467862b1a
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f166.google.com (mail-ew0-f166.google.com
	[209.85.219.166])
	by alsa0.perex.cz (Postfix) with ESMTP id BB1E6243FE
	for <alsa-devel@alsa-project.org>;
	Tue, 14 Apr 2009 18:17:40 +0200 (CEST)
Received: by ewy10 with SMTP id 10so2808318ewy.32
	for <alsa-devel@alsa-project.org>; Tue, 14 Apr 2009 09:17:40 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>
List-Id: alsa-devel@alsa-project.org

--0015174c3c667e756d0467862b1a
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

This still does not support bidirectional audio but works when used playbac=
k
or capture separatelly.

SDMA API used in i.mx31 dma driver has been moved to DMA API.

Please, have patience with me, this is a very experimental version and I am
new to this world (audio codecs and linux in general).


Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>

/*
 * linux/sound/arm/mx27-pcm.c -- ALSA SoC interface for the Freescale i.MX2=
7
CPU
 *
 * Copyright 2009 Vista Silicon S.L.
 * Author: Javier Martin
 *         javier.martin@vista-silicon.com
 *
 * Based on mxc-pcm.c by    Liam Girdwood, (C) 2006 Wolfson Microelectronic=
s
PLC.
 * and on mxc-alsa-mc13783 (C) 2006 Freescale.
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 *  Revision history
 *    14th April 2009   Initial version.
 *
 */

#include <linux/module.h>
#include <linux/init.h>
#include <linux/platform_device.h>
#include <linux/slab.h>
#include <linux/dma-mapping.h>
#include <sound/driver.h>
#include <sound/core.h>
#include <sound/pcm.h>
#include <sound/pcm_params.h>
#include <sound/soc.h>
#include <asm/dma.h>
#include <asm/hardware.h>

#include "imx27-pcm.h"
#include "imx27-ssi.h" //For debugging

/* debug */
#define IMX_DEBUG 0
#if IMX_DEBUG
#define dbg(format, arg...) printk(format, ## arg)
#else
#define dbg(format, arg...)
#endif

/* Taken from drivers/mxc/ssi/registers.h just provisionally */
#define    MXC_SSI1STX0        0x00
#define    MXC_SSI1SRX0        0x08
#define    MXC_SSI2STX0        0x00
#define    MXC_SSI2SRX0        0x08

static const struct snd_pcm_hardware mx27_pcm_hardware =3D {
    .info            =3D (SNDRV_PCM_INFO_INTERLEAVED |
                   SNDRV_PCM_INFO_BLOCK_TRANSFER |
                   SNDRV_PCM_INFO_MMAP |
                   SNDRV_PCM_INFO_MMAP_VALID),
    .formats        =3D SNDRV_PCM_FMTBIT_S16_LE,
    .buffer_bytes_max    =3D 32 * 1024,
    .period_bytes_min    =3D 64,
    .period_bytes_max    =3D 8 * 1024,
    .periods_min        =3D 2,
    .periods_max        =3D 255,
    .fifo_size        =3D 0,
};

struct mx27_runtime_data {
    int dma_ch_tx; //DMA channel number for tx
    int dma_ch_rx; //DMA channel number for rx
    int active; //Is the stream active?
    unsigned int period; //Period number
    unsigned int periods; //=BF?
    int tx_spin; //=BF?
    spinlock_t dma_lock; //DMA spinlock
    struct mx27_pcm_dma_param *dma_params; //FIXME this is SDMA api
};

/*!
  * This function stops the current dma transfer for playback
  * and clears the dma pointers.
  *
  * @param    substream    pointer to the structure of the current stream.
  *
  */
static int audio_stop_dma(struct snd_pcm_substream *substream)
{
    struct snd_pcm_runtime *runtime =3D substream->runtime;
    struct mx27_runtime_data *prtd =3D runtime->private_data;
    unsigned int dma_size =3D frames_to_bytes(runtime, runtime->period_size=
);
    unsigned int offset  =3D dma_size * prtd->periods;
    unsigned long flags;

    spin_lock_irqsave(&prtd->dma_lock, flags);

//     dbg("MX27 : audio_stop_dma active =3D 0\n");
    prtd->active =3D 0;
    prtd->period =3D 0;
    prtd->periods =3D 0;

    /* this stops the dma channel and clears the buffer ptrs */

    if(substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
        if(mxc_dma_disable(prtd->dma_ch_tx)<0)
            printk("audio_stop_dma: error when stopping dma transfer in
channel %d \n", prtd->dma_ch_tx);
    }
    else {
        if(mxc_dma_disable(prtd->dma_ch_rx)<0)
            printk("audio_stop_dma: error when stopping dma transfer in
channel %d \n", prtd->dma_ch_rx);
    }
    spin_unlock_irqrestore(&prtd->dma_lock, flags);

    return 0;
}

/*!
  * This function is called whenever a new audio block needs to be
  * transferred to wm8974. The function receives the address and the size
  * of the new block and start a new DMA transfer.
  *
  * @param    substream    pointer to the structure of the current stream.
  *
  */
static int dma_new_period(struct snd_pcm_substream *substream)
{
    struct snd_pcm_runtime *runtime =3D  substream->runtime;
    struct mx27_runtime_data *prtd =3D runtime->private_data;
    unsigned int dma_size;
    unsigned int offset;
    int ret=3D0;
    mxc_dma_requestbuf_t dma_request;


    if (prtd->active){
        memset(&dma_request, 0, sizeof(mxc_dma_requestbuf_t));;
        dma_size =3D frames_to_bytes(runtime, runtime->period_size);

printk("dma_new_period: prtd->period (%x) runtime->periods (%d)\n",
            prtd->period,runtime->periods);
printk("dma_new_period: runtime->period_size (%d) dma_size (%d)\n",
            (unsigned int)runtime->period_size,
            runtime->dma_bytes);

               offset =3D dma_size * prtd->period;
        snd_assert(dma_size <=3D mx27_pcm_hardware.period_bytes_max);

        if(substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
        {
printk("\ndma_new_period (playback): runtime->dma_area =3D %x\noffset =3D
%x\ndma_size =3D %x\n", runtime->dma_area, offset, dma_size);
printk("\ndma_new_period : dma_addr is %x\n", (runtime->dma_addr + offset))=
;
              dma_request.src_addr =3D (dma_addr_t)(runtime->dma_addr +
offset);
#ifdef CONFIG_SND_SOC_MX27_SSI1

            dma_request.dst_addr =3D (dma_addr_t) (SSI1_BASE_ADDR +
MXC_SSI1STX0);
            printk("dst_addr is %x\n", dma_request.dst_addr);
            printk("src_addr is %x\n", dma_request.src_addr);
#else
            dma_request.dst_addr =3D
                (dma_addr_t) (SSI2_BASE_ADDR + MXC_SSI2STX0);
#endif
        }
        else
        {
printk("\ndma_new_period (capture): runtime->dma_area =3D %x\noffset =3D
%x\ndma_size =3D %x\n", runtime->dma_area, offset, dma_size);
printk("\ndma_new_period: dma_addr is %x\n", (runtime->dma_addr + offset));
            dma_request.dst_addr =3D (dma_addr_t) (runtime->dma_addr +
offset);
#ifdef CONFIG_SND_SOC_MX27_SSI1
            dma_request.src_addr =3D
                (dma_addr_t) (SSI1_BASE_ADDR + MXC_SSI1SRX0);
#else
            dma_request.src_addr =3D
                (dma_addr_t) (SSI2_BASE_ADDR + MXC_SSI2SRX0);
#endif
        }
        dma_request.num_of_bytes =3D dma_size; //8
        printk("dma_new_period: Start DMA offset (%d) size (%d)\n", offset,
                         runtime->dma_bytes);
        if(substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK) {
            printk("dma_neq_period: configuring tx dma\n");
            ret =3D mxc_dma_config(prtd->dma_ch_tx, &dma_request, 1,
MXC_DMA_MODE_WRITE);
            if(ret<0) {
                printk("dma_new_period: buffer could not be added for
playback transfer\n");
                return ret;
            }


            printk("dma_new_period: enable  tx dma transfer\n");
            ret =3D mxc_dma_enable(prtd->dma_ch_tx);
            if(ret<0) {
                printk("dma_new_period: cannot queue DMA buffer\
                            (%i)\n", ret);
                return ret;
            }
        }
        else
        {
            ret =3D mxc_dma_config(prtd->dma_ch_rx, &dma_request, 1,
MXC_DMA_MODE_READ);
            if(ret<0) {
                printk("dma_new_period: buffer could not be added for
capture transfer\n");
                return ret;
            }

            printk("dma_new_period: enable  dma transfer\n");
            ret =3D mxc_dma_enable(prtd->dma_ch_rx);
            if(ret<0) {
                printk("dma_new_period: cannot queue DMA buffer\
                            (%i)\n", ret);
                return ret;
            }
        }

printk("dma_new_period: transfer enabled\n src_addr =3D %x\n dst_addr =3D %=
x\n
num_of_byes =3D %d\n", (void *) dma_request.src_addr, (void *)
dma_request.dst_addr, dma_request.num_of_bytes);
        prtd->tx_spin =3D 1; /* FGA little trick to retrieve DMA pos */
        prtd->period++;
        prtd->period %=3D runtime->periods;
    }
    return ret;
}


/*!
  * This is a callback which will be called
  * when a TX transfer finishes. The call occurs
  * in interrupt context.
  *
  * @param    dat    pointer to the structure of the current stream.
  *
  */
static void audio_dma_irq(void *data, int error, unsigned int count)
{
    struct snd_pcm_substream *substream;
    struct snd_pcm_runtime *runtime;
    struct mx27_runtime_data *prtd;
    unsigned int dma_size;
    unsigned int previous_period;
    unsigned int offset;

    substream =3D data;
    runtime =3D substream->runtime;
    prtd =3D runtime->private_data;
    previous_period  =3D prtd->periods;
    dma_size =3D frames_to_bytes(runtime, runtime->period_size);
    offset =3D dma_size * previous_period;

    prtd->tx_spin =3D 0;
    prtd->periods++;
    prtd->periods %=3D runtime->periods;

//     printk("audio_dma_irq: irq per %d offset %x\n", prtd->periods,
offset);

    /*
      * Give back to the CPU the access to the non cached memory
      */
//     if(substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
//         dma_unmap_single(NULL, runtime->dma_addr + offset, dma_size,
//                             DMA_TO_DEVICE);
//     else
//         dma_unmap_single(NULL, runtime->dma_addr + offset, dma_size,
//                             DMA_FROM_DEVICE);
    /*
      * If we are getting a callback for an active stream then we inform
      * the PCM middle layer we've finished a period
      */
     if (prtd->active)
        snd_pcm_period_elapsed(substream);

    /*
      * Trig next DMA transfer
      */
    dma_new_period(substream);
}

/*!
  * This function configures the hardware to allow audio
  * playback operations. It is called by ALSA framework.
  *
  * @param    substream    pointer to the structure of the current stream.
  *
  * @return              0 on success, -1 otherwise.
  */
static int
snd_mxc_prepare(struct snd_pcm_substream *substream)
{
    struct snd_pcm_runtime *runtime =3D  substream->runtime;
    struct mx27_runtime_data *prtd =3D runtime->private_data;

    prtd->period =3D 0;
    prtd->periods =3D 0;

    return 0;
}

static int mxc_pcm_hw_params(struct snd_pcm_substream *substream,
    struct snd_pcm_hw_params *hw_params)
{
    struct snd_pcm_runtime *runtime =3D substream->runtime;
    struct mx27_runtime_data *prtd =3D runtime->private_data;
    int ret;

    if((ret=3Dsnd_pcm_lib_malloc_pages(substream,
params_buffer_bytes(hw_params))) < 0)
    {
        printk("imx27-pcm: failed to malloc pcm pages\n");
        return ret;
    }
    printk("mxc_pcm_hw_params: snd_pcm_lib_malloc pages has return OK\n");
    printk("IMX27: snd_imx27_audio_hw_params runtime->dma_addr 0x(%x)\n",
         (unsigned int)runtime->dma_addr);
    printk("IMX27: snd_imx27_audio_hw_params runtime->dma_area 0x(%x)\n",
         (unsigned int)runtime->dma_area);
    printk("IMX27: snd_imx27_audio_hw_params runtime->dma_bytes 0x(%x)\n",
         (unsigned int)runtime->dma_bytes);

    return ret;
}

static int mxc_pcm_hw_free(struct snd_pcm_substream *substream)
{
    struct snd_pcm_runtime *runtime =3D substream->runtime;
    struct mx27_runtime_data *prtd =3D runtime->private_data;


    mxc_dma_free(prtd->dma_ch_tx);
    mxc_dma_free(prtd->dma_ch_rx);
    snd_pcm_lib_free_pages(substream);

    return 0;
}

static int mxc_pcm_trigger(struct snd_pcm_substream *substream, int cmd)
{
    struct mx27_runtime_data *prtd =3D substream->runtime->private_data;
    int ret =3D 0;

    switch (cmd) {
    case SNDRV_PCM_TRIGGER_START:
        prtd->tx_spin =3D 0;
        /* requested stream startup */
        prtd->active =3D 1;
        printk("mxc_pcm_trigger: starting dma_new_period\n");
            ret =3D dma_new_period(substream);
        break;
    case SNDRV_PCM_TRIGGER_STOP:
        /* requested stream shutdown */
        printk("mxc_pcm_trigger: stopping dma transfer\n");
        ret =3D audio_stop_dma(substream);
        break;
    default:
        ret =3D -EINVAL;
        break;
    }

    return ret;
}

static snd_pcm_uframes_t mxc_pcm_pointer(struct snd_pcm_substream
*substream)
{
    struct snd_pcm_runtime *runtime =3D substream->runtime;
    struct mx27_runtime_data *prtd =3D runtime->private_data;
    unsigned int offset =3D 0;

printk("mxc_pcm_pointer:\n runtime->period_size=3D%d\n prtd->periods=3D%d\n
runtime->buffer_size=3D%d\n prtd->tx_spin=3D%d\n", runtime->period_size,
prtd->periods, runtime->buffer_size, prtd->tx_spin);
    /* tx_spin value is used here to check if a transfer is active */
    if (prtd->tx_spin){
        offset =3D (runtime->period_size * (prtd->periods)) +
                        (runtime->period_size >> 1);
        if (offset >=3D runtime->buffer_size)
            offset =3D runtime->period_size >> 1;
    } else {
        offset =3D (runtime->period_size * (prtd->periods));
        if (offset >=3D runtime->buffer_size)
            offset =3D 0;
    }
printk("mxc_pcm_pointer: pointer offset %x\n", offset);

    return offset;
}

//Alocation of substream->runtime->private_data
static int mxc_pcm_open(struct snd_pcm_substream *substream)
{
    struct snd_pcm_runtime *runtime =3D substream->runtime;
    struct mx27_runtime_data *prtd;
    int ret;

    snd_soc_set_runtime_hwparams(substream, &mx27_pcm_hardware);

    //??
    if ((ret =3D snd_pcm_hw_constraint_integer(runtime,
                    SNDRV_PCM_HW_PARAM_PERIODS)) < 0)
        return ret;

    if((prtd =3D kzalloc(sizeof(struct mx27_runtime_data), GFP_KERNEL)) =3D=
=3D
NULL) {
        ret =3D -ENOMEM;
        goto out;
    }

    runtime->private_data =3D prtd;

    if(substream->stream =3D=3D SNDRV_PCM_STREAM_PLAYBACK)
    {

#ifdef CONFIG_SND_SOC_MX27_SSI1
printk("mxc_pcm_open: Requesting MXC_DMA_SSI1_16BIT_TX0 dma channel\n");
        prtd->dma_ch_tx  =3D mxc_dma_request(MXC_DMA_SSI1_16BIT_TX0, "ALSA =
TX
DMA"); //MXC_DMA_TEST_RAM2RAM
#else
        prtd->dma_ch_tx =3D mxc_dma_request(MXC_DMA_SSI2_16BIT_TX0, "ALSA T=
X
DMA");
#endif
        if(prtd->dma_ch_tx < 0)
        {
            printk("error requesting a write(dma to device) dma channel\n")=
;
            return ret;
        }

        //Set dma callback
printk("mxc_pcm_open: Setting tx dma callback function\n");
        ret =3D mxc_dma_callback_set(prtd->dma_ch_tx, (mxc_dma_callback_t)
audio_dma_irq, (void *)substream);
        if(ret<0) {
            printk("error setting dma callback function\n");
            return ret;
        }

        return 0;
    }
    else
    {
#ifdef CONFIG_SND_SOC_MX27_SSI1
printk("mxc_pcm_open: Requesting MXC_DMA_SSI1_16BIT_RX0 dma channel\n");
        prtd->dma_ch_rx  =3D mxc_dma_request(MXC_DMA_SSI1_16BIT_RX0, "ALSA =
RX
DMA");
#else
        prtd->dma_ch_rx =3D mxc_dma_request(MXC_DMA_SSI2_16BIT_RX0, "ALSA R=
X
DMA");
#endif
        if(prtd->dma_ch_rx < 0)
        {
            printk("error requesting a read(dma from device) dma
channel\n");
            return ret;
        }

        //Set dma callback
printk("mxc_pcm_open: Setting rx dma callback function\n");
        if(mxc_dma_callback_set(prtd->dma_ch_rx, (mxc_dma_callback_t)
audio_dma_irq, (void *)substream)<0)
            printk("error setting dma callback function\n");

        return 0;
    }



 out:
    return ret;
}

static int mxc_pcm_close(struct snd_pcm_substream *substream)
{
    struct snd_pcm_runtime *runtime =3D substream->runtime;
    struct mxc_runtime_data *prtd =3D runtime->private_data;

    kfree(prtd);

    return 0;
}

static int
mxc_pcm_mmap(struct snd_pcm_substream *substream, struct vm_area_struct
*vma)
{
    struct snd_pcm_runtime *runtime =3D substream->runtime;
    return dma_mmap_writecombine(substream->pcm->card->dev, vma,
                     runtime->dma_area,
                     runtime->dma_addr,
                     runtime->dma_bytes);
}

struct snd_pcm_ops mxc_pcm_ops =3D {
    .open        =3D mxc_pcm_open,
    .close        =3D mxc_pcm_close,
    .ioctl        =3D snd_pcm_lib_ioctl,
    .hw_params    =3D mxc_pcm_hw_params,
    .hw_free    =3D mxc_pcm_hw_free,
    .prepare    =3D snd_mxc_prepare,
    .trigger    =3D mxc_pcm_trigger,
    .pointer    =3D mxc_pcm_pointer,
    .mmap        =3D mxc_pcm_mmap,
};

static u64 mxc_pcm_dmamask =3D 0xffffffff;

static int imx31_pcm_preallocate_dma_buffer(struct snd_pcm *pcm, int stream=
)
{
    struct snd_pcm_substream *substream =3D pcm->streams[stream].substream;
    struct snd_dma_buffer *buf =3D &substream->dma_buffer;
    size_t size =3D mx27_pcm_hardware.buffer_bytes_max;
    buf->dev.type =3D SNDRV_DMA_TYPE_DEV;
    buf->dev.dev =3D pcm->card->dev;
    buf->private_data =3D NULL;

    //Reserve uncached-buffered memory area for DMA
    buf->area =3D dma_alloc_writecombine(pcm->card->dev, size,
                       &buf->addr, GFP_KERNEL);

    printk("imx27_pcm: preallocate_dma_buffer: area=3D%p, addr=3D%p, size=
=3D%d\n",
(void *) buf->area, (void *) buf->addr, size);

    if (!buf->area)
        return -ENOMEM;

    buf->bytes =3D size;
    return 0;
}

static void imx31_pcm_free_dma_buffers(struct snd_pcm *pcm)
{
    struct snd_pcm_substream *substream;
    struct snd_dma_buffer *buf;
    int stream;

    for (stream =3D 0; stream < 2; stream++) {
        substream =3D pcm->streams[stream].substream;
        if (!substream)
            continue;

        buf =3D &substream->dma_buffer;
        if (!buf->area)
            continue;

        dma_free_writecombine(pcm->card->dev, buf->bytes,
                      buf->area, buf->addr);
        buf->area =3D NULL;
    }
}

int mxc_pcm_new(struct snd_card *card, struct snd_soc_dai *dai,
    struct snd_pcm *pcm)
{
    int ret =3D 0;

    if (!card->dev->dma_mask)
        card->dev->dma_mask =3D &mxc_pcm_dmamask;
    if (!card->dev->coherent_dma_mask)
        card->dev->coherent_dma_mask =3D 0xffffffff;

    if (dai->playback.channels_min) {
        ret =3D imx31_pcm_preallocate_dma_buffer(pcm,
            SNDRV_PCM_STREAM_PLAYBACK);
        printk("mxc_pcm_new: preallocate playback buffer\n");
        if (ret)
            goto out;
    }

    if (dai->capture.channels_min) {
        ret =3D imx31_pcm_preallocate_dma_buffer(pcm,
            SNDRV_PCM_STREAM_CAPTURE);
        printk("mxc_pcm_new: preallocate capture buffer\n");
        if (ret)
            goto out;
    }
 out:
    return ret;
}

struct snd_soc_platform imx27_soc_platform =3D {
    .name        =3D "mxc-audio",
    .pcm_ops     =3D &mxc_pcm_ops,
    .pcm_new    =3D mxc_pcm_new,
    .pcm_free    =3D imx31_pcm_free_dma_buffers,
};

EXPORT_SYMBOL_GPL(imx27_soc_platform);

MODULE_AUTHOR("Javier Martin");
MODULE_DESCRIPTION("Freescale i.MX27 PCM DMA module");
MODULE_LICENSE("GPL");


/*
 * mx27-pcm.h :- ASoC platform header for Freescale i.MX27
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 */

#ifndef _MXC_PCM_H
#define _MXC_PCM_H

#include <asm/arch/dma.h>

/* AUDMUX regs definition - MOVE to asm/arch when stable
#define AUDMUX_IO_BASE_ADDR    IO_ADDRESS(AUDMUX_BASE_ADDR)

#define DAM_PTCR1    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x00)))
#define DAM_PDCR1    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x04)))
#define DAM_PTCR2    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x08)))
#define DAM_PDCR2    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x0C)))
#define DAM_PTCR3    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x10)))
#define DAM_PDCR3    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x14)))
#define DAM_PTCR4    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x18)))
#define DAM_PDCR4    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x1C)))
#define DAM_PTCR5    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x20)))
#define DAM_PDCR5    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x24)))
#define DAM_PTCR6    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x28)))
#define DAM_PDCR6    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x2C)))
#define DAM_PTCR7    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x30)))
#define DAM_PDCR7    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x34)))
#define DAM_CNMCR    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x38)))
#define DAM_PTCR(a)    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + a*8)))
#define DAM_PDCR(a)    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 4 + a*8)))


#define AUDMUX_PTCR_TFSDIR        (1 << 31)
#define AUDMUX_PTCR_TFSSEL(x, y)        ((x << 30) | (((y - 1) & 0x7) <<
27))
#define AUDMUX_PTCR_TCLKDIR        (1 << 26)
#define AUDMUX_PTCR_TCSEL(x, y)        ((x << 25) | (((y - 1) & 0x7) << 22)=
)
#define AUDMUX_PTCR_RFSDIR        (1 << 21)
#define AUDMUX_PTCR_RFSSEL(x, y)        ((x << 20) | (((y - 1) & 0x7) <<
17))
#define AUDMUX_PTCR_RCLKDIR        (1 << 16)
#define AUDMUX_PTCR_RCSEL(x, y)        ((x << 15) | (((y - 1) & 0x7) << 12)=
)
#define AUDMUX_PTCR_SYN        (1 << 11)

#define AUDMUX_FROM_TXFS    0
#define AUDMUX_FROM_RXFS    1

#define AUDMUX_PDCR_RXDSEL(x)        (((x - 1) & 0x7) << 13)
#define AUDMUX_PDCR_TXDXEN        (1 << 12)
#define AUDMUX_PDCR_MODE(x)        (((x) & 0x3) << 8)
#define AUDMUX_PDCR_INNMASK(x)        (((x) & 0xff) << 0)

#define AUDMUX_CNMCR_CEN        (1 << 18)
#define AUDMUX_CNMCR_FSPOL        (1 << 17)
#define AUDMUX_CNMCR_CLKPOL        (1 << 16)
#define AUDMUX_CNMCR_CNTHI(x)        (((x) & 0xff) << 8)
#define AUDMUX_CNMCR_CNTLOW(x)        (((x) & 0xff) << 0)
*/

/* Previous defines are only valid for imx31 */
#define AUDMUX_IO_BASE_ADDR    IO_ADDRESS(AUDMUX_BASE_ADDR)

#define DAM_HPCR1    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x00)))
#define DAM_HPCR2    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x04)))
#define DAM_HPCR3    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x08)))
#define DAM_PPCR1    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x10)))
#define DAM_PPCR2    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x14)))
#define DAM_PPCR3    (*((volatile u32 *)(AUDMUX_IO_BASE_ADDR + 0x1C)))

#define AUDMUX_HPCR_TFSDIR    (1 << 31)
#define AUDMUX_HPCR_TCLKDIR    (1 << 30)
#define AUDMUX_HPCR_TFCSEL(x)    (((x) & 0xff) << 26)
#define AUDMUX_HPCR_RXDSEL(x)    (((x) & 0x7) << 13)
#define AUDMUX_HPCR_SYN        (1 << 12)

#define AUDMUX_PPCR_TFSDIR    (1 << 31)
#define AUDMUX_PPCR_TCLKDIR    (1 << 30)
#define AUDMUX_PPCR_TFCSEL(x)    (((x) & 0xff) << 26)
#define AUDMUX_PPCR_RXDSEL(x)    (((x) & 0x7) << 13)
#define AUDMUX_PPCR_SYN        (1 << 12)



struct mx27_pcm_dma_params {
    char *name;            /* stream identifier */
    mxc_dma_requestbuf_t buf_params; /*DMA buffer params */

};

extern struct snd_soc_dai mxc_ssi_dai[3];

/* platform data */
extern struct snd_soc_platform imx27_soc_platform;


#endif

--0015174c3c667e756d0467862b1a
Content-Type: text/x-csrc; name="imx27-pcm.c"
Content-Disposition: attachment; filename="imx27-pcm.c"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ftisp8xl0

LyoKICogbGludXgvc291bmQvYXJtL214MjctcGNtLmMgLS0gQUxTQSBTb0MgaW50ZXJmYWNlIGZv
ciB0aGUgRnJlZXNjYWxlIGkuTVgyNyBDUFUKICoKICogQ29weXJpZ2h0IDIwMDkgVmlzdGEgU2ls
aWNvbiBTLkwuCiAqIEF1dGhvcjogSmF2aWVyIE1hcnRpbgogKiAgICAgICAgIGphdmllci5tYXJ0
aW5AdmlzdGEtc2lsaWNvbi5jb20KICoKICogQmFzZWQgb24gbXhjLXBjbS5jIGJ5CUxpYW0gR2ly
ZHdvb2QsIChDKSAyMDA2IFdvbGZzb24gTWljcm9lbGVjdHJvbmljcyBQTEMuCiAqIGFuZCBvbiBt
eGMtYWxzYS1tYzEzNzgzIChDKSAyMDA2IEZyZWVzY2FsZS4KICoKICogVGhpcyBwcm9ncmFtIGlz
IGZyZWUgc29mdHdhcmU7IHlvdSBjYW4gcmVkaXN0cmlidXRlIGl0IGFuZC9vciBtb2RpZnkKICog
aXQgdW5kZXIgdGhlIHRlcm1zIG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSB2ZXJz
aW9uIDIgYXMKICogcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlIEZvdW5kYXRpb24uCiAq
CiAqICBSZXZpc2lvbiBoaXN0b3J5CiAqICAgIDE0dGggQXByaWwgMjAwOSAgIEluaXRpYWwgdmVy
c2lvbi4KICoKICovCgojaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+CiNpbmNsdWRlIDxsaW51eC9p
bml0Lmg+CiNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4KI2luY2x1ZGUgPGxpbnV4
L3NsYWIuaD4KI2luY2x1ZGUgPGxpbnV4L2RtYS1tYXBwaW5nLmg+CiNpbmNsdWRlIDxzb3VuZC9k
cml2ZXIuaD4KI2luY2x1ZGUgPHNvdW5kL2NvcmUuaD4KI2luY2x1ZGUgPHNvdW5kL3BjbS5oPgoj
aW5jbHVkZSA8c291bmQvcGNtX3BhcmFtcy5oPgojaW5jbHVkZSA8c291bmQvc29jLmg+CiNpbmNs
dWRlIDxhc20vZG1hLmg+CiNpbmNsdWRlIDxhc20vaGFyZHdhcmUuaD4KCiNpbmNsdWRlICJpbXgy
Ny1wY20uaCIKI2luY2x1ZGUgImlteDI3LXNzaS5oIiAvL0ZvciBkZWJ1Z2dpbmcKCi8qIGRlYnVn
ICovCiNkZWZpbmUgSU1YX0RFQlVHIDAKI2lmIElNWF9ERUJVRwojZGVmaW5lIGRiZyhmb3JtYXQs
IGFyZy4uLikgcHJpbnRrKGZvcm1hdCwgIyMgYXJnKQojZWxzZQojZGVmaW5lIGRiZyhmb3JtYXQs
IGFyZy4uLikKI2VuZGlmCgovKiBUYWtlbiBmcm9tIGRyaXZlcnMvbXhjL3NzaS9yZWdpc3RlcnMu
aCBqdXN0IHByb3Zpc2lvbmFsbHkgKi8KI2RlZmluZSAgICBNWENfU1NJMVNUWDAJCTB4MDAKI2Rl
ZmluZSAgICBNWENfU1NJMVNSWDAJCTB4MDgKI2RlZmluZSAgICBNWENfU1NJMlNUWDAJCTB4MDAK
I2RlZmluZSAgICBNWENfU1NJMlNSWDAJCTB4MDgKCnN0YXRpYyBjb25zdCBzdHJ1Y3Qgc25kX3Bj
bV9oYXJkd2FyZSBteDI3X3BjbV9oYXJkd2FyZSA9IHsKCS5pbmZvCQkJPSAoU05EUlZfUENNX0lO
Rk9fSU5URVJMRUFWRUQgfAoJCQkJICAgU05EUlZfUENNX0lORk9fQkxPQ0tfVFJBTlNGRVIgfAoJ
CQkJICAgU05EUlZfUENNX0lORk9fTU1BUCB8CgkJCQkgICBTTkRSVl9QQ01fSU5GT19NTUFQX1ZB
TElEKSwKCS5mb3JtYXRzCQk9IFNORFJWX1BDTV9GTVRCSVRfUzE2X0xFLAoJLmJ1ZmZlcl9ieXRl
c19tYXgJPSAzMiAqIDEwMjQsCgkucGVyaW9kX2J5dGVzX21pbgk9IDY0LAoJLnBlcmlvZF9ieXRl
c19tYXgJPSA4ICogMTAyNCwKCS5wZXJpb2RzX21pbgkJPSAyLAoJLnBlcmlvZHNfbWF4CQk9IDI1
NSwKCS5maWZvX3NpemUJCT0gMCwKfTsKCnN0cnVjdCBteDI3X3J1bnRpbWVfZGF0YSB7CglpbnQg
ZG1hX2NoX3R4OyAvL0RNQSBjaGFubmVsIG51bWJlciBmb3IgdHgKCWludCBkbWFfY2hfcng7IC8v
RE1BIGNoYW5uZWwgbnVtYmVyIGZvciByeAoJaW50IGFjdGl2ZTsgLy9JcyB0aGUgc3RyZWFtIGFj
dGl2ZT8KCXVuc2lnbmVkIGludCBwZXJpb2Q7IC8vUGVyaW9kIG51bWJlciAKCXVuc2lnbmVkIGlu
dCBwZXJpb2RzOyAvL78/CglpbnQgdHhfc3BpbjsgLy+/PwoJc3BpbmxvY2tfdCBkbWFfbG9jazsg
Ly9ETUEgc3BpbmxvY2sKCXN0cnVjdCBteDI3X3BjbV9kbWFfcGFyYW0gKmRtYV9wYXJhbXM7IC8v
RklYTUUgdGhpcyBpcyBTRE1BIGFwaQp9OwoKLyohCiAgKiBUaGlzIGZ1bmN0aW9uIHN0b3BzIHRo
ZSBjdXJyZW50IGRtYSB0cmFuc2ZlciBmb3IgcGxheWJhY2sKICAqIGFuZCBjbGVhcnMgdGhlIGRt
YSBwb2ludGVycy4KICAqCiAgKiBAcGFyYW0Jc3Vic3RyZWFtCXBvaW50ZXIgdG8gdGhlIHN0cnVj
dHVyZSBvZiB0aGUgY3VycmVudCBzdHJlYW0uCiAgKgogICovCnN0YXRpYyBpbnQgYXVkaW9fc3Rv
cF9kbWEoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0pCnsKCXN0cnVjdCBzbmRf
cGNtX3J1bnRpbWUgKnJ1bnRpbWUgPSBzdWJzdHJlYW0tPnJ1bnRpbWU7CglzdHJ1Y3QgbXgyN19y
dW50aW1lX2RhdGEgKnBydGQgPSBydW50aW1lLT5wcml2YXRlX2RhdGE7Cgl1bnNpZ25lZCBpbnQg
ZG1hX3NpemUgPSBmcmFtZXNfdG9fYnl0ZXMocnVudGltZSwgcnVudGltZS0+cGVyaW9kX3NpemUp
OwoJdW5zaWduZWQgaW50IG9mZnNldCAgPSBkbWFfc2l6ZSAqIHBydGQtPnBlcmlvZHM7Cgl1bnNp
Z25lZCBsb25nIGZsYWdzOwoKCXNwaW5fbG9ja19pcnFzYXZlKCZwcnRkLT5kbWFfbG9jaywgZmxh
Z3MpOwoKLy8gCWRiZygiTVgyNyA6IGF1ZGlvX3N0b3BfZG1hIGFjdGl2ZSA9IDBcbiIpOwoJcHJ0
ZC0+YWN0aXZlID0gMDsKCXBydGQtPnBlcmlvZCA9IDA7CglwcnRkLT5wZXJpb2RzID0gMDsKCgkv
KiB0aGlzIHN0b3BzIHRoZSBkbWEgY2hhbm5lbCBhbmQgY2xlYXJzIHRoZSBidWZmZXIgcHRycyAq
LwoKCWlmKHN1YnN0cmVhbS0+c3RyZWFtID09IFNORFJWX1BDTV9TVFJFQU1fUExBWUJBQ0spIHsK
CQlpZihteGNfZG1hX2Rpc2FibGUocHJ0ZC0+ZG1hX2NoX3R4KTwwKQoJCQlwcmludGsoImF1ZGlv
X3N0b3BfZG1hOiBlcnJvciB3aGVuIHN0b3BwaW5nIGRtYSB0cmFuc2ZlciBpbiBjaGFubmVsICVk
IFxuIiwgcHJ0ZC0+ZG1hX2NoX3R4KTsgCgl9CgllbHNlIHsKCQlpZihteGNfZG1hX2Rpc2FibGUo
cHJ0ZC0+ZG1hX2NoX3J4KTwwKQoJCQlwcmludGsoImF1ZGlvX3N0b3BfZG1hOiBlcnJvciB3aGVu
IHN0b3BwaW5nIGRtYSB0cmFuc2ZlciBpbiBjaGFubmVsICVkIFxuIiwgcHJ0ZC0+ZG1hX2NoX3J4
KTsgCgl9CglzcGluX3VubG9ja19pcnFyZXN0b3JlKCZwcnRkLT5kbWFfbG9jaywgZmxhZ3MpOwoK
CXJldHVybiAwOwp9CgovKiEKICAqIFRoaXMgZnVuY3Rpb24gaXMgY2FsbGVkIHdoZW5ldmVyIGEg
bmV3IGF1ZGlvIGJsb2NrIG5lZWRzIHRvIGJlCiAgKiB0cmFuc2ZlcnJlZCB0byB3bTg5NzQuIFRo
ZSBmdW5jdGlvbiByZWNlaXZlcyB0aGUgYWRkcmVzcyBhbmQgdGhlIHNpemUKICAqIG9mIHRoZSBu
ZXcgYmxvY2sgYW5kIHN0YXJ0IGEgbmV3IERNQSB0cmFuc2Zlci4KICAqCiAgKiBAcGFyYW0Jc3Vi
c3RyZWFtCXBvaW50ZXIgdG8gdGhlIHN0cnVjdHVyZSBvZiB0aGUgY3VycmVudCBzdHJlYW0uCiAg
KgogICovCnN0YXRpYyBpbnQgZG1hX25ld19wZXJpb2Qoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFt
ICpzdWJzdHJlYW0pCnsKCXN0cnVjdCBzbmRfcGNtX3J1bnRpbWUgKnJ1bnRpbWUgPSAgc3Vic3Ry
ZWFtLT5ydW50aW1lOwoJc3RydWN0IG14MjdfcnVudGltZV9kYXRhICpwcnRkID0gcnVudGltZS0+
cHJpdmF0ZV9kYXRhOwoJdW5zaWduZWQgaW50IGRtYV9zaXplOwoJdW5zaWduZWQgaW50IG9mZnNl
dDsKCWludCByZXQ9MDsKCW14Y19kbWFfcmVxdWVzdGJ1Zl90IGRtYV9yZXF1ZXN0OwoKCglpZiAo
cHJ0ZC0+YWN0aXZlKXsKCQltZW1zZXQoJmRtYV9yZXF1ZXN0LCAwLCBzaXplb2YobXhjX2RtYV9y
ZXF1ZXN0YnVmX3QpKTs7CgkJZG1hX3NpemUgPSBmcmFtZXNfdG9fYnl0ZXMocnVudGltZSwgcnVu
dGltZS0+cGVyaW9kX3NpemUpOwoKcHJpbnRrKCJkbWFfbmV3X3BlcmlvZDogcHJ0ZC0+cGVyaW9k
ICgleCkgcnVudGltZS0+cGVyaW9kcyAoJWQpXG4iLAoJCQlwcnRkLT5wZXJpb2QscnVudGltZS0+
cGVyaW9kcyk7CnByaW50aygiZG1hX25ld19wZXJpb2Q6IHJ1bnRpbWUtPnBlcmlvZF9zaXplICgl
ZCkgZG1hX3NpemUgKCVkKVxuIiwKCQkJKHVuc2lnbmVkIGludClydW50aW1lLT5wZXJpb2Rfc2l6
ZSwKCQkJcnVudGltZS0+ZG1hX2J5dGVzKTsKCiAgICAgICAJCW9mZnNldCA9IGRtYV9zaXplICog
cHJ0ZC0+cGVyaW9kOwoJCXNuZF9hc3NlcnQoZG1hX3NpemUgPD0gbXgyN19wY21faGFyZHdhcmUu
cGVyaW9kX2J5dGVzX21heCk7CgoJCWlmKHN1YnN0cmVhbS0+c3RyZWFtID09IFNORFJWX1BDTV9T
VFJFQU1fUExBWUJBQ0spCgkJewpwcmludGsoIlxuZG1hX25ld19wZXJpb2QgKHBsYXliYWNrKTog
cnVudGltZS0+ZG1hX2FyZWEgPSAleFxub2Zmc2V0ID0gJXhcbmRtYV9zaXplID0gJXhcbiIsIHJ1
bnRpbWUtPmRtYV9hcmVhLCBvZmZzZXQsIGRtYV9zaXplKTsKcHJpbnRrKCJcbmRtYV9uZXdfcGVy
aW9kIDogZG1hX2FkZHIgaXMgJXhcbiIsIChydW50aW1lLT5kbWFfYWRkciArIG9mZnNldCkpOwog
IAkJCWRtYV9yZXF1ZXN0LnNyY19hZGRyID0gKGRtYV9hZGRyX3QpKHJ1bnRpbWUtPmRtYV9hZGRy
ICsgb2Zmc2V0KTsKI2lmZGVmIENPTkZJR19TTkRfU09DX01YMjdfU1NJMQoKCQkJZG1hX3JlcXVl
c3QuZHN0X2FkZHIgPSAoZG1hX2FkZHJfdCkgKFNTSTFfQkFTRV9BRERSICsgTVhDX1NTSTFTVFgw
KTsKCQkJcHJpbnRrKCJkc3RfYWRkciBpcyAleFxuIiwgZG1hX3JlcXVlc3QuZHN0X2FkZHIpOwoJ
CQlwcmludGsoInNyY19hZGRyIGlzICV4XG4iLCBkbWFfcmVxdWVzdC5zcmNfYWRkcik7CiNlbHNl
CgkJCWRtYV9yZXF1ZXN0LmRzdF9hZGRyID0KCQkJICAgIChkbWFfYWRkcl90KSAoU1NJMl9CQVNF
X0FERFIgKyBNWENfU1NJMlNUWDApOwojZW5kaWYKCQl9CgkJZWxzZQoJCXsKcHJpbnRrKCJcbmRt
YV9uZXdfcGVyaW9kIChjYXB0dXJlKTogcnVudGltZS0+ZG1hX2FyZWEgPSAleFxub2Zmc2V0ID0g
JXhcbmRtYV9zaXplID0gJXhcbiIsIHJ1bnRpbWUtPmRtYV9hcmVhLCBvZmZzZXQsIGRtYV9zaXpl
KTsKcHJpbnRrKCJcbmRtYV9uZXdfcGVyaW9kOiBkbWFfYWRkciBpcyAleFxuIiwgKHJ1bnRpbWUt
PmRtYV9hZGRyICsgb2Zmc2V0KSk7CgkJCWRtYV9yZXF1ZXN0LmRzdF9hZGRyID0gKGRtYV9hZGRy
X3QpIChydW50aW1lLT5kbWFfYWRkciArIG9mZnNldCk7CiNpZmRlZiBDT05GSUdfU05EX1NPQ19N
WDI3X1NTSTEKCQkJZG1hX3JlcXVlc3Quc3JjX2FkZHIgPQoJCQkgICAgKGRtYV9hZGRyX3QpIChT
U0kxX0JBU0VfQUREUiArIE1YQ19TU0kxU1JYMCk7CiNlbHNlCgkJCWRtYV9yZXF1ZXN0LnNyY19h
ZGRyID0KCQkJICAgIChkbWFfYWRkcl90KSAoU1NJMl9CQVNFX0FERFIgKyBNWENfU1NJMlNSWDAp
OwojZW5kaWYKCQl9CgkJZG1hX3JlcXVlc3QubnVtX29mX2J5dGVzID0gZG1hX3NpemU7IC8vOAoJ
CXByaW50aygiZG1hX25ld19wZXJpb2Q6IFN0YXJ0IERNQSBvZmZzZXQgKCVkKSBzaXplICglZClc
biIsIG9mZnNldCwKCQkJCQkJIHJ1bnRpbWUtPmRtYV9ieXRlcyk7CgkJaWYoc3Vic3RyZWFtLT5z
dHJlYW0gPT0gU05EUlZfUENNX1NUUkVBTV9QTEFZQkFDSykgewoJCQlwcmludGsoImRtYV9uZXFf
cGVyaW9kOiBjb25maWd1cmluZyB0eCBkbWFcbiIpOwoJCQlyZXQgPSBteGNfZG1hX2NvbmZpZyhw
cnRkLT5kbWFfY2hfdHgsICZkbWFfcmVxdWVzdCwgMSwgTVhDX0RNQV9NT0RFX1dSSVRFKTsKCQkJ
aWYocmV0PDApIHsKCQkJCXByaW50aygiZG1hX25ld19wZXJpb2Q6IGJ1ZmZlciBjb3VsZCBub3Qg
YmUgYWRkZWQgZm9yIHBsYXliYWNrIHRyYW5zZmVyXG4iKTsKCQkJCXJldHVybiByZXQ7CgkJCX0K
CQkJCQoKCQkJcHJpbnRrKCJkbWFfbmV3X3BlcmlvZDogZW5hYmxlICB0eCBkbWEgdHJhbnNmZXJc
biIpOwoJCQlyZXQgPSBteGNfZG1hX2VuYWJsZShwcnRkLT5kbWFfY2hfdHgpOwoJCQlpZihyZXQ8
MCkgewoJCQkJcHJpbnRrKCJkbWFfbmV3X3BlcmlvZDogY2Fubm90IHF1ZXVlIERNQSBidWZmZXJc
CgkJCQkJCQkoJWkpXG4iLCByZXQpOwoJCQkJcmV0dXJuIHJldDsKCQkJfQoJCX0KCQllbHNlIAoJ
CXsKCQkJcmV0ID0gbXhjX2RtYV9jb25maWcocHJ0ZC0+ZG1hX2NoX3J4LCAmZG1hX3JlcXVlc3Qs
IDEsIE1YQ19ETUFfTU9ERV9SRUFEKTsKCQkJaWYocmV0PDApIHsKCQkJCXByaW50aygiZG1hX25l
d19wZXJpb2Q6IGJ1ZmZlciBjb3VsZCBub3QgYmUgYWRkZWQgZm9yIGNhcHR1cmUgdHJhbnNmZXJc
biIpOwoJCQkJcmV0dXJuIHJldDsKCQkJfQoKCQkJcHJpbnRrKCJkbWFfbmV3X3BlcmlvZDogZW5h
YmxlICBkbWEgdHJhbnNmZXJcbiIpOwoJCQlyZXQgPSBteGNfZG1hX2VuYWJsZShwcnRkLT5kbWFf
Y2hfcngpOwoJCQlpZihyZXQ8MCkgewoJCQkJcHJpbnRrKCJkbWFfbmV3X3BlcmlvZDogY2Fubm90
IHF1ZXVlIERNQSBidWZmZXJcCgkJCQkJCQkoJWkpXG4iLCByZXQpOwoJCQkJcmV0dXJuIHJldDsK
CQkJfQoJCX0KCnByaW50aygiZG1hX25ld19wZXJpb2Q6IHRyYW5zZmVyIGVuYWJsZWRcbiBzcmNf
YWRkciA9ICV4XG4gZHN0X2FkZHIgPSAleFxuIG51bV9vZl9ieWVzID0gJWRcbiIsICh2b2lkICop
IGRtYV9yZXF1ZXN0LnNyY19hZGRyLCAodm9pZCAqKSBkbWFfcmVxdWVzdC5kc3RfYWRkciwgZG1h
X3JlcXVlc3QubnVtX29mX2J5dGVzKTsKCQlwcnRkLT50eF9zcGluID0gMTsgLyogRkdBIGxpdHRs
ZSB0cmljayB0byByZXRyaWV2ZSBETUEgcG9zICovCgkJcHJ0ZC0+cGVyaW9kKys7CgkJcHJ0ZC0+
cGVyaW9kICU9IHJ1bnRpbWUtPnBlcmlvZHM7CiAgICB9CglyZXR1cm4gcmV0Owp9CgoKLyohCiAg
KiBUaGlzIGlzIGEgY2FsbGJhY2sgd2hpY2ggd2lsbCBiZSBjYWxsZWQKICAqIHdoZW4gYSBUWCB0
cmFuc2ZlciBmaW5pc2hlcy4gVGhlIGNhbGwgb2NjdXJzCiAgKiBpbiBpbnRlcnJ1cHQgY29udGV4
dC4KICAqCiAgKiBAcGFyYW0JZGF0CXBvaW50ZXIgdG8gdGhlIHN0cnVjdHVyZSBvZiB0aGUgY3Vy
cmVudCBzdHJlYW0uCiAgKgogICovCnN0YXRpYyB2b2lkIGF1ZGlvX2RtYV9pcnEodm9pZCAqZGF0
YSwgaW50IGVycm9yLCB1bnNpZ25lZCBpbnQgY291bnQpCnsKCXN0cnVjdCBzbmRfcGNtX3N1YnN0
cmVhbSAqc3Vic3RyZWFtOwoJc3RydWN0IHNuZF9wY21fcnVudGltZSAqcnVudGltZTsKCXN0cnVj
dCBteDI3X3J1bnRpbWVfZGF0YSAqcHJ0ZDsKCXVuc2lnbmVkIGludCBkbWFfc2l6ZTsKCXVuc2ln
bmVkIGludCBwcmV2aW91c19wZXJpb2Q7Cgl1bnNpZ25lZCBpbnQgb2Zmc2V0OwoKCXN1YnN0cmVh
bSA9IGRhdGE7CglydW50aW1lID0gc3Vic3RyZWFtLT5ydW50aW1lOwoJcHJ0ZCA9IHJ1bnRpbWUt
PnByaXZhdGVfZGF0YTsKCXByZXZpb3VzX3BlcmlvZCAgPSBwcnRkLT5wZXJpb2RzOwoJZG1hX3Np
emUgPSBmcmFtZXNfdG9fYnl0ZXMocnVudGltZSwgcnVudGltZS0+cGVyaW9kX3NpemUpOwoJb2Zm
c2V0ID0gZG1hX3NpemUgKiBwcmV2aW91c19wZXJpb2Q7CgoJcHJ0ZC0+dHhfc3BpbiA9IDA7Cglw
cnRkLT5wZXJpb2RzKys7CglwcnRkLT5wZXJpb2RzICU9IHJ1bnRpbWUtPnBlcmlvZHM7CgovLyAJ
cHJpbnRrKCJhdWRpb19kbWFfaXJxOiBpcnEgcGVyICVkIG9mZnNldCAleFxuIiwgcHJ0ZC0+cGVy
aW9kcywgb2Zmc2V0KTsKCgkvKgoJICAqIEdpdmUgYmFjayB0byB0aGUgQ1BVIHRoZSBhY2Nlc3Mg
dG8gdGhlIG5vbiBjYWNoZWQgbWVtb3J5CgkgICovCi8vIAlpZihzdWJzdHJlYW0tPnN0cmVhbSA9
PSBTTkRSVl9QQ01fU1RSRUFNX1BMQVlCQUNLKQovLyAJCWRtYV91bm1hcF9zaW5nbGUoTlVMTCwg
cnVudGltZS0+ZG1hX2FkZHIgKyBvZmZzZXQsIGRtYV9zaXplLAovLyAJCQkJCQkJRE1BX1RPX0RF
VklDRSk7Ci8vIAllbHNlCi8vIAkJZG1hX3VubWFwX3NpbmdsZShOVUxMLCBydW50aW1lLT5kbWFf
YWRkciArIG9mZnNldCwgZG1hX3NpemUsCi8vIAkJCQkJCQlETUFfRlJPTV9ERVZJQ0UpOwoJLyoK
CSAgKiBJZiB3ZSBhcmUgZ2V0dGluZyBhIGNhbGxiYWNrIGZvciBhbiBhY3RpdmUgc3RyZWFtIHRo
ZW4gd2UgaW5mb3JtCgkgICogdGhlIFBDTSBtaWRkbGUgbGF5ZXIgd2UndmUgZmluaXNoZWQgYSBw
ZXJpb2QKCSAgKi8KIAlpZiAocHJ0ZC0+YWN0aXZlKQoJCXNuZF9wY21fcGVyaW9kX2VsYXBzZWQo
c3Vic3RyZWFtKTsKCgkvKgoJICAqIFRyaWcgbmV4dCBETUEgdHJhbnNmZXIKCSAgKi8KCWRtYV9u
ZXdfcGVyaW9kKHN1YnN0cmVhbSk7Cn0KCi8qIQogICogVGhpcyBmdW5jdGlvbiBjb25maWd1cmVz
IHRoZSBoYXJkd2FyZSB0byBhbGxvdyBhdWRpbwogICogcGxheWJhY2sgb3BlcmF0aW9ucy4gSXQg
aXMgY2FsbGVkIGJ5IEFMU0EgZnJhbWV3b3JrLgogICoKICAqIEBwYXJhbQlzdWJzdHJlYW0JcG9p
bnRlciB0byB0aGUgc3RydWN0dXJlIG9mIHRoZSBjdXJyZW50IHN0cmVhbS4KICAqCiAgKiBAcmV0
dXJuICAgICAgICAgICAgICAwIG9uIHN1Y2Nlc3MsIC0xIG90aGVyd2lzZS4KICAqLwpzdGF0aWMg
aW50CnNuZF9teGNfcHJlcGFyZShzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSkK
ewoJc3RydWN0IHNuZF9wY21fcnVudGltZSAqcnVudGltZSA9ICBzdWJzdHJlYW0tPnJ1bnRpbWU7
CglzdHJ1Y3QgbXgyN19ydW50aW1lX2RhdGEgKnBydGQgPSBydW50aW1lLT5wcml2YXRlX2RhdGE7
CgoJcHJ0ZC0+cGVyaW9kID0gMDsKCXBydGQtPnBlcmlvZHMgPSAwOwoKCXJldHVybiAwOwp9Cgpz
dGF0aWMgaW50IG14Y19wY21faHdfcGFyYW1zKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vi
c3RyZWFtLAoJc3RydWN0IHNuZF9wY21faHdfcGFyYW1zICpod19wYXJhbXMpCnsKCXN0cnVjdCBz
bmRfcGNtX3J1bnRpbWUgKnJ1bnRpbWUgPSBzdWJzdHJlYW0tPnJ1bnRpbWU7CglzdHJ1Y3QgbXgy
N19ydW50aW1lX2RhdGEgKnBydGQgPSBydW50aW1lLT5wcml2YXRlX2RhdGE7CglpbnQgcmV0OwoK
CWlmKChyZXQ9c25kX3BjbV9saWJfbWFsbG9jX3BhZ2VzKHN1YnN0cmVhbSwgcGFyYW1zX2J1ZmZl
cl9ieXRlcyhod19wYXJhbXMpKSkgPCAwKQoJewoJCXByaW50aygiaW14MjctcGNtOiBmYWlsZWQg
dG8gbWFsbG9jIHBjbSBwYWdlc1xuIik7CgkJcmV0dXJuIHJldDsKCX0KCXByaW50aygibXhjX3Bj
bV9od19wYXJhbXM6IHNuZF9wY21fbGliX21hbGxvYyBwYWdlcyBoYXMgcmV0dXJuIE9LXG4iKTsK
CXByaW50aygiSU1YMjc6IHNuZF9pbXgyN19hdWRpb19od19wYXJhbXMgcnVudGltZS0+ZG1hX2Fk
ZHIgMHgoJXgpXG4iLAoJCSAodW5zaWduZWQgaW50KXJ1bnRpbWUtPmRtYV9hZGRyKTsKCXByaW50
aygiSU1YMjc6IHNuZF9pbXgyN19hdWRpb19od19wYXJhbXMgcnVudGltZS0+ZG1hX2FyZWEgMHgo
JXgpXG4iLAoJCSAodW5zaWduZWQgaW50KXJ1bnRpbWUtPmRtYV9hcmVhKTsKCXByaW50aygiSU1Y
Mjc6IHNuZF9pbXgyN19hdWRpb19od19wYXJhbXMgcnVudGltZS0+ZG1hX2J5dGVzIDB4KCV4KVxu
IiwKCQkgKHVuc2lnbmVkIGludClydW50aW1lLT5kbWFfYnl0ZXMpOwoKCXJldHVybiByZXQ7Cn0K
CnN0YXRpYyBpbnQgbXhjX3BjbV9od19mcmVlKHN0cnVjdCBzbmRfcGNtX3N1YnN0cmVhbSAqc3Vi
c3RyZWFtKQp7CglzdHJ1Y3Qgc25kX3BjbV9ydW50aW1lICpydW50aW1lID0gc3Vic3RyZWFtLT5y
dW50aW1lOwoJc3RydWN0IG14MjdfcnVudGltZV9kYXRhICpwcnRkID0gcnVudGltZS0+cHJpdmF0
ZV9kYXRhOwoJCgoJbXhjX2RtYV9mcmVlKHBydGQtPmRtYV9jaF90eCk7CglteGNfZG1hX2ZyZWUo
cHJ0ZC0+ZG1hX2NoX3J4KTsKCXNuZF9wY21fbGliX2ZyZWVfcGFnZXMoc3Vic3RyZWFtKTsKCgly
ZXR1cm4gMDsKfQoKc3RhdGljIGludCBteGNfcGNtX3RyaWdnZXIoc3RydWN0IHNuZF9wY21fc3Vi
c3RyZWFtICpzdWJzdHJlYW0sIGludCBjbWQpCnsKCXN0cnVjdCBteDI3X3J1bnRpbWVfZGF0YSAq
cHJ0ZCA9IHN1YnN0cmVhbS0+cnVudGltZS0+cHJpdmF0ZV9kYXRhOwoJaW50IHJldCA9IDA7CgoJ
c3dpdGNoIChjbWQpIHsKCWNhc2UgU05EUlZfUENNX1RSSUdHRVJfU1RBUlQ6CgkJcHJ0ZC0+dHhf
c3BpbiA9IDA7CgkJLyogcmVxdWVzdGVkIHN0cmVhbSBzdGFydHVwICovCgkJcHJ0ZC0+YWN0aXZl
ID0gMTsKCQlwcmludGsoIm14Y19wY21fdHJpZ2dlcjogc3RhcnRpbmcgZG1hX25ld19wZXJpb2Rc
biIpOwogICAgICAgIAlyZXQgPSBkbWFfbmV3X3BlcmlvZChzdWJzdHJlYW0pOwoJCWJyZWFrOwoJ
Y2FzZSBTTkRSVl9QQ01fVFJJR0dFUl9TVE9QOgoJCS8qIHJlcXVlc3RlZCBzdHJlYW0gc2h1dGRv
d24gKi8KCQlwcmludGsoIm14Y19wY21fdHJpZ2dlcjogc3RvcHBpbmcgZG1hIHRyYW5zZmVyXG4i
KTsKCQlyZXQgPSBhdWRpb19zdG9wX2RtYShzdWJzdHJlYW0pOwoJCWJyZWFrOwoJZGVmYXVsdDoK
CQlyZXQgPSAtRUlOVkFMOwoJCWJyZWFrOwoJfQoKCXJldHVybiByZXQ7Cn0KCnN0YXRpYyBzbmRf
cGNtX3VmcmFtZXNfdCBteGNfcGNtX3BvaW50ZXIoc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpz
dWJzdHJlYW0pCnsKCXN0cnVjdCBzbmRfcGNtX3J1bnRpbWUgKnJ1bnRpbWUgPSBzdWJzdHJlYW0t
PnJ1bnRpbWU7CglzdHJ1Y3QgbXgyN19ydW50aW1lX2RhdGEgKnBydGQgPSBydW50aW1lLT5wcml2
YXRlX2RhdGE7Cgl1bnNpZ25lZCBpbnQgb2Zmc2V0ID0gMDsKCnByaW50aygibXhjX3BjbV9wb2lu
dGVyOlxuIHJ1bnRpbWUtPnBlcmlvZF9zaXplPSVkXG4gcHJ0ZC0+cGVyaW9kcz0lZFxuIHJ1bnRp
bWUtPmJ1ZmZlcl9zaXplPSVkXG4gcHJ0ZC0+dHhfc3Bpbj0lZFxuIiwgcnVudGltZS0+cGVyaW9k
X3NpemUsIHBydGQtPnBlcmlvZHMsIHJ1bnRpbWUtPmJ1ZmZlcl9zaXplLCBwcnRkLT50eF9zcGlu
KTsKCS8qIHR4X3NwaW4gdmFsdWUgaXMgdXNlZCBoZXJlIHRvIGNoZWNrIGlmIGEgdHJhbnNmZXIg
aXMgYWN0aXZlICovCglpZiAocHJ0ZC0+dHhfc3Bpbil7CgkJb2Zmc2V0ID0gKHJ1bnRpbWUtPnBl
cmlvZF9zaXplICogKHBydGQtPnBlcmlvZHMpKSArCgkJCQkJCShydW50aW1lLT5wZXJpb2Rfc2l6
ZSA+PiAxKTsKCQlpZiAob2Zmc2V0ID49IHJ1bnRpbWUtPmJ1ZmZlcl9zaXplKQoJCQlvZmZzZXQg
PSBydW50aW1lLT5wZXJpb2Rfc2l6ZSA+PiAxOwoJfSBlbHNlIHsKCQlvZmZzZXQgPSAocnVudGlt
ZS0+cGVyaW9kX3NpemUgKiAocHJ0ZC0+cGVyaW9kcykpOwoJCWlmIChvZmZzZXQgPj0gcnVudGlt
ZS0+YnVmZmVyX3NpemUpCgkJCW9mZnNldCA9IDA7Cgl9CnByaW50aygibXhjX3BjbV9wb2ludGVy
OiBwb2ludGVyIG9mZnNldCAleFxuIiwgb2Zmc2V0KTsKCQoJcmV0dXJuIG9mZnNldDsKfQoKLy9B
bG9jYXRpb24gb2Ygc3Vic3RyZWFtLT5ydW50aW1lLT5wcml2YXRlX2RhdGEKc3RhdGljIGludCBt
eGNfcGNtX29wZW4oc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW0pCnsKCXN0cnVj
dCBzbmRfcGNtX3J1bnRpbWUgKnJ1bnRpbWUgPSBzdWJzdHJlYW0tPnJ1bnRpbWU7CglzdHJ1Y3Qg
bXgyN19ydW50aW1lX2RhdGEgKnBydGQ7CglpbnQgcmV0OwoKCXNuZF9zb2Nfc2V0X3J1bnRpbWVf
aHdwYXJhbXMoc3Vic3RyZWFtLCAmbXgyN19wY21faGFyZHdhcmUpOwoKCS8vPz8KCWlmICgocmV0
ID0gc25kX3BjbV9od19jb25zdHJhaW50X2ludGVnZXIocnVudGltZSwKCQkJCQlTTkRSVl9QQ01f
SFdfUEFSQU1fUEVSSU9EUykpIDwgMCkKCQlyZXR1cm4gcmV0OwoKCWlmKChwcnRkID0ga3phbGxv
YyhzaXplb2Yoc3RydWN0IG14MjdfcnVudGltZV9kYXRhKSwgR0ZQX0tFUk5FTCkpID09IE5VTEwp
IHsKCQlyZXQgPSAtRU5PTUVNOwoJCWdvdG8gb3V0OwoJfQoKCXJ1bnRpbWUtPnByaXZhdGVfZGF0
YSA9IHBydGQ7CgoJaWYoc3Vic3RyZWFtLT5zdHJlYW0gPT0gU05EUlZfUENNX1NUUkVBTV9QTEFZ
QkFDSykKCXsKCQkKI2lmZGVmIENPTkZJR19TTkRfU09DX01YMjdfU1NJMQpwcmludGsoIm14Y19w
Y21fb3BlbjogUmVxdWVzdGluZyBNWENfRE1BX1NTSTFfMTZCSVRfVFgwIGRtYSBjaGFubmVsXG4i
KTsKCQlwcnRkLT5kbWFfY2hfdHggID0gbXhjX2RtYV9yZXF1ZXN0KE1YQ19ETUFfU1NJMV8xNkJJ
VF9UWDAsICJBTFNBIFRYIERNQSIpOyAvL01YQ19ETUFfVEVTVF9SQU0yUkFNCiNlbHNlCgkJcHJ0
ZC0+ZG1hX2NoX3R4ID0gbXhjX2RtYV9yZXF1ZXN0KE1YQ19ETUFfU1NJMl8xNkJJVF9UWDAsICJB
TFNBIFRYIERNQSIpOwojZW5kaWYKCQlpZihwcnRkLT5kbWFfY2hfdHggPCAwKQoJCXsgCgkJCXBy
aW50aygiZXJyb3IgcmVxdWVzdGluZyBhIHdyaXRlKGRtYSB0byBkZXZpY2UpIGRtYSBjaGFubmVs
XG4iKTsKCQkJcmV0dXJuIHJldDsKCQl9CgoJCS8vU2V0IGRtYSBjYWxsYmFjawpwcmludGsoIm14
Y19wY21fb3BlbjogU2V0dGluZyB0eCBkbWEgY2FsbGJhY2sgZnVuY3Rpb25cbiIpOwoJCXJldCA9
IG14Y19kbWFfY2FsbGJhY2tfc2V0KHBydGQtPmRtYV9jaF90eCwgKG14Y19kbWFfY2FsbGJhY2tf
dCkgYXVkaW9fZG1hX2lycSwgKHZvaWQgKilzdWJzdHJlYW0pOwoJCWlmKHJldDwwKSB7CgkJCXBy
aW50aygiZXJyb3Igc2V0dGluZyBkbWEgY2FsbGJhY2sgZnVuY3Rpb25cbiIpOwoJCQlyZXR1cm4g
cmV0OwoJCX0KCgkJcmV0dXJuIDA7Cgl9CgllbHNlCgl7CiNpZmRlZiBDT05GSUdfU05EX1NPQ19N
WDI3X1NTSTEKcHJpbnRrKCJteGNfcGNtX29wZW46IFJlcXVlc3RpbmcgTVhDX0RNQV9TU0kxXzE2
QklUX1JYMCBkbWEgY2hhbm5lbFxuIik7CgkJcHJ0ZC0+ZG1hX2NoX3J4ICA9IG14Y19kbWFfcmVx
dWVzdChNWENfRE1BX1NTSTFfMTZCSVRfUlgwLCAiQUxTQSBSWCBETUEiKTsKI2Vsc2UKCQlwcnRk
LT5kbWFfY2hfcnggPSBteGNfZG1hX3JlcXVlc3QoTVhDX0RNQV9TU0kyXzE2QklUX1JYMCwgIkFM
U0EgUlggRE1BIik7CiNlbmRpZgoJCWlmKHBydGQtPmRtYV9jaF9yeCA8IDApCgkJeyAKCQkJcHJp
bnRrKCJlcnJvciByZXF1ZXN0aW5nIGEgcmVhZChkbWEgZnJvbSBkZXZpY2UpIGRtYSBjaGFubmVs
XG4iKTsKCQkJcmV0dXJuIHJldDsKCQl9CgoJCS8vU2V0IGRtYSBjYWxsYmFjawpwcmludGsoIm14
Y19wY21fb3BlbjogU2V0dGluZyByeCBkbWEgY2FsbGJhY2sgZnVuY3Rpb25cbiIpOwoJCWlmKG14
Y19kbWFfY2FsbGJhY2tfc2V0KHBydGQtPmRtYV9jaF9yeCwgKG14Y19kbWFfY2FsbGJhY2tfdCkg
YXVkaW9fZG1hX2lycSwgKHZvaWQgKilzdWJzdHJlYW0pPDApCgkJCXByaW50aygiZXJyb3Igc2V0
dGluZyBkbWEgY2FsbGJhY2sgZnVuY3Rpb25cbiIpOwoKCQlyZXR1cm4gMDsKCX0KCgoKIG91dDoK
CXJldHVybiByZXQ7Cn0KCnN0YXRpYyBpbnQgbXhjX3BjbV9jbG9zZShzdHJ1Y3Qgc25kX3BjbV9z
dWJzdHJlYW0gKnN1YnN0cmVhbSkKewoJc3RydWN0IHNuZF9wY21fcnVudGltZSAqcnVudGltZSA9
IHN1YnN0cmVhbS0+cnVudGltZTsKCXN0cnVjdCBteGNfcnVudGltZV9kYXRhICpwcnRkID0gcnVu
dGltZS0+cHJpdmF0ZV9kYXRhOwoKCWtmcmVlKHBydGQpOwoKCXJldHVybiAwOwp9CgpzdGF0aWMg
aW50Cm14Y19wY21fbW1hcChzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSwgc3Ry
dWN0IHZtX2FyZWFfc3RydWN0ICp2bWEpCnsKCXN0cnVjdCBzbmRfcGNtX3J1bnRpbWUgKnJ1bnRp
bWUgPSBzdWJzdHJlYW0tPnJ1bnRpbWU7CglyZXR1cm4gZG1hX21tYXBfd3JpdGVjb21iaW5lKHN1
YnN0cmVhbS0+cGNtLT5jYXJkLT5kZXYsIHZtYSwKCQkJCSAgICAgcnVudGltZS0+ZG1hX2FyZWEs
CgkJCQkgICAgIHJ1bnRpbWUtPmRtYV9hZGRyLAoJCQkJICAgICBydW50aW1lLT5kbWFfYnl0ZXMp
Owp9CgpzdHJ1Y3Qgc25kX3BjbV9vcHMgbXhjX3BjbV9vcHMgPSB7Cgkub3BlbgkJPSBteGNfcGNt
X29wZW4sCgkuY2xvc2UJCT0gbXhjX3BjbV9jbG9zZSwKCS5pb2N0bAkJPSBzbmRfcGNtX2xpYl9p
b2N0bCwKCS5od19wYXJhbXMJPSBteGNfcGNtX2h3X3BhcmFtcywKCS5od19mcmVlCT0gbXhjX3Bj
bV9od19mcmVlLAoJLnByZXBhcmUJPSBzbmRfbXhjX3ByZXBhcmUsCgkudHJpZ2dlcgk9IG14Y19w
Y21fdHJpZ2dlciwKCS5wb2ludGVyCT0gbXhjX3BjbV9wb2ludGVyLAoJLm1tYXAJCT0gbXhjX3Bj
bV9tbWFwLAp9OwoKc3RhdGljIHU2NCBteGNfcGNtX2RtYW1hc2sgPSAweGZmZmZmZmZmOwoKc3Rh
dGljIGludCBpbXgzMV9wY21fcHJlYWxsb2NhdGVfZG1hX2J1ZmZlcihzdHJ1Y3Qgc25kX3BjbSAq
cGNtLCBpbnQgc3RyZWFtKQp7CglzdHJ1Y3Qgc25kX3BjbV9zdWJzdHJlYW0gKnN1YnN0cmVhbSA9
IHBjbS0+c3RyZWFtc1tzdHJlYW1dLnN1YnN0cmVhbTsKCXN0cnVjdCBzbmRfZG1hX2J1ZmZlciAq
YnVmID0gJnN1YnN0cmVhbS0+ZG1hX2J1ZmZlcjsKCXNpemVfdCBzaXplID0gbXgyN19wY21faGFy
ZHdhcmUuYnVmZmVyX2J5dGVzX21heDsKCWJ1Zi0+ZGV2LnR5cGUgPSBTTkRSVl9ETUFfVFlQRV9E
RVY7CglidWYtPmRldi5kZXYgPSBwY20tPmNhcmQtPmRldjsKCWJ1Zi0+cHJpdmF0ZV9kYXRhID0g
TlVMTDsKCgkvL1Jlc2VydmUgdW5jYWNoZWQtYnVmZmVyZWQgbWVtb3J5IGFyZWEgZm9yIERNQQoJ
YnVmLT5hcmVhID0gZG1hX2FsbG9jX3dyaXRlY29tYmluZShwY20tPmNhcmQtPmRldiwgc2l6ZSwK
CQkJCQkgICAmYnVmLT5hZGRyLCBHRlBfS0VSTkVMKTsKCglwcmludGsoImlteDI3X3BjbTogcHJl
YWxsb2NhdGVfZG1hX2J1ZmZlcjogYXJlYT0lcCwgYWRkcj0lcCwgc2l6ZT0lZFxuIiwgKHZvaWQg
KikgYnVmLT5hcmVhLCAodm9pZCAqKSBidWYtPmFkZHIsIHNpemUpOwoKCWlmICghYnVmLT5hcmVh
KQoJCXJldHVybiAtRU5PTUVNOwoJCQoJYnVmLT5ieXRlcyA9IHNpemU7CglyZXR1cm4gMDsKfQoK
c3RhdGljIHZvaWQgaW14MzFfcGNtX2ZyZWVfZG1hX2J1ZmZlcnMoc3RydWN0IHNuZF9wY20gKnBj
bSkKewoJc3RydWN0IHNuZF9wY21fc3Vic3RyZWFtICpzdWJzdHJlYW07CglzdHJ1Y3Qgc25kX2Rt
YV9idWZmZXIgKmJ1ZjsKCWludCBzdHJlYW07CgoJZm9yIChzdHJlYW0gPSAwOyBzdHJlYW0gPCAy
OyBzdHJlYW0rKykgewoJCXN1YnN0cmVhbSA9IHBjbS0+c3RyZWFtc1tzdHJlYW1dLnN1YnN0cmVh
bTsKCQlpZiAoIXN1YnN0cmVhbSkKCQkJY29udGludWU7CgoJCWJ1ZiA9ICZzdWJzdHJlYW0tPmRt
YV9idWZmZXI7CgkJaWYgKCFidWYtPmFyZWEpCgkJCWNvbnRpbnVlOwoKCQlkbWFfZnJlZV93cml0
ZWNvbWJpbmUocGNtLT5jYXJkLT5kZXYsIGJ1Zi0+Ynl0ZXMsCgkJCQkgICAgICBidWYtPmFyZWEs
IGJ1Zi0+YWRkcik7CgkJYnVmLT5hcmVhID0gTlVMTDsKCX0KfQoKaW50IG14Y19wY21fbmV3KHN0
cnVjdCBzbmRfY2FyZCAqY2FyZCwgc3RydWN0IHNuZF9zb2NfZGFpICpkYWksCglzdHJ1Y3Qgc25k
X3BjbSAqcGNtKQp7CglpbnQgcmV0ID0gMDsKCglpZiAoIWNhcmQtPmRldi0+ZG1hX21hc2spCgkJ
Y2FyZC0+ZGV2LT5kbWFfbWFzayA9ICZteGNfcGNtX2RtYW1hc2s7CglpZiAoIWNhcmQtPmRldi0+
Y29oZXJlbnRfZG1hX21hc2spCgkJY2FyZC0+ZGV2LT5jb2hlcmVudF9kbWFfbWFzayA9IDB4ZmZm
ZmZmZmY7CgoJaWYgKGRhaS0+cGxheWJhY2suY2hhbm5lbHNfbWluKSB7CgkJcmV0ID0gaW14MzFf
cGNtX3ByZWFsbG9jYXRlX2RtYV9idWZmZXIocGNtLAoJCQlTTkRSVl9QQ01fU1RSRUFNX1BMQVlC
QUNLKTsKCQlwcmludGsoIm14Y19wY21fbmV3OiBwcmVhbGxvY2F0ZSBwbGF5YmFjayBidWZmZXJc
biIpOwoJCWlmIChyZXQpCgkJCWdvdG8gb3V0OwoJfQoKCWlmIChkYWktPmNhcHR1cmUuY2hhbm5l
bHNfbWluKSB7CgkJcmV0ID0gaW14MzFfcGNtX3ByZWFsbG9jYXRlX2RtYV9idWZmZXIocGNtLAoJ
CQlTTkRSVl9QQ01fU1RSRUFNX0NBUFRVUkUpOwoJCXByaW50aygibXhjX3BjbV9uZXc6IHByZWFs
bG9jYXRlIGNhcHR1cmUgYnVmZmVyXG4iKTsKCQlpZiAocmV0KQoJCQlnb3RvIG91dDsKCX0KIG91
dDoKCXJldHVybiByZXQ7Cn0KCnN0cnVjdCBzbmRfc29jX3BsYXRmb3JtIGlteDI3X3NvY19wbGF0
Zm9ybSA9IHsKCS5uYW1lCQk9ICJteGMtYXVkaW8iLAoJLnBjbV9vcHMgCT0gJm14Y19wY21fb3Bz
LAoJLnBjbV9uZXcJPSBteGNfcGNtX25ldywKCS5wY21fZnJlZQk9IGlteDMxX3BjbV9mcmVlX2Rt
YV9idWZmZXJzLAp9OwoKRVhQT1JUX1NZTUJPTF9HUEwoaW14Mjdfc29jX3BsYXRmb3JtKTsKCk1P
RFVMRV9BVVRIT1IoIkphdmllciBNYXJ0aW4iKTsKTU9EVUxFX0RFU0NSSVBUSU9OKCJGcmVlc2Nh
bGUgaS5NWDI3IFBDTSBETUEgbW9kdWxlIik7Ck1PRFVMRV9MSUNFTlNFKCJHUEwiKTsK
--0015174c3c667e756d0467862b1a
Content-Type: application/octet-stream; name="imx27-pcm.h"
Content-Disposition: attachment; filename="imx27-pcm.h"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_ftispbwa1

LyoKICogbXgyNy1wY20uaCA6LSBBU29DIHBsYXRmb3JtIGhlYWRlciBmb3IgRnJlZXNjYWxlIGku
TVgyNwogKgogKiBUaGlzIHByb2dyYW0gaXMgZnJlZSBzb2Z0d2FyZTsgeW91IGNhbiByZWRpc3Ry
aWJ1dGUgaXQgYW5kL29yIG1vZGlmeQogKiBpdCB1bmRlciB0aGUgdGVybXMgb2YgdGhlIEdOVSBH
ZW5lcmFsIFB1YmxpYyBMaWNlbnNlIHZlcnNpb24gMiBhcwogKiBwdWJsaXNoZWQgYnkgdGhlIEZy
ZWUgU29mdHdhcmUgRm91bmRhdGlvbi4KICovCgojaWZuZGVmIF9NWENfUENNX0gKI2RlZmluZSBf
TVhDX1BDTV9ICgojaW5jbHVkZSA8YXNtL2FyY2gvZG1hLmg+CgovKiBBVURNVVggcmVncyBkZWZp
bml0aW9uIC0gTU9WRSB0byBhc20vYXJjaCB3aGVuIHN0YWJsZSAKI2RlZmluZSBBVURNVVhfSU9f
QkFTRV9BRERSCUlPX0FERFJFU1MoQVVETVVYX0JBU0VfQUREUikKCiNkZWZpbmUgREFNX1BUQ1Ix
CSgqKCh2b2xhdGlsZSB1MzIgKikoQVVETVVYX0lPX0JBU0VfQUREUiArIDB4MDApKSkKI2RlZmlu
ZSBEQU1fUERDUjEJKCooKHZvbGF0aWxlIHUzMiAqKShBVURNVVhfSU9fQkFTRV9BRERSICsgMHgw
NCkpKQojZGVmaW5lIERBTV9QVENSMgkoKigodm9sYXRpbGUgdTMyICopKEFVRE1VWF9JT19CQVNF
X0FERFIgKyAweDA4KSkpCiNkZWZpbmUgREFNX1BEQ1IyCSgqKCh2b2xhdGlsZSB1MzIgKikoQVVE
TVVYX0lPX0JBU0VfQUREUiArIDB4MEMpKSkKI2RlZmluZSBEQU1fUFRDUjMJKCooKHZvbGF0aWxl
IHUzMiAqKShBVURNVVhfSU9fQkFTRV9BRERSICsgMHgxMCkpKQojZGVmaW5lIERBTV9QRENSMwko
Kigodm9sYXRpbGUgdTMyICopKEFVRE1VWF9JT19CQVNFX0FERFIgKyAweDE0KSkpCiNkZWZpbmUg
REFNX1BUQ1I0CSgqKCh2b2xhdGlsZSB1MzIgKikoQVVETVVYX0lPX0JBU0VfQUREUiArIDB4MTgp
KSkKI2RlZmluZSBEQU1fUERDUjQJKCooKHZvbGF0aWxlIHUzMiAqKShBVURNVVhfSU9fQkFTRV9B
RERSICsgMHgxQykpKQojZGVmaW5lIERBTV9QVENSNQkoKigodm9sYXRpbGUgdTMyICopKEFVRE1V
WF9JT19CQVNFX0FERFIgKyAweDIwKSkpCiNkZWZpbmUgREFNX1BEQ1I1CSgqKCh2b2xhdGlsZSB1
MzIgKikoQVVETVVYX0lPX0JBU0VfQUREUiArIDB4MjQpKSkKI2RlZmluZSBEQU1fUFRDUjYJKCoo
KHZvbGF0aWxlIHUzMiAqKShBVURNVVhfSU9fQkFTRV9BRERSICsgMHgyOCkpKQojZGVmaW5lIERB
TV9QRENSNgkoKigodm9sYXRpbGUgdTMyICopKEFVRE1VWF9JT19CQVNFX0FERFIgKyAweDJDKSkp
CiNkZWZpbmUgREFNX1BUQ1I3CSgqKCh2b2xhdGlsZSB1MzIgKikoQVVETVVYX0lPX0JBU0VfQURE
UiArIDB4MzApKSkKI2RlZmluZSBEQU1fUERDUjcJKCooKHZvbGF0aWxlIHUzMiAqKShBVURNVVhf
SU9fQkFTRV9BRERSICsgMHgzNCkpKQojZGVmaW5lIERBTV9DTk1DUgkoKigodm9sYXRpbGUgdTMy
ICopKEFVRE1VWF9JT19CQVNFX0FERFIgKyAweDM4KSkpCiNkZWZpbmUgREFNX1BUQ1IoYSkJKCoo
KHZvbGF0aWxlIHUzMiAqKShBVURNVVhfSU9fQkFTRV9BRERSICsgYSo4KSkpCiNkZWZpbmUgREFN
X1BEQ1IoYSkJKCooKHZvbGF0aWxlIHUzMiAqKShBVURNVVhfSU9fQkFTRV9BRERSICsgNCArIGEq
OCkpKQoKCiNkZWZpbmUgQVVETVVYX1BUQ1JfVEZTRElSCQkoMSA8PCAzMSkKI2RlZmluZSBBVURN
VVhfUFRDUl9URlNTRUwoeCwgeSkJCSgoeCA8PCAzMCkgfCAoKCh5IC0gMSkgJiAweDcpIDw8IDI3
KSkKI2RlZmluZSBBVURNVVhfUFRDUl9UQ0xLRElSCQkoMSA8PCAyNikKI2RlZmluZSBBVURNVVhf
UFRDUl9UQ1NFTCh4LCB5KQkJKCh4IDw8IDI1KSB8ICgoKHkgLSAxKSAmIDB4NykgPDwgMjIpKQoj
ZGVmaW5lIEFVRE1VWF9QVENSX1JGU0RJUgkJKDEgPDwgMjEpCiNkZWZpbmUgQVVETVVYX1BUQ1Jf
UkZTU0VMKHgsIHkpCQkoKHggPDwgMjApIHwgKCgoeSAtIDEpICYgMHg3KSA8PCAxNykpCiNkZWZp
bmUgQVVETVVYX1BUQ1JfUkNMS0RJUgkJKDEgPDwgMTYpCiNkZWZpbmUgQVVETVVYX1BUQ1JfUkNT
RUwoeCwgeSkJCSgoeCA8PCAxNSkgfCAoKCh5IC0gMSkgJiAweDcpIDw8IDEyKSkKI2RlZmluZSBB
VURNVVhfUFRDUl9TWU4JCSgxIDw8IDExKQoKI2RlZmluZSBBVURNVVhfRlJPTV9UWEZTCTAKI2Rl
ZmluZSBBVURNVVhfRlJPTV9SWEZTCTEKCiNkZWZpbmUgQVVETVVYX1BEQ1JfUlhEU0VMKHgpCQko
KCh4IC0gMSkgJiAweDcpIDw8IDEzKQojZGVmaW5lIEFVRE1VWF9QRENSX1RYRFhFTgkJKDEgPDwg
MTIpCiNkZWZpbmUgQVVETVVYX1BEQ1JfTU9ERSh4KQkJKCgoeCkgJiAweDMpIDw8IDgpCiNkZWZp
bmUgQVVETVVYX1BEQ1JfSU5OTUFTSyh4KQkJKCgoeCkgJiAweGZmKSA8PCAwKQoKI2RlZmluZSBB
VURNVVhfQ05NQ1JfQ0VOCQkoMSA8PCAxOCkKI2RlZmluZSBBVURNVVhfQ05NQ1JfRlNQT0wJCSgx
IDw8IDE3KQojZGVmaW5lIEFVRE1VWF9DTk1DUl9DTEtQT0wJCSgxIDw8IDE2KQojZGVmaW5lIEFV
RE1VWF9DTk1DUl9DTlRISSh4KQkJKCgoeCkgJiAweGZmKSA8PCA4KQojZGVmaW5lIEFVRE1VWF9D
Tk1DUl9DTlRMT1coeCkJCSgoKHgpICYgMHhmZikgPDwgMCkKKi8KCi8qIFByZXZpb3VzIGRlZmlu
ZXMgYXJlIG9ubHkgdmFsaWQgZm9yIGlteDMxICovCiNkZWZpbmUgQVVETVVYX0lPX0JBU0VfQURE
UglJT19BRERSRVNTKEFVRE1VWF9CQVNFX0FERFIpCgojZGVmaW5lIERBTV9IUENSMQkoKigodm9s
YXRpbGUgdTMyICopKEFVRE1VWF9JT19CQVNFX0FERFIgKyAweDAwKSkpCiNkZWZpbmUgREFNX0hQ
Q1IyCSgqKCh2b2xhdGlsZSB1MzIgKikoQVVETVVYX0lPX0JBU0VfQUREUiArIDB4MDQpKSkKI2Rl
ZmluZSBEQU1fSFBDUjMJKCooKHZvbGF0aWxlIHUzMiAqKShBVURNVVhfSU9fQkFTRV9BRERSICsg
MHgwOCkpKQojZGVmaW5lIERBTV9QUENSMQkoKigodm9sYXRpbGUgdTMyICopKEFVRE1VWF9JT19C
QVNFX0FERFIgKyAweDEwKSkpCiNkZWZpbmUgREFNX1BQQ1IyCSgqKCh2b2xhdGlsZSB1MzIgKiko
QVVETVVYX0lPX0JBU0VfQUREUiArIDB4MTQpKSkKI2RlZmluZSBEQU1fUFBDUjMJKCooKHZvbGF0
aWxlIHUzMiAqKShBVURNVVhfSU9fQkFTRV9BRERSICsgMHgxQykpKQoKI2RlZmluZSBBVURNVVhf
SFBDUl9URlNESVIJKDEgPDwgMzEpCiNkZWZpbmUgQVVETVVYX0hQQ1JfVENMS0RJUgkoMSA8PCAz
MCkKI2RlZmluZSBBVURNVVhfSFBDUl9URkNTRUwoeCkJKCgoeCkgJiAweGZmKSA8PCAyNikKI2Rl
ZmluZSBBVURNVVhfSFBDUl9SWERTRUwoeCkJKCgoeCkgJiAweDcpIDw8IDEzKQojZGVmaW5lIEFV
RE1VWF9IUENSX1NZTgkJKDEgPDwgMTIpCgojZGVmaW5lIEFVRE1VWF9QUENSX1RGU0RJUgkoMSA8
PCAzMSkKI2RlZmluZSBBVURNVVhfUFBDUl9UQ0xLRElSCSgxIDw8IDMwKQojZGVmaW5lIEFVRE1V
WF9QUENSX1RGQ1NFTCh4KQkoKCh4KSAmIDB4ZmYpIDw8IDI2KQojZGVmaW5lIEFVRE1VWF9QUENS
X1JYRFNFTCh4KQkoKCh4KSAmIDB4NykgPDwgMTMpCiNkZWZpbmUgQVVETVVYX1BQQ1JfU1lOCQko
MSA8PCAxMikKCgoKc3RydWN0IG14MjdfcGNtX2RtYV9wYXJhbXMgewoJY2hhciAqbmFtZTsJCQkv
KiBzdHJlYW0gaWRlbnRpZmllciAqLwoJbXhjX2RtYV9yZXF1ZXN0YnVmX3QgYnVmX3BhcmFtczsg
LypETUEgYnVmZmVyIHBhcmFtcyAqLwoKfTsKCmV4dGVybiBzdHJ1Y3Qgc25kX3NvY19kYWkgbXhj
X3NzaV9kYWlbM107CgovKiBwbGF0Zm9ybSBkYXRhICovCmV4dGVybiBzdHJ1Y3Qgc25kX3NvY19w
bGF0Zm9ybSBpbXgyN19zb2NfcGxhdGZvcm07CgoKI2VuZGlmCg==
--0015174c3c667e756d0467862b1a
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--0015174c3c667e756d0467862b1a--
