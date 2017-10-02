From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] ASoC: rockchip: Fix wrong allocation size of dapm routes
Date: Mon, 2 Oct 2017 08:14:50 -0700
Message-ID: <CAD=FV=V+sVf8E_ka1u5kDBKWS6MY3vMpaVgmjDV1CnVSOkQ3AA@mail.gmail.com>
References: <20170929035252.19808-1-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170929035252.19808-1-jeffy.chen@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeffy Chen <jeffy.chen@rock-chips.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jaroslav Kysela <perex@perex.cz>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Heiko Stuebner <heiko@sntech.de>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi,

On Thu, Sep 28, 2017 at 8:52 PM, Jeffy Chen <jeffy.chen@rock-chips.com> wrote:
> The allocation size of dapm routes is wrong, correct it.
>
> Fixes: d9f9c167edae ("ASoC: rockchip: Init dapm routes dynamically")
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> ---
>
>  sound/soc/rockchip/rk3399_gru_sound.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)

I guess Jeffy and I found this independently.  In
http://crosreview.com/693319 Jeffy indicated that he thought my patch
could land, so I guess drop his and take mine from
<https://patchwork.kernel.org/patch/9978763/>?

Thanks!

-Doug
