From: Cheng-yi Chiang <cychiang@chromium.org>
Subject: Re: [PATCH 1/4] ASoC: hdmi-codec: Add an op to set callback function
 for plug event
Date: Tue, 9 Jul 2019 19:58:56 +0800
Message-ID: <CAFv8NwJHpY+ptc+WbeRhsKB8wGnt08r38GG7WUYTrt=wZaGqqA@mail.gmail.com>
References: <20190705042623.129541-1-cychiang@chromium.org>
 <20190705042623.129541-2-cychiang@chromium.org> <CA+Px+wXtmf9dQQP7ywPLp7Qbbvqau=WnO3qhZ8+qmbJD1gjx+A@mail.gmail.com>
 <20190705121240.GA20625@sirena.org.uk> <CAFv8NwLP-hUBW8FZW5kooaggeNRG7LAEd2pd_-70YBrVMY-+CQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAFv8NwLP-hUBW8FZW5kooaggeNRG7LAEd2pd_-70YBrVMY-+CQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: Tzung-Bi Shih <tzungbi@google.com>, linux-kernel <linux-kernel@vger.kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>, Russell King <rmk+kernel@armlinux.org.uk>, Andrzej Hajda <a.hajda@samsung.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, Heiko Stuebner <heiko@sntech.de>, Doug Anderson <dianders@chromium.org>, Dylan Reid <dgreid@chromium.org>, tzungbi@chromium.org, ALSA development <alsa-devel@alsa-project.org>, dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 8, 2019 at 1:03 PM Cheng-yi Chiang <cychiang@chromium.org> wrote:
>
> On Fri, Jul 5, 2019 at 8:12 PM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Fri, Jul 05, 2019 at 03:08:37PM +0800, Tzung-Bi Shih wrote:
> > > On Fri, Jul 5, 2019 at 12:26 PM Cheng-Yi Chiang <cychiang@chromium.org> wrote:
> >
> > > > +typedef void (*hdmi_codec_plugged_cb)(struct platform_device *dev,
> > > > +                                     bool plugged);
> > > > +
> >
> > > The callback prototype is "weird" by struct platform_device.  Is it
> > > possible to having snd_soc_component instead of platform_device?
> >
> > Or if it's got to be a device why not just a generic device so
> > we're not tied to a particular bus here?
>
> My intention was to invoke the call in dw-hdmi.c like this:
>
>     hdmi->plugged_cb(hdmi->audio,
>                                    result == connector_status_connected);
>
> Here hdmi->audio is a platform_device.
> I think dw-hdmi can not get  snd_soc_component easily.
> I can use a generic device here so the ops is more general.
> The calling will be like
>     hdmi->plugged_cb(&hdmi->audio->dev,
>                                    result == connector_status_connected);
> I will update this in v2.
> Thanks!

I have thought about this a bit more. And I think the more proper
interface is to pass in a generic struct device* for codec.
This way, the user of hdmi-codec driver on the DRM side is not limited
to the relation chain of
audio platform device -> codec platform device, which is just a
special case in dw-hdmi driver.
As long as DRM side can get hdmi-codec device pointer through
drv_data, it can use this callback.
Hope this makes the interface more generic.
