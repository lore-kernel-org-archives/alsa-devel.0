From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [alsa-devel] [PATCH] ASoC: rockchip: i2s: add rockchip_dmaengine_pcm_config
Date: Fri, 09 Jan 2015 09:02:20 +0100
Message-ID: <54AF8B0C.2050301@metafoo.de>
References: <1420768369-6681-1-git-send-email-jay.xu@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1420768369-6681-1-git-send-email-jay.xu@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jianqun Xu <jay.xu@rock-chips.com>, lgirdwood@gmail.com, heiko@sntech.de, broonie@kernel.org, perex@perex.cz, tiwai@suse.de, sonnyrao@chromium.org
Cc: linux-rockchip@lists.infradead.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On 01/09/2015 02:52 AM, Jianqun Xu wrote:
> This patch makes snd_dmaengine_pcm_register with rockchip_dmaengine_pcm_config,
> which configure the parameters of period and buffer match to rockchip DMAC.
>
> =======================
> without rockchip_dmaengine_pcm_config, and test with command -
> aplay -D hw:0,0 /tmp/a, there are the error dump:
> [  134.899396] dma-pl330 ffb20000.dma-controller: fill_queue:2251 Bad Desc(7)
> [  134.906270] dma-pl330 ffb20000.dma-controller: fill_queue:2251 Bad Desc(8)
> [  134.913141] dma-pl330 ffb20000.dma-controller: fill_queue:2251 Bad Desc(9)
>
> And bellow sound from DMA debugger:
> "I debugged it a little and it looks like what is happening is that requests
> which aren't a multiple of burst size * burst length are coming in.  Right
> now the i2s block is setting a burst size of 4 and burst length of 4, but
> the dmaengine code has no idea about this restriction.  I was able to
> eliminate the messages by changing burst length to 1 in the i2s driver.
> This fix would always work as long as we're sending a multiple of 4 bytes
> (which so far seems to be the case)"
>
> This patch can make the length of dma buffer is aligned to a multiple of burst size
> and burst length.

No, all it does it sets the maximum size to something that is aligned, an 
application can still choose something else.

And this is the wrong approach anyway, we don't want to have new 
snd_pcm_hardware for drivers using generic dmaengine PCM driver.

The right approach is to modify the dmaengine PCM driver to set a constraint 
that makes sure that the period size is a multiple of the burst size.

- Lars
