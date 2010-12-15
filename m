From: Manu Abraham <abraham.manu@gmail.com>
Subject: Re: mapping externally allocated Scatter Gather DMA
	buffers
Date: Thu, 16 Dec 2010 00:26:45 +0530
Message-ID: <AANLkTinBJe+c=aiHTvkmur-T2y67iMfc6uEERrwcizoD@mail.gmail.com>
References: <AANLkTik4VQmsvBiXyoj-wEu5jgjpPVRP0bF7gkp9GJ-E@mail.gmail.com>
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
	<AANLkTinRzLNTxZCO6eaAxN-=NATnVSHn1jamr2n8EFDT@mail.gmail.com>
	<alpine.LNX.2.00.1011120902590.29422@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id 526D9245CB
	for <alsa-devel@alsa-project.org>; Wed, 15 Dec 2010 19:56:46 +0100 (CET)
Received: by wwi18 with SMTP id 18so5726895wwi.2
	for <alsa-devel@alsa-project.org>; Wed, 15 Dec 2010 10:56:46 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1011120902590.29422@eeebox2.perex-int.cz>
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

Hi,

Had some amount of success, but not completely functional yet.

at the moment, I do get a overrun (at least that's what arecord
claims). In fact after opening due to audio capture I do get the first
interrupt, but before the next interrupt arrives, arecord closes the
device and reopens the device (from the logs, I do see that the device
is being continuously opened and closed for each of those mentioned
overruns ?).

Eventually the device always ends up with an interrupt showing data
with the first 4 pages.

Any idea, why arecord keeps opening and closing for each overrun ?

Thanks,
Manu

testbox v4l # arecord -D plughw:2,0 --format S16_LE --rate=3D32000 -c 2
> /tmp/test.wav
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 32000 Hz, Stereo
overrun!!! (at least 0.005 ms long)
overrun!!! (at least 0.002 ms long)
overrun!!! (at least 0.002 ms long)
overrun!!! (at least 0.003 ms long)
overrun!!! (at least 0.003 ms long)
overrun!!! (at least 0.001 ms long)
overrun!!! (at least 0.002 ms long)
overrun!!! (at least 0.001 ms long)
overrun!!! (at least 0.001 ms long)
overrun!!! (at least 0.001 ms long)
overrun!!! (at least 0.001 ms long)
overrun!!! (at least 0.001 ms long)


testbox v4l # cat /var/log/messages |grep evhandler
Dec 15 23:33:26 testbox kernel: [22380.791159] saa7231_audio_evhandler
(0): DEBUG: got buffer with index:1 port:6
Dec 15 23:33:26 testbox kernel: [22380.807889] saa7231_audio_evhandler
(0): DEBUG: got buffer with index:1 port:6
Dec 15 23:33:26 testbox kernel: [22380.824799] saa7231_audio_evhandler
(0): DEBUG: got buffer with index:1 port:6
Dec 15 23:33:26 testbox kernel: [22380.840634] saa7231_audio_evhandler
(0): DEBUG: got buffer with index:1 port:6
Dec 15 23:33:26 testbox kernel: [22380.856821] saa7231_audio_evhandler
(0): DEBUG: got buffer with index:1 port:6
Dec 15 23:33:26 testbox kernel: [22380.872661] saa7231_audio_evhandler
(0): DEBUG: got buffer with index:1 port:6
Dec 15 23:33:26 testbox kernel: [22380.888827] saa7231_audio_evhandler
(0): DEBUG: got buffer with index:1 port:6
Dec 15 23:33:26 testbox kernel: [22380.904667] saa7231_audio_evhandler
(0): DEBUG: got buffer with index:1 port:6
Dec 15 23:33:26 testbox kernel: [22380.920849] saa7231_audio_evhandler
(0): DEBUG: got buffer with index:1 port:6


[22395.146703] saa7231_irq_handler (0): status=3D0x800 vector=3D43
event=3D43 handler:f83d63a6
[22395.146716] saa7231_audio_evhandler (0): DEBUG: got buffer with
index:1 port:6
[22395.146734] saa7231_capture_pointer (0): DEBUG:()
[22395.146737] saa7231_capture_trigger (0): Trying to STOP stream, cmd=3D0

