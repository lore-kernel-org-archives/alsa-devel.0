From: Manu Abraham <abraham.manu@gmail.com>
Subject: Re: callbacks order while capturing from Line-IN
Date: Thu, 23 Dec 2010 04:33:04 +0530
Message-ID: <AANLkTimFgmpsXOOTsg0SHSpAJcfUDVRHmu=1Sar24PhB@mail.gmail.com>
References: <AANLkTik+MSbaDS0jD3ax8t7TFjf1vXAjaK3a=P+5MUNa@mail.gmail.com>
	<AANLkTik7WwZGnDyE=bfw5_a_PXcERhFF9bPy0qYX=6+v@mail.gmail.com>
	<alpine.LNX.2.00.1012170719391.28150@eeebox2.perex-int.cz>
	<AANLkTi=d3FCtz7zQk7ss2xnZi8M0ipx70xocf1ceXcQH@mail.gmail.com>
	<alpine.LNX.2.00.1012170903300.28150@eeebox2.perex-int.cz>
	<AANLkTimO-R3H=2HQA3-ssgfbPmqxr7OTvFuFS93RaZUa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 2406010383A
	for <alsa-devel@alsa-project.org>; Thu, 23 Dec 2010 00:03:06 +0100 (CET)
Received: by wyi11 with SMTP id 11so5356131wyi.38
	for <alsa-devel@alsa-project.org>; Wed, 22 Dec 2010 15:03:05 -0800 (PST)
In-Reply-To: <AANLkTimO-R3H=2HQA3-ssgfbPmqxr7OTvFuFS93RaZUa@mail.gmail.com>
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

On Fri, Dec 17, 2010 at 3:50 PM, Manu Abraham <abraham.manu@gmail.com> wrot=
e:
> On Fri, Dec 17, 2010 at 1:38 PM, Jaroslav Kysela <perex@perex.cz> wrote:
>> On Fri, 17 Dec 2010, Manu Abraham wrote:
>>
>>> Thanks, that was very helpful. I am looking at it. I did find an issue
>>> looking at the pointer callback itself straight away.
>>>
>>> The logs do look thus now: http://pastebin.ca/2021872
>>
>> This is your problem (first irq_handler):
>>
>> saa7231_irq_handler (0): status=3D0x800 vector=3D43 event=3D43 handler:f=
83b91ff
>> saa7231_capture_pointer (0): DEBUG:() Index:0 with frames:0, total 48 pa=
ges
>> saa7231_capture_trigger (0): Trying to STOP stream, cmd=3D0
>>
>> The pointer should return how many samples are filled (probably value 61=
44
>> in your case). The midlevel code expects that at least one period has be=
en
>> recorded, but your pointer() callbacks returned 0 here. It is wrong.
>> Ignoring STOP/START is just a bad workaround for the broken driver.
>
>
> Initially, I had to ignore the CMD's to understand what was happening,
> ie why the DMA engine was giving me buffer index:0 and hence I did
> ignore the START/STOP CMD's.
>
> I did hardcoded the max frames per buffer to be 6144 (as your guess),
> as you can see...
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0stride =A0 =A0 =A0 =A0 =A0=3D 768; /* mean=
ingless in 1D mode */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0buf_size =A0 =A0 =A0 =A0=3D 24576; //7680;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0x_length =A0 =A0 =A0 =A0=3D 32;// 4 /* max=
 bytes in a line/frame/packet */
> // =A0 =A0 =A0 =A0 =A0 =A0 =A0y_length =A0 =A0 =A0 =A0=3D 1920; /* max li=
nes/frames/packets per buffer */
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0y_length =A0 =A0 =A0 =A0=3D 6144; //1920; =
/* max lines/frames/packets per buffer */
>
> =A0 =A0 =A0 =A0SAA7231_WR(x_length, SAA7231_BAR0, module, S2D_CHx_B1_X_LE=
NGTH(0));
> =A0 =A0 =A0 =A0SAA7231_WR(y_length, SAA7231_BAR0, module, S2D_CHx_B1_Y_LE=
NGTH(0));
>
>
> Initially, I was of the understanding that capture pointer wanted the
> start of the buffer and hence started with 0, 6144 and multiples of
> it...
> Now that you mention it; I modified it to return 6144 frames after
> each interrupt.
>
> static snd_pcm_uframes_t saa7231_capture_pointer(struct snd_pcm_substream=
 *pcm)
