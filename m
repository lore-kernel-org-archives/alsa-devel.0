From: "Pharaoh ." <pharaoh137@gmail.com>
Subject: Re: Input/output error - Confusion regarding period
	size and interrupts
Date: Mon, 16 Jul 2007 19:48:05 +0530
Message-ID: <61445c750707160718j54205f42h51f51657132c574c@mail.gmail.com>
References: <61445c750707160532q4beb8f4cu30b2cfa8731be95e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.227])
	by alsa0.perex.cz (Postfix) with ESMTP id 239731037F8
	for <alsa-devel@alsa-project.org>;
	Mon, 16 Jul 2007 16:18:06 +0200 (CEST)
Received: by nz-out-0506.google.com with SMTP id m22so838772nzf
	for <alsa-devel@alsa-project.org>; Mon, 16 Jul 2007 07:18:05 -0700 (PDT)
In-Reply-To: <61445c750707160532q4beb8f4cu30b2cfa8731be95e@mail.gmail.com>
Content-Disposition: inline
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

I finally solved it, the issue has nothing to do with the above
mentioned things, it was
h/w specific issue.

On 7/16/07, Pharaoh . <pharaoh137@gmail.com> wrote:
> Hi
>
> The hardware I am working on expects 8K bytes to be DMAed before
> giving an interrupt. Only after a block of 8K bytes is DMAed, I get an
> end of the block interrupt and I enqueue next 8K bytes for processing.
> The params look like these:
>
> static snd_pcm_hardware_t snd_omap_alsa_playback = {
>         .info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_PAUSE |
>                               SNDRV_PCM_INFO_RESUME |
> SNDRV_PCM_INFO_MMAP_VALID | SNDRV_PCM_INFO_MMAP),
>         .formats = (SNDRV_PCM_FMTBIT_S16_LE),
>         .rates = (SNDRV_PCM_RATE_44100 | SNDRV_PCM_RATE_48000 ),
>         .rate_min = 44100,
>         .rate_max = 48000,
>         .channels_min = 2,
>         .channels_max = 2,
>         .buffer_bytes_max = 8192*8,
>         .period_bytes_min = 32,
>         .period_bytes_max = 8 * 1024,
>         .periods_min = 2,               //ping pong buffer
>         .periods_max = 128,
>         .fifo_size = 0,
> };
>
> I just copied it from another driver ;-). But now I am getting an
> input/output error after
> first block of data i.e. 8K bytes are DMAed. Does it have anything to
> do with the above struct? I have discussed this earlier too, but now
> attacking it once again after long gap.
>
> -pharaoh.
>
