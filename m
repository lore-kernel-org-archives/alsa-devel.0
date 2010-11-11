From: Manu Abraham <abraham.manu@gmail.com>
Subject: Re: mapping externally allocated Scatter Gather DMA
	buffers
Date: Thu, 11 Nov 2010 18:04:20 +0530
Message-ID: <AANLkTi=g5LR=wm8B7jKy6kHFUjZHzt3NdZD8s3reVMbJ@mail.gmail.com>
References: <AANLkTik4VQmsvBiXyoj-wEu5jgjpPVRP0bF7gkp9GJ-E@mail.gmail.com>
	<alpine.LNX.2.00.1011091300130.29422@eeebox2.perex-int.cz>
	<AANLkTikzXbnnPBNS+51zFvrYVqOTw8bz1=qWq_h--y35@mail.gmail.com>
	<alpine.LNX.2.00.1011091347020.29422@eeebox2.perex-int.cz>
	<AANLkTikHL5-6nuf6_sbkAX+y_vUo57tF-SW_j75ijEPJ@mail.gmail.com>
	<alpine.LNX.2.00.1011091530230.29422@eeebox2.perex-int.cz>
	<AANLkTimTrFLv911vVm-eH9EqDyXEwg-y4uFkqbUyVB7v@mail.gmail.com>
	<alpine.LNX.2.00.1011100755560.29422@eeebox2.perex-int.cz>
	<AANLkTi=2pO+x=Okt8RXPJe2TqGexEX70oMCFAtBAkm2U@mail.gmail.com>
	<alpine.LNX.2.00.1011101228061.29422@eeebox2.perex-int.cz>
	<AANLkTim=NT4cPQV+c3Y7eZF81Pv6R--vRgT_jGj7xZQJ@mail.gmail.com>
	<alpine.LNX.2.00.1011101515420.29422@eeebox2.perex-int.cz>
	<AANLkTi=gjN1xfnMZ4R29Sq_=fxYAfJwOQmD_+6beLYSp@mail.gmail.com>
	<alpine.LNX.2.00.1011101859010.29422@eeebox2.perex-int.cz>
	<AANLkTimXTdWRrdA8+ToQp-gPofKohaSJ_Ss5x4S42uo5@mail.gmail.com>
	<alpine.LNX.2.00.1011111113030.29422@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 93D1224481
	for <alsa-devel@alsa-project.org>; Thu, 11 Nov 2010 13:34:21 +0100 (CET)
Received: by wwc33 with SMTP id 33so1314002wwc.2
	for <alsa-devel@alsa-project.org>; Thu, 11 Nov 2010 04:34:21 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1011111113030.29422@eeebox2.perex-int.cz>
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
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 11, 2010 at 4:00 PM, Jaroslav Kysela <perex@perex.cz> wrote:
> On Thu, 11 Nov 2010, Manu Abraham wrote:
>
>> On Wed, Nov 10, 2010 at 11:35 PM, Jaroslav Kysela <perex@perex.cz> wrote:

>>
>> I adapted the whole thing to make the buffersize divided amongst the
>> XS2D_BUFFERS (8):
>
> Probably yes.
>
>> I hope the mapping of the buffers is okay ? It looks thus, now ..
>
> From information you sent me about hw privately, I think that the
> period_bytes must be 4096 or multiple of this value with minumum count of
> periods 8 (or multiple of 8). Otherwise you get a non-continuous memory a=
rea
> (the hw uses only portion of system memory page, thus there'll be gaps). =
The
> problem is that we have MMAP_COMPLEX mode, but no application can handle
> (does not implement) this mmap mode and I'm not sure, if we can even
> describe the DMA buffer size layout for this case for your specific hw.
>
> I would use:
>
> =A0 =A0 =A0 =A0snd_pcm_hw_constraint_step(runtime, 0,
> SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A04096);
>
>
> =A0 =A0 =A0 =A0snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM_=
PERIODS,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 8);
>
> And define periods_min =3D 8 (max to multiple 8 - choose your max limit) =
and
> period_bytes_min to 4096 (max to multiple 4096 - choose your max limit).
>
> Note that -EIO means that your driver does not called
> snd_pcm_period_elapsed() and/or the pointer callback returns wrong positi=
on
> to the audio ring buffer.



Ok, modified it, also added in code to acquire the stream, It's a bit
more complete now.
The crazy part that I do see now, is that I see an inconsistent lock
state with the hda_intel
driver which is the soundcard on my system. But I don't understand why
the locking on it
has to become inconsistent on loading this driver.

Eventually it looks thus:




static struct snd_pcm_hardware saa7231_capture_info =3D {
	.info			=3D (SNDRV_PCM_INFO_MMAP		|
				  SNDRV_PCM_INFO_INTERLEAVED	|
				  SNDRV_PCM_INFO_BLOCK_TRANSFER	|
				  SNDRV_PCM_INFO_MMAP_VALID),

	.formats		=3D (SNDRV_PCM_FMTBIT_S16_LE	|
				  SNDRV_PCM_FMTBIT_S16_BE	|
				  SNDRV_PCM_FMTBIT_S8		|
				  SNDRV_PCM_FMTBIT_U8		|
				  SNDRV_PCM_FMTBIT_U16_LE	|
				  SNDRV_PCM_FMTBIT_U16_BE),

	.rates			=3D SNDRV_PCM_RATE_32000,

	.rate_min		=3D 32000,
	.rate_max		=3D 48000,

	.channels_min		=3D 1,
	.channels_max		=3D 2,

	.buffer_bytes_max	=3D XS2D_BUFFERS * PAGE_SIZE * 512,

	.period_bytes_min	=3D 4096,
	.period_bytes_max	=3D 2097152,

	.periods_min		=3D 8,
	.periods_max		=3D 4096,
};

/*
 * 10mS Buffer lengths
 * @48kHz	1920 bytes
 * @44.1kHz	1764 bytes
 * @32kHz	1280 bytes
 *
 *
 * period min =3D 10mS @48k:  1920 bytes @44.1k:  1764 bytes @32k:  1280 by=
tes
 * period max =3D 1S   @48k:192000 bytes @44.1k:176400 bytes @32k:128000 by=
tes
 * period     =3D 4S   @48k:768000 bytes @44.1k:705600 bytes @32k:512000 by=
tes
 */
