From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH for-4.11] ASoC: don't dereference NULL pcm_{new,free}
Date: Fri, 10 Mar 2017 16:39:39 -0800
Message-ID: <20170311003939.GB4586@google.com>
References: <20170308231854.50167-1-briannorris@chromium.org>
 <87zigvz4q3.wl%kuninori.morimoto.gx@renesas.com>
 <20170309002129.GA99773@google.com>
 <87varjz31k.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87varjz31k.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi Kuninori,

On Thu, Mar 09, 2017 at 12:53:50AM +0000, Kuninori Morimoto wrote:
> > All I know is that I'm definitely hitting a NULL
> > platform->driver->pcm_new callback, and that either reverting your patch
> > or applying the patch I just sent fixes it.
> 
> I want to know why this happen.
> Can you show me which driver is calling snd_soc_add_platform() in your case ?

There are 4 drivers calling that:

  snd_soc_dummy_probe
  rt5514_spi_probe
  2 instances of snd_dmaengine_pcm_register, via rockchip_i2s_probe

Only the latter two seem to run the assignment here:

	if (platform_drv->pcm_new)
		platform->component.pcm_new = snd_soc_platform_drv_pcm_new;

Both snd_soc_dummy_probe and rt5514_spi_probe find ->pcm_new NULL here.

I'm running with the sound/soc/rockchip/rk3399_gru_sound.c platform
driver. If it helps, I'm using the DT posted at [1]. IIUC, the "RT5514
DSP" link is trying to link up a "snd-soc-dummy" instance.

I'm fairly thoroughly confused. Any better ideas?

Brian

[1] https://www.spinics.net/lists/arm-kernel/msg561964.html
    [PATCH v2 4/6] arm64: dts: rockchip: add Gru/Kevin DTS
