From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: [PATCH 23/25] ALSA/dummy: Replace tasklet with softirq hrtimer
Date: Mon, 4 Sep 2017 21:45:32 +0900
Message-ID: <78c75ba0-a061-e7b0-dafb-c611d79f433f@sakamocchi.jp>
References: <s5hh8wnvjei.wl-tiwai@suse.de>
 <20170901102537.8066-1-o-takashi@sakamocchi.jp>
 <s5hbmmutytt.wl-tiwai@suse.de>
 <19775981-a3f2-5f65-e934-bfe25db62a43@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <19775981-a3f2-5f65-e934-bfe25db62a43@sakamocchi.jp>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, keescook@chromium.org, peterz@infradead.org, linux-kernel@vger.kernel.org, mingo@redhat.com, john.stultz@linaro.org, tglx@linutronix.de, hch@lst.org, anna-maria@linutronix.de
List-Id: alsa-devel@alsa-project.org

Hi,

On Sep 2 2017 10:19, Takashi Sakamoto wrote:
> Well, in sound subsystem, there're a few drivers which uses hrtimer:
>   - snd-pcsp
>   - snd-sh-dac-audio
>   - snd-soc-imx-pcm-fiq
> 
> As a quick glance, 'snd-sh-dac-audio' includes the same bug, too. 
> Additionally, 'snd-soc-imx-pcm-fiq' maintains hrtimer with loose manner 
> in a point of state of PCM substream and it shall gain the same bug if 
> improved. Later, I posted some patches for them.

After reading code thoroughly, I conclude that no need to fix these two
drivers. They're programmed with own protections. The former
(snd-sh-dac-audio) has 'struct snd_sh_dac.empty' and the latter
(snd-soc-imx-pcm-fiq) has 'struct imx_pcm_runtime_data.playing' and
'.capturing', to avoid cancellation of hrtimer on hrtimer callback.

These ways are not necessarily efficient but actually have no trouble.
I leave them as is.


Regards

Takashi Sakamoto