[22395.146780] saa7231_capture_prepare (0): ()
[22395.146783] saa7231_capture_prepare (0): Trying to Acquire stream
with 4096 lines per stream buffer
[22395.146786] saa7231_xs2dtl_acquire (0): Activating clock ..
mode=3D0x01, port_id=3D0x06
[22395.146788] saa7231_activate_clocks (0): DEBUG: Activating Clock
for Mode=3D0x01, port=3D0x06
[22395.146793] saa7231_activate_clocks (0): INFO:
tmIActivateSystemUseCase noticed active use case!
[22395.146806] saa7231_init_ptables (0): DEBUG: Initializing PORT:6
DMA_CH:7 with 8 Buffers
[22395.157028] saa7231_capture_trigger (0): Trying to START stream, cmd=3D1
[22395.157031] saa7231_xs2dtl_run (0): module=3D0x124000 Run
[22395.162525] saa7231_irq_handler (0): status=3D0x800 vector=3D43
event=3D43 handler:f83d63a6
[22395.162537] saa7231_audio_evhandler (0): DEBUG: got buffer with
index:1 port:6
[22395.162551] saa7231_capture_pointer (0): DEBUG:()
[22395.162553] saa7231_capture_trigger (0): Trying to STOP stream, cmd=3D0

[22395.162586] saa7231_capture_prepare (0): ()
[22395.162588] saa7231_capture_prepare (0): Trying to Acquire stream
with 4096 lines per stream buffer
[22395.162591] saa7231_xs2dtl_acquire (0): Activating clock ..
mode=3D0x01, port_id=3D0x06
[22395.162593] saa7231_activate_clocks (0): DEBUG: Activating Clock
for Mode=3D0x01, port=3D0x06
[22395.162598] saa7231_activate_clocks (0): INFO:
tmIActivateSystemUseCase noticed active use case!
[22395.162611] saa7231_init_ptables (0): DEBUG: Initializing PORT:6
DMA_CH:7 with 8 Buffers
[22395.173028] saa7231_capture_trigger (0): Trying to START stream, cmd=3D1
[22395.173032] saa7231_xs2dtl_run (0): module=3D0x124000 Run
[22395.178682] saa7231_irq_handler (0): status=3D0x800 vector=3D43
event=3D43 handler:f83d63a6
[22395.178695] saa7231_audio_evhandler (0): DEBUG: got buffer with
index:1 port:6
[22395.178714] saa7231_capture_pointer (0): DEBUG:()
[22395.178716] saa7231_capture_trigger (0): Trying to STOP stream, cmd=3D0

[22395.178759] saa7231_capture_prepare (0): ()
[22395.178762] saa7231_capture_prepare (0): Trying to Acquire stream
with 4096 lines per stream buffer
[22395.178765] saa7231_xs2dtl_acquire (0): Activating clock ..
mode=3D0x01, port_id=3D0x06
[22395.178767] saa7231_activate_clocks (0): DEBUG: Activating Clock
for Mode=3D0x01, port=3D0x06
[22395.178772] saa7231_activate_clocks (0): INFO:
tmIActivateSystemUseCase noticed active use case!
[22395.178785] saa7231_init_ptables (0): DEBUG: Initializing PORT:6
DMA_CH:7 with 8 Buffers
[22395.189028] saa7231_capture_trigger (0): Trying to START stream, cmd=3D1
[22395.189030] saa7231_xs2dtl_run (0): module=3D0x124000 Run
[22395.194864] saa7231_irq_handler (0): status=3D0x800 vector=3D43
event=3D43 handler:f83d63a6
[22395.194877] saa7231_audio_evhandler (0): DEBUG: got buffer with
index:1 port:6
[22395.194893] saa7231_capture_pointer (0): DEBUG:()
[22395.194896] saa7231_capture_trigger (0): Trying to STOP stream, cmd=3D0

[22395.194932] saa7231_capture_prepare (0): ()
[22395.194934] saa7231_capture_prepare (0): Trying to Acquire stream
with 4096 lines per stream buffer
[22395.194937] saa7231_xs2dtl_acquire (0): Activating clock ..
mode=3D0x01, port_id=3D0x06
[22395.194939] saa7231_activate_clocks (0): DEBUG: Activating Clock
for Mode=3D0x01, port=3D0x06
[22395.194944] saa7231_activate_clocks (0): INFO:
tmIActivateSystemUseCase noticed active use case!
[22395.194957] saa7231_init_ptables (0): DEBUG: Initializing PORT:6
DMA_CH:7 with 8 Buffers
[22395.206170] saa7231_hw_free (0): DEBUG: Removing IRQ event ..
[22395.206174] saa7231_remove_irqevent (0): Removing IRQ Event:43 ......
[22395.206176] saa7231_remove_irqevent (0): IRQ Event 43 <AS2D_AVIS> removed
[22395.206202] saa7231_hw_free (0): DEBUG: Removing IRQ event ..
[22395.206242] saa7231_remove_irqevent (0): Removing IRQ Event:43 ......
[22395.206244] saa7231_capture_close (0): DEBUG: Closing stream

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

