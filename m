From: Fabio Estevam <festevam-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/2] Support non-ssi cpu-dai for sgtl5000
Date: Mon, 29 Aug 2016 10:58:57 -0300
Message-ID: <CAOMZO5B3FDPxm301Hwb+ZVOwYDAMU0vjcVAG0hH36Rf2+s0VDA@mail.gmail.com>
References: <1472467915-21317-1-git-send-email-wente.wang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1472467915-21317-1-git-send-email-wente.wang-3arQi8VN3Tc@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Winter Wang <wente.wang-3arQi8VN3Tc@public.gmane.org>
Cc: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org" <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, "alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org" <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Aug 29, 2016 at 7:51 AM, Winter Wang <wente.wang-3arQi8VN3Tc@public.gmane.org> wrote:
> These patches support sgtl5000 to be attached to other non-ssi cpu-dais like SAI.

Do we really need this?

We can use SAI with sgtl5000 just fine via simple card. Take a look at:
https://git.kernel.org/cgit/linux/kernel/git/shawnguo/linux.git/commit/arch/arm/boot/dts/imx6ul-14x14-evk.dts?h=imx/fixes&id=bf3251e112a0139c8dec796c9f12f2e8f01a73ca
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