> {
> =A0 =A0 =A0 =A0struct saa7231_audio *audio =A0 =A0 =3D snd_pcm_substream_=
chip(pcm);
> =A0 =A0 =A0 =A0struct saa7231_dev *saa7231 =A0 =A0 =3D audio->saa7231;
> =A0 =A0 =A0 =A0struct snd_pcm_runtime *rt =A0 =A0 =A0=3D pcm->runtime;
> =A0 =A0 =A0 =A0u32 frames, buf_size;
>
> =A0 =A0 =A0 =A0buf_size =3D 24576;
> =A0 =A0 =A0 =A0frames =3D (buf_size / 4) * (audio->index + 1);
> =A0 =A0 =A0 =A0dprintk(SAA7231_DEBUG, 1, "DEBUG:() Index:%d with frames:%=
d, total %d
> pages", audio->index, frames, audio->pages);
> =A0 =A0 =A0 =A0return frames;
> }
>
> Eventually the arecord overrun error is gone completely
>
> testbox v4l # arecord -D plughw:2,0 --format S16_LE --rate=3D48000 -c 2
>> /tmp/test3.wav
> Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, Ster=
eo
> ^CAborted by signal Interrupt...
>
>
> Eventually, fixed the capture_trigger
>
>
>
>>
>>> Now, I do get a .wav file The contents of which seems to be junk ??
>>>
>>> http://202.88.242.108:8000/test/test.wav
>>>
>>> Tried to play it back with alsaplayer and mplyer with no results,
>>> mplayer shows no issues though.. Maybe PCM corruptions ? But at least
>>> some noises it should make =A0?
>>
>> Try add some printk directly to the driver to show the few recorded samp=
les
>> in the DMA buffers.







I have some data now.

Result is that I can capture a wave file; No resultant audio: mplayer
detects it as



testbox ~ # mplayer /tmp/test4.wav
MPlayer SVN-r29796-4.4.3 (C) 2000-2009 MPlayer Team

Playing /tmp/test4.wav.
Audio only file format detected.
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Opening audio decoder: [pcm] Uncompressed PCM audio decoder
AUDIO: 48000 Hz, 2 ch, s16le, 1536.0 kbit/100.00% (ratio: 192000->192000)
Selected audio codec: [pcm] afm: pcm (Uncompressed PCM)
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
AO: [alsa] 48000Hz 2ch s16le (2 bytes per sample)
Video: no video
Starting playback...
A:  32.0 (31.9) of 32.0 (32.0)  0.0%


I had to make some changes (made changes to behave in a single buffer
mode rather than the 8 buffer mode);

device info changed to


.rate_min =3D 48000,
.rate_max =3D 48000,

.channels_min =3D 2,
.channels_max =3D 2,


.period_bytes_min =3D 1024,
.period_bytes_max =3D 4,

.buffer_bytes_max =3D 32 * 1024,


static int hw_params(struct snd_pcm_substream *pcm, struct
snd_pcm_hw_params *params)
{

 ...
    periods =3D params_periods(params);
    bytes   =3D params_period_bytes(params);
    bufsiz   =3D params_buffer_bytes(params);
    pages  =3D snd_sgbuf_aligned_pages(bufsiz);

    dprintk("bufsiz=3D%d periods=3D%d bytes=3D%d pages=3D%d", bufsiz, perio=
ds,
bytes, pages);

}

static snd_pcm_uframes_t saa7231_capture_pointer(struct snd_pcm_substream *=
pcm)
{
	struct saa7231_audio *audio	=3D snd_pcm_substream_chip(pcm);
	struct saa7231_dev *saa7231	=3D audio->saa7231;
	struct snd_pcm_runtime *rt	=3D pcm->runtime;

	u32 frames, size, buf_size;

	size =3D  (audio->pages / AS2D_BUFFERS) * PAGE_SIZE;
	buf_size =3D size * (audio->index + 1);
	frames =3D bytes_to_frames(rt, rt->period_size) * (audio->index + 1);
	dprintk(SAA7231_DEBUG, 1, "DEBUG:() Index:%d with frames:%d, total:%d
pages, size:%d buf_size:%d",
		audio->index, frames, audio->pages, size, buf_size);

	return frames;
}





which results in the following. Any idea why the stream is not as
expected ? At least it's supposed to make some noise at least ?
Any ideas, as to what could be wrong ?


Any help is much appreciated.


Thanks,
Manu




Dec 23 04:10:58 testbox kernel: [  150.328113] saa7231_capture_open (0): ()
Dec 23 04:10:58 testbox kernel: [  150.328702] saa7231_hw_params (0): DEBUG=
: ()
Dec 23 04:10:58 testbox kernel: [  150.328704] saa7231_hw_params (0):
bufsiz=3D32768 periods=3D4 bytes=3D8192 pages=3D8
Dec 23 04:10:58 testbox kernel: [  150.328707] saa7231_stream_init
(0): DEBUG: Initializing Stream with MODE=3D0x01
Dec 23 04:10:58 testbox kernel: [  150.328709] saa7231_as2dtl_init
(0): AS2DTL engine Initializing .

..

Dec 23 04:10:58 testbox kernel: [  150.331804] saa7231_hw_params (0):
Mapping 8 buffers with 1 pages each
Dec 23 04:10:58 testbox kernel: [  150.331806] saa7231_hw_params (0):
Page Table array size=3D8
Dec 23 04:10:58 testbox kernel: [  150.331809] saa7231_hw_params (0):
Mapping Page:0 from XS2D_BUFFER:0 to PTA Offset:0
Dec 23 04:10:58 testbox kernel: [  150.331812] saa7231_hw_params (0):
Mapping Page:0 from XS2D_BUFFER:1 to PTA Offset:1
Dec 23 04:10:58 testbox kernel: [  150.331814] saa7231_hw_params (0):
Mapping Page:0 from XS2D_BUFFER:2 to PTA Offset:2
Dec 23 04:10:58 testbox kernel: [  150.331816] saa7231_hw_params (0):
Mapping Page:0 from XS2D_BUFFER:3 to PTA Offset:3
Dec 23 04:10:58 testbox kernel: [  150.331817] saa7231_hw_params (0):
Mapping Page:0 from XS2D_BUFFER:4 to PTA Offset:4
Dec 23 04:10:58 testbox kernel: [  150.331819] saa7231_hw_params (0):
Mapping Page:0 from XS2D_BUFFER:5 to PTA Offset:5
Dec 23 04:10:58 testbox kernel: [  150.331821] saa7231_hw_params (0):
Mapping Page:0 from XS2D_BUFFER:6 to PTA Offset:6
Dec 23 04:10:58 testbox kernel: [  150.331822] saa7231_hw_params (0):
Mapping Page:0 from XS2D_BUFFER:7 to PTA Offset:7

..

Dec 23 04:10:58 testbox kernel: [  150.407554] saa7231_hw_params (0):
acquire() with: BPS:16 SPL:2 Pitch:4 Lines:1024 Buflen:32768
Dec 23 04:10:58 testbox kernel: [  150.407558] saa7231_as2dtl_acquire
(0): Activating clock .. mode=3D0x01, port_id=3D0x06

..

Dec 23 04:10:58 testbox kernel: [  150.407585] tmISetParameters (0):
DEBUG: buf_size:4096 stride:4 x_length:1024 y_length:4
Dec 23 04:10:58 testbox kernel: [  150.418057] saa7231_capture_prepare
(0): Nothing to do ...
Dec 23 04:10:58 testbox kernel: [  150.418139] saa7231_capture_trigger
(0): Trying to START stream, cmd=3D1
Dec 23 04:10:58 testbox kernel: [  150.418141] saa7231_as2dtl_run (0):
module=3D0x124000 Run
Dec 23 04:10:58 testbox kernel: [  150.418149] saa7231_capture_pointer
(0): DEBUG:() Index:0 with frames:512, total:8 pages, size:4096
buf_size:4096
Dec 23 04:10:58 testbox kernel: [  150.418153] ALSA
sound/core/pcm_lib.c:365: hwptr_update: pcmC2D0c:0: pos=3D512/2048/8192,
hwptr=3D512/0/512/0
Dec 23 04:10:58 testbox kernel: [  150.418159] saa7231_capture_pointer
(0): DEBUG:() Index:0 with frames:512, total:8 pages, size:4096
buf_size:4096
Dec 23 04:10:58 testbox kernel: [  150.418161] ALSA
sound/core/pcm_lib.c:365: hwptr_update: pcmC2D0c:0: pos=3D512/2048/8192,
hwptr=3D0/512/512/0
Dec 23 04:10:58 testbox kernel: [  150.435630] saa7231_irq_handler
(0): status=3D0x800 vector=3D43 event=3D43 handler:f83b67b6
Dec 23 04:10:58 testbox kernel: [  150.435640] saa7231_audio_evhandler
(0): DEBUG: got buffer with index:1 port:6
Dec 23 04:10:58 testbox kernel: [  150.435763]       3761 3332 5f31
6c61   6173 695f 696e 0074
Dec 23 04:10:58 testbox kernel: [  150.435769]       6c63 6f6b 7475
705f   6572 6573 5f74 616d
Dec 23 04:10:58 testbox kernel: [  150.435773]       6b73 6900 706e
7475   735f 7274 7400 516d
Dec 23 04:10:58 testbox kernel: [  150.435778]       6575 7972 7055
6164   6574 6c43 636f 496b
Dec 23 04:10:58 testbox kernel: [  150.435783]       736e 6174 636e
0065   7266 6565 705f 6761
Dec 23 04:10:58 testbox kernel: [  150.435787]       7365 7400 686d
4177   6475 6f69 7641 7369
Dec 23 04:10:58 testbox kernel: [  150.435792]       495f 696e 0074
6173   3761 3332 5f31 7561
Dec 23 04:10:58 testbox kernel: [  150.435796]       6964 5f6f 6564
6174   6863 5f00 725f 6c65
Dec 23 04:10:58 testbox kernel: [  150.435801]       6165 6573 725f
6765   6f69 006e 7664 5f62
Dec 23 04:10:58 testbox kernel: [  150.435805]       6572 6967 7473
7265   615f 6164 7470 7265
Dec 23 04:10:58 testbox kernel: [  150.435810]       7300 6669 735f
7274   7300 6161 3237 3133
Dec 23 04:10:58 testbox kernel: [  150.435814]       615f 736c 5f61
7865   7469 7300 6161 3237
Dec 23 04:10:58 testbox kernel: [  150.435819]       3133 635f 7567
655f   6978 0074 6173 3761
Dec 23 04:10:58 testbox kernel: [  150.435823]       3332 5f31 7067
6f69   735f 7465 7300 6161
Dec 23 04:10:58 testbox kernel: [  150.435828]       3237 3133 645f
616d   7562 5f66 6c61 6f6c
Dec 23 04:10:58 testbox kernel: [  150.435832]       0063 5f5f 7263
5f63   6173 3761 3332 5f31
Dec 23 04:10:58 testbox kernel: [  150.435849] saa7231_capture_pointer
(0): DEBUG:() Index:1 with frames:1024, total:8 pages, size:4096
buf_size:8192
Dec 23 04:10:58 testbox kernel: [  150.435853] ALSA
sound/core/pcm_lib.c:365: period_update: pcmC2D0c:0:
pos=3D1024/2048/8192, hwptr=3D8704/512/9216/0
Dec 23 04:10:58 testbox kernel: [  150.435858] ALSA
sound/core/pcm_lib.c:419: PCM: hw_ptr skipping! [Q] (pos=3D1024,
delta=3D8704, period=3D2048, jdelta=3D17/181/0, hw_ptr=3D512/512)
Dec 23 04:10:58 testbox kernel: [  150.451631] saa7231_irq_handler
(0): status=3D0x800 vector=3D43 event=3D43 handler:f83b67b6
Dec 23 04:10:58 testbox kernel: [  150.451640] saa7231_audio_evhandler
(0): DEBUG: got buffer with index:2 port:6
Dec 23 04:10:58 testbox kernel: [  150.451658]       0000 0000 0010
0000   1e75 0000 ffffa610 5f74
Dec 23 04:10:58 testbox kernel: [  150.451663]       0000 0000 0010
fffffff1   1e8c 0000 0000 0000
Dec 23 04:10:58 testbox kernel: [  150.451667]       0000 0000 0010
0000   1e9c 0000 0000 0000
Dec 23 04:10:58 testbox kernel: [  150.451672]       0000 0000 0010
0000   1ead 0000 0000 0000
Dec 23 04:10:58 testbox kernel: [  150.451676]       0000 0000 0010
0000   1eb4 0000 0000 0000
Dec 23 04:10:58 testbox kernel: [  150.451681]       0000 0000 0010
0000   1ec1 0000 0000 0000
Dec 23 04:10:58 testbox kernel: [  150.451685]       0000 0000 0010
0000   1ed4 0000 0000 0000
Dec 23 04:10:58 testbox kernel: [  150.451689]       0000 0000 0010
0000   1eef 0000 0000 0000
Dec 23 04:10:58 testbox kernel: [  150.451694]       0000 0000 0010
0000   1eff 0000 1f8c 0000
Dec 23 04:10:58 testbox kernel: [  150.451698]       0093 0000 0012
0002   1f10 0000 5532 0000
Dec 23 04:10:58 testbox kernel: [  150.451703]       018e 0000 0012
0002   1f25 0000 0000 0000
Dec 23 04:10:58 testbox kernel: [  150.451707]       0000 0000 0010
0000   1f3e 0000 ffff82bf ffffff96
Dec 23 04:10:58 testbox kernel: [  150.451712]       0000 0000 0010
fffffff1   1f56 0000 05be 0000
Dec 23 04:10:58 testbox kernel: [  150.451716]       014b 0000 0012
0002   1f66 0000 3fa7 6acf
Dec 23 04:10:58 testbox kernel: [  150.451721]       0000 0000 0010
fffffff1   1f7c 0000 0000 0000
Dec 23 04:10:58 testbox kernel: [  150.451725]       092f 0000 0012
0006   1f8d 0000 36cf 0000
Dec 23 04:10:58 testbox kernel: [  150.451731] saa7231_capture_pointer
(0): DEBUG:() Index:2 with frames:1536, total:8 pages, size:4096
buf_size:12288
Dec 23 04:10:58 testbox kernel: [  150.451734] ALSA
sound/core/pcm_lib.c:365: period_update: pcmC2D0c:0:
pos=3D1536/2048/8192, hwptr=3D9216/512/9728/0
Dec 23 04:10:58 testbox kernel: [  150.451739] ALSA
sound/core/pcm_lib.c:419: PCM: hw_ptr skipping! [Q] (pos=3D1536,
delta=3D9216, period=3D2048, jdelta=3D33/192/0, hw_ptr=3D512/512)
Dec 23 04:10:58 testbox kernel: [  150.467632] saa7231_irq_handler
(0): status=3D0x800 vector=3D43 event=3D43 handler:f83b67b6
Dec 23 04:10:58 testbox kernel: [  150.467641] saa7231_audio_evhandler
(0): DEBUG: got buffer with index:3 port:6
Dec 23 04:10:58 testbox kernel: [  150.467660]       194a 0000 0401
0000   1959 0000 0401 0000
Dec 23 04:10:58 testbox kernel: [  150.467664]       195d 0000 0401
0000   1964 0000 0401 0000
Dec 23 04:10:58 testbox kernel: [  150.467669]       1968 0000 0401
0000   196f 0000 0401 0000
Dec 23 04:10:58 testbox kernel: [  150.467673]       1973 0000 0401
0000   1982 0000 0401 0000
Dec 23 04:10:58 testbox kernel: [  150.467678]       1986 0000 0401
0000   198d 0000 0401 0000
Dec 23 04:10:58 testbox kernel: [  150.467682]       1991 0000 0401
0000   1998 0000 0401 0000
Dec 23 04:10:58 testbox kernel: [  150.467687]       199c 0000 0401
0000   19a3 0000 0401 0000
Dec 23 04:10:58 testbox kernel: [  150.467691]       19a7 0000 0401
0000   19ae 0000 0401 0000
Dec 23 04:10:58 testbox kernel: [  150.467695]       19b2 0000 0401
0000   19b9 0000 0401 0000
Dec 23 04:10:58 testbox kernel: [  150.467700]       19bd 0000 0401
0000   19cc 0000 0401 0000
Dec 23 04:10:58 testbox kernel: [  150.467704]       19d0 0000 0401
0000   0000 0000 0301 0000
Dec 23 04:10:58 testbox kernel: [  150.467709]       0004 0000 0301
0000   0008 0000 0301 0000
Dec 23 04:10:58 testbox kernel: [  150.467713]       000c 0000 0301
0000   0018 0000 0301 0000
Dec 23 04:10:58 testbox kernel: [  150.467717]       001c 0000 0301
0000   0020 0000 0301 0000
Dec 23 04:10:58 testbox kernel: [  150.467722]       0024 0000 0301
0000   0030 0000 0401 0000
Dec 23 04:10:58 testbox kernel: [  150.467726]       0034 0000 0401
0000   0038 0000 0401 0000
Dec 23 04:10:58 testbox kernel: [  150.467732] saa7231_capture_pointer
(0): DEBUG:() Index:3 with frames:2048, total:8 pages, size:4096
buf_size:16384
Dec 23 04:10:58 testbox kernel: [  150.467736] ALSA
sound/core/pcm_lib.c:365: period_update: pcmC2D0c:0:
pos=3D2048/2048/8192, hwptr=3D1536/512/2048/0
Dec 23 04:10:58 testbox kernel: [  150.483634] saa7231_irq_handler
(0): status=3D0x800 vector=3D43 event=3D43 handler:f83b67b6
Dec 23 04:10:58 testbox kernel: [  150.483643] saa7231_audio_evhandler
(0): DEBUG: got buffer with index:4 port:6
Dec 23 04:10:58 testbox kernel: [  150.483660]       ffffdc77 0009
1b01 0000   ffffdc83 0009 1b01 0000
Dec 23 04:10:58 testbox kernel: [  150.483665]       ffffdc92 0009
1b01 0000   ffffdc9e 0009 1b01 0000
Dec 23 04:10:58 testbox kernel: [  150.483670]       ffffdcac 0009
1b01 0000   ffffdcba 0009 1b01 0000
Dec 23 04:10:58 testbox kernel: [  150.483674]       ffffdcc8 0009
1b01 0000   ffffdcd7 0009 1b01 0000
Dec 23 04:10:58 testbox kernel: [  150.483679]       ffffdce3 0009
1b01 0000   ffffdcf1 0009 1b01 0000
Dec 23 04:10:58 testbox kernel: [  150.483684]       ffffdcff 0009
1b01 0000   ffffdd1b 0009 1b01 0000
Dec 23 04:10:58 testbox kernel: [  150.483688]       ffffdd29 0009
1b01 0000   ffffdd37 0009 1b01 0000
Dec 23 04:10:58 testbox kernel: [  150.483693]       ffffdd54 0009
1b01 0000   ffffdd60 0009 1b01 0000
Dec 23 04:10:58 testbox kernel: [  150.483697]       ffffdd6f 0009
1b01 0000   ffffdd7a 0009 1b01 0000
Dec 23 04:10:58 testbox kernel: [  150.483702]       ffffdd86 0009
1b01 0000   ffffdd8c 0009 1b01 0000
Dec 23 04:10:58 testbox kernel: [  150.483707]       ffffdd92 0009
1b01 0000   ffffdd98 0009 1b01 0000
Dec 23 04:10:58 testbox kernel: [  150.483711]       ffffdd9e 0009
1b01 0000   ffffdda4 0009 1b01 0000
Dec 23 04:10:58 testbox kernel: [  150.483716]       ffffddaa 0009
1b01 0000   ffffddb0 0009 1b01 0000
Dec 23 04:10:58 testbox kernel: [  150.483720]       ffffddb6 0009
1b01 0000   ffffddbc 0009 1b01 0000
Dec 23 04:10:58 testbox kernel: [  150.483725]       ffffddc2 0009
1b01 0000   ffffddc8 0009 1b01 0000
Dec 23 04:10:58 testbox kernel: [  150.483729]       ffffddce 0009
1b01 0000   ffffddd4 0009 1b01 0000
Dec 23 04:10:58 testbox kernel: [  150.483736] saa7231_capture_pointer
(0): DEBUG:() Index:4 with frames:2560, total:8 pages, size:4096
buf_size:20480
Dec 23 04:10:58 testbox kernel: [  150.483739] ALSA
sound/core/pcm_lib.c:365: period_update: pcmC2D0c:0:
pos=3D2560/2048/8192, hwptr=3D8704/2048/10752/0
Dec 23 04:10:58 testbox kernel: [  150.483743] ALSA
sound/core/pcm_lib.c:419: PCM: hw_ptr skipping! [Q] (pos=3D2560,
delta=3D8704, period=3D2048, jdelta=3D16/181/0, hw_ptr=3D2048/2048)
Dec 23 04:10:59 testbox kernel: [  150.499636] saa7231_irq_handler
(0): status=3D0x800 vector=3D43 event=3D43 handler:f83b67b6
Dec 23 04:10:59 testbox kernel: [  150.499644] saa7231_audio_evhandler
(0): DEBUG: got buffer with index:5 port:6
Dec 23 04:10:59 testbox kernel: [  150.499662]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.499667]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.499671]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.499676]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.499680]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.499685]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.499689]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.499693]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.499698]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.499702]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.499706]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.499711]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.499715]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.499719]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.499724]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.499728]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.499734] saa7231_capture_pointer
(0): DEBUG:() Index:5 with frames:3072, total:8 pages, size:4096
buf_size:24576
Dec 23 04:10:59 testbox kernel: [  150.499737] ALSA
sound/core/pcm_lib.c:365: period_update: pcmC2D0c:0:
pos=3D3072/2048/8192, hwptr=3D9216/2048/11264/0
Dec 23 04:10:59 testbox kernel: [  150.499741] ALSA
sound/core/pcm_lib.c:419: PCM: hw_ptr skipping! [Q] (pos=3D3072,
delta=3D9216, period=3D2048, jdelta=3D32/192/0, hw_ptr=3D2048/2048)
Dec 23 04:10:59 testbox kernel: [  150.515637] saa7231_irq_handler
(0): status=3D0x800 vector=3D43 event=3D43 handler:f83b67b6
Dec 23 04:10:59 testbox kernel: [  150.515646] saa7231_audio_evhandler
(0): DEBUG: got buffer with index:6 port:6
Dec 23 04:10:59 testbox kernel: [  150.515664]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.515668]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.515673]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.515677]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.515682]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.515686]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.515690]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.515695]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.515699]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.515703]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.515708]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.515712]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.515716]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.515721]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.515725]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.515729]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.515735] saa7231_capture_pointer
(0): DEBUG:() Index:6 with frames:3584, total:8 pages, size:4096
buf_size:28672
Dec 23 04:10:59 testbox kernel: [  150.515738] ALSA
sound/core/pcm_lib.c:365: period_update: pcmC2D0c:0:
pos=3D3584/2048/8192, hwptr=3D9728/2048/11776/0
Dec 23 04:10:59 testbox kernel: [  150.515743] ALSA
sound/core/pcm_lib.c:419: PCM: hw_ptr skipping! [Q] (pos=3D3584,
delta=3D9728, period=3D2048, jdelta=3D48/202/0, hw_ptr=3D2048/2048)
Dec 23 04:10:59 testbox kernel: [  150.531638] saa7231_irq_handler
(0): status=3D0x800 vector=3D43 event=3D43 handler:f83b67b6
Dec 23 04:10:59 testbox kernel: [  150.531647] saa7231_audio_evhandler
(0): DEBUG: got buffer with index:7 port:6
Dec 23 04:10:59 testbox kernel: [  150.531665]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.531670]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.531674]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.531678]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.531683]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.531687]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.531691]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.531696]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.531700]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.531704]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.531709]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.531713]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.531717]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.531722]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.531726]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.531730]       0000 0000 0000
0000   0000 0000 0000 0000
Dec 23 04:10:59 testbox kernel: [  150.531736] saa7231_capture_pointer
(0): DEBUG:() Index:7 with frames:4096, total:8 pages, size:4096
buf_size:32768
Dec 23 04:10:59 testbox kernel: [  150.531740] ALSA
sound/core/pcm_lib.c:365: period_update: pcmC2D0c:0:
pos=3D4096/2048/8192, hwptr=3D2048/2048/4096/0
Dec 23 04:10:59 testbox kernel: [  150.531834] saa7231_capture_pointer
(0): DEBUG:() Index:7 with frames:4096, total:8 pages, size:4096
buf_size:32768
Dec 23 04:10:59 testbox kernel: [  150.531838] ALSA
sound/core/pcm_lib.c:365: hwptr_update: pcmC2D0c:0:
pos=3D4096/2048/8192, hwptr=3D0/4096/4096/0
Dec 23 04:10:59 testbox kernel: [  150.531867] saa7231_capture_pointer
(0): DEBUG:() Index:7 with frames:4096, total:8 pages, size:4096
buf_size:32768
Dec 23 04:10:59 testbox kernel: [  150.531870] ALSA
sound/core/pcm_lib.c:365: hwptr_update: pcmC2D0c:0:
pos=3D4096/2048/8192, hwptr=3D0/4096/4096/0
Dec 23 04:10:59 testbox kernel: [  150.547640] saa7231_irq_handler
(0): status=3D0x800 vector=3D43 event=3D43 handler:f83b67b6
Dec 23 04:10:59 testbox kernel: [  150.547649] saa7231_audio_evhandler
(0): DEBUG: got buffer with index:0 port:6
Dec 23 04:10:59 testbox kernel: [  150.547667]       119d 0000 3b1c
fffff83b   004a 0000 0074 0002
Dec 23 04:10:59 testbox kernel: [  150.547672]       11a3 0000 3b66
fffff83b   0038 0000 0074 0002
Dec 23 04:10:59 testbox kernel: [  150.547676]       11a9 0000
ffff9628 fffff83b   0014 0000 0072 0008
Dec 23 04:10:59 testbox kernel: [  150.547681]       11b8 0000 0000
0000   0000 0000 0061 fffffff1
Dec 23 04:10:59 testbox kernel: [  150.547685]       11c9 0000 3fa0
fffff83b   001a 0000 0074 0002
Dec 23 04:10:59 testbox kernel: [  150.547690]       11dd 0000 3fba
fffff83b   0115 0000 0074 0002
Dec 23 04:10:59 testbox kernel: [  150.547695]       11f7 0000
ffff97a0 fffff83b   001a 0000 0072 0008
Dec 23 04:10:59 testbox kernel: [  150.547699]       1206 0000 40cf
fffff83b   0096 0000 0074 0002
Dec 23 04:10:59 testbox kernel: [  150.547704]       1219 0000
ffff97e8 fffff83b   0013 0000 0072 0008
Dec 23 04:10:59 testbox kernel: [  150.547708]       10dd 0000 4165
fffff83b   0164 0000 0074 0002
Dec 23 04:10:59 testbox kernel: [  150.547713]       10f2 0000
ffff9774 fffff83b   0015 0000 0072 0008
Dec 23 04:10:59 testbox kernel: [  150.547717]       1101 0000 42c9
fffff83b   05bc 0000 0074 0002
Dec 23 04:10:59 testbox kernel: [  150.547722]       1228 0000
ffff97d4 fffff83b   0011 0000 0072 0008
Dec 23 04:10:59 testbox kernel: [  150.547727]       1237 0000 4885
fffff83b   0072 0000 0074 0002
Dec 23 04:10:59 testbox kernel: [  150.547731]       124b 0000
ffff978c fffff83b   0014 0000 0072 0008
Dec 23 04:10:59 testbox kernel: [  150.547736]       125a 0000 48f7
fffff83b   00fa 0000 0074 0002
Dec 23 04:10:59 testbox kernel: [  150.547742] saa7231_capture_pointer
(0): DEBUG:() Index:0 with frames:512, total:8 pages, size:4096
buf_size:4096
Dec 23 04:10:59 testbox kernel: [  150.547745] ALSA
sound/core/pcm_lib.c:365: period_update: pcmC2D0c:0:
pos=3D512/2048/8192, hwptr=3D4608/4096/8704/0
Dec 23 04:10:59 testbox kernel: [  150.547749] ALSA
sound/core/pcm_lib.c:419: PCM: hw_ptr skipping! [Q] (pos=3D512,
delta=3D4608, period=3D2048, jdelta=3D16/96/0, hw_ptr=3D4096/4096)
Dec 23 04:10:59 testbox kernel: [  150.563642] saa7231_irq_handler
(0): status=3D0x800 vector=3D43 event=3D43 handler:f83b67b6
Dec 23 04:10:59 testbox kernel: [  150.563650] saa7231_audio_evhandler
(0): DEBUG: got buffer with index:1 port:6
Dec 23 04:10:59 testbox kernel: [  150.563668]       3761 3332 5f31
6c61   6173 695f 696e 0074
