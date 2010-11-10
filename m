From: Manu Abraham <abraham.manu@gmail.com>
Subject: Re: mapping externally allocated Scatter Gather DMA
	buffers
Date: Wed, 10 Nov 2010 21:20:23 +0530
Message-ID: <AANLkTimtS-9ZN6OgmQ8kZdedVSKzEakA6VeO-f73Y-_4@mail.gmail.com>
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
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51]) by alsa0.perex.cz (Postfix) with ESMTP id BFD3324502
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2010 16:50:24 +0100 (CET)
Received: by ewy26 with SMTP id 26so372528ewy.38
	for <alsa-devel@alsa-project.org>; Wed, 10 Nov 2010 07:50:24 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1011101515420.29422@eeebox2.perex-int.cz>
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

On Wed, Nov 10, 2010 at 8:35 PM, Jaroslav Kysela <perex@perex.cz> wrote:
> On Wed, 10 Nov 2010, Manu Abraham wrote:
>
>> On Wed, Nov 10, 2010 at 5:00 PM, Jaroslav Kysela <perex@perex.cz> wrote:
>>>
>>> On Wed, 10 Nov 2010, Manu Abraham wrote:
>>>
>>>> Ok, so period should be the interval at which an IRQ is expected.
>>>> ie, if i set a buffer size for 40mS, the period should be 40, I guess.
>>>>
>>>> That said, what should be a recommended value for period ? If hardware
>>>> needs to generate an IRQ at the end of each period ?
>>>
>>> It's good to allow the lowledevel driver to pass all possible period
>>> sizes
>>> to the user space. The application does decision how many wakeups
>>> expects.
>>
>>
>> Ok, I adapted it to look thus,
>>
>> static struct snd_pcm_hardware saa7231_capture_info =3D {
>> =A0 =A0 =A0 =A0.info =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D (SNDRV_PCM_=
INFO_MMAP =A0 =A0 =A0 =A0 =A0|
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SNDRV=
_PCM_INFO_INTERLEAVED =A0 =A0|
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SNDRV=
_PCM_INFO_BLOCK_TRANSFER |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SNDRV=
_PCM_INFO_MMAP_VALID),
>>
>> =A0 =A0 =A0 =A0.formats =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D (SNDRV_PCM_FM=
TBIT_S16_LE =A0 =A0 =A0|
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SNDRV=
_PCM_FMTBIT_S16_BE =A0 =A0 =A0 |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SNDRV=
_PCM_FMTBIT_S8 =A0 =A0 =A0 =A0 =A0 |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SNDRV=
_PCM_FMTBIT_U8 =A0 =A0 =A0 =A0 =A0 |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SNDRV=
_PCM_FMTBIT_U16_LE =A0 =A0 =A0 |
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0SNDRV=
_PCM_FMTBIT_U16_BE),
>>
>> =A0 =A0 =A0 =A0.rates =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=3D SNDRV_PCM_R=
ATE_32000,
>>
>> =A0 =A0 =A0 =A0.rate_min =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 32000,
>> =A0 =A0 =A0 =A0.rate_max =A0 =A0 =A0 =A0 =A0 =A0 =A0 =3D 48000,
>>
>> =A0 =A0 =A0 =A0.channels_min =A0 =A0 =A0 =A0 =A0 =3D 2,
>> =A0 =A0 =A0 =A0.channels_max =A0 =A0 =A0 =A0 =A0 =3D 2,
>>
>> =A0 =A0 =A0 =A0.buffer_bytes_max =A0 =A0 =A0 =3D 512 * 4096,
>> #if 0
>> =A0 =A0 =A0 =A0.period_bytes_min =A0 =A0 =A0 =3D 192,
>> =A0 =A0 =A0 =A0.period_bytes_max =A0 =A0 =A0 =3D 1536,
>> =A0 =A0 =A0 =A0.periods_min =A0 =A0 =A0 =A0 =A0 =A0=3D 2,
>> =A0 =A0 =A0 =A0.periods_max =A0 =A0 =A0 =A0 =A0 =A0=3D 1024,
>> #endif
>> =A0 =A0 =A0 =A0.period_bytes_min =A0 =A0 =A0 =3D 1920, =A0 =A0/* 10mS @ =
48khz */
>> =A0 =A0 =A0 =A0.period_bytes_max =A0 =A0 =A0 =3D 768000, =A0/* 4S =A0 @ =
48kHz */
>>
>> =A0 =A0 =A0 =A0.periods_min =A0 =A0 =A0 =A0 =A0 =A0=3D 10, =A0 =A0 =A0/*=
 10mS */
>> =A0 =A0 =A0 =A0.periods_max =A0 =A0 =A0 =A0 =A0 =A0=3D 4000000, /* 4S */
>
> ??? 10 (period_bytes_min) * 10 (periods_min) =3D 100mS . Note that
> period_bytes_* limits periods size, but periods_* count of periods per the
> whole audio DMA ring buffer. Define smallest number of periods (it's usua=
lly
> value one or two for periods_min).


Ok.


>> };
>>
>> /*
>> * 10mS Buffer lengths
>> * @48kHz =A0 =A0 =A0 =A01920 bytes
>> * @44.1kHz =A0 =A0 =A01764 bytes
>> * @32kHz =A0 =A0 =A0 =A01280 bytes
>> *
>> *
>> * period min =3D 10mS @48k: =A01920 bytes @44.1k: =A01764 bytes @32k: =
=A01280
>> bytes
>> * period max =3D 1S =A0 @48k:192000 bytes @44.1k:176400 bytes @32k:128000
>> bytes
>> * period =A0 =A0 =3D 4S =A0 @48k:768000 bytes @44.1k:705600 bytes @32k:5=
12000
>> bytes
>> */
>> static int saa7231_capture_open(struct snd_pcm_substream *pcm)
>> {
>> =A0 =A0 =A0 struct saa7231_audio *audio =A0 =A0 =A0=3D snd_pcm_substream=
_chip(pcm);
>> =A0 =A0 =A0 struct snd_pcm_runtime *rt =A0 =A0 =A0 =3D pcm->runtime;
>> =A0 =A0 =A0 =A0struct saa7231_dev *saa7231 =A0 =A0 =3D audio->saa7231;
>> =A0 =A0 =A0 int err;
>>
>> =A0 =A0 =A0 =A0dprintk(SAA7231_DEBUG, 1, "()");
>> =A0 =A0 =A0 =A0rt->hw =3D saa7231_capture_info;
>> =A0 =A0 =A0 =A0snd_pcm_hw_constraint_list(rt, 0, SNDRV_PCM_HW_PARAM_RATE,
>> &hw_constraint_rates);
>> =A0 =A0 =A0 =A0err =3D snd_pcm_hw_constraint_integer(rt,
>> SNDRV_PCM_HW_PARAM_PERIODS);
>> =A0 =A0 =A0 if (err < 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dprintk(SAA7231_ERROR, 1, "snd_pcm_hw_con=
straint_integer()
>> failed.
>> ret=3D%d", err);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
>> =A0 =A0 =A0 =A0}
>
>> =A0 =A0 =A0 =A0err =3D snd_pcm_hw_constraint_minmax(rt,
>> SNDRV_PCM_HW_PARAM_PERIOD_SIZE, 10, 4000000);
>> =A0 =A0 =A0 =A0if (err < 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dprintk(SAA7231_ERROR, 1, "snd_pcm_hw_con=
straint_minmax()
>> failed.
>> ret=3D%d", err);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
>> =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0err =3D snd_pcm_hw_constraint_minmax(rt,
>> SNDRV_PCM_HW_PARAM_PERIOD_BYTES, 1920, 768000);
>> =A0 =A0 =A0 =A0if (err < 0) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dprintk(SAA7231_ERROR, 1, "snd_pcm_hw_con=
straint_minmax()
>> failed.
>> ret=3D%d", err);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return err;
>> =A0 =A0 =A0 =A0}
>
> Remove these minmax contrains. You already do limiting in hw->ops.


Ok.



>> =A0 =A0 =A0 return 0;
>> }
>>
>> /*
>> * saa7231_hw_params()
>> *
>> * This callback is called when the hardware parameter (hw_params) is set=
up
>> * by the application, ie., once when the buffer size, the period size,
>> * the format etc are defined for the PCM substream.
>> */
>> static int saa7231_hw_params(struct snd_pcm_substream *pcm, struct
>> snd_pcm_hw_params *params)
>> {
>> =A0 =A0 =A0 =A0struct saa7231_audio *audio =A0 =A0 =3D snd_pcm_substream=
_chip(pcm);
>> =A0 =A0 =A0 =A0struct saa7231_dev *saa7231 =A0 =A0 =3D audio->saa7231;
>> =A0 =A0 =A0 =A0struct snd_pcm_runtime *rt =A0 =A0 =A0=3D pcm->runtime;
>>
>> =A0 =A0 =A0 =A0struct saa7231_dmabuf *buffer;
>> =A0 =A0 =A0 =A0struct saa7231_stream *stream;
>> =A0 =A0 =A0 =A0struct saa7231_dmabuf *dmabuf;
>>
>> =A0 =A0 =A0 =A0struct page **ptable;
>>
>> =A0 =A0 =A0 =A0void *mem;
>> =A0 =A0 =A0 =A0void *dma_area;
>>
>> =A0 =A0 =A0 =A0int i, j, pages, bytes, periods, bufsiz, pt_size;
>>
>> =A0 =A0 =A0 =A0dprintk(SAA7231_DEBUG, 1, "DEBUG: ()");
>> =A0 =A0 =A0 =A0periods =3D params_periods(params);
>> =A0 =A0 =A0 =A0bytes =3D params_period_bytes(params);
>>
>> =A0 =A0 =A0 =A0bufsiz =3D periods * bytes;
>> =A0 =A0 =A0 =A0dprintk(SAA7231_DEBUG, 1, "bufsiz=3D%d periods=3D%d bytes=
=3D%d",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bufsiz,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0periods,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0bytes);
>>
>> =A0 =A0 =A0 =A0pages =3D bufsiz / PAGE_SIZE;
>
> This is wrong. It should be 'pages =3D (bufsize + PAGE_SIZE - 1) / PAGE_S=
IZE'.


Ok.


>> =A0 =A0 =A0 =A0/* enable stream */
>> =A0 =A0 =A0 =A0/* initializing 8 buffer with "pages" pages each .. */
>> =A0 =A0 =A0 =A0stream =3D saa7231_stream_init(saa7231, AUDIO_CAPTURE, AD=
APTER_INT,
>> 0, pages);
>> =A0 =A0 =A0 =A0if (!stream) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dprintk(SAA7231_ERROR, 1, "ERROR: Registe=
ring stream");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
>> =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0audio->stream =3D stream;
>> =A0 =A0 =A0 =A0buffer =3D stream->dmabuf;
>> =A0 =A0 =A0 =A0saa7231_add_irqevent(saa7231, 43, SAA7231_EDGE_RISING,
>> saa7231_audio_evhandler, "AS2D_AVIS");
>> =A0 =A0 =A0 =A0dprintk(SAA7231_DEBUG, 1, "Mapping %d buffers with %d pag=
es each",
>> XS2D_BUFFERS, pages);
>
> Unfortunately, I don't understand the role of XS2D_BUFFERS. The ALSA bufs=
ize
> is the whole DMA area (you should use params_buffer_bytes() to get this
> value instead of calculating this using periods * period_size).


Ok. The hardware has 8 SG buffers each. each of the buffer heads are
setup on to the MMU.
each of these buffers XS2D_BUFFERS can handle a maximum of 512 pages,
ie page table
for the SG buffer can be a maximum of 4096 bytes long.


> It means: Just allocate number of pages required for buffer_bytes. Don't
> play with periods (except the interrupts).
>
>> =A0 =A0 =A0 =A0/*
>> =A0 =A0 =A0 =A0 * For a single DMA buffer:
>> =A0 =A0 =A0 =A0 * each page takes a u64 size in a page table
>> =A0 =A0 =A0 =A0 * number of entries a single page can hold =3D PAGE_SIZE=
 / entry
>> size
>> =A0 =A0 =A0 =A0 * ie entries.max =3D PAGE_SIZE / 8 =3D> 4096/8 =3D 512
>> =A0 =A0 =A0 =A0 * Now, we have entries.req =3D 7 ("pages") per buffer
>> =A0 =A0 =A0 =A0 *
>> =A0 =A0 =A0 =A0 * For all in XS2D_BUFFERS:
>> =A0 =A0 =A0 =A0 * page table should be large enough to hold all the page=
s in each
>> DMA buffer
>> =A0 =A0 =A0 =A0 * total number of pages =3D pages * XS2D_BUFFERS
>> =A0 =A0 =A0 =A0 * max buffers that we need to consider =3D 512 * 8, this=
 needs 8
>> pages
>> for a page table
>> =A0 =A0 =A0 =A0 *
>> =A0 =A0 =A0 =A0 * On a general note, we can calculate pages for page tab=
le as
>> =A0 =A0 =A0 =A0 * page_table_size =3D total_pages / 512, with a minimum =
of a single
>> page
>> =A0 =A0 =A0 =A0 */
>>
>> #define MAX_ENTRIES_PER_PAGE =A0 =A0 =A0 =A0 =A0 =A0 (PAGE_SIZE / 8)
>>
>> =A0 =A0 =A0 =A0pt_size =3D (pages * XS2D_BUFFERS) / MAX_ENTRIES_PER_PAGE;
>> =A0 =A0 =A0 =A0/* minimum 1 page required for the table */
>> =A0 =A0 =A0 =A0if (pt_size < 1)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0pt_size =3D 1;
>>
>> =A0 =A0 =A0 =A0dprintk(SAA7231_DEBUG, 1, "Page Table array size=3D%d", p=
t_size);
>> =A0 =A0 =A0 =A0ptable =3D kzalloc((sizeof (struct page) * pt_size), GFP_=
KERNEL);
>> =A0 =A0 =A0 =A0if (!ptable) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dprintk(SAA7231_ERROR, 1, "ERROR: No memo=
ry to allocate
>> virtual map");
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -ENOMEM;
>> =A0 =A0 =A0 =A0}
>> =A0 =A0 =A0 =A0audio->ptable =3D ptable;
>>
>> =A0 =A0 =A0 =A0for (i =3D 0; i < XS2D_BUFFERS; i ++) {
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dmabuf =3D &buffer[i];
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0mem =3D dmabuf->vmalloc;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0for (j =3D 0; j < pages; j++)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ptable[j] =3D virt_to_pag=
e(mem);
>> =A0 =A0 =A0 =A0}
>
> This looks broken. ptable is overwritten for each XS2D_BUFFERS iteration.


True.


>> #if 0
>> =A0 =A0 =A0 =A0dma_area =3D vmap(ptable, (pages * XS2D_BUFFERS), VM_MAP,
>> PAGE_KERNEL);
>> =A0 =A0 =A0 =A0rt->dma_area =A0 =A0=3D dma_area;
>> =A0 =A0 =A0 =A0rt->dma_bytes =A0 =3D XS2D_BUFFERS * pages * SAA7231_PAGE=
_SIZE;
>> =A0 =A0 =A0 =A0rt->dma_addr =A0 =A0=3D 0;
>> #endif
>> =A0 =A0 =A0 =A0return 0;
>> }
>
> I think that the second argument is number of linux mem pages. Your value
> seems strange.


Uh, oh. I had assumed that each of the 8 XS2D_Buffers would contain "pages"
each and hence..


Regards,
Manu
