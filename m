From: Heiko Stuebner <heiko@sntech.de>
Subject: Re: [alsa-devel] [PATCH] ASoC: rockchip: add missing INTERLEAVED PCM attribute
Date: Wed, 24 Apr 2019 15:53:54 +0200
Message-ID: <2153141.WrWJEDd2yy@phil>
References: <20180910163932.13722-1-katsuhiro@katsuster.net> <CAD=FV=WKV3eLsg3mWpmCWYjvk2JY4_Q-20v1Ohzy=02+LjpPnw@mail.gmail.com> <20190424134536.GA20271@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190424134536.GA20271@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Doug Anderson <dianders@chromium.org>, stable@vger.kernel.org, Katsuhiro Suzuki <katsuhiro@katsuster.net>, LKML <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>, ALSA Development Mailing List <alsa-devel@alsa-project.org>, Mark Brown <broonie@kernel.org>, Urja Rannikko <urjaman@gmail.com>
List-Id: alsa-devel@alsa-project.org

Am Mittwoch, 24. April 2019, 15:45:36 CEST schrieb Greg KH:
> On Tue, Apr 23, 2019 at 03:26:42PM -0700, Doug Anderson wrote:
> > Hi,
> > 
> > On Sep 10, 2018 at 4:39 PM Katsuhiro Suzuki <katsuhiro@katsuster.net> wrote:
> > >
> > > This patch adds SNDRV_PCM_INFO_INTERLEAVED into PCM hardware info.
> > >
> > > Signed-off-by: Katsuhiro Suzuki <katsuhiro@katsuster.net>
> > > ---
> > >  sound/soc/rockchip/rockchip_pcm.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > I just tracked down that audio was broken on 4.19 and needs this
> > change to work.  Stable: can you please pick it?  Specifically I
> > believe you'd want to treat it as if it had:
> > 
> > Fixes: 75b31192fe6a ("ASoC: rockchip: add config for rockchip
> > dmaengine pcm register")
> 
> What is the git commit id of this patch in Linus's tree?

Commit id is 24d6638302b48328a58c13439276d4531af4ca7d [0]

[0] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=24d6638302b48328a58c13439276d4531af4ca7d
