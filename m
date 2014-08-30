From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH 0/2] rockchip-i2s: add power setting for I2S controller and fix some critical bugs
Date: Sat, 30 Aug 2014 20:55:12 +0200
Message-ID: <2985541.F8SvxX1thq@diego>
References: <1409350027-17604-1-git-send-email-jay.xu@rock-chips.com> <CAD=FV=XPYkDJ2J3rTHZgKzbH_EMBUmCMwHWjpf1Aagnv_mUqGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAD=FV=XPYkDJ2J3rTHZgKzbH_EMBUmCMwHWjpf1Aagnv_mUqGQ-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: Jianqun <jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, yongjun_wei-zrsr2BFq86L20UzCJQGyNP8+0UxHXcjY@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

Am Freitag, 29. August 2014, 21:30:43 schrieb Doug Anderson:
> Jianqun,
> 
> On Fri, Aug 29, 2014 at 3:07 PM, Jianqun <jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org> wrote:
> > Add optional power setting for i2s controller found on rk3066, rk3168 and
> > rk3288 processors from rockchip, should according to hardware design.
> > 
> > Default setting for I2S controller is powered by 3.3V, there needs this
> > patch if it's powered by 1.8V by hardware design.
> > 
> > Jianqun (2):
> >   rockchip-i2s: dt: add grf requested properties to set power of I2S
> >   controller rockchip-i2s: add power setting for I2S controller, also fix
> >   some bugs>  
> >  .../devicetree/bindings/sound/rockchip-i2s.txt     |  6 +-
> >  sound/soc/rockchip/rockchip_i2s.c                  | 93
> >  +++++++++++++--------- sound/soc/rockchip/rockchip_i2s.h                
> >   | 13 +--
> >  3 files changed, 68 insertions(+), 44 deletions(-)
> 
> Did the general solution I posted at
> <https://patchwork.kernel.org/patch/4807821/> not work for you?  ...or
> did you not see that?

Also, I don't think it's a good idea to set the io voltage bit simply from a 
dt setting without looking at the actual regulator voltage ... as a 1.8V 
setting when the regulator supplies 3.3V supposedly is able to damage the 
chip.


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
