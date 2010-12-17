From: Jaroslav Kysela <perex@perex.cz>
Subject: Re: callbacks order while capturing from Line-IN
Date: Fri, 17 Dec 2010 09:08:36 +0100 (CET)
Message-ID: <alpine.LNX.2.00.1012170903300.28150@eeebox2.perex-int.cz>
References: <AANLkTik+MSbaDS0jD3ax8t7TFjf1vXAjaK3a=P+5MUNa@mail.gmail.com>
	<AANLkTik7WwZGnDyE=bfw5_a_PXcERhFF9bPy0qYX=6+v@mail.gmail.com>
	<alpine.LNX.2.00.1012170719391.28150@eeebox2.perex-int.cz>
	<AANLkTi=d3FCtz7zQk7ss2xnZi8M0ipx70xocf1ceXcQH@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.perex.cz (unknown [212.20.107.53])
	by alsa0.perex.cz (Postfix) with ESMTP id E0C5F103830
	for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2010 09:08:37 +0100 (CET)
In-Reply-To: <AANLkTi=d3FCtz7zQk7ss2xnZi8M0ipx70xocf1ceXcQH@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Manu Abraham <abraham.manu@gmail.com>
Cc: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, 17 Dec 2010, Manu Abraham wrote:

> Thanks, that was very helpful. I am looking at it. I did find an issue
> looking at the pointer callback itself straight away.
>
>
> static snd_pcm_uframes_t saa7231_capture_pointer(struct snd_pcm_substream *pcm)
> {
> 	struct saa7231_audio *audio	= snd_pcm_substream_chip(pcm);
> 	struct saa7231_dev *saa7231	= audio->saa7231;
> 	struct snd_pcm_runtime *rt	= pcm->runtime;
>
> 	dprintk(SAA7231_DEBUG, 1, "DEBUG:()");
> 	return bytes_to_frames(rt, audio->index * audio->pages * PAGE_SIZE);
> }
>
> audio->pages is the whole number of pages for all the 8 buffers; Fixed
> that issue, run it again, this time arecord stated just a single
> overrun
>
> static snd_pcm_uframes_t saa7231_capture_pointer(struct snd_pcm_substream *pcm)
> {
> 	struct saa7231_audio *audio	= snd_pcm_substream_chip(pcm);
> 	struct saa7231_dev *saa7231	= audio->saa7231;
> 	struct snd_pcm_runtime *rt	= pcm->runtime;
> 	u32 frames;
>
> 	frames = bytes_to_frames(rt, audio->index * (audio->pages /
> XS2D_BUFFERS) * PAGE_SIZE);
> 	dprintk(SAA7231_DEBUG, 1, "DEBUG:() Index:%d with frames:%d, total %d
> pages", audio->index, frames, audio->pages);
> 	return frames;
> }
>
>
> testbox v4l # arecord -D plughw:2,0 --format S16_LE --rate=48000 -c 2
>> /tmp/test.wav
> Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
> overrun!!! (at least 0.006 ms long)
> ^CAborted by signal Interrupt...
>
> The logs do look thus now: http://pastebin.ca/2021872

This is your problem (first irq_handler):

saa7231_irq_handler (0): status=0x800 vector=43 event=43 handler:f83b91ff
saa7231_capture_pointer (0): DEBUG:() Index:0 with frames:0, total 48 pages
saa7231_capture_trigger (0): Trying to STOP stream, cmd=0

The pointer should return how many samples are filled (probably value 
6144 in your case). The midlevel code expects that at least one period has 
been recorded, but your pointer() callbacks returned 0 here. It is 
wrong. Ignoring STOP/START is just a bad workaround for the broken 
driver.

> Now, I do get a .wav file The contents of which seems to be junk ??
>
> http://202.88.242.108:8000/test/test.wav
>
> Tried to play it back with alsaplayer and mplyer with no results,
> mplayer shows no issues though.. Maybe PCM corruptions ? But at least
> some noises it should make  ?

Try add some printk directly to the driver to show the few recorded 
samples in the DMA buffers.

 						Jaroslav

-----
Jaroslav Kysela <perex@perex.cz>
Linux Kernel Sound Maintainer
ALSA Project, Red Hat, Inc.
