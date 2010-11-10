From: Manu Abraham <abraham.manu@gmail.com>
Subject: Re: mapping externally allocated Scatter Gather DMA
	buffers
Date: Wed, 10 Nov 2010 11:59:09 +0530
Message-ID: <AANLkTimTrFLv911vVm-eH9EqDyXEwg-y4uFkqbUyVB7v@mail.gmail.com>
References: <AANLkTik4VQmsvBiXyoj-wEu5jgjpPVRP0bF7gkp9GJ-E@mail.gmail.com>
	<alpine.LNX.2.00.1010260923070.29422@eeebox2.perex-int.cz>
	<AANLkTin58toyQJ0f3M3abszE0zgV+t9R29rsFKin74vk@mail.gmail.com>
	<alpine.LNX.2.00.1011091300130.29422@eeebox2.perex-int.cz>
	<AANLkTikzXbnnPBNS+51zFvrYVqOTw8bz1=qWq_h--y35@mail.gmail.com>
	<alpine.LNX.2.00.1011091347020.29422@eeebox2.perex-int.cz>
	<AANLkTikHL5-6nuf6_sbkAX+y_vUo57tF-SW_j75ijEPJ@mail.gmail.com>
	<alpine.LNX.2.00.1011091530230.29422@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id AD61524550
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2010 07:29:12 +0100 (CET)
Received: by wwd20 with SMTP id 20so343662wwd.20
	for <alsa-devel@alsa-project.org>; Tue, 09 Nov 2010 22:29:09 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1011091530230.29422@eeebox2.perex-int.cz>
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

On Tue, Nov 9, 2010 at 8:04 PM, Jaroslav Kysela <perex@perex.cz> wrote:
> On Tue, 9 Nov 2010, Manu Abraham wrote:
>
>> On Tue, Nov 9, 2010 at 6:21 PM, Jaroslav Kysela <perex@perex.cz> wrote:
>>>
>>> On Tue, 9 Nov 2010, Manu Abraham wrote:
>>>
>>>> On Tue, Nov 9, 2010 at 5:31 PM, Jaroslav Kysela <perex@perex.cz> wrote:
>>>>>
>>>>> On Tue, 9 Nov 2010, Manu Abraham wrote:
>>>>>
>>>>>> testbox ~ # arecord -Dhw:2,0
>>>>>> Recording WAVE 'stdin' : Unsigned 8 bit, Rate 8000 Hz, Mono
>>>>>
>>>>>> Any idea, why saa7231_hw_params is not getting invoked ?
>>>>>
>>>>> Your hw probably does not support directly 8-bit sample at 8000Hz, one
>>>>> channel. Use 'plughw:2,0' device instead 'hw:2,0' to let alsa-lib do
>>>>> all
>>>>> stream format conversions.
>>>>
>>>> That didn't make any difference at all.
>>>
>>> Check your code. You probably created wrong hw_ops, looking to your cod=
e:
>>>
>>> =A0 =A0 =A0 =A0.buffer_bytes_max =A0 =A0 =A0 =3D 512 * 4096,
>>> =A0 =A0 =A0 =A0.period_bytes_min =A0 =A0 =A0 =3D 8192,
>>> =A0 =A0 =A0 =A0.period_bytes_max =A0 =A0 =A0 =3D 8192,
>>> =A0 =A0 =A0 =A0.periods_min =A0 =A0 =A0 =A0 =A0 =A0=3D 8192,
>>> =A0 =A0 =A0 =A0.periods_max =A0 =A0 =A0 =A0 =A0 =A0=3D 8192,
>>>
>>> It's definitely an empty configuration space.
>>>
>>> You have buffer_bytes_max 2097152, but restricted number of periods to
>>> 8192
>>> and period_bytes to 8192.
>>>
>>> 8192 * 8192 =3D 67108864 which is not less than 2097152 (and I'm not
>>> counting
>>> the bytes for channels and formats). Bingo, the ALSA PCM code does not
>>> know
>>> what to configure.
>>>
>>> Decrease periods_min and probably also periods_max.
>>>
>>
>> oh ! The error message was really a weird one. I can say that the
>> hardware can do 192 audio frames in an interrupt, whatever the frame
>> size is. So, what periods and period_bytes should I describe in the
>> configuration ?
>
> You cannot describe this using hw_ops. Leave period bytes in good range (=
192
> - 1536?), periods (2-1024?) and add something like this to the open
> callback:
>
> =A0 =A0 =A0 err =3D snd_pcm_hw_constraint_minmax(runtime,
> SNDRV_PCM_HW_PARAM_PERIOD_SIZE,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0192, 192);
>
> Note the difference between SNDRV_PCM_HW_PARAM_PERIOD_SIZE and
> SNDRV_PCM_HW_PARAM_PERIOD_BYTES.
>

