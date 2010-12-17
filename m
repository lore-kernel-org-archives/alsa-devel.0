From: Manu Abraham <abraham.manu@gmail.com>
Subject: Re: callbacks order while capturing from Line-IN
Date: Fri, 17 Dec 2010 15:50:45 +0530
Message-ID: <AANLkTimO-R3H=2HQA3-ssgfbPmqxr7OTvFuFS93RaZUa@mail.gmail.com>
References: <AANLkTik+MSbaDS0jD3ax8t7TFjf1vXAjaK3a=P+5MUNa@mail.gmail.com>
	<AANLkTik7WwZGnDyE=bfw5_a_PXcERhFF9bPy0qYX=6+v@mail.gmail.com>
	<alpine.LNX.2.00.1012170719391.28150@eeebox2.perex-int.cz>
	<AANLkTi=d3FCtz7zQk7ss2xnZi8M0ipx70xocf1ceXcQH@mail.gmail.com>
	<alpine.LNX.2.00.1012170903300.28150@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id B341F103830
	for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2010 11:20:49 +0100 (CET)
Received: by wyi11 with SMTP id 11so442512wyi.38
	for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2010 02:20:47 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1012170903300.28150@eeebox2.perex-int.cz>
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

On Fri, Dec 17, 2010 at 1:38 PM, Jaroslav Kysela <perex@perex.cz> wrote:
> On Fri, 17 Dec 2010, Manu Abraham wrote:
>
>> Thanks, that was very helpful. I am looking at it. I did find an issue
>> looking at the pointer callback itself straight away.
>>
>> The logs do look thus now: http://pastebin.ca/2021872
>
> This is your problem (first irq_handler):
>
> saa7231_irq_handler (0): status=3D0x800 vector=3D43 event=3D43 handler:f8=
3b91ff
> saa7231_capture_pointer (0): DEBUG:() Index:0 with frames:0, total 48 pag=
es
> saa7231_capture_trigger (0): Trying to STOP stream, cmd=3D0
>
> The pointer should return how many samples are filled (probably value 6144
> in your case). The midlevel code expects that at least one period has been
> recorded, but your pointer() callbacks returned 0 here. It is wrong.
> Ignoring STOP/START is just a bad workaround for the broken driver.


Initially, I had to ignore the CMD's to understand what was happening,
ie why the DMA engine was giving me buffer index:0 and hence I did
ignore the START/STOP CMD's.

I did hardcoded the max frames per buffer to be 6144 (as your guess),
as you can see...

		stride		=3D 768; /* meaningless in 1D mode */
		buf_size	=3D 24576; //7680;
		x_length	=3D 32;// 4 /* max bytes in a line/frame/packet */
//		y_length	=3D 1920; /* max lines/frames/packets per buffer */
		y_length	=3D 6144; //1920; /* max lines/frames/packets per buffer */

	SAA7231_WR(x_length, SAA7231_BAR0, module, S2D_CHx_B1_X_LENGTH(0));
	SAA7231_WR(y_length, SAA7231_BAR0, module, S2D_CHx_B1_Y_LENGTH(0));


Initially, I was of the understanding that capture pointer wanted the
start of the buffer and hence started with 0, 6144 and multiples of
it...
Now that you mention it; I modified it to return 6144 frames after
each interrupt.

static snd_pcm_uframes_t saa7231_capture_pointer(struct snd_pcm_substream *=
pcm)
{
	struct saa7231_audio *audio	=3D snd_pcm_substream_chip(pcm);
	struct saa7231_dev *saa7231	=3D audio->saa7231;
	struct snd_pcm_runtime *rt	=3D pcm->runtime;
	u32 frames, buf_size;

	buf_size =3D 24576;
	frames =3D (buf_size / 4) * (audio->index + 1);
	dprintk(SAA7231_DEBUG, 1, "DEBUG:() Index:%d with frames:%d, total %d
pages", audio->index, frames, audio->pages);
	return frames;
}

Eventually the arecord overrun error is gone completely

testbox v4l # arecord -D plughw:2,0 --format S16_LE --rate=3D48000 -c 2
> /tmp/test3.wav
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
^CAborted by signal Interrupt...


Eventually, fixed the capture_trigger



>
>> Now, I do get a .wav file The contents of which seems to be junk ??
>>
>> http://202.88.242.108:8000/test/test.wav
>>
>> Tried to play it back with alsaplayer and mplyer with no results,
>> mplayer shows no issues though.. Maybe PCM corruptions ? But at least
>> some noises it should make =A0?
>
> Try add some printk directly to the driver to show the few recorded sampl=
es
> in the DMA buffers.


I did add a few printks, the data seems to be all 0's.

http://pastebin.ca/2021947

I guess the NULL data is not an Alsa related issue ? Thanks again for
all the help.



Thanks,
Manu
