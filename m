From: Appalayagari Sreedhar <sreecha01@gmail.com>
Subject: Re: alsa driver playback using aplay fails
Date: Thu, 8 Sep 2011 14:24:42 +0530
Message-ID: <CAODvfaFgAT9fuSjM12=XMHsBGusHqyN2=eSLyWx=gZaE-n+4ZQ@mail.gmail.com>
References: <CAODvfaGKcr-2Ray6PxQqU_Sr-wFwqVZx6mo8_ZZsdmY98jkSEw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 37C5710390A
	for <alsa-devel@alsa-project.org>;
	Thu,  8 Sep 2011 10:54:44 +0200 (CEST)
Received: by ywt32 with SMTP id 32so455504ywt.38
	for <alsa-devel@alsa-project.org>; Thu, 08 Sep 2011 01:54:43 -0700 (PDT)
In-Reply-To: <CAODvfaGKcr-2Ray6PxQqU_Sr-wFwqVZx6mo8_ZZsdmY98jkSEw@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Hi,

Can anyone give me the alsa aplay source code.

-Sreedhar.

On 9/7/11, Appalayagari Sreedhar <sreecha01@gmail.com> wrote:
> Hi,
>
> I have integrated the cx2070x codec driver which is in ALSA model.
> I am trying to test the codec driver using the aplay command.
>
> in my code CPU is the master and codec is the slave.
>
> The Audio format which i used is :
>
> #define AUDIO_FORMAT (SND_SOC_DAIFMT_I2S | \
>                 SND_SOC_DAIFMT_CBS_CFS | SND_SOC_DAIFMT_IB_NF)
>
> when i run the aplay command.
>
> aplay Front_Center.wav
>
> the codec driver is opening and shutting down.
> please find the log. the CPU is TI processsor.
>
>  davinci_i2s_startup
>  davinci_i2s_startup
>  snd_soc_set_runtime_hwparams
> asoc: cx2070x <-> davinci-mcbsp info:
> asoc: rate mask 0x6fe
> asoc: min ch 2 max ch 2
> asoc: min rate 8000 max rate 96000
> Playing WAVE 'Front_Center.wav' : Signed 16 bit Little Endian, Rate
> 48000 Hz, Mono
>  soc_pcm_hw_params
>  davinci_i2s_set_dai_fmt
>  davinci_i2s_set_dai_fmt
>  cx2070x_hw_params
> 4294941454: cx2070x_hw_params() called
> format:2 speed:48000
>  davinci_i2s_hw_params
>  soc_pcm_prepare
>  davinci_i2s_prepare
>  davinci_mcbsp_stop
>  davinci_mcbsp_stop
>  davinci_i2s_prepare
>  soc_pcm_trigger
>  davinci_i2s_trigger
>  davinci_i2s_trigger
>  soc_pcm_trigger
>  davinci_i2s_trigger
>  davinci_mcbsp_stop
>  davinci_mcbsp_stop
>  davinci_i2s_trigger
>  soc_pcm_hw_free
>  soc_pcm_hw_free
>  soc_codec_close
>  davinci_i2s_shutdown
>  davinci_mcbsp_stop
>  davinci_mcbsp_stop
>  davinci_i2s_shutdown
> # pop wq checking: Playback status: inactive waiting: yes
>
> Could you please tell me where i am doing wrong?
>
> Thank you,
> Sreedhar.
>
