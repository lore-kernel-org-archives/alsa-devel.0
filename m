From: Manu Abraham <abraham.manu@gmail.com>
Subject: Re: mapping externally allocated Scatter Gather DMA
	buffers
Date: Wed, 10 Nov 2010 17:29:06 +0530
Message-ID: <AANLkTim=NT4cPQV+c3Y7eZF81Pv6R--vRgT_jGj7xZQJ@mail.gmail.com>
References: <AANLkTik4VQmsvBiXyoj-wEu5jgjpPVRP0bF7gkp9GJ-E@mail.gmail.com>
	<alpine.LNX.2.00.1010260923070.29422@eeebox2.perex-int.cz>
	<AANLkTin58toyQJ0f3M3abszE0zgV+t9R29rsFKin74vk@mail.gmail.com>
	<alpine.LNX.2.00.1011091300130.29422@eeebox2.perex-int.cz>
	<AANLkTikzXbnnPBNS+51zFvrYVqOTw8bz1=qWq_h--y35@mail.gmail.com>
	<alpine.LNX.2.00.1011091347020.29422@eeebox2.perex-int.cz>
	<AANLkTikHL5-6nuf6_sbkAX+y_vUo57tF-SW_j75ijEPJ@mail.gmail.com>
	<alpine.LNX.2.00.1011091530230.29422@eeebox2.perex-int.cz>
	<AANLkTimTrFLv911vVm-eH9EqDyXEwg-y4uFkqbUyVB7v@mail.gmail.com>
	<alpine.LNX.2.00.1011100755560.29422@eeebox2.perex-int.cz>
	<AANLkTi=2pO+x=Okt8RXPJe2TqGexEX70oMCFAtBAkm2U@mail.gmail.com>
	<alpine.LNX.2.00.1011101228061.29422@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id A467924396
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2010 12:59:07 +0100 (CET)
Received: by wyb33 with SMTP id 33so611305wyb.38
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2010 03:59:07 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1011101228061.29422@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 10, 2010 at 5:00 PM, Jaroslav Kysela <perex@perex.cz> wrote:
> On Wed, 10 Nov 2010, Manu Abraham wrote:
>
>> Ok, so period should be the interval at which an IRQ is expected.
>> ie, if i set a buffer size for 40mS, the period should be 40, I guess.
>>
>> That said, what should be a recommended value for period ? If hardware
>> needs to generate an IRQ at the end of each period ?
>
> It's good to allow the lowledevel driver to pass all possible period sizes
> to the user space. The application does decision how many wakeups expects.


Ok, I adapted it to look thus,

static struct snd_pcm_hardware saa7231_capture_info = {
	.info			= (SNDRV_PCM_INFO_MMAP		|
				  SNDRV_PCM_INFO_INTERLEAVED	|
				  SNDRV_PCM_INFO_BLOCK_TRANSFER	|
				  SNDRV_PCM_INFO_MMAP_VALID),

	.formats		= (SNDRV_PCM_FMTBIT_S16_LE	|
				  SNDRV_PCM_FMTBIT_S16_BE	|
				  SNDRV_PCM_FMTBIT_S8		|
				  SNDRV_PCM_FMTBIT_U8		|
				  SNDRV_PCM_FMTBIT_U16_LE	|
				  SNDRV_PCM_FMTBIT_U16_BE),

	.rates			= SNDRV_PCM_RATE_32000,

	.rate_min		= 32000,
	.rate_max		= 48000,

	.channels_min		= 2,
	.channels_max		= 2,

	.buffer_bytes_max	= 512 * 4096,
#if 0
	.period_bytes_min	= 192,
	.period_bytes_max	= 1536,
	.periods_min		= 2,
	.periods_max		= 1024,
#endif
	.period_bytes_min	= 1920,    /* 10mS @ 48khz */
	.period_bytes_max	= 768000,  /* 4S   @ 48kHz */

	.periods_min		= 10,      /* 10mS */
	.periods_max		= 4000000, /* 4S */
};

/*
 * 10mS Buffer lengths
 * @48kHz	1920 bytes
 * @44.1kHz	1764 bytes
 * @32kHz	1280 bytes
 *
 *
 * period min = 10mS @48k:  1920 bytes @44.1k:  1764 bytes @32k:  1280 bytes
 * period max = 1S   @48k:192000 bytes @44.1k:176400 bytes @32k:128000 bytes
 * period     = 4S   @48k:768000 bytes @44.1k:705600 bytes @32k:512000 bytes
 */
