From: Manu Abraham <abraham.manu@gmail.com>
Subject: Re: mapping externally allocated Scatter Gather DMA
	buffers
Date: Fri, 12 Nov 2010 13:31:04 +0530
Message-ID: <AANLkTinRzLNTxZCO6eaAxN-=NATnVSHn1jamr2n8EFDT@mail.gmail.com>
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
	<AANLkTi=g5LR=wm8B7jKy6kHFUjZHzt3NdZD8s3reVMbJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) by alsa0.perex.cz (Postfix) with ESMTP id AF7CF243ED
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 09:01:06 +0100 (CET)
Received: by wyg36 with SMTP id 36so737989wyg.38
	for <alsa-devel@alsa-project.org>; Fri, 12 Nov 2010 00:01:06 -0800 (PST)
In-Reply-To: <AANLkTi=g5LR=wm8B7jKy6kHFUjZHzt3NdZD8s3reVMbJ@mail.gmail.com>
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

On Thu, Nov 11, 2010 at 6:04 PM, Manu Abraham <abraham.manu@gmail.com> wrot=
e:
> On Thu, Nov 11, 2010 at 4:00 PM, Jaroslav Kysela <perex@perex.cz> wrote:
>> On Thu, 11 Nov 2010, Manu Abraham wrote:
>>
>>> On Wed, Nov 10, 2010 at 11:35 PM, Jaroslav Kysela <perex@perex.cz> wrot=
e:
>
>>>
>>> I adapted the whole thing to make the buffersize divided amongst the
>>> XS2D_BUFFERS (8):
>>
>> Probably yes.
>>
>>> I hope the mapping of the buffers is okay ? It looks thus, now ..
>>
>> From information you sent me about hw privately, I think that the
>> period_bytes must be 4096 or multiple of this value with minumum count of
>> periods 8 (or multiple of 8). Otherwise you get a non-continuous memory =
area
>> (the hw uses only portion of system memory page, thus there'll be gaps).=
 The
>> problem is that we have MMAP_COMPLEX mode, but no application can handle
>> (does not implement) this mmap mode and I'm not sure, if we can even
>> describe the DMA buffer size layout for this case for your specific hw.
>>
>> I would use:
>>
>> =A0 =A0 =A0 =A0snd_pcm_hw_constraint_step(runtime, 0,
>> SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A04096);
>>
>>
>> =A0 =A0 =A0 =A0snd_pcm_hw_constraint_step(runtime, 0, SNDRV_PCM_HW_PARAM=
_PERIODS,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 8);
>>
>> And define periods_min =3D 8 (max to multiple 8 - choose your max limit)=
 and
>> period_bytes_min to 4096 (max to multiple 4096 - choose your max limit).
>>
>> Note that -EIO means that your driver does not called
>> snd_pcm_period_elapsed() and/or the pointer callback returns wrong posit=
ion
>> to the audio ring buffer.
>
>
>
> Ok, modified it, also added in code to acquire the stream, It's a bit
> more complete now.
> The crazy part that I do see now, is that I see an inconsistent lock
> state with the hda_intel
> driver which is the soundcard on my system. But I don't understand why
> the locking on it
> has to become inconsistent on loading this driver.


Ok, I found the reason: I was passing a single page for the
page_table, which I guess corrupted the whole stack !!

Eventually, I fixed the same. but ran into another issue ? Should
trigger not sleep or something that way ?
Currently, I see the issue as follows in the log, but if the
ops->run() callback is commented out I don't get that
weird message/error about lock states.

Now, ops->run(), ie xs2dtl_run() is called with other other streams,
such as an MPEG stream, where it doesn't
show any issues.

Any idea, why uncommenting ops->run() produces that message ? Should
trigger not sleep ? Confused ...



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

	int i, j, pages, bytes, periods, bufsiz, idx;

#define MAX_ENTRIES_PER_PAGE		(PAGE_SIZE / 8)
#define PAGES_PER_XS2D(__pages)		(__pages / XS2D_BUFFERS)
#define BUFSIZE_PER_XS2D(__size)	(__size / XS2D_BUFFERS)

	dprintk(SAA7231_DEBUG, 1, "DEBUG: ()");

	periods =3D params_periods(params);
	bytes   =3D params_period_bytes(params);
	bufsiz  =3D params_buffer_bytes(params);
	pages	=3D snd_sgbuf_aligned_pages(bufsiz);

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

	dprintk(SAA7231_DEBUG, 1, "Page Table array size=3D%d", pages);
	ptable =3D kzalloc((sizeof (struct page) * pages), GFP_KERNEL);
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
	int err =3D 0;

	switch (cmd) {
        case SNDRV_PCM_TRIGGER_START:
		dprintk(SAA7231_DEBUG, 1, "Trying to START stream, cmd=3D%d", cmd);
		if (ops->run) {
			err =3D ops->run(stream);
			if (err) {
				dprintk(SAA7231_ERROR, 1, "ERROR: starting stream, err=3D%d", err);
				return -EIO;
			}
		}
		break;
        case SNDRV_PCM_TRIGGER_STOP:
		dprintk(SAA7231_DEBUG, 1, "Trying to STOP stream, cmd=3D%d", cmd);
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
		dprintk(SAA7231_DEBUG, 1, "Trying to PAUSE stream, cmd=3D%d", cmd);
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

static int saa7231_xs2dtl_run(struct saa7231_stream *stream)
{
	unsigned long run =3D 0;
	u32 delay;

	u32 reg;
	struct saa7231_dev *saa7231	=3D stream->saa7231;
	struct saa7231_dtl *dtl		=3D &stream->dtl;
	struct saa7231_dmabuf *dmabuf	=3D stream->dmabuf;
	u32 module			=3D dtl->module;
	int port			=3D stream->port_id;

	SAA7231_WR(DMAADDR(0, port, dmabuf, 0), SAA7231_BAR0, module,
S2D_CHx_B0_B_START_ADDRESS(0));
	SAA7231_WR(DMAADDR(0, port, dmabuf, 1), SAA7231_BAR0, module,
S2D_CHx_B1_B_START_ADDRESS(0));

	/* tell the device that the mmu got updated */
	reg =3D SAA7231_RD(SAA7231_BAR0, MMU, MMU_DMA_CONFIG(stream->port_id));
	reg &=3D ~0x40;
	SAA7231_WR(reg, SAA7231_BAR0, MMU, MMU_DMA_CONFIG(stream->port_id));
	SAA7231_WR((reg | 0x40), SAA7231_BAR0, MMU, MMU_DMA_CONFIG(stream->port_id=
));

	dtl->addr_prev =3D 0xffffff;

	/*
	 * monitor PT load operation but wait a short time before
	 * checking the PT valid. Otherwise we will see the old state.
	 */
	delay =3D 1000;
	do {
		if (!run) {
			msleep(10);
			delay--;
		}
		run =3D SAA7231_RD(SAA7231_BAR0, MMU, MMU_DMA_CONFIG(stream->port_id)) & =
0x80;
	} while (!run && delay);

	/* check status of the PTA load operation */
	if (!run) {
		dprintk(SAA7231_ERROR, 1, "ERROR, Preload PTA failed");
		return -EINVAL;
	}

	/* read channel control register, enable channel */
	reg =3D SAA7231_RD(SAA7231_BAR0, module, S2D_CHx_CTRL(0));
	SAA7231_WR(reg | 0x1, SAA7231_BAR0, module, S2D_CHx_CTRL(0));
	reg =3D SAA7231_RD(SAA7231_BAR0, module, S2D_S2D_CTRL);

	/* clear all pending interrupts */
	SAA7231_WR(0x3fff, SAA7231_BAR0, module, S2D_INT_CLR_STATUS(0));

	/* enable interrupts */
	SAA7231_WR(0x1800, SAA7231_BAR0, module, S2D_INT_SET_ENABLE(0));

	/* enable capture */
	reg |=3D 0x1;
	SAA7231_WR(reg, SAA7231_BAR0, module, S2D_S2D_CTRL);
	dtl->stream_run =3D 1;

	return 0;
}

testbox ~ # arecord -D plughw:2,0 --format S16_LE --rate=3D32000 -c 2 >
~/test_capture.wav
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 32000 Hz, Stereo
arecord: pcm_read:1617: read error: Input/output error


[  276.117516] SAA7231 0000:05:00.0: PCI INT A -> GSI 16 (level, low) -> IR=
Q 16
[  276.117524] SAA7231 0000:05:00.0: setting latency timer to 64
[  276.117547] saa7231_pci_init (0): BAR 0 Offset: 04 BAR 2 Offset: 04
[  276.117549] saa7231_pci_init (0): BAR0 Start=3Dfc800000 length=3D4M
[  276.117551] saa7231_pci_init (0): BAR2 Start=3Dfc400000 length=3D4M
[  276.118754]     SAA7231GE [14c7:3595], irq: 16,
[  276.118757]     mmio(0): 0xf8800000 mmio(2): 0xf9e00000
[  276.118771]     SAA7231 64Bit, MSI Disabled, MSI-X=3D1 msgs
[  276.118778] saa7231_get_version (0): SAA7231 PCI Express V1A found
[  276.118780] saa7231_cgu_init (0): Initializing CGU
[  276.118782] saa7231_cgu_init (0): Using 54MHz RootClock
[  276.118803] saa7231_cgu_init (0): PLL Status CDEC160: 00 REF550: 00
ADPLL: 00 DSP: 00
[  276.118805] saa7231_set_clk (0): clk_output=3D0   clk_frequency=3D2
[  276.118807] saa7231_set_clk (0): clk_output=3D1   clk_frequency=3D2
[  276.118809] saa7231_set_clk (0): clk_output=3D2   clk_frequency=3D2
[  276.118810] saa7231_set_clk (0): clk_output=3D3   clk_frequency=3D2
[  276.118812] saa7231_set_clk (0): clk_output=3D4   clk_frequency=3D2
[  276.118814] saa7231_set_clk (0): clk_output=3D5   clk_frequency=3D2
[  276.118815] saa7231_set_clk (0): clk_output=3D6   clk_frequency=3D2
[  276.118817] saa7231_set_clk (0): clk_output=3D7   clk_frequency=3D2
[  276.118819] saa7231_set_clk (0): clk_output=3D8   clk_frequency=3D2
[  276.118820] saa7231_set_clk (0): clk_output=3D9   clk_frequency=3D2
[  276.118822] saa7231_set_clk (0): clk_output=3D10   clk_frequency=3D2
[  276.118824] saa7231_set_clk (0): clk_output=3D11   clk_frequency=3D2
[  276.118826] saa7231_set_clk (0): clk_output=3D12   clk_frequency=3D2
[  276.118827] saa7231_set_clk (0): clk_output=3D13   clk_frequency=3D2
[  276.118829] saa7231_set_clk (0): clk_output=3D14   clk_frequency=3D2
[  276.118831] saa7231_set_clk (0): clk_output=3D15   clk_frequency=3D2
[  276.118832] saa7231_set_clk (0): clk_output=3D16   clk_frequency=3D2
[  276.118834] saa7231_set_clk (0): clk_output=3D17   clk_frequency=3D2
[  276.118836] saa7231_set_clk (0): clk_output=3D18   clk_frequency=3D2
[  276.170029] saa7231_cgu_init (0): DEBUG: RGU_RESET_ACTIVE0 7c02001f
[  276.271028] saa7231_cgu_init (0): DEBUG: RGU_RESET_ACTIVE0 ffffffff
[  276.271033] saa7231_cgu_init (0): DEBUG: RGU_RESET_ACTIVE1 2e1f
[  276.271035] saa7231_set_clk (0): clk_output=3D17   clk_frequency=3D0
[  276.277053] saa7231_i2c_init (0): Initializing SAA7231 I2C Core
[  276.277057] saa7231_i2c_init (0): Initializing adapter (0) SAA7231 I2C:0
[  276.277344] saa7231_i2c_hwinit (0): Adapter (109000) SAA7231 I2C:0 RESET
[  276.277347] saa7231_i2c_hwinit (0): Initializing Adapter SAA7231 I2C:0 @=
 100k
[  276.277355] saa7231_i2c_init (0): Initializing adapter (1) SAA7231 12C:1
[  276.277625] saa7231_i2c_hwinit (0): Adapter (10a000) SAA7231 12C:1 RESET
[  276.277627] saa7231_i2c_hwinit (0): Initializing Adapter SAA7231 12C:1 @=
 100k
[  276.277635] saa7231_i2c_init (0): Initializing adapter (2) SAA7231 I2C:2
[  276.277703] saa7231_i2c_hwinit (0): Adapter (10b000) SAA7231 I2C:2 RESET
[  276.277705] saa7231_i2c_hwinit (0): Initializing Adapter SAA7231 I2C:2 @=
 100k
[  276.277713] saa7231_i2c_init (0): Initializing adapter (3) SAA7231 I2C:3
[  276.277973] saa7231_i2c_hwinit (0): Adapter (10c000) SAA7231 I2C:3 RESET
[  276.277976] saa7231_i2c_hwinit (0): Initializing Adapter SAA7231 I2C:3 @=
 100k
[  276.277983] saa7231_i2c_init (0): SAA7231 I2C Core succesfully initializ=
ed
[  276.277985] saa7231_alsa_init (0): Initializing Audio ..
[  276.283197] saa7231_pci_probe (0): SAA7231 device:0 initialized
[  285.973561] saa7231_capture_open (0): ()
[  285.974297] saa7231_hw_params (0): DEBUG: ()
[  285.974299] saa7231_hw_params (0): bufsiz=3D131072 periods=3D8
bytes=3D16384 pages=3D32
[  285.974302] saa7231_stream_init (0): DEBUG: Initializing Stream
with MODE=3D0x01
[  285.974305] saa7231_xs2dtl_init (0): XS2DTL engine Initializing .....
[  285.974307] saa7231_xs2dtl_init (0): Allocated 8 XS2DTL Buffer @0xf42dc2=
00
[  285.974309] saa7231_xs2dtl_init (0): Allocating DMA Buffers ...
[  285.974311] saa7231_xs2dtl_init (0): Allocating DMA buffer:0 @0xf42dc200=
..
[  285.974322] saa7231_allocate_ptable (0): Virtual 0xf38dc000 to Phys
0x338dc000 mapped page
[  285.974338] saa7231_dmabuf_sgalloc (0): Virtual contiguous 16384
byte region with 4 4k pages
[  285.974361]       6c763000 6c762000 6f8bd000 6f810000
[  285.974367] saa7231_xs2dtl_init (0): Allocating DMA buffer:1 @0xf42dc228=
..
[  285.974375] saa7231_allocate_ptable (0): Virtual 0xf38dd000 to Phys
0x338dd000 mapped page
[  285.974381] saa7231_dmabuf_sgalloc (0): Virtual contiguous 16384
byte region with 4 4k pages
[  285.974401]       6fa10000 6c6b0000 6c6b5000 6c6b4000
[  285.974406] saa7231_xs2dtl_init (0): Allocating DMA buffer:2 @0xf42dc250=
..
[  285.974414] saa7231_allocate_ptable (0): Virtual 0xf3832000 to Phys
0x33832000 mapped page
[  285.974421] saa7231_dmabuf_sgalloc (0): Virtual contiguous 16384
byte region with 4 4k pages
[  285.974441]       6c6b8000 6c6b3000 6c6b2000 6c581000
[  285.974445] saa7231_xs2dtl_init (0): Allocating DMA buffer:3 @0xf42dc278=
..
[  285.974453] saa7231_allocate_ptable (0): Virtual 0xf3927000 to Phys
0x33927000 mapped page
[  285.974459] saa7231_dmabuf_sgalloc (0): Virtual contiguous 16384
byte region with 4 4k pages
[  285.974479]       6c783000 6c782000 6c699000 6c698000
[  285.974484] saa7231_xs2dtl_init (0): Allocating DMA buffer:4 @0xf42dc2a0=
..
[  285.974491] saa7231_allocate_ptable (0): Virtual 0xf38a9000 to Phys
0x338a9000 mapped page
[  285.974498] saa7231_dmabuf_sgalloc (0): Virtual contiguous 16384
byte region with 4 4k pages
[  285.974517]       6c6bc000 6c879000 6fbf5000 6c777000
[  285.974522] saa7231_xs2dtl_init (0): Allocating DMA buffer:5 @0xf42dc2c8=
..
[  285.974529] saa7231_allocate_ptable (0): Virtual 0xf538e000 to Phys
0x3538e000 mapped page
[  285.974535] saa7231_dmabuf_sgalloc (0): Virtual contiguous 16384
byte region with 4 4k pages
[  285.974555]       6c77c000 6c593000 6fbf6000 6c58d000
[  285.974560] saa7231_xs2dtl_init (0): Allocating DMA buffer:6 @0xf42dc2f0=
..
[  285.974568] saa7231_allocate_ptable (0): Virtual 0xf3974000 to Phys
0x33974000 mapped page
[  285.974573] saa7231_dmabuf_sgalloc (0): Virtual contiguous 16384
byte region with 4 4k pages
[  285.974593]       6fbe2000 6fbe0000 6c6a2000 6c6b7000
[  285.974599] saa7231_xs2dtl_init (0): Allocating DMA buffer:7 @0xf42dc318=
..
[  285.974606] saa7231_allocate_ptable (0): Virtual 0xf38a5000 to Phys
0x338a5000 mapped page
[  285.974612] saa7231_dmabuf_sgalloc (0): Virtual contiguous 16384
byte region with 4 4k pages
[  285.974632]       6c692000 6c60a000 6c75b000 6f825000
[  285.974637] saa7231_xs2dtl_init (0): Initializing PTA ...
[  285.974639] saa7231_init_ptables (0): DEBUG: Initializing PORT:6
DMA_CH:7 with 8 Buffers
[  285.974641] saa7231_xs2dtl_init (0): Setting up PORT Gates ...
[  285.974644] saa7231_stream_init (0): INFO: Initialized MODE:0x01 for POR=
T:6
[  285.974646] saa7231_add_irqevent (0): Adding AS2D_AVIS IRQ Event:43 ...
[  285.974648] saa7231_setup_vector (0): Adding Vector:43
[  285.974652] saa7231_setup_vector (0): Enabling Vector:43
[  285.974656] saa7231_add_irqevent (0): Succesfully added AS2D_AVIS
as Event handler:43
[  285.974658] saa7231_hw_params (0): Mapping 8 buffers with 4 pages each
[  285.974659] saa7231_hw_params (0): Page Table array size=3D32
[  285.974662] saa7231_hw_params (0): Mapping Page:0 from
XS2D_BUFFER:0 to PTA Offset:0
[  285.974664] saa7231_hw_params (0): Mapping Page:1 from
XS2D_BUFFER:0 to PTA Offset:1
[  285.974666] saa7231_hw_params (0): Mapping Page:2 from
XS2D_BUFFER:0 to PTA Offset:2
[  285.974668] saa7231_hw_params (0): Mapping Page:3 from
XS2D_BUFFER:0 to PTA Offset:3
[  285.974670] saa7231_hw_params (0): Mapping Page:0 from
XS2D_BUFFER:1 to PTA Offset:4
[  285.974673] saa7231_hw_params (0): Mapping Page:1 from
XS2D_BUFFER:1 to PTA Offset:5
[  285.974675] saa7231_hw_params (0): Mapping Page:2 from
XS2D_BUFFER:1 to PTA Offset:6
[  285.974677] saa7231_hw_params (0): Mapping Page:3 from
XS2D_BUFFER:1 to PTA Offset:7
[  285.974679] saa7231_hw_params (0): Mapping Page:0 from
XS2D_BUFFER:2 to PTA Offset:8
[  285.974681] saa7231_hw_params (0): Mapping Page:1 from
XS2D_BUFFER:2 to PTA Offset:9
[  285.974683] saa7231_hw_params (0): Mapping Page:2 from
XS2D_BUFFER:2 to PTA Offset:10
[  285.974685] saa7231_hw_params (0): Mapping Page:3 from
XS2D_BUFFER:2 to PTA Offset:11
[  285.974687] saa7231_hw_params (0): Mapping Page:0 from
XS2D_BUFFER:3 to PTA Offset:12
[  285.974689] saa7231_hw_params (0): Mapping Page:1 from
XS2D_BUFFER:3 to PTA Offset:13
[  285.974691] saa7231_hw_params (0): Mapping Page:2 from
XS2D_BUFFER:3 to PTA Offset:14
[  285.974693] saa7231_hw_params (0): Mapping Page:3 from
XS2D_BUFFER:3 to PTA Offset:15
[  285.974695] saa7231_hw_params (0): Mapping Page:0 from
XS2D_BUFFER:4 to PTA Offset:16
[  285.974697] saa7231_hw_params (0): Mapping Page:1 from
XS2D_BUFFER:4 to PTA Offset:17
[  285.974699] saa7231_hw_params (0): Mapping Page:2 from
XS2D_BUFFER:4 to PTA Offset:18
[  285.974701] saa7231_hw_params (0): Mapping Page:3 from
XS2D_BUFFER:4 to PTA Offset:19
[  285.974704] saa7231_hw_params (0): Mapping Page:0 from
XS2D_BUFFER:5 to PTA Offset:20
[  285.974706] saa7231_hw_params (0): Mapping Page:1 from
XS2D_BUFFER:5 to PTA Offset:21
[  285.974708] saa7231_hw_params (0): Mapping Page:2 from
XS2D_BUFFER:5 to PTA Offset:22
[  285.974710] saa7231_hw_params (0): Mapping Page:3 from
XS2D_BUFFER:5 to PTA Offset:23
[  285.974712] saa7231_hw_params (0): Mapping Page:0 from
XS2D_BUFFER:6 to PTA Offset:24
[  285.974714] saa7231_hw_params (0): Mapping Page:1 from
XS2D_BUFFER:6 to PTA Offset:25
[  285.974716] saa7231_hw_params (0): Mapping Page:2 from
XS2D_BUFFER:6 to PTA Offset:26
[  285.974718] saa7231_hw_params (0): Mapping Page:3 from
XS2D_BUFFER:6 to PTA Offset:27
[  285.974720] saa7231_hw_params (0): Mapping Page:0 from
XS2D_BUFFER:7 to PTA Offset:28
[  285.974722] saa7231_hw_params (0): Mapping Page:1 from
XS2D_BUFFER:7 to PTA Offset:29
[  285.974724] saa7231_hw_params (0): Mapping Page:2 from
XS2D_BUFFER:7 to PTA Offset:30
[  285.974726] saa7231_hw_params (0): Mapping Page:3 from
XS2D_BUFFER:7 to PTA Offset:31
[  285.974749] saa7231_capture_prepare (0): ()
[  285.974751] saa7231_capture_prepare (0): Trying to Acquire stream
with 4096 lines per stream buffer
[  285.974753] saa7231_xs2dtl_acquire (0): Activating clock ..
mode=3D0x01, port_id=3D0x06
[  285.974756] saa7231_activate_clocks (0): DEBUG: Activating Clock
for Mode=3D0x01, port=3D0x06
[  285.974758] tmGetClockInstance (0): DEBUG: Mode=3D0x01, dmaport=3D0x06
[  285.974760] tmGetClockInstance (0): ret=3D0
[  285.974766] saa7231_activate_clocks (0): INFO: activate use case index 0
[  285.974768] saa7231_init_ptables (0): DEBUG: Initializing PORT:6
DMA_CH:7 with 8 Buffers
[  285.974871] saa7231_capture_trigger (0): Trying to START stream, cmd=3D1
[  285.985285]
[  285.985286] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
[  285.985289] [ INFO: inconsistent lock state ]
[  285.985291] 2.6.34.7 #2
[  285.985293] ---------------------------------
[  285.985295] inconsistent {IN-HARDIRQ-W} -> {HARDIRQ-ON-W} usage.
[  285.985297] arecord/6052 [HC0[0]:SC0[0]:HE1:SE1] takes:
[  285.985299]  (&(&substream->self_group.lock)->rlock){?.....}, at:
[<c13271b5>] snd_pcm_stream_lock_irq+0x20/0x23
[  285.985309] {IN-HARDIRQ-W} state was registered at:
[  285.985311]   [<c105a27c>] __lock_acquire+0x23e/0xb47
[  285.985318]   [<c105ac11>] lock_acquire+0x8c/0xab
[  285.985322]   [<c144a8bb>] _raw_spin_lock+0x20/0x2f
[  285.985326]   [<c132811e>] snd_pcm_period_elapsed+0x39/0xb4
[  285.985329]   [<f843040f>] azx_interrupt+0x8e/0x106 [snd_hda_intel]
[  285.985336]   [<c1079a16>] handle_IRQ_event+0x4b/0xf1
[  285.985340]   [<c107b469>] handle_fasteoi_irq+0x86/0xbd
[  285.985344] irq event stamp: 4550
[  285.985346] hardirqs last  enabled at (4549): [<c100287b>]
sysenter_exit+0xf/0x16
[  285.985350] hardirqs last disabled at (4550): [<c144ac7b>]
_raw_read_lock_irq+0x11/0x35
[  285.985353] softirqs last  enabled at (3756): [<c1039b96>]
__do_softirq+0x15a/0x169
[  285.985357] softirqs last disabled at (3731): [<c10042fc>]
do_softirq+0x63/0xaf
[  285.985360]
[  285.985361] other info that might help us debug this:
[  285.985363] 2 locks held by arecord/6052:
[  285.985364]  #0:  (snd_pcm_link_rwlock){.?....}, at: [<c13271aa>]
snd_pcm_stream_lock_irq+0x15/0x23
[  285.985369]  #1:  (&(&substream->self_group.lock)->rlock){?.....},
at: [<c13271b5>] snd_pcm_stream_lock_irq+0x20/0x23
[  285.985374]
[  285.985375] stack backtrace:
[  285.985378] Pid: 6052, comm: arecord Not tainted 2.6.34.7 #2
[  285.985379] Call Trace:
[  285.985383]  [<c1448b56>] ? printk+0x14/0x16
[  285.985385]  [<c105938f>] valid_state+0x12a/0x13d
[  285.985388]  [<c1059493>] mark_lock+0xf1/0x1d9
[  285.985391]  [<c1059b3c>] ? check_usage_backwards+0x0/0x68
[  285.985394]  [<c10595be>] mark_held_locks+0x43/0x5b
[  285.985396]  [<c144ad98>] ? _raw_spin_unlock_irq+0x27/0x2b
[  285.985399]  [<c10597d7>] trace_hardirqs_on_caller+0xe7/0x121
[  285.985402]  [<c105981c>] trace_hardirqs_on+0xb/0xd
[  285.985405]  [<c144ad98>] _raw_spin_unlock_irq+0x27/0x2b
[  285.985409]  [<c102d6ac>] finish_task_switch+0x5c/0x86
[  285.985412]  [<c102d650>] ? finish_task_switch+0x0/0x86
[  285.985415]  [<c144925d>] schedule+0x53d/0x5b4
[  285.985417]  [<c14495ec>] schedule_timeout+0x7e/0x9b
[  285.985422]  [<c103f3ea>] ? process_timeout+0x0/0xf
[  285.985425]  [<c1449623>] schedule_timeout_uninterruptible+0x1a/0x1c
[  285.985428]  [<c103f8e9>] msleep+0x15/0x1b
[  285.985439]  [<f83b5974>] saa7231_xs2dtl_run+0x93/0x123 [saa7231_core]
[  285.985447]  [<f83b9746>] saa7231_capture_trigger+0x59/0xed [saa7231_cor=
e]
[  285.985450]  [<c13226e3>] snd_pcm_do_start+0x23/0x26
[  285.985453]  [<c132263a>] snd_pcm_action_single+0x2a/0x50
[  285.985455]  [<c1323ce8>] snd_pcm_action+0x6f/0x7b
[  285.985458]  [<c1323d8a>] snd_pcm_start+0x19/0x1b
[  285.985461]  [<c13283a0>] snd_pcm_lib_read1+0x61/0x1ff
[  285.985464]  [<c13285be>] snd_pcm_lib_read+0x33/0x54
[  285.985467]  [<c13273e5>] ? snd_pcm_lib_read_transfer+0x0/0x70
[  285.985469]  [<c1325ec1>] snd_pcm_capture_ioctl1+0x8e/0x2ed
[  285.985472]  [<c1326148>] snd_pcm_capture_ioctl+0x28/0x35
[  285.985477]  [<c10c7ec5>] vfs_ioctl+0x2c/0x96
[  285.985480]  [<c1326120>] ? snd_pcm_capture_ioctl+0x0/0x35
[  285.985483]  [<c10c843f>] do_vfs_ioctl+0x46c/0x4aa
[  285.985486]  [<c10bd0f3>] ? fsnotify_modify+0x54/0x5f
[  285.985489]  [<c10bd1fe>] ? do_sync_write+0x0/0xca
[  285.985491]  [<c10be3e3>] ? fget_light+0xe/0xaf
[  285.985494]  [<c10c84b0>] sys_ioctl+0x33/0x4d
[  285.985497]  [<c100284c>] sysenter_do_call+0x12/0x32
[  296.977014] saa7231_xs2dtl_run (0): ERROR, Preload PTA failed
[  296.977019] saa7231_capture_trigger (0): ERROR: starting stream, err=3D-=
22
[  296.977022] saa7231_capture_trigger (0): Trying to STOP stream, cmd=3D0
[  296.977182] saa7231_hw_free (0): DEBUG: Removing IRQ event ..
[  296.977184] saa7231_remove_irqevent (0): Removing IRQ Event:43 ......
[  296.977187] saa7231_remove_irqevent (0): IRQ Event 43 <AS2D_AVIS> removed
[  296.977191] saa7231_hw_free (0): DEBUG: Unmap Virtual memory region ..
[  296.977204] saa7231_hw_free (0): DEBUG: Stream exiting ..
[  296.977207] saa7231_stream_exit (0): INFO: Freeing MODE:0x01 for PORT=3D=
0x06
[  296.977209] saa7231_xs2dtl_exit (0): Free XS2DTL engine ..
[  296.977211] saa7231_dmabuf_free (0): INFO: Scatterlist unmapped
[  296.977216] saa7231_dmabuf_free (0): INFO: Scatterlist free
[  296.977218] saa7231_dmabuf_sgfree (0): SG free
[  296.977224] saa7231_dmabuf_free (0): INFO: Page table free
[  296.977226] saa7231_free_ptable (0): SG Page table free
[  296.977229] saa7231_dmabuf_free (0): INFO: Scatterlist unmapped
[  296.977233] saa7231_dmabuf_free (0): INFO: Scatterlist free
[  296.977234] saa7231_dmabuf_sgfree (0): SG free
[  296.977240] saa7231_dmabuf_free (0): INFO: Page table free
[  296.977242] saa7231_free_ptable (0): SG Page table free
[  296.977245] saa7231_dmabuf_free (0): INFO: Scatterlist unmapped
[  296.977249] saa7231_dmabuf_free (0): INFO: Scatterlist free
[  296.977250] saa7231_dmabuf_sgfree (0): SG free
[  296.977256] saa7231_dmabuf_free (0): INFO: Page table free
[  296.977258] saa7231_free_ptable (0): SG Page table free
[  296.977261] saa7231_dmabuf_free (0): INFO: Scatterlist unmapped
[  296.977265] saa7231_dmabuf_free (0): INFO: Scatterlist free
[  296.977266] saa7231_dmabuf_sgfree (0): SG free
[  296.977272] saa7231_dmabuf_free (0): INFO: Page table free
[  296.977274] saa7231_free_ptable (0): SG Page table free
[  296.977277] saa7231_dmabuf_free (0): INFO: Scatterlist unmapped
[  296.977281] saa7231_dmabuf_free (0): INFO: Scatterlist free
[  296.977282] saa7231_dmabuf_sgfree (0): SG free
[  296.977288] saa7231_dmabuf_free (0): INFO: Page table free
[  296.977290] saa7231_free_ptable (0): SG Page table free
[  296.977293] saa7231_dmabuf_free (0): INFO: Scatterlist unmapped
[  296.977297] saa7231_dmabuf_free (0): INFO: Scatterlist free
[  296.977298] saa7231_dmabuf_sgfree (0): SG free
[  296.977304] saa7231_dmabuf_free (0): INFO: Page table free
[  296.977306] saa7231_free_ptable (0): SG Page table free
[  296.977309] saa7231_dmabuf_free (0): INFO: Scatterlist unmapped
[  296.977313] saa7231_dmabuf_free (0): INFO: Scatterlist free
[  296.977314] saa7231_dmabuf_sgfree (0): SG free
[  296.977320] saa7231_dmabuf_free (0): INFO: Page table free
[  296.977322] saa7231_free_ptable (0): SG Page table free
[  296.977325] saa7231_dmabuf_free (0): INFO: Scatterlist unmapped
[  296.977329] saa7231_dmabuf_free (0): INFO: Scatterlist free
[  296.977331] saa7231_dmabuf_sgfree (0): SG free
[  296.977337] saa7231_dmabuf_free (0): INFO: Page table free
[  296.977338] saa7231_free_ptable (0): SG Page table free
[  296.977342] saa7231_hw_free (0): DEBUG: Freeing ptable ...
[  296.977344] saa7231_capture_close (0): DEBUG: Closing stream


Regards,
Manu
