From: Manu Abraham <abraham.manu@gmail.com>
Subject: mapping externally allocated Scatter Gather DMA buffers
Date: Tue, 26 Oct 2010 12:02:09 +0530
Message-ID: <AANLkTik4VQmsvBiXyoj-wEu5jgjpPVRP0bF7gkp9GJ-E@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 2E2F3103814
	for <alsa-devel@alsa-project.org>;
	Tue, 26 Oct 2010 08:33:48 +0200 (CEST)
Received: by wwb13 with SMTP id 13so871420wwb.20
	for <alsa-devel@alsa-project.org>; Mon, 25 Oct 2010 23:33:47 -0700 (PDT)
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

Hi,

I have been wondering how to interface a Scatter Gather region as a DMA
buffer for an Audio Grabbing device.
The device is a NOC type device, similar to a SOC, the audio grabber is a
part of it, for realizing the audio
capabilities on the device.

The hardware DMA is mostly a Scatter Gather based engine, and it can be
described thus, briefly.

struct dmabuf {
    void *vmalloc;
    dma_addr_t phys;
    void *virt;
    int pages;
    int offset;
    struct scatterlist *sg_list;
    struct list_head list;
};

where:

dmabuf->virt = __get_free_page(GFP_KERNEL);
dmabuf->phys = dma_map_single(dev, PAGE_SIZE, DMA_FROM_DEVICE);
dmabuf->sg_list = kzalloc(sizeof (struct scatterlist) * pages, GFP_KERNEL);
sg_init_table(sg_list, pages);
dmabuf->vmalloc = vmalloc((pages + 1) * PAGE_SIZE);

In a loop with the pages involved, I do populate the pages into the list;


Now I have a stream engine with the hardware, where 8 such dmabufs are
allocated. On an interrupt, the device
can know from status registers, which dmabuf the device driver needs to read
the data from.

I wonder what would be the best possible way to interface the stream engine
to the Alsa DMA capture engine.
I have been eyeballing the alsa sources and whatever documents that are
available, but found very little details
on the alsa core, but nevertheless found that, it might be possible to pass
the vmalloc'd region to
substream->runtime->dma_area. I wonder whether this is possible practically
and would like to hear your
comments on it, whatever feedback, or ideas you have.

Any helpful comments appreciated very much.

Thanks,
Manu
