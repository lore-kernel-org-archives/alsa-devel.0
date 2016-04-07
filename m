From: Sekhar Nori <nsekhar-l0cyMroinI0@public.gmane.org>
Subject: Re: [alsa-devel] [PATCH 6/6] ARM: DTS: da850: Add McBSP0 and McBSP1
Date: Thu, 7 Apr 2016 18:35:52 +0530
Message-ID: <57065B30.4000601@ti.com>
References: <1459948893-4206-1-git-send-email-petr@barix.com>
 <1459948893-4206-7-git-send-email-petr@barix.com> <570645B4.6060606@ti.com>
 <57064F8B.3020501@barix.com> <5706567B.5000501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <5706567B.5000501-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Peter Ujfalusi <peter.ujfalusi-l0cyMroinI0@public.gmane.org>, Petr Kulhavy <petr-Qh/3xLP0EvwAvxtiuMwx3w@public.gmane.org>, khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
Cc: mark.rutland-5wv7dgnIgG8@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Thursday 07 April 2016 06:15 PM, Peter Ujfalusi wrote:

> I think what the da850.dtsi does is wrong. The dtsi file should not set any
> pinmux, those need to be set by the board .dts files If one board uses McASP0,
> it will set up the pins for that and leave McBSP pins as they were, but other
> board might use McBSP1 and not use McASP0, there you will have pincontrol for
> McBSP1.

Most functions on da850 are available only on one physical pin. So every
board that needs that functionality needs to setup the pinmux the same
way. This was the idea behind adding pinmux to da850.dtsi rather than
repeating it for every board.

Even though the pinctrl entries are there in da850.dtsi, the pinmux
registers wont be touched unless the status is set to "okay" for that
device in board .dts file.

The only care that needs to be taken is that the pins listed in
da850.dtsi need to be the minimum required for achieving that
functionality. If a board needs more than what is populated in
da850.dtsi then it can define its own pinctrl entries overriding that
coming from da850.dtsi

Thanks,
Sekhar
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
