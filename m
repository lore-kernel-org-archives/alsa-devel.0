From: Shawn Guo <shawn.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v6 1/3] ARM: dts: pbab01: move i2c pins and frequency
 configuration into pfla02
Date: Tue, 11 Nov 2014 21:33:33 +0800
Message-ID: <20141111133331.GA2704@dragon>
References: <1415106349-18846-1-git-send-email-d.lavnikevich@sam-solutions.com>
 <1415106349-18846-2-git-send-email-d.lavnikevich@sam-solutions.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1415106349-18846-2-git-send-email-d.lavnikevich-H6HfJ9slvY0Aspv4Qr0y0gC/G2K4zDHf@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Dmitry Lavnikevich <d.lavnikevich-H6HfJ9slvY0Aspv4Qr0y0gC/G2K4zDHf@public.gmane.org>
Cc: shawn.guo-KZfg59tc24xl57MIdRCFDg@public.gmane.org, kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, perex-/Fr2/VpizcU@public.gmane.org, tiwai-l3A5Bk7waGM@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Tue, Nov 04, 2014 at 04:05:47PM +0300, Dmitry Lavnikevich wrote:
> Since pins and frequency are specific to module (pfla02), not base board
> (pbab02), it is better to be initialized in corresponding dts file.
> 
> This patch fixes i2c2, i2c3 pin configuration which caused messages:
> 
> imx6q-pinctrl 20e0000.iomuxc: no groups defined in /soc/aips-bus@02000000/iomuxc@020e0000/i2c2grp
> imx6q-pinctrl 20e0000.iomuxc: no groups defined in /soc/aips-bus@02000000/iomuxc@020e0000/i2c3grp
> imx6q-pinctrl 20e0000.iomuxc: unable to find group for node i2c2grp
> imx6q-pinctrl 20e0000.iomuxc: unable to find group for node i2c3grp
> 
> Signed-off-by: Dmitry Lavnikevich <d.lavnikevich-H6HfJ9slvY0Aspv4Qr0y0gC/G2K4zDHf@public.gmane.org>

Applied all 3, thanks.
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
