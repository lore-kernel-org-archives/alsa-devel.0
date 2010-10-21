From: Adam Rosenberg <adam@alcorn.com>
Subject: Re: Constraining the number of frames per period
Date: Thu, 21 Oct 2010 17:15:40 -0400
Message-ID: <AANLkTikAf+o7e-=hosi+dwEywK-Mt5UTvJtqzT=i_5Fz@mail.gmail.com>
References: <AANLkTi=v2DKXfptubtwEPfH_4eZJ-vwLqVHAkmf3iE2D@mail.gmail.com>
	<alpine.LNX.2.00.1010211649160.29422@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f51.google.com (mail-ww0-f51.google.com [74.125.82.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 58DFD103A8D
	for <alsa-devel@alsa-project.org>;
	Thu, 21 Oct 2010 23:16:01 +0200 (CEST)
Received: by wwb18 with SMTP id 18so46986wwb.20
	for <alsa-devel@alsa-project.org>; Thu, 21 Oct 2010 14:16:01 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.1010211649160.29422@eeebox2.perex-int.cz>
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

Jaroslav,

Thank you for the quick reply.

On Thu, Oct 21, 2010 at 10:50 AM, Jaroslav Kysela <perex@perex.cz> wrote:

> On Thu, 21 Oct 2010, Adam Rosenberg wrote:
>
>  I would like to make sure that all programs that use the sound driver
>> I wrote are required to use 512 frames per period.  Is there a
>> snd_pcm_hw_constraint function that will allow me to do this?
>>
>
> Just use periods_min and period_max = 512 in the hw structure. But why this
> constraint? It's better to use different ways in the driver (timers, etc) to
> leave reasonable range of the configuration space.
>


I am trying to constrain the number of frames per period (not the number of
periods).  The DMA transfer creates an interrupt every 512 frames (1 frame =
16 channels with 32bits per channel) .  I am having a difficult time
understanding how to properly write the ALSA driver so that it will work
with many different formats and between 1 and 2 channels.  It seems as
though I have to call snd_pcm_period_elapsed everytime I get a DMA interrupt
to let the underlying code know that 512 frames have finished transferring.
If the application does not select 512 frames per period, the audio plays
too fast or too slow.  Here is my best guess at what the hardware settings
should be:

static struct snd_pcm_hardware ourCS42448PcmHw =
{
    .info = (SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER ),

    // Note: the CS42448 does not support 8 bit audio
    .formats = (SNDRV_PCM_FMTBIT_S32_LE | SNDRV_PCM_FMTBIT_S24_LE |
SNDRV_PCM_FMTBIT_S16_LE |
                SNDRV_PCM_FMTBIT_S32_BE | SNDRV_PCM_FMTBIT_S24_BE |
SNDRV_PCM_FMTBIT_S16_BE),

    // Sample rates supported
    // Note: this board has an ICS661 chip
    //       that is being configured in init
    //       so these values must match that setting
#if CONFIG_CS42448_SAMPLE_RATE == 44100
    .rates = SNDRV_PCM_RATE_44100,
    .rate_min = 44100,
    .rate_max = 44100,
#else // default to 48000
    .rates = SNDRV_PCM_RATE_48000,
    .rate_min = 48000,
    .rate_max = 48000,
#endif

    // the max number of bytes in one PCM stream
    // must allow for a minimum of 4 periods with
    // 512 frames per period and up to 2 channels of
    // 32 bit data per frame
    .buffer_bytes_max = 32768,  // this value allows 8 periods of the max
frame size

    // the number of channels in one PCM stream
    .channels_min = 1,
    .channels_max = 2,

    .period_bytes_max = 4096,
    .periods_min = 4,
    .period_bytes_min = 512,
    .periods_max = 64,
};

Is there some way that I can impose a constraint on the number of frames in
a period or is this the wrong solution to my problem?

Thanks,
Adam

Adam Rosenberg
Software Engineer

Alcorn McBride Inc.
3300 South Hiawassee
Building 105
Orlando, FL 32835

(407) 296 - 5800 ext. 5490
