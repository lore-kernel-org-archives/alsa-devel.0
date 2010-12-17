From: Manu Abraham <abraham.manu@gmail.com>
Subject: Re: callbacks order while capturing from Line-IN
Date: Fri, 17 Dec 2010 11:43:44 +0530
Message-ID: <AANLkTik7WwZGnDyE=bfw5_a_PXcERhFF9bPy0qYX=6+v@mail.gmail.com>
References: <AANLkTik+MSbaDS0jD3ax8t7TFjf1vXAjaK3a=P+5MUNa@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 15F51103830
	for <alsa-devel@alsa-project.org>; Fri, 17 Dec 2010 07:13:45 +0100 (CET)
Received: by wyi11 with SMTP id 11so297365wyi.38
	for <alsa-devel@alsa-project.org>; Thu, 16 Dec 2010 22:13:44 -0800 (PST)
In-Reply-To: <AANLkTik+MSbaDS0jD3ax8t7TFjf1vXAjaK3a=P+5MUNa@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Dec 17, 2010 at 10:28 AM, Manu Abraham <abraham.manu@gmail.com> wro=
te:
> Hi,
>
> By now I am a bit confused.
>
> I am seeing a certain pattern in which the callbacks are invoked:
>
> - hw_params()
> - prepare()
> - trigger(); // Start DMA
> - pointer();
> =A0 =A0 =A0 =A0 =A0 =A0--> gets data after interrupt is handled
> - trigger(); // Stop DMA
> - prepare();
> - trigger(); // Start DMA
> - pointer();
> =A0 =A0 =A0 =A0 =A0 --> gets data after interrupt is handled
>
> ..
> ..
>
> and so on.
>
> Is this the right behaviour that's expected from a function ALSA
> capture driver ?
> I am trying to understand why there is Start DMA, Stop DMA, Start DMA, St=
op DMA
> in a cyclic fashion for each of the interrupts in my setup.


To test my theory that a STOP cmd after an interrupt was giving me the
same buffer location, I did commented out the STOP cmd, as well,
allowing the START cmd to run only if the streaming engine has not
START 'ed.

This allows the interrupt handler to fire correctly with the correct
buffer indices, as seen in the following logs.

http://pastebin.ca/2021840

The problem is that,

1. I don't understand why the application issues a CMD to STOP/START,
after each interrupt.
2. The STOP/START cmds reinitializes the Streaming engine to start
with buffer index:0, therefore always buffer position is at the very
beginning of the buffer.

Additionally, I see these lines:

testbox v4l # arecord -D plughw:2,0 --format S16_LE --rate=3D48000 -c 2
> /tmp/test.wav
Recording WAVE 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
overrun!!! (at least 0.002 ms long)
overrun!!! (at least 0.002 ms long)
overrun!!! (at least 0.002 ms long)
overrun!!! (at least 0.002 ms long)
overrun!!! (at least 0.002 ms long)
overrun!!! (at least 0.002 ms long)
overrun!!! (at least 0.002 ms long)
overrun!!! (at least 0.002 ms long)
overrun!!! (at least 0.002 ms long)
overrun!!! (at least 0.002 ms long)
overrun!!! (at least 0.002 ms long)
overrun!!! (at least 0.002 ms long)
overrun!!! (at least 0.002 ms long)
overrun!!! (at least 0.002 ms long)
overrun!!! (at least 0.002 ms long)
overrun!!! (at least 0.002 ms long)
overrun!!! (at least 0.002 ms long)
overrun!!! (at least 0.006 ms long)
overrun!!! (at least 0.002 ms long)
^CAborted by signal Interrupt...


The hardware information definition looks thus:

static struct snd_pcm_hardware saa7231_capture_info =3D {
	.info			=3D (SNDRV_PCM_INFO_MMAP		|
				  SNDRV_PCM_INFO_INTERLEAVED	|
				  SNDRV_PCM_INFO_BLOCK_TRANSFER	|
				  SNDRV_PCM_INFO_MMAP_VALID),

	.formats		=3D SNDRV_PCM_FMTBIT_S16_LE,
	.rates			=3D SNDRV_PCM_RATE_48000,

	.rate_min		=3D 48000,
	.rate_max		=3D 48000,

	.channels_min		=3D 2,
	.channels_max		=3D 2,

	.buffer_bytes_max	=3D XS2D_BUFFERS * PAGE_SIZE * 512, /* 16,777,216 */

	.period_bytes_min	=3D 4096,
	.period_bytes_max	=3D 2097152,

	.periods_min		=3D 8, //8,
	.periods_max		=3D 4096, //4096,
};

Where XS2D_BUFFERS =3D 8


Any help is much appreciated.


Thanks,
Manu
