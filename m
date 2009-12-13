From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: hw_ptr accuracy with intel8x0 -> PulseAudio issue
Date: Sun, 13 Dec 2009 15:34:02 +0800
Message-ID: <4f3252890912122334le0e5634gd693c7f5d1bfa6eb@mail.gmail.com>
References: <6160a5130912020115t45bd4635hceb0ac3de4fb1efe@mail.gmail.com>
	<4f3252890912021826g732292ecv8959a7cfbf574446@mail.gmail.com>
	<6160a5130912030828m5b2401f3w31a67b6b51e8d8b6@mail.gmail.com>
	<4f3252890912031442i56ccc905g935a4d6ed48f40c6@mail.gmail.com>
	<6160a5130912031650u5949c921jc86d0847b2844803@mail.gmail.com>
	<4f3252890912041817u7ab83a3eh7643476d64d709f3@mail.gmail.com>
	<s5h4oo1sisn.wl%tiwai@suse.de>
	<4f3252890912090355n70a2b5cfu4fbb74d473480a94@mail.gmail.com>
	<s5hr5r4ntus.wl%tiwai@suse.de>
	<6160a5130912100627t4d62397dp654c9bcb84ade617@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f53.google.com (mail-pw0-f53.google.com
	[209.85.160.53]) by alsa0.perex.cz (Postfix) with ESMTP id AEDF5244AB
	for <alsa-devel@alsa-project.org>; Sun, 13 Dec 2009 08:34:03 +0100 (CET)
Received: by pwi18 with SMTP id 18so4491804pwi.32
	for <alsa-devel@alsa-project.org>; Sat, 12 Dec 2009 23:34:02 -0800 (PST)
In-Reply-To: <6160a5130912100627t4d62397dp654c9bcb84ade617@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

2009/12/10 pl bossart <bossart.nospam@gmail.com>

> Takashi,
> I tested with .periods_min=2 and reduced the period_max by half. The
> underruns reported by PulseAudio are no longer present with this
> modification.
>


why did you reduce periods_max by half since the driver should still support
1024 periods of 32 bytes when you set periods_min = 2 ?

Is it period_bytes_max by half ?

static struct snd_pcm_hardware snd_intel8x0_stream =
{
    .info =            (SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_INTERLEAVED |
                 SNDRV_PCM_INFO_BLOCK_TRANSFER |
                 SNDRV_PCM_INFO_MMAP_VALID |
                 SNDRV_PCM_INFO_PAUSE |
                 SNDRV_PCM_INFO_RESUME),
    .formats =        SNDRV_PCM_FMTBIT_S16_LE,
    .rates =        SNDRV_PCM_RATE_48000,
    .rate_min =        48000,
    .rate_max =        48000,
    .channels_min =        2,
    .channels_max =        2,
    .buffer_bytes_max =    128 * 1024,
    .period_bytes_min =    32,
    .period_bytes_max =    128 * 1024,
    .periods_min =        1,
    .periods_max =        1024,
    .fifo_size =        0,
};
