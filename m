From: "Kuankuan.Yang" <ykk-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH 5/6] dt-bindings: Add documentation for Rockchip hdmi-audio
Date: Tue, 16 Dec 2014 17:48:54 +0800
Message-ID: <54900006.9060701@rock-chips.com>
References: <1418609494-15820-1-git-send-email-ykk@rock-chips.com> <1418612114-19692-1-git-send-email-ykk@rock-chips.com> <20141215104029.GE11285@n2100.arm.linux.org.uk> <20141215120205.GZ11764@sirena.org.uk> <548EDDC2.9050104@rock-chips.com> <20141215161827.GE11764@sirena.org.uk> <548FCE8F.7090106@rock-chips.com> <20141216093443.GN11285@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141216093443.GN11285-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, David Airlie <airlied-cv59FeDIM0c@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Bard Liao <bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Takashi Iwai <tiwai-l3A5Bk7waGM@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Dylan Reid <dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Xu Jianqun <jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Oder Chiou <oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Jyri Sarha <jsarha-l0cyMroinI0@public.gmane.org>, Ben Zhang <benzh-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, =?UTF-8?B?U3Tvv73vv71wa
List-Id: alsa-devel@alsa-project.org


=E5=9C=A8 2014=E5=B9=B412=E6=9C=8816=E6=97=A5 17:34, Russell King - ARM=
 Linux =E5=86=99=E9=81=93:
> On Tue, Dec 16, 2014 at 02:17:51PM +0800, Kuankuan.Yang wrote:
>> hdmi-audio driver share irq with dw_hdmi driver,  for continuing AHB=
AUDDMA
>> or for detecting hdmi insert.
>> So maybe it's hard to switch to simple-card way,  Russell what's you=
r
>> opinion ?
> My "opinion" is that I need to spend some time looking in depth at bo=
th
> your code and my code before I can form an idea of how to proceed.
>
> However, since I seem to be spending a lot of time chasing regression=
s
> which have appeared in v3.18, I don't have a lot of time to look at t=
his
> right now.
>
okay, if u got any ideas, wish u can let me know, thks.


--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
