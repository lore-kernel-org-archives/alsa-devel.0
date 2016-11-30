From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 2/3 v2] ALSA: usb-audio: avoid setting of sample rate
 multiple times on bus
Date: Thu, 1 Dec 2016 07:19:52 +0900
Message-ID: <3e73cbb9-e19e-97d7-3ca0-fe7a8f018270@sakamocchi.jp>
References: <20161130075923.15205-1-jiada_wang@mentor.com>
 <20161130075923.15205-3-jiada_wang@mentor.com>
 <c4579c3f-4798-7096-2c05-b0670ccbad08@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <c4579c3f-4798-7096-2c05-b0670ccbad08@sakamocchi.jp>
Sender: linux-kernel-owner@vger.kernel.org
To: Jiada Wang <jiada_wang@mentor.com>, perex@perex.cz, tiwai@suse.com
Cc: alsa-devel@alsa-project.org, apape@de.adit-jv.com, linux-kernel@vger.kernel.org, Mark_Craske@mentor.com
List-Id: alsa-devel@alsa-project.org

On Nov 30 2016 19:45, Takashi Sakamoto wrote:
> Hi Jiada,
>
> I don't oppose this patch. Nevertheless, your description is not
> necessarily correct.
>
> On Nov 30 2016 16:59, Jiada Wang wrote:
>> From: Daniel Girnus <dgirnus@de.adit-jv.com>
>>
>> ALSA usually calls the prepare function twice before starting the
>> playback:
>> 1. On hw_params call from userland and
>> 2. internally when starting the stream.
>
> ALSA PCM core in kernel land doesn't perform like this.
>
> In alsa-lib, 'snd_pcm_hw_params()' calls 'snd_pcm_hw_params_internal()'
> and 'snd_pcm_prepare()' sequentially.
> http://git.alsa-project.org/?p=alsa-lib.git;a=blob;f=src/pcm/pcm.c;h=cd87bc759ded95953e332b7e8d56b0f2d5b4185d;hb=HEAD#l853
>
>
> In system call level (e.g. see by strace(1)), this looks like two
> ioctl(2)s with 'SNDRV_PCM_IOCTL_HW_PARAMS' and 'SNDRV_PCM_IOCTL_PREPARE'.
>
> Well, when applications are written to execute 'snd_pcm_hw_params()' and
> 'snd_pcm_hw_prepare()' sequentially, additional ioctl(2) with
> 'SNDRV_PCM_IOCTL_PREPARE' appears. PulseAudio is this kind of
> application. I indicated the useless in 2014, but it still remains:
> https://lists.freedesktop.org/archives/pulseaudio-discuss/2014-January/019773.html
>
>
> You have the misunderstanding due to a nature of alsa-lib and tendency
> of major applications, from my point of view.

So here you should mention that current USB Audio device class driver 
somewhat ignores state machine of ALSA PCM runtime.

In ALSA PCM core, state of the runtime is described in 'struct 
snd_pcm_runtime.status.state' with macros of 'SNDRV_PCM_STATE_XXX'. 
Applications are allowed to handle the runtime according to the state.

In your issue, the driver is programmed ignoring a case that double 
calls of snd_pcm_prepare(), in short, ioctl(PREPARE) is called in 
'PREPARED' state. This is not only an issue for snd-usb-audio, but also 
for snd-usb-hiface.
http://mailman.alsa-project.org/pipermail/alsa-devel/2016-November/115174.html

For these issue, I have no patch proposals because I have few test 
devices, sorry.


Regards

Takashi Sakamoto