static int saa7231_capture_open(struct snd_pcm_substream *pcm)
{
        struct saa7231_audio *audio	=3D snd_pcm_substream_chip(pcm);
        struct snd_pcm_runtime *rt	=3D pcm->runtime;
	struct saa7231_dev *saa7231	=3D audio->saa7231;
        int err;

	dprintk(SAA7231_DEBUG, 1, "()");
	rt->hw =3D saa7231_capture_info;
	snd_pcm_hw_constraint_list(rt, 0, SNDRV_PCM_HW_PARAM_RATE,
&hw_constraint_rates);
	err =3D snd_pcm_hw_constraint_integer(rt, SNDRV_PCM_HW_PARAM_PERIODS);
        if (err < 0) {
		dprintk(SAA7231_ERROR, 1, "snd_pcm_hw_constraint_integer() failed.
ret=3D%d", err);
                return err;
	}

	err =3D snd_pcm_hw_constraint_step(rt, 0, SNDRV_PCM_HW_PARAM_PERIOD_BYTES,=
 4096);
	if (err < 0) {
		dprintk(SAA7231_ERROR, 1, "snd_pcm_hw_constraint_minmax() failed.
ret=3D%d", err);
		return err;
	}
	err =3D snd_pcm_hw_constraint_step(rt, 0, SNDRV_PCM_HW_PARAM_PERIODS, 8);
	if (err < 0) {
		dprintk(SAA7231_ERROR, 1, "snd_pcm_hw_constraint_minmax() failed.
ret=3D%d", err);
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
	struct saa7231_audio *audio	=3D snd_pcm_substream_chip(pcm);
	struct saa7231_dev *saa7231	=3D audio->saa7231;
	struct snd_pcm_runtime *rt	=3D pcm->runtime;

	struct saa7231_dmabuf *buffer;
	struct saa7231_stream *stream;
	struct saa7231_dmabuf *dmabuf;

	struct page **ptable;

	void *mem;
	void *dma_area;

	int i, j, pages, bytes, periods, bufsiz, pt_size, idx;

#define MAX_ENTRIES_PER_PAGE		(PAGE_SIZE / 8)
#define PAGES_PER_XS2D(__pages)		(__pages / XS2D_BUFFERS)
#define BUFSIZE_PER_XS2D(__size)	(__size / XS2D_BUFFERS)

	dprintk(SAA7231_DEBUG, 1, "DEBUG: ()");

	periods =3D params_periods(params);
	bytes   =3D params_period_bytes(params);
	bufsiz  =3D params_buffer_bytes(params);
	pages   =3D (bufsiz + PAGE_SIZE - 1) / PAGE_SIZE;

	audio->bufsize =3D bufsiz;

	dprintk(SAA7231_DEBUG, 1, "bufsiz=3D%d periods=3D%d bytes=3D%d pages=3D%d",
		bufsiz,
		periods,
		bytes,
		pages);

	/* enable stream */
	/* initializing 8 buffer with "pages" pages each .. */
	stream =3D saa7231_stream_init(saa7231, AUDIO_CAPTURE, ADAPTER_INT, 0,
(pages / XS2D_BUFFERS));
	if (!stream) {
		dprintk(SAA7231_ERROR, 1, "ERROR: Registering stream");
		return -ENOMEM;
	}
	audio->stream =3D stream;
	buffer =3D stream->dmabuf;
	saa7231_add_irqevent(saa7231, 43, SAA7231_EDGE_RISING,
saa7231_audio_evhandler, "AS2D_AVIS");
	dprintk(SAA7231_DEBUG, 1, "Mapping %d buffers with %d pages each",
XS2D_BUFFERS, PAGES_PER_XS2D(pages));

	/*
	 * For a single DMA buffer:
	 * each page takes a u64 size in a page table
	 * number of entries a single page can hold =3D PAGE_SIZE / entry size
	 * ie entries.max =3D PAGE_SIZE / 8 =3D> 4096/8 =3D 512
	 * Now, we have entries.req =3D 7 ("pages") per buffer
	 *
	 * For all in XS2D_BUFFERS:
	 * page table should be large enough to hold all the pages in each DMA buf=
fer
	 * total number of pages =3D pages * XS2D_BUFFERS
	 * max buffers that we need to consider =3D 512 * 8, this needs 8 pages
for a page table
	 *
	 * On a general note, we can calculate pages for page table as
	 * page_table_size =3D total_pages / 512, with a minimum of a single page
	 */

	pt_size =3D (pages * XS2D_BUFFERS) / MAX_ENTRIES_PER_PAGE;
	/* minimum 1 page required for the table */
	if (pt_size < 1)
		pt_size =3D 1;

	dprintk(SAA7231_DEBUG, 1, "Page Table array size=3D%d", pt_size);
	ptable =3D kzalloc((sizeof (struct page) * pt_size), GFP_KERNEL);
	if (!ptable) {
		dprintk(SAA7231_ERROR, 1, "ERROR: No memory to allocate virtual map");
		return -ENOMEM;
	}
	audio->ptable =3D ptable;
	idx =3D 0;

	for (i =3D 0; i < XS2D_BUFFERS; i ++) {
		dmabuf =3D &buffer[i];
		mem =3D dmabuf->vmalloc;
		for (j =3D 0; j < PAGES_PER_XS2D(pages); j++) {
			BUG_ON(idx > pages);
			dprintk(SAA7231_DEBUG, 1, "Mapping Page:%d from XS2D_BUFFER:%d to
PTA Offset:%d", j, i, idx);
			ptable[idx] =3D virt_to_page(mem);
			mem +=3D PAGE_SIZE;
			idx +=3D 1;
		}
	}

	dma_area =3D vmap(ptable, pages, VM_MAP, PAGE_KERNEL);
	rt->dma_area	=3D dma_area;
	rt->dma_bytes	=3D pages * PAGE_SIZE;
	rt->dma_addr	=3D 0;

	return 0;
}

/*
 * saa7231_hw_free()
 *
 * This callback is called to release the resources allocated via hw_params.
 * For eg: releasing the buffer via snd_pcm_lib_malloc_pages() is done by
 * snd_pcm_lib_free_pages(substream)
 * This function is always called before the close callback is called. Also,
 * the callback maybe called multiple times.
 */
static int saa7231_hw_free(struct snd_pcm_substream *pcm)
{
	struct saa7231_audio *audio	=3D snd_pcm_substream_chip(pcm);
	struct saa7231_dev *saa7231	=3D audio->saa7231;
	struct saa7231_stream *stream	=3D audio->stream;
	struct page **ptable		=3D audio->ptable;
	struct snd_pcm_runtime *rt	=3D pcm->runtime;
	void *dma_area			=3D rt->dma_area;

	dprintk(SAA7231_DEBUG, 1, "DEBUG: Removing IRQ event ..");
	saa7231_remove_irqevent(saa7231, 43);

	if (dma_area) {
		dprintk(SAA7231_DEBUG, 1, "DEBUG: Unmap Virtual memory region ..");
		vunmap(dma_area);
	}
	dprintk(SAA7231_DEBUG, 1, "DEBUG: Stream exiting ..");
	saa7231_stream_exit(stream);

	dprintk(SAA7231_DEBUG, 1, "DEBUG: Freeing ptable ...");
	kfree(ptable);
	return 0;
}

/*
 * saa7231_capture_prepare()
 *
 * This callback is called when the PCM is prepared. You can set the format
 * type, sample rate, etc here. The difference from hw_params is that the
 * prepare callback will be called each time snd_pcm_prepare() is called,
 * ie, when recovering from underruns.
 */
static int saa7231_capture_prepare(struct snd_pcm_substream *pcm)
{
	struct saa7231_audio *audio	=3D snd_pcm_substream_chip(pcm);
	struct saa7231_dev *saa7231	=3D audio->saa7231;
	struct saa7231_stream *stream	=3D audio->stream;
	struct stream_ops *ops		=3D &stream->ops;

	u32 bps, spl, pitch, buflen;
	int err;

	dprintk(SAA7231_DEBUG, 1, "()");

	bps	=3D 16;
	spl	=3D 2;
	pitch	=3D spl * bps / 8;
	buflen	=3D BUFSIZE_PER_XS2D(audio->bufsize);

	stream->params.bps	=3D bps;
	stream->params.spl	=3D spl;
	stream->params.pitch	=3D pitch;
	stream->params.lines	=3D buflen / pitch;
	stream->params.type	=3D STREAM_AUDIO;

	dprintk(SAA7231_DEBUG, 1, "Trying to Acquire stream with %dlines per
stream buffer", stream->params.lines);
	if (ops->acquire) {
		err =3D ops->acquire(stream);
		if (err) {
			dprintk(SAA7231_ERROR, 1, "ERROR: acquiring stream, err=3D%d", err);
			return -EIO;
		}
	}
	return 0;
}

/*
 * saa7231_capture_trigger()
 *
 * This callback is called when the PCM is started, stoppped or paused.
 */
static int saa7231_capture_trigger(struct snd_pcm_substream *pcm, int cmd)
{
	struct saa7231_audio *audio	=3D snd_pcm_substream_chip(pcm);
	struct saa7231_dev *saa7231	=3D audio->saa7231;
	struct saa7231_stream *stream	=3D audio->stream;
	struct stream_ops *ops		=3D &stream->ops;
	int err;

	switch (cmd) {
        case SNDRV_PCM_TRIGGER_START:
		dprintk(SAA7231_DEBUG, 1, "Tring to START stream, cmd=3D%d", cmd);
		if (ops->run) {
			err =3D ops->run(stream);
			if (err) {
				dprintk(SAA7231_ERROR, 1, "ERROR: starting stream, err=3D%d", err);
				return -EIO;
			}
		}
		break;
        case SNDRV_PCM_TRIGGER_STOP:
		dprintk(SAA7231_DEBUG, 1, "Tring to STOP stream, cmd=3D%d", cmd);
		if (ops->stop) {
			err =3D ops->stop(stream);
			if (err) {
				dprintk(SAA7231_ERROR, 1, "ERROR: stopping stream, err=3D%d", err);
				return -EIO;
			}
		}
		break;
        case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
        case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
        case SNDRV_PCM_TRIGGER_SUSPEND:
		dprintk(SAA7231_DEBUG, 1, "Tring to PAUSE stream, cmd=3D%d", cmd);
		if (ops->pause) {
			err =3D ops->pause(stream);
			if (err) {
				dprintk(SAA7231_ERROR, 1, "ERROR: pausing stream, err=3D%d", err);
				return -EIO;
			}
		}
		break;
	default:
		dprintk(SAA7231_DEBUG, 1, "Unknown command, cmd=3D%d", cmd);
		snd_BUG();
		return -EINVAL;
	}
	return 0;
}

/*
 * saa7231_capture_pointer()
 *
 * This callback is called when the PCM middle layer inquires the current
 * hardware position on the buffer. The position must be returned in frames,
 * ranging from 0 to buffer_size - 1.
 * This is usually called from the buffer-update routine in the PCM middle
 * layer, which is invoked when snd_pcm_period_elapsed() is called in the
 * interrupt routine. The PCM middle layer then updates the position and
 * calculates the available space, wakes up poll threads etc
 */
static snd_pcm_uframes_t saa7231_capture_pointer(struct snd_pcm_substream *=
pcm)
{
	struct saa7231_audio *audio	=3D snd_pcm_substream_chip(pcm);
	struct saa7231_dev *saa7231	=3D audio->saa7231;

	dprintk(SAA7231_DEBUG, 1, "DEBUG:()");

	return 0; //bytes_to_frames(rt, played);
}

/**
 * Initialiaze a stream port, for the required port
 */
struct saa7231_stream *saa7231_stream_init(struct saa7231_dev *saa7231,
					   enum saa7231_mode mode,
					   enum adapter_type adap_type,
					   int count,
					   int pages)
{
	int ret;
	struct saa7231_stream *stream;
	struct saa7231_dtl *dtl;

	stream =3D kzalloc(sizeof(struct saa7231_stream), GFP_KERNEL);
	if (!stream) {
		dprintk(SAA7231_ERROR, 1, "ERROR: Failed allocating streams");
		return NULL;
	}
	stream->mode	=3D mode;
	stream->saa7231 =3D saa7231;
	dtl 		=3D &stream->dtl;

	dprintk(SAA7231_DEBUG, 1, "DEBUG: Initializing Stream with MODE=3D0x%02x",=
 mode);

	switch (mode) {
	case AUDIO_CAPTURE:
		if (count >=3D 1) {
			dprintk(SAA7231_ERROR, 1, "ERROR: Invalid Stream port, port=3D%d", count=
);
			return NULL;
		}

		switch (adap_type) {
		case ADAPTER_INT:
			stream->port_id	=3D STREAM_PORT_AS2D_LOCAL;
			dtl->module	=3D AS2D_LOCAL;
			break;
		case ADAPTER_EXT:
			stream->port_id	=3D STREAM_PORT_AS2D_EXTERN;
			dtl->module	=3D AS2D_EXTERN;
			break;
		}

		ret =3D saa7231_xs2dtl_init(stream, pages);
		if (ret < 0) {
			dprintk(SAA7231_ERROR, 1, "ERROR: XS2DTL engine initialization failed");
			return NULL;
		}
		break;
	case VIDEO_CAPTURE:
		if (count >=3D 1) {
			dprintk(SAA7231_ERROR, 1, "ERROR: Invalid Stream port, port=3D%d", count=
);
			return NULL;
		}

		switch (adap_type) {
		case ADAPTER_INT:
			stream->port_id	=3D STREAM_PORT_VS2D_AVIS;
			dtl->module	=3D VS2D_AVIS;
			break;
		case ADAPTER_EXT:
			stream->port_id	=3D STREAM_PORT_VS2D_ITU;
			dtl->module	=3D VS2D_ITU;
			break;
		}

		ret =3D saa7231_vs2dtl_init(stream, pages);
		if (ret) {
			dprintk(SAA7231_ERROR, 1, "ERROR: VS2DTL engine initialization failed");
			return NULL;
		}
		ret =3D saa7231_avis_attach(stream);
		if (ret) {
			dprintk(SAA7231_ERROR, 1, "ERROR: AVIS initialization, attach() failed");
			return NULL;
		}
		break;
	case VBI_CAPTURE:
		if (count >=3D 1) {
			dprintk(SAA7231_ERROR, 1, "ERROR: Invalid Stream port, port=3D%d", count=
);
			return NULL;
		}

		switch (adap_type) {
		case ADAPTER_INT:
			stream->port_id	=3D STREAM_PORT_DS2D_AVIS;
			dtl->module	=3D DS2D_AVIS;
			break;
		case ADAPTER_EXT:
			stream->port_id	=3D STREAM_PORT_DS2D_ITU;
			dtl->module	=3D DS2D_ITU;
			break;
		}

		ret =3D saa7231_xs2dtl_init(stream, pages);
		if (ret) {
			dprintk(SAA7231_ERROR, 1, "ERROR: XS2DTL engine initialization failed");
			return NULL;
		}
		break;
	case DIGITAL_CAPTURE:
		if (count >=3D 2) {
			dprintk(SAA7231_ERROR, 1, "ERROR: Invalid Stream port, port=3D%d", count=
);
			return NULL;
		}

		switch (adap_type) {
		case ADAPTER_INT:
			stream->port_id	=3D STREAM_PORT_TS2D_DTV0 + count;
			dtl->module	=3D TS2D0_DTV + (count * 0x1000);
			break;
		case ADAPTER_EXT:
			stream->port_id	=3D STREAM_PORT_TS2D_EXTERN0 + count;
			dtl->module	=3D TS2D0_EXTERN + (count * 0x1000);
			break;
		}

		ret =3D saa7231_xs2dtl_init(stream, pages);
		if (ret) {
			dprintk(SAA7231_ERROR, 1, "ERROR: XS2DTL engine initialization failed");
			return NULL;
		}
		BUG_ON(stream->ops.acquire =3D=3D NULL);
		stream->params.bps   =3D 8;
		stream->params.spl   =3D 188;
		stream->params.lines =3D 348;
		stream->params.pitch =3D 188;
		stream->params.thrsh =3D 0;
		stream->params.flags =3D 0;
		stream->params.type  =3D STREAM_TS;
		ret =3D stream->ops.acquire(stream);
		if (ret < 0) {
			dprintk(SAA7231_ERROR, 1, "TS setup failed, ret=3D%d", ret);
			return NULL;
		}
		break;
	default:
		dprintk(SAA7231_ERROR, 1, "ERROR: Unknown mode=3D0x%02x", mode);
		BUG_ON(1);
		break;
	}

	/*
	 * Stream port starts at 0, but the related DMA channel is offset
	 * by +1, since MSI uses DMA channel 0. We store this offset as a
	 * mask
	 */
	dprintk(SAA7231_ERROR, 1, "INFO: Initialized MODE:0x%02x for PORT:%d",
		mode,
		stream->port_id);

	stream->init =3D 1;
	return stream;
}

int saa7231_xs2dtl_init(struct saa7231_stream *stream, int pages)
{
	int i, ret;
	struct stream_ops *ops		=3D &stream->ops;
	struct saa7231_dev *saa7231	=3D stream->saa7231;

	struct saa7231_dmabuf *dmabuf;

	dprintk(SAA7231_DEBUG, 1, "XS2DTL engine Initializing .....");
	/**
	 * Note: the stream port array starts at 0 but the related DMA
	 *       channel at dwDMAChannel +1, because MSI uses channel 0.
	 *       Store DMA enumeration but keep "+1" in channel mask!
	 */
	switch (stream->port_id) {
	case STREAM_PORT_DS2D_AVIS:
	case STREAM_PORT_DS2D_ITU:
		stream->port_hw =3D STREAM_VBI;
		stream->config	=3D 0;
		break;

	case STREAM_PORT_AS2D_LOCAL:
	case STREAM_PORT_AS2D_EXTERN:
		stream->port_hw =3D STREAM_AUDIO;
		stream->config	=3D 0x4; /* IIS stream */
		break;

	case STREAM_PORT_TS2D_DTV0:
	case STREAM_PORT_TS2D_DTV1:
		stream->port_hw =3D STREAM_TS;
		stream->config   =3D 0x0;
		break;

	case STREAM_PORT_TS2D_EXTERN0:
	case STREAM_PORT_TS2D_EXTERN1:
		stream->port_hw =3D STREAM_TS;
		stream->config	=3D 0x11; /* Parallel, Port ON */
		break;

	case STREAM_PORT_TS2D_CAM:
		stream->port_hw =3D STREAM_TS;
		stream->config	=3D 0x0181;
		break;

	default:
		dprintk(SAA7231_ERROR, 1, "ERROR: Invalid DMA setup!");
		stream->config	=3D 0;
		return -EINVAL;
	}
	/* Allocate space for n XS2D Buffers */
	dmabuf =3D kzalloc(sizeof (struct saa7231_dmabuf) * XS2D_BUFFERS, GFP_KERN=
EL);
	if (!dmabuf) {
		dprintk(SAA7231_ERROR, 1, "ERROR: Allocating %d XS2D Buffers", XS2D_BUFFE=
RS);
		ret =3D -ENOMEM;
	}
	dprintk(SAA7231_DEBUG, 1, "Allocated %d XS2DTL Buffer @0x%p",
XS2D_BUFFERS, dmabuf);
	stream->dmabuf =3D dmabuf;

	dprintk(SAA7231_DEBUG, 1, "Allocating DMA Buffers ...");
	for (i =3D 0; i < XS2D_BUFFERS; i++) {
		dprintk(SAA7231_DEBUG, 1, "Allocating DMA buffer:%d @0x%p..", i, &dmabuf[=
i]);
		ret =3D saa7231_dmabuf_alloc(saa7231, &dmabuf[i], pages);
		if (ret < 0) {
			dprintk(SAA7231_ERROR, 1, "ERROR: Failed allocating DMA buffers,
error=3D%d", ret);
			return -ENOMEM;
		}
	}
	dprintk(SAA7231_DEBUG, 1, "Initializing PTA ...");
	saa7231_init_ptables(stream);

	dprintk(SAA7231_DEBUG, 1, "Setting up PORT Gates ...");
	/* deactivate gating */
	switch (stream->port_id) {
	case STREAM_PORT_DS2D_AVIS:
		SAA7231_WR(0, SAA7231_BAR0, STREAM, STREAM_RA_VBI_LOC_CLGATE);
		break;
	case STREAM_PORT_DS2D_ITU:
		SAA7231_WR(0, SAA7231_BAR0, STREAM, STREAM_RA_VIDEO_EXT_CLGATE);
		break;
	case STREAM_PORT_AS2D_LOCAL:
		SAA7231_WR(0, SAA7231_BAR0, STREAM, STREAM_RA_AUDIO_LOC_CLGATE);
		break;
	case STREAM_PORT_AS2D_EXTERN:
		SAA7231_WR(0, SAA7231_BAR0, STREAM, STREAM_RA_AUDIO_EXT_CLGATE);
		break;
	case STREAM_PORT_TS2D_DTV0:
		SAA7231_WR(0, SAA7231_BAR0, STREAM, STREAM_RA_TS0_LOC_CLGATE);
		break;
	case STREAM_PORT_TS2D_DTV1:
		SAA7231_WR(0, SAA7231_BAR0, STREAM, STREAM_RA_TS1_LOC_CLGATE);
		break;
	case STREAM_PORT_TS2D_EXTERN0:
		SAA7231_WR(0, SAA7231_BAR0, STREAM, STREAM_RA_TS0_EXT_CLGATE);
		break;
	case STREAM_PORT_TS2D_EXTERN1:
		SAA7231_WR(0, SAA7231_BAR0, STREAM, STREAM_RA_TS1_EXT_CLGATE);
		break;
	case STREAM_PORT_TS2D_CAM:
		SAA7231_WR(0, SAA7231_BAR0, STREAM, STREAM_RA_TSCA_EXT_CLGATE);
		SAA7231_WR(0, SAA7231_BAR0, STREAM, STREAM_RA_TSMUX_CLGATE);

		/* TODO! disable clock usage here */
		break;
	default:
		return -EINVAL;
	}

	ops->acquire	=3D saa7231_xs2dtl_acquire;
	ops->run	=3D saa7231_xs2dtl_run;
	ops->pause	=3D saa7231_xs2dtl_pause;
	ops->stop	=3D saa7231_xs2dtl_stop;

	ops->set_buffer =3D saa7231_xs2dtl_set_buffer;
	ops->get_buffer =3D saa7231_xs2dtl_get_buffer;

	ops->exit 	=3D saa7231_xs2dtl_exit;

	return 0;
}

/**
 * Allocates one page of memory, which is stores the data of one
 * 7231 page table. The result gets stored in the passed DMA buffer
 * structure.
 */
static int saa7231_allocate_ptable(struct saa7231_dmabuf *dmabuf)
{
	struct saa7231_dev *saa7231	=3D dmabuf->saa7231;
	struct pci_dev *pdev		=3D saa7231->pdev;
	void *virt;
	dma_addr_t phys;

	virt =3D (void *) __get_free_page(GFP_KERNEL);
	if (!virt) {
		dprintk(SAA7231_ERROR, 1, "ERROR: Out of pages !");
		return -ENOMEM;
	}

	/*
	 * TODO!
	 * A conversion from virtual to physical is sufficient alone ?
	 * phys =3D __pa(virt)
	 * Or should we do DMA to the Page Table themselves ?
	 * In some some chip versions it seems we must manually copy the
	 * Page Tables, as Page Table DMA doesn't work ??
	 * Need to figure this out, as people who are really aware of this
	 * concept, can no longer be reached
	 */
	phys =3D dma_map_single(&pdev->dev,
			      virt,
			      SAA7231_PAGE_SIZE,
			      DMA_FROM_DEVICE);

	dprintk(SAA7231_DEBUG, 1, "Virtual 0x%p to Phys 0x%04x mapped page",
		virt,
		phys);

	if (!phys) {
		dprintk(SAA7231_ERROR, 1, "ERROR: map memory failed !");
		return -ENOMEM;
	}

	BUG_ON((unsigned long) phys % SAA7231_PAGE_SIZE);
	dmabuf->pt_phys =3D phys;
	dmabuf->pt_virt =3D virt;
	return 0;
}

/**
 * Create a SG, when an allocated buffer is passed to it,
 * otherwise the needed memory gets allocated by itself
 */
static int saa7231_dmabuf_sgalloc(struct saa7231_dmabuf *dmabuf, void
*buf, int pages)
{
	struct saa7231_dev *saa7231	=3D dmabuf->saa7231;
	struct scatterlist *sg_list;
	struct page *pg;
	void *vma =3D NULL, *mem =3D NULL;

	int i;

	BUG_ON(!pages);
	BUG_ON(!dmabuf);

	/* Allocate memory for SG list */
	sg_list =3D kzalloc(sizeof (struct scatterlist) * pages , GFP_KERNEL);
	if (!sg_list) {
		dprintk(SAA7231_ERROR, 1, "Failed to allocate memory for scatterlist.");
		return -ENOMEM;
	}
	sg_init_table(sg_list, pages);

	if (!buf) {
		/* allocate memory, unaligned, virtually contiguous memory region */
		mem =3D vmalloc((pages + 1) * SAA7231_PAGE_SIZE);
		if (!mem) {
			dprintk(SAA7231_ERROR, 1, "ERROR: vmalloc failed allocating %d
pages", pages);
			return -ENOMEM;
		}
		dprintk(SAA7231_INFO, 1, "Virtual contiguous %d byte region with %d
%dk pages",
			pages * SAA7231_PAGE_SIZE,
			pages,
			(SAA7231_PAGE_SIZE / 1024));

		/* align memory to page */
		vma =3D (void *) PAGE_ALIGN (((unsigned long) mem));
		BUG_ON(((unsigned long) vma) % SAA7231_PAGE_SIZE);
	} else {
		dprintk(SAA7231_DEBUG, 1, "DEBUG: Request to add %d pages to SG list", pa=
ges);
		vma =3D buf;
	}

	for (i =3D 0; i < pages; i++) {
		if (!buf)
			pg =3D vmalloc_to_page(vma + i * SAA7231_PAGE_SIZE);
		else
			pg =3D virt_to_page(vma + i * SAA7231_PAGE_SIZE);

		BUG_ON(!pg);

		sg_set_page(&sg_list[i], pg, SAA7231_PAGE_SIZE, 0);
	}
	dmabuf->sg_list	=3D sg_list;
	dmabuf->virt	=3D vma;
	dmabuf->vmalloc	=3D mem;
	dmabuf->pages	=3D pages; /* scatterlist length */

	return 0;
}

/* Allocates a DMA buffer for the specified external linear buffer. */
int saa7231_dmabuf_alloc(struct saa7231_dev *saa7231,
			 struct saa7231_dmabuf *dmabuf,
			 int size)
{
	struct pci_dev *pdev	=3D saa7231->pdev;

	int ret;

	BUG_ON(!saa7231);
	BUG_ON(!dmabuf);
	BUG_ON(! (size > 0));

	dmabuf->dma_type =3D SAA7231_DMABUF_INT;

	dmabuf->vmalloc	 =3D NULL;
	dmabuf->virt	 =3D NULL;
	dmabuf->pt_phys	 =3D 0;
	dmabuf->pt_virt	 =3D NULL;

	dmabuf->pages	 =3D 0;
	dmabuf->saa7231	 =3D saa7231;

	/* Allocate page table */
	ret =3D saa7231_allocate_ptable(dmabuf);
	if (ret) {
		dprintk(SAA7231_ERROR, 1, "PT alloc failed, Out of memory");
		goto err1;
	}

	/* Allocate buffer as SG */
	ret =3D saa7231_dmabuf_sgalloc(dmabuf, NULL, size);
	if (ret) {
		/* size is in pages */
		dprintk(SAA7231_ERROR, 1, "Request FAILED! for Virtual contiguous %d
byte region with %d %dk pages",
			size * SAA7231_PAGE_SIZE,
			size,
			(SAA7231_PAGE_SIZE / 1024));
		goto err2;
	}

	ret =3D dma_map_sg(&pdev->dev,
			 dmabuf->sg_list,
			 dmabuf->pages,
			 DMA_FROM_DEVICE);

	if (ret < 0) {
		dprintk(SAA7231_ERROR, 1, "SG map failed, ret=3D%d", ret);
		goto err3;
	}

	saa7231_dmabuf_sgpagefill(dmabuf, dmabuf->sg_list, ret, 0);

	return 0;
err3:
	saa7231_dmabuf_sgfree(dmabuf);
err2:
	saa7231_free_ptable(dmabuf);
err1:
	return ret;
}

/*  Fill the "page table" page with the pointers to the specified SG buffer=
 */
static void saa7231_dmabuf_sgpagefill(struct saa7231_dmabuf *dmabuf,
				      struct scatterlist *sg_list,
				      int pages,
				      int offset)
{
	struct saa7231_dev *saa7231	=3D dmabuf->saa7231;
	struct pci_dev *pdev		=3D saa7231->pdev;
	struct scatterlist *sg_cur;

	u32 *page;
	int i, j, k =3D 0;
	dma_addr_t addr =3D 0;

	BUG_ON(!dmabuf);
	BUG_ON(!sg_list);
	BUG_ON(!pages);

	/* make page writable for the PC */
	dma_sync_single_for_cpu(&pdev->dev,
				dmabuf->pt_phys,
				SAA7231_PAGE_SIZE,
				DMA_FROM_DEVICE);

	page =3D dmabuf->pt_virt;

	/* create page table */
	for (i =3D 0; i < pages; i++) {
		sg_cur =3D &sg_list[i];

//		BUG_ON(!((sg_cur->length + sg_cur->offset) % SAA7231_PAGE_SIZE));

		if (i =3D=3D 0)
			dmabuf->offset =3D (sg_cur->length + sg_cur->offset) % SAA7231_PAGE_SIZE;
		else
			BUG_ON(sg_cur->offset !=3D 0);

		for (j =3D 0; (j * SAA7231_PAGE_SIZE) < sg_dma_len(sg_cur); j++) {

			if ((offset + sg_cur->offset) >=3D SAA7231_PAGE_SIZE) {
				offset -=3D SAA7231_PAGE_SIZE;
				continue;
			}

			addr =3D ((u64 )sg_dma_address(sg_cur)) + (j * SAA7231_PAGE_SIZE) -
sg_cur->offset;

			BUG_ON(!addr);

			if (!(i % 8) && !(i =3D=3D 0))
				dprintk(SAA7231_DEBUG, 0, "\n    ");
			if ((i % 4) =3D=3D 0)
				dprintk(SAA7231_DEBUG, 0, "  ");
			if (i =3D=3D 0)
				dprintk(SAA7231_DEBUG, 0, "    ");

			dprintk(SAA7231_DEBUG, 0, "%04x ", addr);

			page[k * 2 + 0] =3D ADDR_LSB(addr); /* Low */
			page[k * 2 + 1] =3D ADDR_MSB(addr); /* High */

			BUG_ON(page[k * 2] % SAA7231_PAGE_SIZE);
			k++;
		}
	}

	for (; k < (SAA7231_PAGE_SIZE / 8); k++) {
		page[k * 2 + 0] =3D ADDR_LSB(addr);
		page[k * 2 + 1] =3D ADDR_MSB(addr);
	}

	/* make "page table" page writable for the PC */
	dma_sync_single_for_device(&pdev->dev,
				   dmabuf->pt_phys,
				   SAA7231_PAGE_SIZE,
				   DMA_FROM_DEVICE);

}

testbox ~ # arecord -D plughw:2,0 --format S16_LE --rate=3D32000 -c 2 >
~/test_capture.wav
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 32000 Hz, Stereo
arecord: pcm_read:1617: read error: Input/output error


[  103.349513] SAA7231 0000:05:00.0: PCI INT A -> GSI 16 (level, low) -> IR=
Q 16
[  103.349521] SAA7231 0000:05:00.0: setting latency timer to 64
[  103.349544] saa7231_pci_init (0): BAR 0 Offset: 04 BAR 2 Offset: 04
[  103.349547] saa7231_pci_init (0): BAR0 Start=3Dfc800000 length=3D4M
[  103.349549] saa7231_pci_init (0): BAR2 Start=3Dfc400000 length=3D4M
[  103.351180]     SAA7231GE [14c7:3595], irq: 16,
[  103.351183]     mmio(0): 0xf8780000 mmio(2): 0xf8c00000
[  103.351197]     SAA7231 64Bit, MSI Disabled, MSI-X=3D1 msgs
[  103.351203] saa7231_get_version (0): SAA7231 PCI Express V1A found
[  103.351205] saa7231_cgu_init (0): Initializing CGU
[  103.351207] saa7231_cgu_init (0): Using 54MHz RootClock
[  103.351228] saa7231_cgu_init (0): PLL Status CDEC160: 00 REF550: 00
ADPLL: 00 DSP: 00
[  103.351231] saa7231_set_clk (0): clk_output=3D0   clk_frequency=3D2
[  103.351232] saa7231_set_clk (0): clk_output=3D1   clk_frequency=3D2
[  103.351234] saa7231_set_clk (0): clk_output=3D2   clk_frequency=3D2
[  103.351236] saa7231_set_clk (0): clk_output=3D3   clk_frequency=3D2
[  103.351238] saa7231_set_clk (0): clk_output=3D4   clk_frequency=3D2
[  103.351239] saa7231_set_clk (0): clk_output=3D5   clk_frequency=3D2
[  103.351241] saa7231_set_clk (0): clk_output=3D6   clk_frequency=3D2
[  103.351243] saa7231_set_clk (0): clk_output=3D7   clk_frequency=3D2
[  103.351244] saa7231_set_clk (0): clk_output=3D8   clk_frequency=3D2
[  103.351246] saa7231_set_clk (0): clk_output=3D9   clk_frequency=3D2
[  103.351248] saa7231_set_clk (0): clk_output=3D10   clk_frequency=3D2
[  103.351250] saa7231_set_clk (0): clk_output=3D11   clk_frequency=3D2
[  103.351251] saa7231_set_clk (0): clk_output=3D12   clk_frequency=3D2
[  103.351253] saa7231_set_clk (0): clk_output=3D13   clk_frequency=3D2
[  103.351255] saa7231_set_clk (0): clk_output=3D14   clk_frequency=3D2
[  103.351257] saa7231_set_clk (0): clk_output=3D15   clk_frequency=3D2
[  103.351259] saa7231_set_clk (0): clk_output=3D16   clk_frequency=3D2
[  103.351260] saa7231_set_clk (0): clk_output=3D17   clk_frequency=3D2
[  103.351262] saa7231_set_clk (0): clk_output=3D18   clk_frequency=3D2
[  103.402026] saa7231_cgu_init (0): DEBUG: RGU_RESET_ACTIVE0 7c02001f
[  103.504025] saa7231_cgu_init (0): DEBUG: RGU_RESET_ACTIVE0 ffffffff
[  103.504029] saa7231_cgu_init (0): DEBUG: RGU_RESET_ACTIVE1 2e1f
[  103.504031] saa7231_set_clk (0): clk_output=3D17   clk_frequency=3D0
[  103.510052] saa7231_i2c_init (0): Initializing SAA7231 I2C Core
[  103.510056] saa7231_i2c_init (0): Initializing adapter (0) SAA7231 I2C:0
[  103.510254] saa7231_i2c_hwinit (0): Adapter (109000) SAA7231 I2C:0 RESET
[  103.510256] saa7231_i2c_hwinit (0): Initializing Adapter SAA7231 I2C:0 @=
 100k
[  103.510264] saa7231_i2c_init (0): Initializing adapter (1) SAA7231 12C:1
[  103.510526] saa7231_i2c_hwinit (0): Adapter (10a000) SAA7231 12C:1 RESET
[  103.510528] saa7231_i2c_hwinit (0): Initializing Adapter SAA7231 12C:1 @=
 100k
[  103.510536] saa7231_i2c_init (0): Initializing adapter (2) SAA7231 I2C:2
[  103.510727] saa7231_i2c_hwinit (0): Adapter (10b000) SAA7231 I2C:2 RESET
[  103.510730] saa7231_i2c_hwinit (0): Initializing Adapter SAA7231 I2C:2 @=
 100k
[  103.510738] saa7231_i2c_init (0): Initializing adapter (3) SAA7231 I2C:3
[  103.510872] saa7231_i2c_hwinit (0): Adapter (10c000) SAA7231 I2C:3 RESET
[  103.510874] saa7231_i2c_hwinit (0): Initializing Adapter SAA7231 I2C:3 @=
 100k
[  103.510882] saa7231_i2c_init (0): SAA7231 I2C Core succesfully initializ=
ed
[  103.510884] saa7231_alsa_init (0): Initializing Audio ..
[  103.518765] saa7231_pci_probe (0): SAA7231 device:0 initialized
[  122.183642] saa7231_capture_open (0): ()
[  122.184422] saa7231_hw_params (0): DEBUG: ()
[  122.184425] saa7231_hw_params (0): bufsiz=3D131072 periods=3D8
bytes=3D16384 pages=3D32
[  122.184428] saa7231_stream_init (0): DEBUG: Initializing Stream
with MODE=3D0x01
[  122.184430] saa7231_xs2dtl_init (0): XS2DTL engine Initializing .....
[  122.184433] saa7231_xs2dtl_init (0): Allocated 8 XS2DTL Buffer @0xf52d32=
00
[  122.184435] saa7231_xs2dtl_init (0): Allocating DMA Buffers ...
[  122.184437] saa7231_xs2dtl_init (0): Allocating DMA buffer:0 @0xf52d3200=
..
[  122.184447] saa7231_allocate_ptable (0): Virtual 0xf53f5000 to Phys
0x353f5000 mapped page
[  122.184464] saa7231_dmabuf_sgalloc (0): Virtual contiguous 16384
byte region with 4 4k pages
[  122.184487]       6c2f1000 6c277000 6c292000 6c377000
[  122.184493] saa7231_xs2dtl_init (0): Allocating DMA buffer:1 @0xf52d3228=
..
[  122.184501] saa7231_allocate_ptable (0): Virtual 0xf53e7000 to Phys
0x353e7000 mapped page
[  122.184507] saa7231_dmabuf_sgalloc (0): Virtual contiguous 16384
byte region with 4 4k pages
[  122.184527]       6c49f000 6c28d000 6c31b000 6c2e8000
[  122.184532] saa7231_xs2dtl_init (0): Allocating DMA buffer:2 @0xf52d3250=
..
[  122.184539] saa7231_allocate_ptable (0): Virtual 0xf4014000 to Phys
0x34014000 mapped page
[  122.184545] saa7231_dmabuf_sgalloc (0): Virtual contiguous 16384
byte region with 4 4k pages
[  122.184564]       6c480000 6c481000 6c31c000 6c31d000
[  122.184569] saa7231_xs2dtl_init (0): Allocating DMA buffer:3 @0xf52d3278=
..
[  122.184577] saa7231_allocate_ptable (0): Virtual 0xf42bb000 to Phys
0x342bb000 mapped page
[  122.184582] saa7231_dmabuf_sgalloc (0): Virtual contiguous 16384
byte region with 4 4k pages
[  122.184602]       6c31f000 6c2f8000 6c2f9000 6c2fa000
[  122.184606] saa7231_xs2dtl_init (0): Allocating DMA buffer:4 @0xf52d32a0=
..
[  122.184614] saa7231_allocate_ptable (0): Virtual 0xf42ba000 to Phys
0x342ba000 mapped page
[  122.184622] saa7231_dmabuf_sgalloc (0): Virtual contiguous 16384
byte region with 4 4k pages
[  122.184641]       6c2fc000 6c2fd000 6c2fe000 6c2ff000
[  122.184646] saa7231_xs2dtl_init (0): Allocating DMA buffer:5 @0xf52d32c8=
..
[  122.184654] saa7231_allocate_ptable (0): Virtual 0xf42b9000 to Phys
0x342b9000 mapped page
[  122.184659] saa7231_dmabuf_sgalloc (0): Virtual contiguous 16384
byte region with 4 4k pages
[  122.184678]       6c301000 6c302000 6c303000 6c304000
[  122.184683] saa7231_xs2dtl_init (0): Allocating DMA buffer:6 @0xf52d32f0=
..
[  122.184690] saa7231_allocate_ptable (0): Virtual 0xf42b8000 to Phys
0x342b8000 mapped page
[  122.184695] saa7231_dmabuf_sgalloc (0): Virtual contiguous 16384
byte region with 4 4k pages
[  122.184714]       6c306000 6c307000 6c308000 6c309000
[  122.184719] saa7231_xs2dtl_init (0): Allocating DMA buffer:7 @0xf52d3318=
..
[  122.184726] saa7231_allocate_ptable (0): Virtual 0xf42b7000 to Phys
0x342b7000 mapped page
[  122.184732] saa7231_dmabuf_sgalloc (0): Virtual contiguous 16384
byte region with 4 4k pages
[  122.184751]       6c30b000 6c30c000 6c30d000 6c30e000
[  122.184756] saa7231_xs2dtl_init (0): Initializing PTA ...
[  122.184758] saa7231_init_ptables (0): DEBUG: Initializing PORT:6
DMA_CH:7 with 8 Buffers
[  122.184760] saa7231_xs2dtl_init (0): Setting up PORT Gates ...
[  122.184762] saa7231_stream_init (0): INFO: Initialized MODE:0x01 for POR=
T:6
[  122.184765] saa7231_add_irqevent (0): Adding AS2D_AVIS IRQ Event:43 ...
[  122.184767] saa7231_setup_vector (0): Adding Vector:43
[  122.184771] saa7231_setup_vector (0): Enabling Vector:43
[  122.184775] saa7231_add_irqevent (0): Succesfully added AS2D_AVIS
as Event handler:43
[  122.184777] saa7231_hw_params (0): Mapping 8 buffers with 4 pages each
[  122.184778] saa7231_hw_params (0): Page Table array size=3D1
[  122.184780] saa7231_hw_params (0): Mapping Page:0 from
XS2D_BUFFER:0 to PTA Offset:0
[  122.184782] saa7231_hw_params (0): Mapping Page:1 from
XS2D_BUFFER:0 to PTA Offset:1
[  122.184784] saa7231_hw_params (0): Mapping Page:2 from
XS2D_BUFFER:0 to PTA Offset:2
[  122.184786] saa7231_hw_params (0): Mapping Page:3 from
XS2D_BUFFER:0 to PTA Offset:3
[  122.184788] saa7231_hw_params (0): Mapping Page:0 from
XS2D_BUFFER:1 to PTA Offset:4
[  122.184790] saa7231_hw_params (0): Mapping Page:1 from
XS2D_BUFFER:1 to PTA Offset:5
[  122.184791] saa7231_hw_params (0): Mapping Page:2 from
XS2D_BUFFER:1 to PTA Offset:6
[  122.184793] saa7231_hw_params (0): Mapping Page:3 from
XS2D_BUFFER:1 to PTA Offset:7
[  122.184795] saa7231_hw_params (0): Mapping Page:0 from
XS2D_BUFFER:2 to PTA Offset:8
[  122.184797] saa7231_hw_params (0): Mapping Page:1 from
XS2D_BUFFER:2 to PTA Offset:9
[  122.184799] saa7231_hw_params (0): Mapping Page:2 from
XS2D_BUFFER:2 to PTA Offset:10
[  122.184801] saa7231_hw_params (0): Mapping Page:3 from
XS2D_BUFFER:2 to PTA Offset:11
[  122.184803] saa7231_hw_params (0): Mapping Page:0 from
XS2D_BUFFER:3 to PTA Offset:12
[  122.184805] saa7231_hw_params (0): Mapping Page:1 from
XS2D_BUFFER:3 to PTA Offset:13
[  122.184807] saa7231_hw_params (0): Mapping Page:2 from
XS2D_BUFFER:3 to PTA Offset:14
[  122.184809] saa7231_hw_params (0): Mapping Page:3 from
XS2D_BUFFER:3 to PTA Offset:15
[  122.184810] saa7231_hw_params (0): Mapping Page:0 from
XS2D_BUFFER:4 to PTA Offset:16
[  122.184812] saa7231_hw_params (0): Mapping Page:1 from
XS2D_BUFFER:4 to PTA Offset:17
[  122.184814] saa7231_hw_params (0): Mapping Page:2 from
XS2D_BUFFER:4 to PTA Offset:18
[  122.184816] saa7231_hw_params (0): Mapping Page:3 from
XS2D_BUFFER:4 to PTA Offset:19
[  122.184818] saa7231_hw_params (0): Mapping Page:0 from
XS2D_BUFFER:5 to PTA Offset:20
[  122.184820] saa7231_hw_params (0): Mapping Page:1 from
XS2D_BUFFER:5 to PTA Offset:21
[  122.184822] saa7231_hw_params (0): Mapping Page:2 from
XS2D_BUFFER:5 to PTA Offset:22
[  122.184824] saa7231_hw_params (0): Mapping Page:3 from
XS2D_BUFFER:5 to PTA Offset:23
[  122.184826] saa7231_hw_params (0): Mapping Page:0 from
XS2D_BUFFER:6 to PTA Offset:24
[  122.184828] saa7231_hw_params (0): Mapping Page:1 from
XS2D_BUFFER:6 to PTA Offset:25
[  122.184830] saa7231_hw_params (0): Mapping Page:2 from
XS2D_BUFFER:6 to PTA Offset:26
[  122.184832] saa7231_hw_params (0): Mapping Page:3 from
XS2D_BUFFER:6 to PTA Offset:27
[  122.184834] saa7231_hw_params (0): Mapping Page:0 from
XS2D_BUFFER:7 to PTA Offset:28
[  122.184835] saa7231_hw_params (0): Mapping Page:1 from
XS2D_BUFFER:7 to PTA Offset:29
[  122.184837] saa7231_hw_params (0): Mapping Page:2 from
XS2D_BUFFER:7 to PTA Offset:30
[  122.184839] saa7231_hw_params (0): Mapping Page:3 from
XS2D_BUFFER:7 to PTA Offset:31
[  122.184864] saa7231_capture_prepare (0): ()
[  122.184866] saa7231_capture_prepare (0): Trying to Acquire stream
with 4096lines per stream buffer
[  122.184868] saa7231_xs2dtl_acquire (0): Activating clock ..
mode=3D0x01, port_id=3D0x06
[  122.184871] saa7231_activate_clocks (0): DEBUG: Activating Clock
for Mode=3D0x01, port=3D0x06
[  122.184873] tmGetClockInstance (0): DEBUG: Mode=3D0x01, dmaport=3D0x06
[  122.184875] tmGetClockInstance (0): ret=3D0
[  122.184880] saa7231_activate_clocks (0): INFO: activate use case index 0
[  122.184882] saa7231_init_ptables (0): DEBUG: Initializing PORT:6
DMA_CH:7 with 8 Buffers
[  122.190510] saa7231_capture_trigger (0): Tring to START stream, cmd=3D1
[  122.201045]
[  122.201047] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  122.201050] [ INFO: inconsistent lock state ]
[  122.201052] 2.6.34.7 #2
[  122.201053] ---------------------------------
[  122.201055] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
[  122.201058] arecord/5860 [HC0[0]:SC0[0]:HE1:SE1] takes:
[  122.201060]  (&(&substream->self_group.lock)->rlock){?.-...}, at:
[<c13271b5>] snd_pcm_stream_lock_irq+0x20/0x23
[  122.201068] {IN-HARDIRQ-W} state was registered at:
[  122.201069]   [<c105a27c>] __lock_acquire+0x23e/0xb47
[  122.201074]   [<c105ac11>] lock_acquire+0x8c/0xab
[  122.201077]   [<c144a8bb>] _raw_spin_lock+0x20/0x2f
[  122.201081]   [<c132811e>] snd_pcm_period_elapsed+0x39/0xb4
[  122.201084]   [<f843040f>] azx_interrupt+0x8e/0x106 [snd_hda_intel]
[  122.201090]   [<c1079a16>] handle_IRQ_event+0x4b/0xf1
[  122.201093]   [<c107b469>] handle_fasteoi_irq+0x86/0xbd
[  122.201096] irq event stamp: 4520
[  122.201098] hardirqs last  enabled at (4519): [<c100287b>]
sysenter_exit+0xf/0x16
[  122.201101] hardirqs last disabled at (4520): [<c144ac7b>]
_raw_read_lock_irq+0x11/0x35
[  122.201105] softirqs last  enabled at (3784): [<c1039b96>]
__do_softirq+0x15a/0x169
[  122.201108] softirqs last disabled at (3757): [<c10042fc>]
do_softirq+0x63/0xaf
[  122.201111]
[  122.201111] other info that might help us debug this:
[  122.201113] 2 locks held by arecord/5860:
[  122.201115]  #0:  (snd_pcm_link_rwlock){.?.-..}, at: [<c13271aa>]
snd_pcm_stream_lock_irq+0x15/0x23
[  122.201120]  #1:  (&(&substream->self_group.lock)->rlock){?.-...},
at: [<c13271b5>] snd_pcm_stream_lock_irq+0x20/0x23
[  122.201124]
[  122.201125] stack backtrace:
[  122.201127] Pid: 5860, comm: arecord Not tainted 2.6.34.7 #2
[  122.201129] Call Trace:
[  122.201132]  [<c1448b56>] ? printk+0x14/0x16
[  122.201134]  [<c105938f>] valid_state+0x12a/0x13d
[  122.201137]  [<c1059493>] mark_lock+0xf1/0x1d9
[  122.201140]  [<c1059b3c>] ? check_usage_backwards+0x0/0x68
[  122.201142]  [<c10595be>] mark_held_locks+0x43/0x5b
[  122.201145]  [<c144ad98>] ? _raw_spin_unlock_irq+0x27/0x2b
[  122.201148]  [<c10597d7>] trace_hardirqs_on_caller+0xe7/0x121
[  122.201151]  [<c105981c>] trace_hardirqs_on+0xb/0xd
[  122.201153]  [<c144ad98>] _raw_spin_unlock_irq+0x27/0x2b
[  122.201157]  [<c102d6ac>] finish_task_switch+0x5c/0x86
[  122.201160]  [<c102d650>] ? finish_task_switch+0x0/0x86
[  122.201162]  [<c144925d>] schedule+0x53d/0x5b4
[  122.201165]  [<c14495ec>] schedule_timeout+0x7e/0x9b
[  122.201169]  [<c103f3ea>] ? process_timeout+0x0/0xf
[  122.201172]  [<c1449623>] schedule_timeout_uninterruptible+0x1a/0x1c
[  122.201175]  [<c103f8e9>] msleep+0x15/0x1b
[  122.201183]  [<f83b5974>] saa7231_xs2dtl_run+0x93/0x123 [saa7231_core]
[  122.201190]  [<f83b9749>] saa7231_capture_trigger+0x5c/0x158 [saa7231_co=
re]
[  122.201193]  [<c13226e3>] snd_pcm_do_start+0x23/0x26
[  122.201196]  [<c132263a>] snd_pcm_action_single+0x2a/0x50
[  122.201199]  [<c1323ce8>] snd_pcm_action+0x6f/0x7b
[  122.201202]  [<c1323d8a>] snd_pcm_start+0x19/0x1b
[  122.201204]  [<c13283a0>] snd_pcm_lib_read1+0x61/0x1ff
[  122.201207]  [<c13285be>] snd_pcm_lib_read+0x33/0x54
[  122.201210]  [<c13273e5>] ? snd_pcm_lib_read_transfer+0x0/0x70
[  122.201213]  [<c1325ec1>] snd_pcm_capture_ioctl1+0x8e/0x2ed
[  122.201215]  [<c1326148>] snd_pcm_capture_ioctl+0x28/0x35
[  122.201219]  [<c10c7ec5>] vfs_ioctl+0x2c/0x96
[  122.201222]  [<c1326120>] ? snd_pcm_capture_ioctl+0x0/0x35
[  122.201224]  [<c10c843f>] do_vfs_ioctl+0x46c/0x4aa
[  122.201228]  [<c10bd0f3>] ? fsnotify_modify+0x54/0x5f
[  122.201231]  [<c10bd1fe>] ? do_sync_write+0x0/0xca
[  122.201234]  [<c10be3e3>] ? fget_light+0xe/0xaf
[  122.201236]  [<c10c84b0>] sys_ioctl+0x33/0x4d
[  122.201239]  [<c100284c>] sysenter_do_call+0x12/0x32
[  133.191022] saa7231_xs2dtl_run (0): ERROR, Preload PTA failed
[  133.191027] saa7231_capture_trigger (0): ERROR: starting stream, err=3D-=
22
[  133.191030] saa7231_capture_trigger (0): Tring to STOP stream, cmd=3D0
[  133.191179] saa7231_hw_free (0): DEBUG: Removing IRQ event ..
[  133.191195] saa7231_remove_irqevent (0): Removing IRQ Event:43 ......
[  133.191225] saa7231_remove_irqevent (0): IRQ Event 43 <AS2D_AVIS> removed
[  133.191229] saa7231_hw_free (0): DEBUG: Unmap Virtual memory region ..
[  133.191241] saa7231_hw_free (0): DEBUG: Stream exiting ..
[  133.191244] saa7231_stream_exit (0): INFO: Freeing MODE:0x01 for PORT=3D=
0x06
[  133.191247] saa7231_xs2dtl_exit (0): Free XS2DTL engine ..
[  133.191249] saa7231_dmabuf_free (0): INFO: Scatterlist unmapped
[  133.191253] saa7231_dmabuf_free (0): INFO: Scatterlist free
[  133.191255] saa7231_dmabuf_sgfree (0): SG free
[  133.191261] saa7231_dmabuf_free (0): INFO: Page table free
[  133.191263] saa7231_free_ptable (0): SG Page table free
[  133.191267] saa7231_dmabuf_free (0): INFO: Scatterlist unmapped
[  133.191271] saa7231_dmabuf_free (0): INFO: Scatterlist free
[  133.191273] saa7231_dmabuf_sgfree (0): SG free
[  133.191278] saa7231_dmabuf_free (0): INFO: Page table free
[  133.191280] saa7231_free_ptable (0): SG Page table free
[  133.191284] saa7231_dmabuf_free (0): INFO: Scatterlist unmapped
[  133.191288] saa7231_dmabuf_free (0): INFO: Scatterlist free
[  133.191289] saa7231_dmabuf_sgfree (0): SG free
[  133.191295] saa7231_dmabuf_free (0): INFO: Page table free
[  133.191296] saa7231_free_ptable (0): SG Page table free
[  133.191300] saa7231_dmabuf_free (0): INFO: Scatterlist unmapped
[  133.191304] saa7231_dmabuf_free (0): INFO: Scatterlist free
[  133.191305] saa7231_dmabuf_sgfree (0): SG free
[  133.191311] saa7231_dmabuf_free (0): INFO: Page table free
[  133.191313] saa7231_free_ptable (0): SG Page table free
[  133.191316] saa7231_dmabuf_free (0): INFO: Scatterlist unmapped
[  133.191320] saa7231_dmabuf_free (0): INFO: Scatterlist free
[  133.191322] saa7231_dmabuf_sgfree (0): SG free
[  133.191327] saa7231_dmabuf_free (0): INFO: Page table free
[  133.191329] saa7231_free_ptable (0): SG Page table free
[  133.191332] saa7231_dmabuf_free (0): INFO: Scatterlist unmapped
[  133.191336] saa7231_dmabuf_free (0): INFO: Scatterlist free
[  133.191338] saa7231_dmabuf_sgfree (0): SG free
[  133.191343] saa7231_dmabuf_free (0): INFO: Page table free
[  133.191345] saa7231_free_ptable (0): SG Page table free
[  133.191348] saa7231_dmabuf_free (0): INFO: Scatterlist unmapped
[  133.191351] saa7231_dmabuf_free (0): INFO: Scatterlist free
[  133.191352] saa7231_dmabuf_sgfree (0): SG free
[  133.191359] saa7231_dmabuf_free (0): INFO: Page table free
[  133.191361] saa7231_free_ptable (0): SG Page table free
[  133.191364] saa7231_dmabuf_free (0): INFO: Scatterlist unmapped
[  133.191367] saa7231_dmabuf_free (0): INFO: Scatterlist free
[  133.191369] saa7231_dmabuf_sgfree (0): SG free
[  133.191374] saa7231_dmabuf_free (0): INFO: Page table free
[  133.191377] saa7231_free_ptable (0): SG Page table free
[  133.191381] saa7231_hw_free (0): DEBUG: Freeing ptable ...
[  133.191383] saa7231_capture_close (0): DEBUG: Closing stream
