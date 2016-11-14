From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH v5 4/7] ASoC: sunxi: Add sun8i I2S driver
Date: Mon, 14 Nov 2016 22:22:36 +0100
Message-ID: <20161114212236.e6gnoqksjzimcsbm@lukather>
References: <cover.1477142934.git.moinejf@free.fr>
 <bee315efb909c1ee8b5fe7d3aeb9a33d713cb562.1477142934.git.moinejf@free.fr>
 <CAGb2v67gDd650TJk_-oHOehnzdH2qor=36HXdPt339Ji=ToAMg@mail.gmail.com>
 <20161106190248.48b59e166bcd9d6f0ebb4d04@free.fr>
 <20161107200505.g76zz7adtfy4ltku@lukather>
 <20161108115129.f315ca5feefd22614859bbe3@free.fr>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ephktjbejfljleqk"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBHOWVDAQKGQE3F73HUI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20161108115129.f315ca5feefd22614859bbe3-GANU6spQydw@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Linux-ALSA <alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, dri-devel <dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, linux-arm-kernel <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, linux-sunxi <linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Id: alsa-devel@alsa-project.org


--ephktjbejfljleqk
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Tue, Nov 08, 2016 at 11:51:29AM +0100, Jean-Francois Moine wrote:
> On Mon, 7 Nov 2016 21:05:05 +0100
> Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
> 
> > Hi,
> > 
> > On Sun, Nov 06, 2016 at 07:02:48PM +0100, Jean-Francois Moine wrote:
> > > On Sun, 23 Oct 2016 09:33:16 +0800
> > > Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org> wrote:
> > > 
> > > > On Fri, Oct 21, 2016 at 4:36 PM, Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org> wrote:
> > > > > This patch adds I2S support to sun8i SoCs as the A83T and H3.
> > > > >
> > > > > Signed-off-by: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
> > > > > ---
> > > > > Note: This driver is closed to the sun4i-i2s except that:
> > > > > - it handles the H3
> > > > 
> > > > If it's close to sun4i-i2s, you should probably rework that one to support
> > > > the newer SoCs.
> > > 
> > > I started to add the H3 into the sun4i-i2s, but I am blocked with
> > > regmap.
> > > Many H3 registers are common with the A10, but some of them have more
> > > or less fields, the fields may be at different offsets. And, finally,
> > > some registers are completely different.
> > > This would not raise any problem, except with regmap which is really
> > > painful.
> > 
> > That's weird, because regmap's regmap_field should make that much
> > easier.
> 
> #define field_relaxed(addr, mask, val) \
> 	writel_relaxed((readl_relaxed(addr) & mask) | val, addr)

I'm not sure what you mean here.

> > > As I may understood, regmap is used to simplify suspend/resume, but, is
> > > it useful to save the I2S register on suspend?
> > > Practically, I am streaming some tune on my device. I suspend it for
> > > any reason. The next morning, I resume it. Are you sure I want to
> > > continue to hear the end of the tune?
> > > 
> > > I better think that streaming should be simply stopped on suspend.
> > 
> > You're mistaken. The code in there is for *runtime* suspend, ie when
> > the device is no longer used, so that case shouldn't even happen at
> > all.
> > 
> > (And real suspend isn't supported anyway)
> 
> Is it time to remove this useless code?

Which useless code?

> > > Then, there is no need to save the playing registers, and, here I am,
> > > there is no need to use regmap.
> > > 
> > > May I go this way?
> > 
> > No, please don't. regmap is also providing very useful features, such
> > as access to all the registers through debugfs, or tracing. What
> > exactly feels painful to you?
> 
> When the I/O registers are in memory (that's the case), you may access
> them (read and write) thru /dev/mem.

For all the registers if you want to dump all of them. It needs
scripting, it needs root access, and it needs some tool (either devmem
or a custom one) to dump the values. And this is if you have the right
kernel configuration options (devmem enabled, with the protection
against mapped devices disabled).

It just works with debugfs.

> Also, is a register access trace really needed in this driver?

Yes.

> The pain is to define the regmap_config (which registers can be
> read/write/volatile and which can be the values the u-boot let us in
> the registers at startup time), and the lot of code which is run instead
> of simple load/store machine instructions.

This is only needed if you want to use caching, and caching is
optional.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--ephktjbejfljleqk--
