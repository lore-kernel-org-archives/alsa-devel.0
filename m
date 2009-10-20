From: =?Big5?B?qvSqQMVB?= <m943040028@gmail.com>
Subject: alsa buffer underrun
Date: Tue, 20 Oct 2009 12:39:51 +0800
Message-ID: <d4537ca60910192139w7f52101aj9da612899e5a708d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-vw0-f197.google.com (mail-vw0-f197.google.com
	[209.85.212.197])
	by alsa0.perex.cz (Postfix) with ESMTP id 4017424531
	for <alsa-devel@alsa-project.org>;
	Tue, 20 Oct 2009 06:39:52 +0200 (CEST)
Received: by vws35 with SMTP id 35so2014017vws.16
	for <alsa-devel@alsa-project.org>; Mon, 19 Oct 2009 21:39:51 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Dear Alsa developers:

I enconter a problem about alsa buffer underrun, and have no idea how to
solve it.
It's great if you can spent a little of your spare time to read this.
Thanks.

Our CPU, (a arm processor running at 162Mhz) using I2S to communicate with
codec.
The i2s hardware is simply a FIFO which generates an interrupt when the FIFO
data is below the
programed watermark(and relevant bit in status register will be set),
then we re-fill data into FIFO in interrupt handler

the interrupt handler code fragment will like this

static irqreturn_t dw_tdm_handler(int irq, void *data)
{
        struct dw_tdm_dev *dev = (struct dw_tdm_dev *)data;
        struct platform_device *pdev = dev->pdev;
        struct snd_pcm_substream *substream = dev->substream;
        struct snd_pcm_runtime *runtime = substream->runtime;

        u16 *buf = (u16 *)runtime->dma_area;
        u32 status = dw_tdm_read_reg(TDM_INT_ STATUS);
        unsigned int bytes_remain =
                runtime->dma_bytes - dev->dma_pos;
        buf += dev->dma_pos / sizeof(u16);

        /* tx fifo is running low, reload new data for it */
        if (status & TX_INT) {
                int i;
                unsigned int empty_banks =
                        TX_EMPTY_BANKS(dw_tdm_read_reg(TDM_STATUS));
                /* 2 FIFO lines each bank */
                unsigned int bytes_to_write = empty_banks * 4;
                bytes_to_write = min(bytes_remain, bytes_to_write);

                dev_dbg(&pdev->dev, "dma_pos = %d\n",
                        dev->dma_pos);
                dev_dbg(&pdev->dev, "hw_ptr = %d\n",
                        frames_to_bytes(runtime, runtime->status->hw_ptr));

                /* re-fill data, 1 sample contains 4 bytes */
                for (i = 0; i < bytes_to_write / 4; i++) {
                        dw_tdm_write_reg(TDM_TX_FIFO, *buf++); /* left
channel */
                        dw_tdm_write_reg(TDM_TX_FIFO, *buf++); /* right
channel */
                }

                dev->dma_pos += bytes_to_write;

                if (bytes_remain == bytes_to_write)
                        dev->dma_pos = 0;
        }

        /* rx fifo is running full, consume data from it */
        if (status & RX_INT) {
                /* TODO */
        }

        dev_dbg(&pdev->dev, "period elapsed\n");
        snd_pcm_period_elapsed(substream);

        /* clear interupt status */
        dw_tdm_write_reg(TDM_INT_CLR, status);

        return IRQ_HANDLED;
}

This runs into buffer underflow problem, when I use aplay to play a wav
file,
it seems user-space process doesn't accquire any cpu time, after out i2s h/w
start to work(, and generate interrupts)

output look like below: (strings in <> is my comments)

# aplay /1.wav
Playing WAVE '/1.wav' : Signed 16 bit Little Endian, Rate 44100 Hz, Stereo
snd_pcm_lib_write1: avail = 8160 <aplay start to fill buffer>
snd_pcm_lib_write1: avail = 7904
snd_pcm_lib_write1: avail = 7648
snd_pcm_lib_write1: avail = 7392
snd_pcm_lib_write1: avail = 7136
snd_pcm_lib_write1: avail = 6880
snd_pcm_lib_write1: avail = 6624
snd_pcm_lib_write1: avail = 6368
snd_pcm_lib_write1: avail = 6112
snd_pcm_lib_write1: avail = 5856
snd_pcm_lib_write1: avail = 5600
snd_pcm_lib_write1: avail = 5344
snd_pcm_lib_write1: avail = 5088
snd_pcm_lib_write1: avail = 4832
snd_pcm_lib_write1: avail = 4576
snd_pcm_lib_write1: avail = 4320
snd_pcm_lib_write1: avail = 4064
snd_pcm_lib_write1: avail = 3808
snd_pcm_lib_write1: avail = 3552
snd_pcm_lib_write1: avail = 3296
snd_pcm_lib_write1: avail = 3040
snd_pcm_lib_write1: avail = 2784
snd_pcm_lib_write1: avail = 2528
snd_pcm_lib_write1: avail = 2272
snd_pcm_lib_write1: avail = 2016
snd_pcm_lib_write1: avail = 1760
snd_pcm_lib_write1: avail = 1504
snd_pcm_lib_write1: avail = 1248
snd_pcm_lib_write1: avail = 992
snd_pcm_lib_write1: avail = 736
snd_pcm_lib_write1: avail = 480
snd_pcm_lib_write1: avail = 224
snd_pcm_lib_write1: avail = 0   <write completed, trigger pcm stream>
<i2s h/w start to work, and consume all the buffers, in this period, aplay
has no chance to re-fill buffer, and underrun occurs>
underrun!!! (at least 19.991 ms long)
snd_pcm_lib_write1: avail = 8160
snd_pcm_lib_write1: avail = 8128
snd_pcm_lib_write1: avail = 7872
snd_pcm_lib_write1: avail = 7616
snd_pcm_lib_write1: avail = 7360
snd_pcm_lib_write1: avail = 7104
snd_pcm_lib_write1: avail = 6848
snd_pcm_lib_write1: avail = 6592
snd_pcm_lib_write1: avail = 6336
snd_pcm_lib_write1: avail = 6080
snd_pcm_lib_write1: avail = 5824
snd_pcm_lib_write1: avail = 5568
snd_pcm_lib_write1: avail = 5312
snd_pcm_lib_write1: avail = 5056
snd_pcm_lib_write1: avail = 4800
snd_pcm_lib_write1: avail = 4544
snd_pcm_lib_write1: avail = 4288
snd_pcm_lib_write1: avail = 4032
snd_pcm_lib_write1: avail = 3776
snd_pcm_lib_write1: avail = 3520
snd_pcm_lib_write1: avail = 3264
snd_pcm_lib_write1: avail = 3008
snd_pcm_lib_write1: avail = 2752
snd_pcm_lib_write1: avail = 2496
snd_pcm_lib_write1: avail = 2240
snd_pcm_lib_write1: avail = 1984
snd_pcm_lib_write1: avail = 1728
snd_pcm_lib_write1: avail = 1472
snd_pcm_lib_write1: avail = 1216
snd_pcm_lib_write1: avail = 960
snd_pcm_lib_write1: avail = 704
snd_pcm_lib_write1: avail = 448
snd_pcm_lib_write1: avail = 192
snd_pcm_lib_write1: avail = 0
underrun!!! (at least 18.479 ms long)


Any ideas or suggestions?
