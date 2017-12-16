From: Brian Norris <briannorris@chromium.org>
Subject: Re: [PATCH] ASoC: rockchip: Use dummy_dai for rt5514
	dsp dailink
Date: Fri, 15 Dec 2017 19:25:54 -0800
Message-ID: <20171216032552.GA220745@google.com>
References: <20171121082517.17233-1-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-io0-f196.google.com (mail-io0-f196.google.com
 [209.85.223.196])
 by alsa0.perex.cz (Postfix) with ESMTP id B53D2266B0F
 for <alsa-devel@alsa-project.org>; Sat, 16 Dec 2017 04:25:58 +0100 (CET)
Received: by mail-io0-f196.google.com with SMTP id o2so4615327ioe.8
 for <alsa-devel@alsa-project.org>; Fri, 15 Dec 2017 19:25:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20171121082517.17233-1-jeffy.chen@rock-chips.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: alsa-devel@alsa-project.org, Doug Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, linux-rockchip@lists.infradead.org, Mark Brown <broonie@kernel.org>, Enric Balletbo i Serra <enric.balletbo@collabora.com>, mka@chromium.org, linux-arm-kernel@lists.infradead.org, cychiang@google.com
List-Id: alsa-devel@alsa-project.org

Hi,

On Tue, Nov 21, 2017 at 04:25:17PM +0800, Jeffy Chen wrote:
> The rt5514 dsp captures pcm data through spi directly, so we should not
> use rockchip-i2s as it's cpu dai like other codecs.
> 
> Use dummy_dai for rt5514 dsp dailink to make voice wakeup work again.
> 
> Reported-by: Jimmy Cheng-Yi Chiang <cychiang@google.com>
> Fixes: (72cfb0f20c75 ASoC: rockchip: Use codec of_node and dai_name for rt5514 dsp)
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

I didn't review this closely (and I don't know ASoC that well), but this
does fix regressions I've seen on 4.15 RCs, where

(a) the rt5514 DAI link doesn't get set up
(b) the rt5514 *always* causes my device to wake up, because we arm the
    wakeup IRQ even though we never actually configured the DSP
(c) there are system crashes on resume because the rt5514-spi driver
    assumes that the DAI link was correctly configured (that's the
    subject of another patch I sent [1]

I believe this was working fine on 4.14? At least, I know (b) didn't
happen, and I'm not sure about (a). (c) is a new issue in 4.15-rc1.

Anyway, that's all to say:

Tested-by: Brian Norris <briannorris@chromium.org>

on the "kevin" Chromebook (Samsung Chromebook Plus).

I also suspect this might be regression-fixing material, for 4.15. Or if
not, at least something like patch [1] should be.

Thanks,
Brian

[1] https://patchwork.kernel.org/patch/10116761/
    [PATCH for-4.15] ASoC: rt5514: don't assume rt5514 component was "attached"
