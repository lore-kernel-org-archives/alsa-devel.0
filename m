From: Doug Anderson <dianders@chromium.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: rockchip: add missing INTERLEAVED PCM attribute
Date: Tue, 23 Apr 2019 15:26:42 -0700
Message-ID: <CAD=FV=WKV3eLsg3mWpmCWYjvk2JY4_Q-20v1Ohzy=02+LjpPnw@mail.gmail.com>
References: <20180910163932.13722-1-katsuhiro@katsuster.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20180910163932.13722-1-katsuhiro@katsuster.net>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: Katsuhiro Suzuki <katsuhiro@katsuster.net>, LKML <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Heiko Stuebner <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Urja Rannikko <urjaman@gmail.com>
List-Id: alsa-devel@alsa-project.org

Hi,

On Sep 10, 2018 at 4:39 PM Katsuhiro Suzuki <katsuhiro@katsuster.net> wrote:
>
> This patch adds SNDRV_PCM_INFO_INTERLEAVED into PCM hardware info.
>
> Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> ---
>  sound/soc/rockchip/rockchip_pcm.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

I just tracked down that audio was broken on 4.19 and needs this
change to work.  Stable: can you please pick it?  Specifically I
believe you'd want to treat it as if it had:

Fixes: 75b31192fe6a ("ASoC: rockchip: add config for rockchip
dmaengine pcm register")


-Doug
