From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v2 3/9] clk: sunxi-ng: add support for
 Allwinner H5 SoC
Date: Fri, 27 Jan 2017 16:53:55 +0100
Message-ID: <20170127155355.zu6k7ucbpewmlsjb@lukather>
References: <20170126154859.55855-1-icenowy@aosc.xyz>
 <20170126154859.55855-4-icenowy@aosc.xyz>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="7eu64d63dd3wrlrk"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBHW2VXCAKGQEMWDZ2JI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20170126154859.55855-4-icenowy-ymACFijhrKM@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Vinod Koul <vinod.koul-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Jaroslav Kysela <perex-/Fr2/VpizcU@public.gmane.org>, Andre Przywara <andre.przywara-5wv7dgnIgG8@public.gmane.org>, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-gpio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dmaengine-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org


--7eu64d63dd3wrlrk
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Thu, Jan 26, 2017 at 11:48:53PM +0800, Icenowy Zheng wrote:
> Allwinner H5 is a SoC that features a CCU like H3, but with MMC phase
> clocks removed (for new MMC controller) and a new bus gate/reset
> imported.
> 
> Add support for it.
> 
> Signed-off-by: Icenowy Zheng <icenowy-ymACFijhrKM@public.gmane.org>
> ---
> A giant rewrite since v1.
> It now do not use a dedicated driver for H5, but altered the CCU driver
> of H3 to support H5.
> 
>  .../devicetree/bindings/clock/sunxi-ccu.txt        |   1 +
>  drivers/clk/sunxi-ng/Kconfig                       |   6 +-
>  drivers/clk/sunxi-ng/Makefile                      |   2 +-
>  .../sunxi-ng/{ccu-sun8i-h3.c => ccu-sunxi-h3-h5.c} | 179 ++++++++++++++++++---
>  .../sunxi-ng/{ccu-sun8i-h3.h => ccu-sunxi-h3-h5.h} |  15 +-
>  include/dt-bindings/clock/sun8i-h3-ccu.h           | 146 +----------------
>  include/dt-bindings/clock/sunxi-h3-h5-ccu.h        | 148 +++++++++++++++++
>  include/dt-bindings/reset/sun8i-h3-ccu.h           | 104 +-----------
>  include/dt-bindings/reset/sunxi-h3-h5-ccu.h        | 106 ++++++++++++
>  9 files changed, 431 insertions(+), 276 deletions(-)
>  rename drivers/clk/sunxi-ng/{ccu-sun8i-h3.c => ccu-sunxi-h3-h5.c} (80%)
>  rename drivers/clk/sunxi-ng/{ccu-sun8i-h3.h => ccu-sunxi-h3-h5.h} (82%)
>  mode change 100644 => 120000 include/dt-bindings/clock/sun8i-h3-ccu.h
>  create mode 100644 include/dt-bindings/clock/sunxi-h3-h5-ccu.h
>  mode change 100644 => 120000 include/dt-bindings/reset/sun8i-h3-ccu.h
>  create mode 100644 include/dt-bindings/reset/sunxi-h3-h5-ccu.h

Please do that in two patches. One to rename the existing driver, one
to support the H5.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--7eu64d63dd3wrlrk--