static int saa7231_audio_evhandler(struct saa7231_dev *saa7231, int vector)
{
	struct saa7231_audio *audio	=3D saa7231->audio;
	struct saa7231_stream *stream	=3D audio->stream;

	int index =3D 0, err =3D 0;

	if (stream->ops.get_buffer) {
		err =3D stream->ops.get_buffer(stream, &index);
		if (err)
			dprintk(SAA7231_ERROR, 1, "ERROR: get_buffer failed, err=3D%d", err);

		dprintk(SAA7231_DEBUG, 1, "DEBUG: got buffer with index:%d port:%d",
index, stream->port_id);
	}
	audio->index =3D index;
	queue_work(saa7231->wq, &audio->irq_pending_work);
	return 0;
}

static void saa7231_audio_irq_work(struct work_struct *work)
{
	struct saa7231_audio *audio =3D container_of(work, struct
saa7231_audio, irq_pending_work);

	snd_pcm_period_elapsed(audio->pcm);
}

static snd_pcm_uframes_t saa7231_capture_pointer(struct snd_pcm_substream *=
pcm)
{
	struct saa7231_audio *audio	=3D snd_pcm_substream_chip(pcm);
	struct saa7231_dev *saa7231	=3D audio->saa7231;
	struct snd_pcm_runtime *rt	=3D pcm->runtime;

	dprintk(SAA7231_DEBUG, 1, "DEBUG:()");
	return bytes_to_frames(rt, audio->index * audio->pages * PAGE_SIZE);
}

static int saa7231_hw_params(struct snd_pcm_substream *pcm, struct
snd_pcm_hw_params *params)
{
	struct saa7231_audio *audio	=3D snd_pcm_substream_chip(pcm);
	struct saa7231_dev *saa7231	=3D audio->saa7231;
	struct snd_pcm_runtime *rt	=3D pcm->runtime;

	struct saa7231_dmabuf *buffer;
	struct saa7231_stream *stream;
	struct avis_audio *decoder;
	struct avis_audio_ops *ops;
	struct audio_config config;

	struct saa7231_dmabuf *dmabuf;
	struct page **ptable;

	void *mem;
	void *dma_area;

	int ret, i, j, pages, bytes, periods, bufsiz, idx;

#define MAX_ENTRIES_PER_PAGE		(PAGE_SIZE / 8)
#define PAGES_PER_XS2D(__pages)		(__pages / XS2D_BUFFERS)
#define BUFSIZE_PER_XS2D(__size)	(__size / XS2D_BUFFERS)

	dprintk(SAA7231_DEBUG, 1, "DEBUG: ()");

	periods =3D params_periods(params);
	bytes   =3D params_period_bytes(params);
	bufsiz  =3D params_buffer_bytes(params);
	pages	=3D snd_sgbuf_aligned_pages(bufsiz);

	audio->bufsize	=3D bufsiz;
	audio->periods	=3D periods;
	audio->bytes	=3D bytes;
	audio->pages	=3D pages;

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
		ret =3D -ENOMEM;
		goto err;
	}
	audio->stream =3D stream;
	buffer =3D stream->dmabuf;
	mutex_lock(&saa7231->dev_lock);

	saa7231_add_irqevent(saa7231, 43, SAA7231_EDGE_RISING,
saa7231_audio_evhandler, "AS2D_AVIS");
	dprintk(SAA7231_DEBUG, 1, "Mapping %d buffers with %d pages each",
XS2D_BUFFERS, PAGES_PER_XS2D(pages));

	dprintk(SAA7231_DEBUG, 1, "Page Table array size=3D%d", pages);
	ptable =3D kzalloc((sizeof (struct page) * pages), GFP_KERNEL);
	if (!ptable) {
		dprintk(SAA7231_ERROR, 1, "ERROR: No memory to allocate virtual map");
		ret =3D -ENOMEM;
		goto err;
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

	config.srate	=3D SRATE_32k;		/* default sample rate */
	config.source	=3D AUDIOSRC_CVBS1;	/* default source */
	config.l_volume	=3D VOL_MAX;
	config.r_volume =3D VOL_MAX;

	ret =3D saa7231_audio_attach(stream, &config);
	if (ret) {
		dprintk(SAA7231_ERROR, 1, "Audio decoder attach failed, err=3D%d", ret);
		goto err;
	}

	decoder	=3D stream->adec;
	ops	=3D &decoder->ops;

	decoder->port =3D AUDIOPORT_DAC1;

	if (ops->powerup) {
		ret =3D ops->powerup(stream);
		if (ret) {
			dprintk(SAA7231_ERROR, 1, "Failed to power up, err=3D%d", ret);
			ret =3D -EIO;
			goto err;
		}
	}

	if (ops->open) {
		ret =3D ops->open(stream);
		if (ret) {
			dprintk(SAA7231_ERROR, 1, "Failed to open stream, err=3D%d", ret);
			return -EIO;
		}
	}

	if (ops->ena_port) {
		ret =3D ops->ena_port(stream, AUDIOPORT_SPDIF, 1);
		if (ret) {
			dprintk(SAA7231_ERROR, 1, "Failed to enable port, err=3D%d", ret);
			return -EIO;
		}
	}

	if (ops->set_src) {
		ret =3D ops->set_src(stream, AUDIOSRC_CVBS1);
		if (ret) {
			dprintk(SAA7231_ERROR, 1, "Failed to enable source, err=3D%d", ret);
			return -EIO;
		}
	}

err:
	mutex_unlock(&saa7231->dev_lock);
	return ret;
}












