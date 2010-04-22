From: Stefan Schoenleitner <dev.c0debabe@gmail.com>
Subject: Re: "Resource temporarily unavailable" while reading
 although poll returns POLLIN event
Date: Thu, 22 Apr 2010 12:49:49 +0200
Message-ID: <4BD029CD.6030200@gmail.com>
References: <4BCEE140.5060704@gmail.com> <4BCF24AC.3000301@gmail.com>
	<y2n4f3252891004212128x22c1be90pd22a4fa58a31a57c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from keymachine.tbmn.org (mail.tbmn.org [87.118.84.39])
	by alsa0.perex.cz (Postfix) with ESMTP id 8E88210383C
	for <alsa-devel@alsa-project.org>;
	Thu, 22 Apr 2010 12:49:50 +0200 (CEST)
In-Reply-To: <y2n4f3252891004212128x22c1be90pd22a4fa58a31a57c@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Raymond Yau <superquad.vortex2@gmail.com>
Cc: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Raymond Yau wrote:
> your program expect the driver support 2 periods per buffer but does not
> expicitly set the period
> 
> 8000 Hz , S16_LE and mono

I am not sure why you think this is the case.

The period size is set at line 170 with snd_pcm_hw_params_set_period_size().

I'm setting up the sampling rate of 8000Hz in setup_pcm() starting at line 111.
I either use snd_pcm_hw_params_set_rate_near() or snd_pcm_hw_params_set_rate(),
depending on whether the PCM supports the exact rate or not.

I set up the audio format SND_PCM_FORMAT_S16_LE at line 76 with
snd_pcm_hw_params_set_format().

And finally, I also set up the number of channels (mono) in line 85 with
snd_pcm_hw_params_set_channels().


Last but not least, snd_pcm_dump() shows that exactly these settings are actively used:

------------------------------------------------------------------------
ALSA <-> PulseAudio PCM I/O Plugin
Its setup is:
  stream       : CAPTURE
  [...]
  format       : S16_LE
  [...]
  channels     : 1
  rate         : 8000
  exact rate   : 8000 (8000/1)
  [...]
  period_size  : 160
  [...]
  avail_min    : 160
------------------------------------------------------------------------

In the above output you can see that the format, number of channels, rate, period size and
avail_min are indeed set to correct values.
 

>>> I verified that avail_min is 160 frames
> 
> is there any specific reason to choose 160 frames ?

Yes there is: 

The audio frames are used for processing by a DSP lateron, which
requires each speech packet (i.e. period) to have exactly 160 frames.
It is also required that the audio frames are in S16_LE format,
they have a sampling rate of 8kHz and they arrive at the
DSP each 20ms (which corresponds to period_time).


As my code will use the atmel-pcm on an embedded target, the above mentioned
constraints should be no problem.

In fact a look at the PCM in the alsa kernel sources (sound/soc/atmel/atmel-pcm.c) reveals:
------------------------------------------------------------------------
static const struct snd_pcm_hardware atmel_pcm_hardware = {
    .info           = SNDRV_PCM_INFO_MMAP |
                  SNDRV_PCM_INFO_MMAP_VALID |
                  SNDRV_PCM_INFO_INTERLEAVED |
                  SNDRV_PCM_INFO_PAUSE,
    .formats        = SNDRV_PCM_FMTBIT_S16_LE,
    .period_bytes_min   = 32,
    .period_bytes_max   = 8192,
    .periods_min        = 2,
    .periods_max        = 1024,
    .buffer_bytes_max   = 32 * 1024,
};
------------------------------------------------------------------------



However, as development on a slow ARM target can be a real pain, I am developing
the code *on a PC* which is why the poll() behavior really is an issue
(and maybe even a bug in alsa but more likely in pulseaudio).

As soon as the code is working, it will be easy to port it the ARM target.

cheers,
stefan