Ok, thanks.

I modified it to look thus ...

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

	.channels_min		=3D 2,
	.channels_max		=3D 2,

	.buffer_bytes_max	=3D 512 * 4096,
	.period_bytes_min	=3D 192,
	.period_bytes_max	=3D 1536,
	.periods_min		=3D 2,
	.periods_max		=3D 1024,
};

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
	err =3D snd_pcm_hw_constraint_minmax(rt,
SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 192, 192);
	if (err < 0) {
		dprintk(SAA7231_ERROR, 1, "snd_pcm_hw_constraint_minmax() failed.
ret=3D%d", err);
		return err;
	}

        return 0;
}

static int saa7231_hw_params(struct snd_pcm_substream *pcm, struct
snd_pcm_hw_params *params)
{
	struct saa7231_audio *audio	=3D snd_pcm_substream_chip(pcm);
	struct saa7231_dev *saa7231	=3D audio->saa7231;

	struct saa7231_dmabuf *buffer;
	struct saa7231_stream *stream;
	struct saa7231_dmabuf *dmabuf;

	struct page **ptable;

	void *vma;
	void *dma_area;

	int i, j, pages, bytes, periods, bufsiz;

	dprintk(SAA7231_DEBUG, 1, "DEBUG: ()");
	periods =3D params_periods(params);
	bytes =3D params_period_bytes(params);

	bufsiz =3D periods * bytes;
	dprintk(SAA7231_DEBUG, 1, "bufsiz=3D%d periods=3D%d bytes=3D%d",
		bufsiz,
		periods,
		bytes);

	pages =3D bufsiz / PAGE_SIZE;

	/* enable stream */
	stream =3D saa7231_stream_init(saa7231, AUDIO_CAPTURE, ADAPTER_INT, 0, 512=
);
	if (!stream) {
		dprintk(SAA7231_ERROR, 1, "ERROR: Registering stream");
		return -ENOMEM;
	}
	audio->stream =3D stream;
	buffer =3D stream->dmabuf;
	saa7231_add_irqevent(saa7231, 43, SAA7231_EDGE_RISING,
saa7231_audio_evhandler, "AS2D_AVIS");
	dprintk(SAA7231_DEBUG, 1, "Mapping %d buffers with %d pages each",
XS2D_BUFFERS, pages);
	return 0;
}


testbox ~ # arecord -Dplughw:2,0
Recording WAVE 'stdin' : Unsigned 8 bit, Rate 8000 Hz, Mono
ALSA lib pcm_mmap.c:369:(snd_pcm_mmap) mmap failed: Invalid argument
arecord: set_params:1041: Unable to install hw params:
ACCESS:  RW_INTERLEAVED
FORMAT:  U8
SUBFORMAT:  STD
SAMPLE_BITS: 8
FRAME_BITS: 8
CHANNELS: 1
RATE: 8000
PERIOD_TIME: 6000
PERIOD_SIZE: 48
PERIOD_BYTES: 48
PERIODS: 83
BUFFER_TIME: 498000
BUFFER_SIZE: 3984
BUFFER_BYTES: 3984
TICK_TIME: 0

[  819.928438] saa7231_capture_open (0): ()
[  819.945466] saa7231_hw_params (0): DEBUG: ()
[  819.945470] saa7231_hw_params (0): bufsiz=3D31872 periods=3D83 bytes=3D3=
84
[  819.945472] saa7231_stream_init (0): DEBUG: Initializing Stream
with MODE=3D0x01
[  819.945475] saa7231_xs2dtl_init (0): XS2DTL engine Initializing .....
[  819.945477] saa7231_xs2dtl_init (0): Allocated 8 XS2DTL Buffer @0xf47b60=
00
[  819.945479] saa7231_xs2dtl_init (0): Allocating DMA Buffers ...
[  819.945481] saa7231_xs2dtl_init (0): Allocating DMA buffer:0 @0xf47b6000=
..
[  819.945492] saa7231_allocate_ptable (0): Virtual 0xf3bb7000 to Phys
0x33bb7000 mapped page
[  819.945598] saa7231_dmabuf_sgalloc (0): Virtual contiguous 2097152
byte region with 512 4k pages
 ...
 ...



bufsiz=3D31872 periods=3D83 bytes=3D384

Now, I wonder what a period really is. I guess I lack the basics here
.. A basic explanation to the context,
would be quite helpful.

Best Regards,
Manu
