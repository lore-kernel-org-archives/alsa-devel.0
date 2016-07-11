From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Verification of settings
Date: Mon, 11 Jul 2016 21:29:13 +0200
Message-ID: <5783F389.3000903@metafoo.de>
References: <CALAeOVO6D1m1JkRqWXgxvVg5pVtZpFRKuEfwGfX5eENtjiZaYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from www381.your-server.de (www381.your-server.de [78.46.137.84])
 by alsa0.perex.cz (Postfix) with ESMTP id D289B265338
 for <alsa-devel@alsa-project.org>; Mon, 11 Jul 2016 21:29:42 +0200 (CEST)
In-Reply-To: <CALAeOVO6D1m1JkRqWXgxvVg5pVtZpFRKuEfwGfX5eENtjiZaYQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Rob Nertney <rob@rob-otics.com>, alsa-user@lists.sourceforge.net, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 07/11/2016 09:10 PM, Rob Nertney wrote:
> Hi all,
> 
> Could I please get a sanity check on my hw_params?
> 
> I have a DMA which is providing between 1-16 channels of 4 bytes/ch worth
> of data as a frame. I get an interrupt to my driver every frame's worth of
> data (64 Bytes). The data is S32_LE, 16000Hz.
> 
> My DMA has 2 buffers, PING and PONG. Each receives an IRQ on a frame
> length, and these local buffers are the size of a frame length (64Bytes).
> 
> #define MAX_BUFFER (64 * 2)
> static struct snd_pcm_hardware my_pcm_hw =
> {
>   .info = (SNDRV_PCM_INFO_MMAP |
>       SNDRV_PCM_INFO_INTERLEAVED |
>       SNDRV_PCM_INFO_BLOCK_TRANSFER |
>       SNDRV_PCM_INFO_MMAP_VALID),
>   .formats          = SNDRV_PCM_FMTBIT_S32,
>   .rates            = SNDRV_PCM_RATE_16000,
>   .rate_min         = 16000,
>   .rate_max         = 16000,
>   .channels_min     = 1,
>   .channels_max     = NUM_CHANNELS,
>   .buffer_bytes_max = MAX_BUFFER,
>   .period_bytes_min = 4,
>   .period_bytes_max = 64,
>   .periods_min      = 2,
>   .periods_max      = 2,
> };
> 
> 
> My understanding is that the MAX_BUFFER needs to be at least twice the size
> of a period so I don't underrun. .periods_max means the maximum number of
> periods in a the alsa dma_area buffer, right?
> 
> So when my DMA fires its ISR, I copy from its local PING buffer to the
> dma_area at offset 0, increment the buf_pos by the frame_length (64Bytes),
> and call snd_pcm_period_elapsed.
> 
> My DMA fires its ISR for its local PONG buffer, copies to the
> dma_area+buf_pos, increments buf_pos (now back to 0, since buffer only
> holds 2 frames/periods), and I call snd_pcm_period_elapsed again, correct?

Hi,

In principle sounds OK. But there is not much of a point to use a
ping-pong buffer if you give the real buffer the same restrictions. You
might as well use the dma_area buffer as the target of the DMA in that
case. But since in your case the DMA is very restrictive in what it can
support it makes more sense to use the ping-pong buffer and broaden the
restrictions on the real buffer. Allow larger period sizes (only call
snd_pcm_period_elapsed() every N interrupts), allow more than two
periods and so on.

- Lars
