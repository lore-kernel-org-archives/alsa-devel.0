From: Cheng-yi Chiang <cychiang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH 1/7] video: add HDMI state notifier support
Date: Fri, 21 Jun 2019 17:39:43 +0800
Message-ID: <CAFv8Nw+m-+pshD_cxKe4Nc_4wP3ttpAfDU7EFb-e+ZBcYNA51Q__21281.3895706617$1561111576$gmane$org@mail.gmail.com>
References: <20190603080931.GG21222@phenom.ffwll.local>
 <CAFv8Nw+1sB8i1d87vLeKxRricZOi4gnXFSgOzW9k0sa_Tzybjg@mail.gmail.com>
 <20190604072411.GP21222@phenom.ffwll.local>
 <CAFv8NwKL9ZL=gNpDmdRV+R9eq22+Da_1kzuYBv8kMMyV3Hq14g@mail.gmail.com>
 <20190611123455.GD2458@phenom.ffwll.local>
 <CAFv8NwJxs-R=ehgeqyx=e+T5OmUBsk3uWnUb2t0cC-LDPS7G5w@mail.gmail.com>
 <20190618121220.GU12905@phenom.ffwll.local>
 <CAFv8NwLci2ALi3V-e=8jjatciHWOoOj-FeajwNLWRpWRtqgBdg@mail.gmail.com>
 <20190620092506.GP12905@phenom.ffwll.local>
 <CAFv8NwLbS_f4cfeorzqtmRzQSY0u1tgM7fitAokg_QfViPvq=Q@mail.gmail.com>
 <20190620211204.GW12905@phenom.ffwll.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
In-Reply-To: <20190620211204.GW12905-dv86pmgwkMBes7Z6vYuT8azUEOm+Xw19@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rockchip/>
List-Post: <mailto:linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rockchip>,
 <mailto:linux-rockchip-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "Linux-rockchip" <linux-rockchip-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rockchip-bounces+glpar-linux-rockchip=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: Cheng-yi Chiang <cychiang-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Hans Verkuil <hverkuil-qWit8jRvyhVmR6Xm/wNWPw@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Greg Kroah-Hartman <gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Takashi Iwai <tiwai-IBi9RG/b67k@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Russell King <rmk+kernel-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org>, Andrzej Hajda <a.hajda-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Laurent Pinchart <Laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org>, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Dylan Reid <dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, tzungbi-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, linux-media-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "moderated list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, dri-devel-PD4FTy7X32k@public.gmane.org
Cc: Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Fri, Jun 21, 2019 at 5:12 AM Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org> wrote:
>
> Massively cutting this thread, since halfway through in my previous reply
> I realized that maybe hdmi_codec is a much better starting point.
>
ACK
> On Thu, Jun 20, 2019 at 09:23:23PM +0800, Cheng-yi Chiang wrote:
> > On Thu, Jun 20, 2019 at 5:25 PM Daniel Vetter <daniel-/w4YWyX8dFk@public.gmane.org> wrote:
> > > Yeah fully agreeing that hdmi_audio_code is probably a better starting
> > > point. Problem is that becuase hdmi_codec is built on top of platform
> > > device it's quite a bit harder to extend with callbacks and things like
> > > that, without breaking the driver model.
> > >
> > > I need to think about this more, but if all we need to look at is
> > > hdmi_codec, then I think this becomes a lot easier. And we can ignore
> > > drm_audio_component.h completely.
> >
> >
> > It is surprising that you think this way.
> > Maybe the original patch before hdmi-notifier was introduced is the
> > better way to solve this issue, if we only need to look at hdmi_codec.
> >
> > The history of hdmi_codec driver is in this patch series:
> >
> > https://lore.kernel.org/patchwork/patch/539656/
>
> Hm, this doesn't seem to be the hdmi_codec driver I meant, but another,
> new one. I was talking about SND_SOC_HDMI_CODEC.
>
Yes you are right. They are different codec drivers.
Sorry for the confusion. What I meant was that my use case on RK3288
was using dw-hdmi-audio.c codec driver,
which was later replaced by a more general version hdmi-codec.c.

> > There was a callback mechanism implemented between dw-hdmi and hdmi
> > codec driver.
> > It was later consolidated by Doug in this patch for better jack status
> > reporting:
> >
> > https://chromium-review.googlesource.com/c/chromiumos/third_party/kernel/+/303573/
>
> Hm that still seems entirely separate hdmi-codec specific to dw-hdmi only
> ...
>
Again you are right. Sorry for the confusion. What I meant is that
this callback mechanism should work on hdmi-codec.c driver as well.

> > I am not sure why the original patch series did not get fully accepted
> > in the upstream.
> > It was quite long time ago.
> >
> > But if you think this might be the right way to do, then it is even
> > better for us because the patch series and Doug's patch had been quite
> > stable
> > on our RK3288 products for about four years with plenty of users, so
> > we have much higher confidence in them.
> > I can rebase and clean up them and post another patch for review.
> >
> > Please let me know what approach you feel is better.
> > Thanks again!
>
> Not sure we're talking about the same. What I had in mind is to add jack
> status to the hdmi-codec.c stuff, which is used by multiple soc drm
> display drivers already. Looking at git grep output, there seems to be
> already some support for dw-hdmi synopsys drm_bridge driver. I thought of
> extending that. Does that not work for you?
>
I think extending current interface will work.
There is a struct hdmi_codec_pdata to let ALSA codec driver access
some ops through platform data.
And after this patch

https://lore.kernel.org/patchwork/patch/692324/

ALSA codec driver can get access to the struct on DRM side.
Based on this I can add a new ops to register callback function for jack status.
It will be similar to Doug's chromium patch above.
I think that is quite a feasible way, and can benefit all boards using
hdmi-codec.c.

Thanks a lot!!

> Thanks, Daniel
> --
> Daniel Vetter
> Software Engineer, Intel Corporation
> http://blog.ffwll.ch