static int saa7231_capture_open(struct snd_pcm_substream *pcm)
{
        struct saa7231_audio *audio	= snd_pcm_substream_chip(pcm);
        struct snd_pcm_runtime *rt	= pcm->runtime;
	struct saa7231_dev *saa7231	= audio->saa7231;
        int err;

	dprintk(SAA7231_DEBUG, 1, "()");
	rt->hw = saa7231_capture_info;
	snd_pcm_hw_constraint_list(rt, 0, SNDRV_PCM_HW_PARAM_RATE,
&hw_constraint_rates);
	err = snd_pcm_hw_constraint_integer(rt, SNDRV_PCM_HW_PARAM_PERIODS);
        if (err < 0) {
		dprintk(SAA7231_ERROR, 1, "snd_pcm_hw_constraint_integer() failed.
ret=%d", err);
                return err;
	}
	err = snd_pcm_hw_constraint_minmax(rt,
SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 10, 4000000);
	if (err < 0) {
		dprintk(SAA7231_ERROR, 1, "snd_pcm_hw_constraint_minmax() failed.
ret=%d", err);
		return err;
	}
	err = snd_pcm_hw_constraint_minmax(rt,
SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 1920, 768000);
	if (err < 0) {
		dprintk(SAA7231_ERROR, 1, "snd_pcm_hw_constraint_minmax() failed.
ret=%d", err);
		return err;
	}
        return 0;
}

/*
 * saa7231_hw_params()
 *
 * This callback is called when the hardware parameter (hw_params) is setup
 * by the application, ie., once when the buffer size, the period size,
 * the format etc are defined for the PCM substream.
 */
static int saa7231_hw_params(struct snd_pcm_substream *pcm, struct
snd_pcm_hw_params *params)
{
	struct saa7231_audio *audio	= snd_pcm_substream_chip(pcm);
	struct saa7231_dev *saa7231	= audio->saa7231;
	struct snd_pcm_runtime *rt	= pcm->runtime;

	struct saa7231_dmabuf *buffer;
	struct saa7231_stream *stream;
	struct saa7231_dmabuf *dmabuf;

	struct page **ptable;

	void *mem;
	void *dma_area;

	int i, j, pages, bytes, periods, bufsiz, pt_size;

	dprintk(SAA7231_DEBUG, 1, "DEBUG: ()");
	periods = params_periods(params);
	bytes = params_period_bytes(params);

	bufsiz = periods * bytes;
	dprintk(SAA7231_DEBUG, 1, "bufsiz=%d periods=%d bytes=%d",
		bufsiz,
		periods,
		bytes);

	pages = bufsiz / PAGE_SIZE;

	/* enable stream */
	/* initializing 8 buffer with "pages" pages each .. */
	stream = saa7231_stream_init(saa7231, AUDIO_CAPTURE, ADAPTER_INT, 0, pages);
	if (!stream) {
		dprintk(SAA7231_ERROR, 1, "ERROR: Registering stream");
		return -ENOMEM;
	}
	audio->stream = stream;
	buffer = stream->dmabuf;
	saa7231_add_irqevent(saa7231, 43, SAA7231_EDGE_RISING,
saa7231_audio_evhandler, "AS2D_AVIS");
	dprintk(SAA7231_DEBUG, 1, "Mapping %d buffers with %d pages each",
XS2D_BUFFERS, pages);

	/*
	 * For a single DMA buffer:
	 * each page takes a u64 size in a page table
	 * number of entries a single page can hold = PAGE_SIZE / entry size
	 * ie entries.max = PAGE_SIZE / 8 => 4096/8 = 512
	 * Now, we have entries.req = 7 ("pages") per buffer
	 *
	 * For all in XS2D_BUFFERS:
	 * page table should be large enough to hold all the pages in each DMA buffer
	 * total number of pages = pages * XS2D_BUFFERS
	 * max buffers that we need to consider = 512 * 8, this needs 8 pages
for a page table
	 *
	 * On a general note, we can calculate pages for page table as
	 * page_table_size = total_pages / 512, with a minimum of a single page
	 */

#define MAX_ENTRIES_PER_PAGE		 (PAGE_SIZE / 8)

	pt_size = (pages * XS2D_BUFFERS) / MAX_ENTRIES_PER_PAGE;
	/* minimum 1 page required for the table */
	if (pt_size < 1)
		pt_size = 1;

	dprintk(SAA7231_DEBUG, 1, "Page Table array size=%d", pt_size);
	ptable = kzalloc((sizeof (struct page) * pt_size), GFP_KERNEL);
	if (!ptable) {
		dprintk(SAA7231_ERROR, 1, "ERROR: No memory to allocate virtual map");
		return -ENOMEM;
	}
	audio->ptable = ptable;

	for (i = 0; i < XS2D_BUFFERS; i ++) {
		dmabuf = &buffer[i];
		mem = dmabuf->vmalloc;
		for (j = 0; j < pages; j++)
			ptable[j] = virt_to_page(mem);
	}
#if 0
	dma_area = vmap(ptable, (pages * XS2D_BUFFERS), VM_MAP, PAGE_KERNEL);
	rt->dma_area	= dma_area;
	rt->dma_bytes	= XS2D_BUFFERS * pages * SAA7231_PAGE_SIZE;
	rt->dma_addr	= 0;
#endif
	return 0;
}


also after vmap(), crazy thing was that  uncommenting the above #if 0'd block,
ie with vmap() it would just crash the whole system.


Best Regards,
Manu
