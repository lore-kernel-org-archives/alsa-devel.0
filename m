From: "Kuankuan.Yang" <ykk-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: Re: [PATCH 5/6] dt-bindings: Add documentation for Rockchip hdmi-audio
Date: Tue, 16 Dec 2014 10:14:37 +0800
Message-ID: <548F958D.7020106@rock-chips.com>
References: <1418609494-15820-1-git-send-email-ykk@rock-chips.com> <1418612114-19692-1-git-send-email-ykk@rock-chips.com> <20141215104029.GE11285@n2100.arm.linux.org.uk> <20141215120205.GZ11764@sirena.org.uk> <548EDDC2.9050104@rock-chips.com> <20141215161827.GE11764@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141215161827.GE11764-GFdadSzt00ze9xe1eoZjHA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Philipp Zabel <p.zabel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org, Fabio Estevam <fabio.estevam-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Dylan Reid <dgreid-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Xu Jianqun <jay.xu-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, =?UTF-8?B?U3Tvv73vv71waGFuZSBNYXJjaGVzaW4=?= <marcheu-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>, Brian Austin <brian.austin-jGc1dHjMKG3QT0dZR+AlfA@public.gmane.org>, Bard Liao <bardliao-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, Max Filippov <jcmvbkbc-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Oder Chiou <oder_chiou-Rasf1IRRPZFBDgjK7y7TUQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.orgl
List-Id: alsa-devel@alsa-project.org

Hi Mark :

Got it, it will be good to use simple-card. i will try it in next versi=
on.

Best Regards.

=E5=9C=A8 2014=E5=B9=B412=E6=9C=8816=E6=97=A5 00:18, Mark Brown =E5=86=99=
=E9=81=93:
> On Mon, Dec 15, 2014 at 09:10:26PM +0800, Kuankuan.Yang wrote:
>> Hi Mark & Russell:
> Please don't top post, that way people have some context for what you=
're
> saying - look at how people normally format their mails on thelist.
>
>> In that way, dt will only need compatible for creating sound device.=
 is it
>> ok  ?
>> sound {
>>      compatible =3D "rockchip,rk3288-hdmi-audio";
>>      status =3D "okay";
>> }
>> could you give me some advises.
> That'd be good, though the other question is if this can be made to u=
se
> simple-card so we can avoid having a custom driver for this.


--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
