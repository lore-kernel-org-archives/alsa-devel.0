From: Cheng-yi Chiang <cychiang@chromium.org>
Subject: Re: [alsa-devel] [PATCH 2/4] drm: bridge: dw-hdmi: Report connector
 status using callback
Date: Sat, 6 Jul 2019 18:17:54 +0800
Message-ID: <CAFv8NwKhBKaDAzfdRVGzOs0M3quZeZANWQ2EDo210jy9M-c0cQ@mail.gmail.com>
References: <20190705042623.129541-1-cychiang@chromium.org>
 <20190705042623.129541-3-cychiang@chromium.org> <VI1PR06MB41425D1F24AC653F08AFA463ACF50@VI1PR06MB4142.eurprd06.prod.outlook.com>
 <CAFv8NwJXbJo=z_NDj+JQHD9LOmnbfM8v_N1uHn4sdBzF-FZQfA@mail.gmail.com> <20190705171618.GA35842@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190705171618.GA35842@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Jonas Karlman <jonas@kwiboo.se>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "tzungbi@chromium.org" <tzungbi@chromium.org>, Heiko Stuebner <heiko@sntech.de>, Liam Girdwood <lgirdwood@gmail.com>, David Airlie <airlied@linux.ie>, Takashi Iwai <tiwai@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "dianders@chromium.org" <dianders@chromium.org>, Hans Verkuil <hverkuil@xs4all.nl>, "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>, Russell King <rmk+kernel@armlinux.org.uk>, Andrzej Hajda <a.hajda@samsung.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Daniel Vetter <daniel@ffwll.ch>, "dgreid@chromium.org" <dgreid@chr>
List-Id: alsa-devel@alsa-project.org

On Sat, Jul 6, 2019 at 1:16 AM Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Jul 05, 2019 at 03:31:24PM +0800, Cheng-yi Chiang wrote:
>
> > It was a long discussion.
> > I think the conclusion was that if we are only talking about
> > hdmi-codec, then we just need to extend the ops exposed in hdmi-codec
> > and don't need to use
> > hdmi-notifier or drm_audio_component.
>
> What I'd picked up from the bits of that discussion that I
> followed was that there was some desire to come up with a unified
> approach to ELD notification rather than having to go through
> this discussion repeatedly?  That would certianly seem more
> sensible.  Admittedly it was a long thread with lots of enormous
> mails so I didn't follow the whole thing.

Hi Mark, thanks for following the long thread.
The end of the discussion was at
https://lkml.org/lkml/2019/6/20/1397

Quoted from Daniel's suggestion:
"
I need to think about this more, but if all we need to look at is
hdmi_codec, then I think this becomes a lot easier. And we can ignore
drm_audio_component.h completely.
"

My thought is that the codec driver under ASoC are only these two:
hdac_hdmi.c and hdmi-codec.c  ( forgive me if I missed others. I just
grep "hdmi" under sound/soc/codecs/ )
hdac_hdmi.c is like a wrapper for HDA and drm_audio_components.
hdmi-codec.c is the only other codec driver that cares HDMI under ASoC.
So adding the jack/eld support at hdmi-codec driver can cover the
existing use cases for HDMI codec driver in ASoC.
That said, adding a new unified approach for Jack/ELD notification
that will only be used by hdmi-codec seems not a high priority.
Hope this explanation helps your decision.
Thanks!
