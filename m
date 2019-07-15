From: Tzung-Bi Shih <tzungbi@google.com>
Subject: Re: [PATCH v3 1/5] ASoC: hdmi-codec: Add an op to set callback
 function for plug event
Date: Mon, 15 Jul 2019 23:56:19 +0800
Message-ID: <CA+Px+wWbmUemETY3OMk1T9XS2w8ZXvZUhVEGzw_w6AxtU8R0rw@mail.gmail.com>
References: <20190712100443.221322-1-cychiang@chromium.org>
 <20190712100443.221322-2-cychiang@chromium.org>
 <20190712105745.xr7jxc626lwoaajx@shell.armlinux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190712105745.xr7jxc626lwoaajx@shell.armlinux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: ALSA development <alsa-devel@alsa-project.org>, tzungbi@chromium.org, Heiko Stuebner <heiko@sntech.de>, Liam Girdwood <lgirdwood@gmail.com>, David Airlie <airlied@linux.ie>, Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>, Douglas Anderson <dianders@chromium.org>, dri-devel@lists.freedesktop.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Hans Verkuil <hverkuil@xs4all.nl>, linux-rockchip@lists.infradead.org, Andrzej Hajda <a.hajda@samsung.com>, Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, Daniel Vetter <daniel@ffwll.ch>, dgreid@chromium.org, Jaroslav Kysela <perex@perex.cz>, linux-arm-kernel@lists.infradead.org, Cheng-Yi Chiang <cychiang@chromium.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jul 12, 2019 at 6:58 PM Russell King - ARM Linux admin
<linux@armlinux.org.uk> wrote:
>
> On Fri, Jul 12, 2019 at 06:04:39PM +0800, Cheng-Yi Chiang wrote:
> > Add an op in hdmi_codec_ops so codec driver can register callback
> > function to handle plug event.
> >
> > Driver in DRM can use this callback function to report connector status.
> >
> > Signed-off-by: Cheng-Yi Chiang <cychiang@chromium.org>
> > ---
> >  include/sound/hdmi-codec.h    | 16 +++++++++++++
> >  sound/soc/codecs/hdmi-codec.c | 45 +++++++++++++++++++++++++++++++++++
> >  2 files changed, 61 insertions(+)
> >
> > diff --git a/include/sound/hdmi-codec.h b/include/sound/hdmi-codec.h
> > index 7fea496f1f34..9a8661680256 100644
> > --- a/include/sound/hdmi-codec.h
> > +++ b/include/sound/hdmi-codec.h
> > @@ -47,6 +47,9 @@ struct hdmi_codec_params {
> >       int channels;
> >  };
> >
> > +typedef void (*hdmi_codec_plugged_cb)(struct device *dev,
> > +                                   bool plugged);
> > +
>
> I'd like to pose a question for people to think about.
>
> Firstly, typedefs are generally shunned in the kernel.  However, for
> these cases it seems to make sense.
>
> However, should the "pointer"-ness be part of the typedef or not?  To
> see what I mean, consider:
>
>         typedef void (*hdmi_foo)(void);
>
>         int register_foo(hdmi_foo foo);
>
> vs
>
>         typedef void hdmi_foo(void);
>
>         int register_foo(hdmi_foo *foo);
>
> which is more in keeping with how we code non-typedef'd code - it's
> obvious that foo is a pointer while reading the code.
I have a different opinion.  Its suffix "_cb" self-described it is a
callback function.  Since function and function pointer are equivalent
in the language, I think we don't need to emphasize that it is a
function "pointer".


> It seems to me that the latter better matches what is in the kernel's
> coding style, which states:
>
>   In general, a pointer, or a struct that has elements that can
>   reasonably be directly accessed should **never** be a typedef.
>
> or maybe Documentation/process/coding-style.rst needs updating?
