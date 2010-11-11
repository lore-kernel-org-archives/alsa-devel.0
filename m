From: Manu Abraham <abraham.manu@gmail.com>
Subject: Re: mapping externally allocated Scatter Gather DMA
	buffers
Date: Thu, 11 Nov 2010 13:15:15 +0530
Message-ID: <AANLkTimXTdWRrdA8+ToQp-gPofKohaSJ_Ss5x4S42uo5@mail.gmail.com>
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
	<AANLkTim=NT4cPQV+c3Y7eZF81Pv6R--vRgT_jGj7xZQJ@mail.gmail.com>
	<alpine.LNX.2.00.1011101515420.29422@eeebox2.perex-int.cz>
	<AANLkTi=gjN1xfnMZ4R29Sq_=fxYAfJwOQmD_+6beLYSp@mail.gmail.com>
	<alpine.LNX.2.00.1011101859010.29422@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 9919C1037EE
	for <alsa-devel@alsa-project.org>; Thu, 11 Nov 2010 08:45:16 +0100 (CET)
Received: by wwd20 with SMTP id 20so1695327wwd.20
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2010 23:45:16 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1011101859010.29422@eeebox2.perex-int.cz>
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

On Wed, Nov 10, 2010 at 11:35 PM, Jaroslav Kysela <perex@perex.cz> wrote:
> On Wed, 10 Nov 2010, Manu Abraham wrote:
>
>> On Wed, Nov 10, 2010 at 8:35 PM, Jaroslav Kysela <perex@perex.cz> wrote:
>>>
>>> On Wed, 10 Nov 2010, Manu Abraham wrote:
>>>>
>>>> =A0 =A0 =A0 =A0/* enable stream */
>>>> =A0 =A0 =A0 =A0/* initializing 8 buffer with "pages" pages each .. */
>>>> =A0 =A0 =A0 =A0stream =3D saa7231_stream_init(saa7231, AUDIO_CAPTURE, =
ADAPTER_INT,
>>>> 0, pages);
>>>> =A0 =A0 =A0 =A0if (!stream) {
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dprintk(SAA7231_ERROR, 1, "ERROR: Regis=
tering stream");
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
>>>> =A0 =A0 =A0 =A0}
>>>> =A0 =A0 =A0 =A0audio->stream =3D stream;
>>>> =A0 =A0 =A0 =A0buffer =3D stream->dmabuf;
>>>> =A0 =A0 =A0 =A0saa7231_add_irqevent(saa7231, 43, SAA7231_EDGE_RISING,
>>>> saa7231_audio_evhandler, "AS2D_AVIS");
>>>> =A0 =A0 =A0 =A0dprintk(SAA7231_DEBUG, 1, "Mapping %d buffers with %d p=
ages
>>>> each",
>>>> XS2D_BUFFERS, pages);
>>>
>>> Unfortunately, I don't understand the role of XS2D_BUFFERS. The ALSA
>>> bufsize
>>> is the whole DMA area (you should use params_buffer_bytes() to get this
>>> value instead of calculating this using periods * period_size).
>>>
>>> It means: Just allocate number of pages required for buffer_bytes. Don't
>>> play with periods (except the interrupts).
>>
>>
>> There are 8 SG buffers for the hardware; the maximum size of each
>> buffer can be 512 pages,
>> the minimum can be a single page.
>
> Could you describe more the whole DMA layout, including IRQ acks?
>
> It seems to me:
>
> SG PAGE 1 points to 1 - 512 data pages (4096 bytes long)
> SG PAGE 2 .....
> =A0 =A0....
> SG PAGE 8 .....


I adapted the whole thing to make the buffersize divided amongst the
XS2D_BUFFERS (8):
I hope the mapping of the buffers is okay ? It looks thus, now ..




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
	.rate_max		=3D 32000,

	.channels_min		=3D 1,
	.channels_max		=3D 2,

//	.buffer_bytes_max	=3D 512 * 4096,
	.buffer_bytes_max	=3D 256 * 1024,
#if 0
	.period_bytes_min	=3D 192,
	.period_bytes_max	=3D 1536,
	.periods_min		=3D 2,
	.periods_max		=3D 1024,
#endif
#if 0
	.period_bytes_min	=3D 1920,    /* 10mS @ 48khz */
	.period_bytes_max	=3D 768000,  /* 4S   @ 48kHz */

	.periods_min		=3D 10,      /* 10mS */
	.periods_max		=3D 4000000, /* 4S */
#endif

	.period_bytes_min	=3D 64,
	.period_bytes_max	=3D 256 * 1024,

	.periods_min		=3D 4,
	.periods_max		=3D 1024,
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
#if 0
	err =3D snd_pcm_hw_constraint_minmax(rt,
SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 10, 4000000);
	if (err < 0) {
		dprintk(SAA7231_ERROR, 1, "snd_pcm_hw_constraint_minmax() failed.
ret=3D%d", err);
		return err;
	}
	err =3D snd_pcm_hw_constraint_minmax(rt,
SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 1920, 768000);
	if (err < 0) {
		dprintk(SAA7231_ERROR, 1, "snd_pcm_hw_constraint_minmax() failed.
ret=3D%d", err);
		return err;
	}
#endif
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

	dprintk(SAA7231_DEBUG, 1, "DEBUG: ()");

	periods =3D params_periods(params);
	bytes   =3D params_period_bytes(params);
	bufsiz  =3D params_buffer_bytes(params);
	pages   =3D (bufsiz + PAGE_SIZE - 1) / PAGE_SIZE;

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

testbox ~ # arecord -D plughw:2,0 --format S16_LE --rate=3D32000 -c 2 >
~/test_capture.wav
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 32000 Hz, Stereo
arecord: pcm_read:1617: read error: Input/output error


[  114.326533] SAA7231 0000:05:00.0: PCI INT A -> GSI 16 (level, low) -> IR=
Q 16
[  114.326541] SAA7231 0000:05:00.0: setting latency timer to 64
[  114.326564] saa7231_pci_init (0): BAR 0 Offset: 04 BAR 2 Offset: 04
[  114.326567] saa7231_pci_init (0): BAR0 Start=3Dfc800000 length=3D4M
[  114.326569] saa7231_pci_init (0): BAR2 Start=3Dfc400000 length=3D4M
[  114.328217]     SAA7231GE [14c7:3595], irq: 16,
[  114.328219]     mmio(0): 0xf8800000 mmio(2): 0xf9e00000
[  114.328232]     SAA7231 64Bit, MSI Disabled, MSI-X=3D1 msgs
[  114.328239] saa7231_get_version (0): SAA7231 PCI Express V1A found
[  114.328241] saa7231_cgu_init (0): Initializing CGU
[  114.328243] saa7231_cgu_init (0): Using 54MHz RootClock
[  114.328264] saa7231_cgu_init (0): PLL Status CDEC160: 00 REF550: 00
ADPLL: 00 DSP: 00
[  114.328266] saa7231_set_clk (0): clk_output=3D0   clk_frequency=3D2
[  114.328268] saa7231_set_clk (0): clk_output=3D1   clk_frequency=3D2
[  114.328270] saa7231_set_clk (0): clk_output=3D2   clk_frequency=3D2
[  114.328272] saa7231_set_clk (0): clk_output=3D3   clk_frequency=3D2
[  114.328273] saa7231_set_clk (0): clk_output=3D4   clk_frequency=3D2
[  114.328275] saa7231_set_clk (0): clk_output=3D5   clk_frequency=3D2
[  114.328277] saa7231_set_clk (0): clk_output=3D6   clk_frequency=3D2
[  114.328278] saa7231_set_clk (0): clk_output=3D7   clk_frequency=3D2
[  114.328280] saa7231_set_clk (0): clk_output=3D8   clk_frequency=3D2
[  114.328282] saa7231_set_clk (0): clk_output=3D9   clk_frequency=3D2
[  114.328283] saa7231_set_clk (0): clk_output=3D10   clk_frequency=3D2
[  114.328285] saa7231_set_clk (0): clk_output=3D11   clk_frequency=3D2
[  114.328287] saa7231_set_clk (0): clk_output=3D12   clk_frequency=3D2
[  114.328288] saa7231_set_clk (0): clk_output=3D13   clk_frequency=3D2
[  114.328290] saa7231_set_clk (0): clk_output=3D14   clk_frequency=3D2
[  114.328292] saa7231_set_clk (0): clk_output=3D15   clk_frequency=3D2
[  114.328294] saa7231_set_clk (0): clk_output=3D16   clk_frequency=3D2
[  114.328295] saa7231_set_clk (0): clk_output=3D17   clk_frequency=3D2
[  114.328297] saa7231_set_clk (0): clk_output=3D18   clk_frequency=3D2
[  114.379027] saa7231_cgu_init (0): DEBUG: RGU_RESET_ACTIVE0 7c02001f
[  114.481027] saa7231_cgu_init (0): DEBUG: RGU_RESET_ACTIVE0 ffffffff
[  114.481032] saa7231_cgu_init (0): DEBUG: RGU_RESET_ACTIVE1 2e1f
[  114.481034] saa7231_set_clk (0): clk_output=3D17   clk_frequency=3D0
[  114.487053] saa7231_i2c_init (0): Initializing SAA7231 I2C Core
[  114.487057] saa7231_i2c_init (0): Initializing adapter (0) SAA7231 I2C:0
[  114.487328] saa7231_i2c_hwinit (0): Adapter (109000) SAA7231 I2C:0 RESET
[  114.487330] saa7231_i2c_hwinit (0): Initializing Adapter SAA7231 I2C:0 @=
 100k
[  114.487338] saa7231_i2c_init (0): Initializing adapter (1) SAA7231 12C:1
[  114.487556] saa7231_i2c_hwinit (0): Adapter (10a000) SAA7231 12C:1 RESET
[  114.487559] saa7231_i2c_hwinit (0): Initializing Adapter SAA7231 12C:1 @=
 100k
[  114.487568] saa7231_i2c_init (0): Initializing adapter (2) SAA7231 I2C:2
[  114.487643] saa7231_i2c_hwinit (0): Adapter (10b000) SAA7231 I2C:2 RESET
[  114.487645] saa7231_i2c_hwinit (0): Initializing Adapter SAA7231 I2C:2 @=
 100k
[  114.487653] saa7231_i2c_init (0): Initializing adapter (3) SAA7231 I2C:3
[  114.488079] saa7231_i2c_hwinit (0): Adapter (10c000) SAA7231 I2C:3 RESET
[  114.488082] saa7231_i2c_hwinit (0): Initializing Adapter SAA7231 I2C:3 @=
 100k
[  114.488089] saa7231_i2c_init (0): SAA7231 I2C Core succesfully initializ=
ed
[  114.488091] saa7231_alsa_init (0): Initializing Audio ..
[  114.495634] saa7231_pci_probe (0): SAA7231 device:0 initialized
[  124.166016] saa7231_capture_open (0): ()
[  124.166546] saa7231_hw_params (0): DEBUG: ()
[  124.166548] saa7231_hw_params (0): bufsiz=3D64000 periods=3D4
bytes=3D16000 pages=3D16
[  124.166551] saa7231_stream_init (0): DEBUG: Initializing Stream
with MODE=3D0x01
[  124.166554] saa7231_xs2dtl_init (0): XS2DTL engine Initializing .....
[  124.166557] saa7231_xs2dtl_init (0): Allocated 8 XS2DTL Buffer @0xf52a12=
00
[  124.166559] saa7231_xs2dtl_init (0): Allocating DMA Buffers ...
[  124.166561] saa7231_xs2dtl_init (0): Allocating DMA buffer:0 @0xf52a1200=
..
[  124.166571] saa7231_allocate_ptable (0): Virtual 0xf460f000 to Phys
0x3460f000 mapped page
[  124.166588] saa7231_dmabuf_sgalloc (0): Virtual contiguous 8192
byte region with 2 4k pages
[  124.166603]       6c48c000 6c487000
[  124.166608] saa7231_xs2dtl_init (0): Allocating DMA buffer:1 @0xf52a1228=
..
[  124.166616] saa7231_allocate_ptable (0): Virtual 0xf4611000 to Phys
0x34611000 mapped page
[  124.166622] saa7231_dmabuf_sgalloc (0): Virtual contiguous 8192
byte region with 2 4k pages
[  124.166633]       6f95e000 6c291000
[  124.166638] saa7231_xs2dtl_init (0): Allocating DMA buffer:2 @0xf52a1250=
..
[  124.166645] saa7231_allocate_ptable (0): Virtual 0xf64ab000 to Phys
0x364ab000 mapped page
[  124.166651] saa7231_dmabuf_sgalloc (0): Virtual contiguous 8192
byte region with 2 4k pages
[  124.166662]       6c2a9000 6c468000
[  124.166666] saa7231_xs2dtl_init (0): Allocating DMA buffer:3 @0xf52a1278=
..
[  124.166674] saa7231_allocate_ptable (0): Virtual 0xf5dad000 to Phys
0x35dad000 mapped page
[  124.166679] saa7231_dmabuf_sgalloc (0): Virtual contiguous 8192
byte region with 2 4k pages
[  124.166690]       6c463000 6c464000
[  124.166694] saa7231_xs2dtl_init (0): Allocating DMA buffer:4 @0xf52a12a0=
..
[  124.166702] saa7231_allocate_ptable (0): Virtual 0xf5e01000 to Phys
0x35e01000 mapped page
[  124.166707] saa7231_dmabuf_sgalloc (0): Virtual contiguous 8192
byte region with 2 4k pages
[  124.166719]       6c466000 6c467000
[  124.166723] saa7231_xs2dtl_init (0): Allocating DMA buffer:5 @0xf52a12c8=
..
[  124.166731] saa7231_allocate_ptable (0): Virtual 0xf53e9000 to Phys
0x353e9000 mapped page
[  124.166736] saa7231_dmabuf_sgalloc (0): Virtual contiguous 8192
byte region with 2 4k pages
[  124.166748]       6c221000 6c222000
[  124.166752] saa7231_xs2dtl_init (0): Allocating DMA buffer:6 @0xf52a12f0=
..
[  124.166760] saa7231_allocate_ptable (0): Virtual 0xf45ea000 to Phys
0x345ea000 mapped page
[  124.166765] saa7231_dmabuf_sgalloc (0): Virtual contiguous 8192
byte region with 2 4k pages
[  124.166776]       6c374000 6c375000
[  124.166780] saa7231_xs2dtl_init (0): Allocating DMA buffer:7 @0xf52a1318=
..
[  124.166788] saa7231_allocate_ptable (0): Virtual 0xf46e7000 to Phys
0x346e7000 mapped page
[  124.166793] saa7231_dmabuf_sgalloc (0): Virtual contiguous 8192
byte region with 2 4k pages
[  124.166804]       6c377000 6c358000
[  124.166808] saa7231_xs2dtl_init (0): Initializing PTA ...
[  124.166810] saa7231_init_ptables (0): DEBUG: Initializing PORT:6
DMA_CH:7 with 8 Buffers
[  124.166812] saa7231_xs2dtl_init (0): Setting up PORT Gates ...
[  124.166815] saa7231_stream_init (0): INFO: Initialized MODE:0x01 for POR=
T:6
[  124.166817] saa7231_add_irqevent (0): Adding AS2D_AVIS IRQ Event:43 ...
[  124.166819] saa7231_setup_vector (0): Adding Vector:43
[  124.166823] saa7231_setup_vector (0): Enabling Vector:43
[  124.166827] saa7231_add_irqevent (0): Succesfully added AS2D_AVIS
as Event handler:43
[  124.166829] saa7231_hw_params (0): Mapping 8 buffers with 2 pages each
[  124.166830] saa7231_hw_params (0): Page Table array size=3D1
[  124.166832] saa7231_hw_params (0): Mapping Page:0 from
XS2D_BUFFER:0 to PTA Offset:0
[  124.166834] saa7231_hw_params (0): Mapping Page:1 from
XS2D_BUFFER:0 to PTA Offset:1
[  124.166836] saa7231_hw_params (0): Mapping Page:0 from
XS2D_BUFFER:1 to PTA Offset:2
[  124.166838] saa7231_hw_params (0): Mapping Page:1 from
XS2D_BUFFER:1 to PTA Offset:3
[  124.166840] saa7231_hw_params (0): Mapping Page:0 from
XS2D_BUFFER:2 to PTA Offset:4
[  124.166842] saa7231_hw_params (0): Mapping Page:1 from
XS2D_BUFFER:2 to PTA Offset:5
[  124.166844] saa7231_hw_params (0): Mapping Page:0 from
XS2D_BUFFER:3 to PTA Offset:6
[  124.166846] saa7231_hw_params (0): Mapping Page:1 from
XS2D_BUFFER:3 to PTA Offset:7
[  124.166848] saa7231_hw_params (0): Mapping Page:0 from
XS2D_BUFFER:4 to PTA Offset:8
[  124.166850] saa7231_hw_params (0): Mapping Page:1 from
XS2D_BUFFER:4 to PTA Offset:9
[  124.166852] saa7231_hw_params (0): Mapping Page:0 from
XS2D_BUFFER:5 to PTA Offset:10
[  124.166854] saa7231_hw_params (0): Mapping Page:1 from
XS2D_BUFFER:5 to PTA Offset:11
[  124.166856] saa7231_hw_params (0): Mapping Page:0 from
XS2D_BUFFER:6 to PTA Offset:12
[  124.166858] saa7231_hw_params (0): Mapping Page:1 from
XS2D_BUFFER:6 to PTA Offset:13
[  124.166860] saa7231_hw_params (0): Mapping Page:0 from
XS2D_BUFFER:7 to PTA Offset:14
[  124.166862] saa7231_hw_params (0): Mapping Page:1 from
XS2D_BUFFER:7 to PTA Offset:15
[  124.166884] saa7231_capture_prepare (0): ()
[  124.166974] saa7231_capture_trigger (0): () cmd=3D1
[  124.166978] saa7231_capture_pointer (0): DEBUG:()
[  134.166232] saa7231_capture_trigger (0): () cmd=3D0
[  134.166248] saa7231_hw_free (0): DEBUG: Removing IRQ event ..
[  134.166251] saa7231_remove_irqevent (0): Removing IRQ Event:43 ......
[  134.166254] saa7231_remove_irqevent (0): IRQ Event 43 <AS2D_AVIS> removed
[  134.166258] saa7231_hw_free (0): DEBUG: Unmap Virtual memory region ..
[  134.166323] saa7231_hw_free (0): DEBUG: Stream exiting ..
[  134.166325] saa7231_stream_exit (0): INFO: Freeing MODE:0x01 for PORT=3D=
0x06
[  134.166327] saa7231_xs2dtl_exit (0): Free XS2DTL engine ..
[  134.166329] saa7231_dmabuf_free (0): INFO: Scatterlist unmapped
[  134.166366] saa7231_dmabuf_free (0): INFO: Scatterlist free
[  134.166368] saa7231_dmabuf_sgfree (0): SG free
[  134.166375] saa7231_dmabuf_free (0): INFO: Page table free
[  134.166376] saa7231_free_ptable (0): SG Page table free
[  134.166380] saa7231_dmabuf_free (0): INFO: Scatterlist unmapped
[  134.166384] saa7231_dmabuf_free (0): INFO: Scatterlist free
[  134.166386] saa7231_dmabuf_sgfree (0): SG free
[  134.166392] saa7231_dmabuf_free (0): INFO: Page table free
[  134.166394] saa7231_free_ptable (0): SG Page table free
[  134.166398] saa7231_dmabuf_free (0): INFO: Scatterlist unmapped
[  134.166401] saa7231_dmabuf_free (0): INFO: Scatterlist free
[  134.166403] saa7231_dmabuf_sgfree (0): SG free
[  134.166409] saa7231_dmabuf_free (0): INFO: Page table free
[  134.166410] saa7231_free_ptable (0): SG Page table free
[  134.166414] saa7231_dmabuf_free (0): INFO: Scatterlist unmapped
[  134.166417] saa7231_dmabuf_free (0): INFO: Scatterlist free
[  134.166419] saa7231_dmabuf_sgfree (0): SG free
[  134.166424] saa7231_dmabuf_free (0): INFO: Page table free
[  134.166426] saa7231_free_ptable (0): SG Page table free
[  134.166429] saa7231_dmabuf_free (0): INFO: Scatterlist unmapped
[  134.166432] saa7231_dmabuf_free (0): INFO: Scatterlist free
[  134.166434] saa7231_dmabuf_sgfree (0): SG free
[  134.166440] saa7231_dmabuf_free (0): INFO: Page table free
[  134.166441] saa7231_free_ptable (0): SG Page table free
[  134.166445] saa7231_dmabuf_free (0): INFO: Scatterlist unmapped
[  134.166448] saa7231_dmabuf_free (0): INFO: Scatterlist free
[  134.166450] saa7231_dmabuf_sgfree (0): SG free
[  134.166455] saa7231_dmabuf_free (0): INFO: Page table free
[  134.166457] saa7231_free_ptable (0): SG Page table free
[  134.166460] saa7231_dmabuf_free (0): INFO: Scatterlist unmapped
[  134.166463] saa7231_dmabuf_free (0): INFO: Scatterlist free
[  134.166465] saa7231_dmabuf_sgfree (0): SG free
[  134.166471] saa7231_dmabuf_free (0): INFO: Page table free
[  134.166473] saa7231_free_ptable (0): SG Page table free
[  134.166476] saa7231_dmabuf_free (0): INFO: Scatterlist unmapped
[  134.166479] saa7231_dmabuf_free (0): INFO: Scatterlist free
[  134.166480] saa7231_dmabuf_sgfree (0): SG free
[  134.166486] saa7231_dmabuf_free (0): INFO: Page table free
[  134.166488] saa7231_free_ptable (0): SG Page table free
[  134.166492] saa7231_hw_free (0): DEBUG: Freeing ptable ...
[  134.166494] saa7231_capture_close (0): DEBUG: Closing stream


Regards,
Manu
