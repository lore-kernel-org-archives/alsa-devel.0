From: Cheng-yi Chiang <cychiang@chromium.org>
Subject: Re: [PATCH v3 1/5] ASoC: hdmi-codec: Add an op to set callback
 function for plug event
Date: Tue, 16 Jul 2019 15:59:36 +0800
Message-ID: <CAFv8NwKwd8Yf4UmqUhcaP1pL2K_d_FSZm9JyY_Azy13017RWgg@mail.gmail.com>
References: <20190712100443.221322-1-cychiang@chromium.org>
 <20190712100443.221322-2-cychiang@chromium.org> <20190712105745.xr7jxc626lwoaajx@shell.armlinux.org.uk>
 <CA+Px+wWbmUemETY3OMk1T9XS2w8ZXvZUhVEGzw_w6AxtU8R0rw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CA+Px+wWbmUemETY3OMk1T9XS2w8ZXvZUhVEGzw_w6AxtU8R0rw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Tzung-Bi Shih <tzungbi@google.com>
Cc: Russell King - ARM Linux admin <linux@armlinux.org.uk>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ALSA development <alsa-devel@alsa-project.org>, Douglas Anderson <dianders@chromium.org>, Heiko Stuebner <heiko@sntech.de>, linux-rockchip@lists.infradead.org, David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, tzungbi@chromium.org, Jaroslav Kysela <perex@perex.cz>, Hans Verkuil <hverkuil@xs4all.nl>, Andrzej Hajda <a.hajda@samsung.com>, Mark Brown <broonie@kernel.org>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Daniel Vetter <daniel@ffwll.ch>, Dylan Reid <dgreid@chromium.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jul 15, 2019 at 11:56 PM Tzung-Bi Shih <tzungbi@google.com> wrote:
>
> On Fri, Jul 12, 2019 at 6:58 PM Russell King - ARM Linux admin
> <linux@armlinux.org.uk> wrote:
> >
> > On Fri, Jul 12, 2019 at 06:04:39PM +0800, Cheng-Yi Chiang wrote:
> > > Add an op in hdmi_codec_ops so codec driver can register callback
> > > function to handle plug event.
> > >
> > > Driver in DRM can use this callback function to report connector status.
> > >
> > > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > > ---
> > >  include/sound/hdmi-codec.h    | 16 +++++++++++++
> > >  sound/soc/codecs/hdmi-codec.c | 45 +++++++++++++++++++++++++++++++++++
> > >  2 files changed, 61 insertions(+)
> > >
> > > diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
> > > index 7fea496f1f34..9a8661680256 100644
> > > --- a/include/sound/hdmi-codec.h
> > > +++ b/include/sound/hdmi-codec.h
> > > @@ -47,6 +47,9 @@ struct hdmi_codec_params {
> > >       int channels;
> > >  };
> > >
> > > +typedef void (*hdmi_codec_plugged_cb)(struct device *dev,
> > > +                                   bool plugged);
> > > +
> >
> > I'd like to pose a question for people to think about.
> >
> > Firstly, typedefs are generally shunned in the kernel.  However, for
> > these cases it seems to make sense.
> >
> > However, should the "pointer"-ness be part of the typedef or not?  To
> > see what I mean, consider:
> >
> >         typedef void (*hdmi_foo)(void);
> >
> >         int register_foo(hdmi_foo foo);
> >
> > vs
> >
> >         typedef void hdmi_foo(void);
> >
> >         int register_foo(hdmi_foo *foo);
> >
> > which is more in keeping with how we code non-typedef'd code - it's
> > obvious that foo is a pointer while reading the code.
> I have a different opinion.  Its suffix "_cb" self-described it is a
> callback function.  Since function and function pointer are equivalent
> in the language, I think we don't need to emphasize that it is a
> function "pointer".
>
>

Hi Russell and Tzungbi, thank you for the review.
Regarding this typedef of callback function, I found a thread
discussing this very long time ago:

https://yarchive.net/comp/linux/typedefs.html

>From that thread, Linus gave an example of using typedef for function
pointer that is following to this pattern.
I also looked around how other driver use it:
$ git grep typedef | grep _cb | less | wc -l
138
$ git grep typedef | grep _cb | grep "(\*" | wc -l
115
Most of the typedef of callback function use this pattern.
So I think this should be fine.
Thanks!


> > It seems to me that the latter better matches what is in the kernel's
> > coding style, which states:
> >
> >   In general, a pointer, or a struct that has elements that can
> >   reasonably be directly accessed should **never** be a typedef.
> >
> > or maybe Documentation/process/coding-style.rst needs updating?