On Fri, Nov 12, 2010 at 1:35 PM, Jaroslav Kysela <perex@perex.cz> wrote:
> On Fri, 12 Nov 2010, Manu Abraham wrote:
>
>> On Thu, Nov 11, 2010 at 6:04 PM, Manu Abraham <abraham.manu@gmail.com>
>> wrote:
>>>
>>> On Thu, Nov 11, 2010 at 4:00 PM, Jaroslav Kysela <perex@perex.cz> wrote:
>>>>
>>>> On Thu, 11 Nov 2010, Manu Abraham wrote:
>>>>
>>>>> On Wed, Nov 10, 2010 at 11:35 PM, Jaroslav Kysela <perex@perex.cz>
>>>>> wrote:
>>>
>>>>>
>>>>> I adapted the whole thing to make the buffersize divided amongst the
>>>>> XS2D_BUFFERS (8):
>>>>
>>>> Probably yes.
>>>>
>>>>> I hope the mapping of the buffers is okay ? It looks thus, now ..
>>>>
>>>> From information you sent me about hw privately, I think that the
>>>> period_bytes must be 4096 or multiple of this value with minumum count
>>>> of
>>>> periods 8 (or multiple of 8). Otherwise you get a non-continuous memory
>>>> area
>>>> (the hw uses only portion of system memory page, thus there'll be gaps=
).
>>>> The
>>>> problem is that we have MMAP_COMPLEX mode, but no application can hand=
le
>>>> (does not implement) this mmap mode and I'm not sure, if we can even
>>>> describe the DMA buffer size layout for this case for your specific hw.
>>>>
>>>> I would use:
>>>>
>>>> =A0 =A0 =A0 =A0snd_pcm_hw_constraint_step(runtime, 0,
>>>> SNDRV_PCM_HW_PARAM_PERIOD_BYTES,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0409=
6);
>>>>
>>>>
>>>> =A0 =A0 =A0 =A0snd_pcm_hw_constraint_step(runtime, 0,
>>>> SNDRV_PCM_HW_PARAM_PERIODS,
>>>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 8);
>>>>
>>>> And define periods_min =3D 8 (max to multiple 8 - choose your max limi=
t)
>>>> and
>>>> period_bytes_min to 4096 (max to multiple 4096 - choose your max limit=
).
>>>>
>>>> Note that -EIO means that your driver does not called
>>>> snd_pcm_period_elapsed() and/or the pointer callback returns wrong
>>>> position
>>>> to the audio ring buffer.
>>>
>>>
>>>
>>> Ok, modified it, also added in code to acquire the stream, It's a bit
>>> more complete now.
>>> The crazy part that I do see now, is that I see an inconsistent lock
>>> state with the hda_intel
>>> driver which is the soundcard on my system. But I don't understand why
>>> the locking on it
>>> has to become inconsistent on loading this driver.
>>
>>
>> Ok, I found the reason: I was passing a single page for the
>> page_table, which I guess corrupted the whole stack !!
>>
>> Eventually, I fixed the same. but ran into another issue ? Should
>> trigger not sleep or something that way ?
>> Currently, I see the issue as follows in the log, but if the
>> ops->run() callback is commented out I don't get that
>> weird message/error about lock states.
>>
>> Now, ops->run(), ie xs2dtl_run() is called with other other streams,
>> such as an MPEG stream, where it doesn't
>> show any issues.
>>
>> Any idea, why uncommenting ops->run() produces that message ? Should
>> trigger not sleep ? Confused ...
>
> Trigger must be fast without any sleeping. Only fast spinlocks are allowe=
d.
> If you need sleep, just activate a tasklet and do the start job in the
> tasklet or a thread.
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0Jaroslav
>
> -----
> Jaroslav Kysela <perex@perex.cz>
> Linux Kernel Sound Maintainer
> ALSA Project, Red Hat, Inc.
>
