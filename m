From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [alsa-devel] [PATCH] ASoC: rockchip: add missing INTERLEAVED PCM
 attribute
Date: Wed, 24 Apr 2019 15:45:36 +0200
Message-ID: <20190424134536.GA20271@kroah.com>
References: <20180910163932.13722-1-katsuhiro@katsuster.net>
 <CAD=FV=WKV3eLsg3mWpmCWYjvk2JY4_Q-20v1Ohzy=02+LjpPnw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAD=FV=WKV3eLsg3mWpmCWYjvk2JY4_Q-20v1Ohzy=02+LjpPnw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Anderson <dianders@chromium.org>
Cc: stable@vger.kernel.org, Katsuhiro Suzuki <katsuhiro@katsuster.net>, LKML <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Heiko Stuebner <heiko@sntech.de>, Mark Brown <broonie@kernel.org>, Urja Rannikko <urjaman@gmail.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Apr 23, 2019 at 03:26:42PM -0700, Doug Anderson wrote:
> Hi,
> 
> On Sep 10, 2018 at 4:39 PM Katsuhiro Suzuki <katsuhiro@katsuster.net> wrote:
> >
> > This patch adds SNDRV_PCM_INFO_INTERLEAVED into PCM hardware info.
> >
> > Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> > ---
> >  sound/soc/rockchip/rockchip_pcm.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> I just tracked down that audio was broken on 4.19 and needs this
> change to work.  Stable: can you please pick it?  Specifically I
> believe you'd want to treat it as if it had:
> 
> Fixes: 75b31192fe6a ("ASoC: rockchip: add config for rockchip
> dmaengine pcm register")

What is the git commit id of this patch in Linus's tree?

thanks,

greg k-h
