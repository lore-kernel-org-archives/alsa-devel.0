From: Manu Abraham <abraham.manu@gmail.com>
Subject: Re: callbacks order while capturing from Line-IN
Date: Fri, 17 Dec 2010 12:50:10 +0530
Message-ID: <AANLkTi=d3FCtz7zQk7ss2xnZi8M0ipx70xocf1ceXcQH@mail.gmail.com>
References: <AANLkTik+MSbaDS0jD3ax8t7TFjf1vXAjaK3a=P+5MUNa@mail.gmail.com>
	<AANLkTik7WwZGnDyE=bfw5_a_PXcERhFF9bPy0qYX=6+v@mail.gmail.com>
	<alpine.LNX.2.00.1012170719391.28150@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id AED2F10387B
	for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2010 08:20:10 +0100 (CET)
Received: by wyi11 with SMTP id 11so327627wyi.38
	for <alsa-devel@alsa-project.org>; Thu, 16 Dec 2010 23:20:10 -0800 (PST)
In-Reply-To: <alpine.LNX.2.00.1012170719391.28150@eeebox2.perex-int.cz>
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

On Fri, Dec 17, 2010 at 11:51 AM, Jaroslav Kysela <perex@perex.cz> wrote:
> On Fri, 17 Dec 2010, Manu Abraham wrote:
>
>> On Fri, Dec 17, 2010 at 10:28 AM, Manu Abraham <abraham.manu@gmail.com>
>> wrote:
>>>
>>> Hi,
>>>
>>> By now I am a bit confused.
>>>
>>> I am seeing a certain pattern in which the callbacks are invoked:
>>>
>>> - hw_params()
>>> - prepare()
>>> - trigger(); // Start DMA
>>> - pointer();
>>> =A0 =A0 =A0 =A0 =A0 =A0--> gets data after interrupt is handled
>>> - trigger(); // Stop DMA
>>> - prepare();
>>> - trigger(); // Start DMA
>>> - pointer();
>>> =A0 =A0 =A0 =A0 =A0 --> gets data after interrupt is handled
>>>
>>> ..
>>> ..
>>>
>>> and so on.
>>>
>>> Is this the right behaviour that's expected from a function ALSA
>>> capture driver ?
>>> I am trying to understand why there is Start DMA, Stop DMA, Start DMA,
>>> Stop DMA
>>> in a cyclic fashion for each of the interrupts in my setup.
>>
>>
>> To test my theory that a STOP cmd after an interrupt was giving me the
>> same buffer location, I did commented out the STOP cmd, as well,
>> allowing the START cmd to run only if the streaming engine has not
>> START 'ed.
>>
>> This allows the interrupt handler to fire correctly with the correct
>> buffer indices, as seen in the following logs.
>>
>> http://pastebin.ca/2021840
>>
>> The problem is that,
>>
>> 1. I don't understand why the application issues a CMD to STOP/START,
>> after each interrupt.
>> 2. The STOP/START cmds reinitializes the Streaming engine to start
>> with buffer index:0, therefore always buffer position is at the very
>> beginning of the buffer.
>
> I believe that your pointer callback is buggy so the midlevel code things
> that you had and overrun.
>
> http://www.alsa-project.org/main/index.php/XRUN_Debug


Thanks, that was very helpful. I am looking at it. I did find an issue
looking at the pointer callback itself straight away.


static snd_pcm_uframes_t saa7231_capture_pointer(struct snd_pcm_substream *=
pcm)
{
	struct saa7231_audio *audio	=3D snd_pcm_substream_chip(pcm);
	struct saa7231_dev *saa7231	=3D audio->saa7231;
	struct snd_pcm_runtime *rt	=3D pcm->runtime;

	dprintk(SAA7231_DEBUG, 1, "DEBUG:()");
	return bytes_to_frames(rt, audio->index * audio->pages * PAGE_SIZE);
}

audio->pages is the whole number of pages for all the 8 buffers; Fixed
that issue, run it again, this time arecord stated just a single
overrun

static snd_pcm_uframes_t saa7231_capture_pointer(struct snd_pcm_substream *=
pcm)
{
	struct saa7231_audio *audio	=3D snd_pcm_substream_chip(pcm);
	struct saa7231_dev *saa7231	=3D audio->saa7231;
	struct snd_pcm_runtime *rt	=3D pcm->runtime;
	u32 frames;

	frames =3D bytes_to_frames(rt, audio->index * (audio->pages /
XS2D_BUFFERS) * PAGE_SIZE);
	dprintk(SAA7231_DEBUG, 1, "DEBUG:() Index:%d with frames:%d, total %d
pages", audio->index, frames, audio->pages);
	return frames;
}


testbox v4l # arecord -D plughw:2,0 --format S16_LE --rate=3D48000 -c 2
> /tmp/test.wav
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
overrun!!! (at least 0.006 ms long)
^CAborted by signal Interrupt...

The logs do look thus now: http://pastebin.ca/2021872


Now, I do get a .wav file The contents of which seems to be junk ??

http://202.88.242.108:8000/test/test.wav

Tried to play it back with alsaplayer and mplyer with no results,
mplayer shows no issues though.. Maybe PCM corruptions ? But at least
some noises it should make  ?


Thanks,
Manu

manu@manu-04:~$ mplayer ~/test.wav
MPlayer SVN-r1.0~rc3+svn20090426-4.4.3 (C) 2000-2009 MPlayer Team
mplayer: could not connect to socket
mplayer: No such file or directory
Failed to open LIRC support. You will not be able to use your remote contro=
l.

Playing /home/manu/test.wav.
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
AO: [pulse] Init failed: Connection refused
Failed to initialize audio driver 'pulse'
AO: [alsa] 48000Hz 2ch s16le (2 bytes per sample)
Video: no video
Starting playback...
A:   9.0 (09.0) of 25.0 (25.0)  0.0%

MPlayer interrupted by signal 2 in module: key_events
A:   9.0 (09.0) of 25.0 (25.0)  0.0%
Exiting... (Quit)
manu@manu-04:~$
