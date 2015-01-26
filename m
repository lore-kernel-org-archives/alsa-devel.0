From: Lars-Peter Clausen <lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 4/4] sound: jz4740: Enable codec clock during
 dai_probe
Date: Mon, 26 Jan 2015 12:42:39 +0100
Message-ID: <54C6282F.5010507@metafoo.de>
References: <1422267511-6649-1-git-send-email-Zubair.Kakakhel@imgtec.com> <1422267511-6649-5-git-send-email-Zubair.Kakakhel@imgtec.com> <54C61980.9030205@metafoo.de> <54C62570.5050600@imgtec.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <54C62570.5050600-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Zubair Lutfullah Kakakhel <Zubair.Kakakhel-1AXoQHu6uovQT0dZR+AlfA@public.gmane.org>, tiwai-l3A5Bk7waGM@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org
Cc: devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On 01/26/2015 12:30 PM, Zubair Lutfullah Kakakhel wrote:
>
> On 26/01/15 10:40, Lars-Peter Clausen wrote:
>> On 01/26/2015 11:18 AM, Zubair Lutfullah Kakakhel wrote:
>>> As we are moving away from platform to DT, we cant rely on the boar=
d
>>> file to do this now. So enable it here.
>>
>> I don't understand this changelog. The board file never did this. Th=
e driver enables the clock in the startup() callback.
>
> My bad.
>
> I couldn't get the ci20 audio to work without this change.
>
> I double checked. The clock is indeed enabled.
>
> But the rate needs to be set for the ci20.
>
> clk_set_rate(i2s->clk_i2s, 12000000);
>
> Where should I put it? I couldn=92t trace how the rate is set for the=
 jz4740..

There is no support for specifying clock rate defaults in the devicetre=
e=20
itself. See commit 86be408bfbd8 ("clk: Support for clock parents and ra=
tes=20
assigned from device tree"). Since the preferred or correct clock rate =
will=20
be board specific this is probably where it should go.

- Lars

--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
