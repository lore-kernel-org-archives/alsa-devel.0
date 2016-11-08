From: Jean-Francois Moine <moinejf-GANU6spQydw@public.gmane.org>
Subject: Re: [PATCH v5 1/7] drm: sunxi: Add a basic DRM driver
 for Allwinner DE2
Date: Tue, 8 Nov 2016 15:37:52 +0100
Message-ID: <20161108153752.a17440e784f2e3993c79ee69@free.fr>
References: <cover.1477142934.git.moinejf@free.fr>
	<8afc5e020c5767face34fe3a9ab300ce9e67ba00.1477142934.git.moinejf@free.fr>
	<20161024140419.ah6hywf3b24pj3fv@lukather>
	<20161025161441.6b248efe9229bd80e3f7a33c@free.fr>
	<20161027220316.y7u3h4qsfftryrmp@lukather>
	<20161028193420.0f7dc67ea1042ff72b09b701@free.fr>
	<20161107223741.gjxj4tqwuxud2iqc@lukather>
Reply-To: moinejf-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCV6DL6LYMNBBRWGQ7AQKGQEDYSUIZI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
In-Reply-To: <20161107223741.gjxj4tqwuxud2iqc@lukather>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Cc: Dave Airlie <airlied-cv59FeDIM0c@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, dri-devel-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

On Mon, 7 Nov 2016 23:37:41 +0100
Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:

> Hi,
>=20
> On Fri, Oct 28, 2016 at 07:34:20PM +0200, Jean-Francois Moine wrote:
> > On Fri, 28 Oct 2016 00:03:16 +0200
> > Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org> wrote:
	[snip]
> > > > > We've been calling them bus and mod.
> > > >=20
> > > > I can understand "bus" (which is better than "apb"), but why "mod"?
> > >=20
> > > Allwinner has been calling the clocks that are supposed to generate
> > > the external signals (depending on where you were looking) module or
> > > mod clocks (which is also why we have mod in the clock
> > > compatibles). The module 1 clocks being used for the audio and the
> > > module 0 for the rest (SPI, MMC, NAND, display, etc.)
> >=20
> > I did not find any 'module' in the H3 documentation.
> > So, is it really a good name?
>=20
> It's true that they use it less nowadays, but they still do,
> ie. https://github.com/allwinner-zh/linux-3.4-sunxi/blob/master/drivers/c=
lk/sunxi/clk-sun8iw7.c#L513

There is a 'mod' suffix, but it is used for the bus gates only, not for
the main clocks.

> And we have to remain consistent anyway.

I don't see any consistency in the H3 DT:
- the bus gates are named "ahb" and apb"
- the (main) clocks are named "mmc", "usb0_phy" and "ir"
There is no "bus" nor "mod".

> > > > > > +
> > > > > > +- resets: phandle to the reset of the device
> > > > > > +
> > > > > > +- ports: phandle's to the LCD ports
> > > > >=20
> > > > > Please use the OF graph.
> > > >=20
> > > > These ports are references to the graph of nodes. See
> > > > 	http://www.kernelhub.org/?msg=3D911825&p=3D2
> > >=20
> > > In an OF-graph, your phandle to the LCD controller would be replaced
> > > by an output endpoint.
> >=20
> > This is the DE controller. There is no endpoint link at this level.
>=20
> The display engine definitely has an endpoint: the TCON.

Not at all. The video chain is simply
	CRTC (TCON) -> connector (HDMI/LCD/DAC/..)
The DE is an ancillary device which handles the planes.

> > The Device Engine just handles the planes of the LCDs, but, indeed,
> > the LCDs must know about the DE and the DE must know about the LCDs.
> > There are 2 ways to realize this knowledge in the DT:
> > 1) either the DE has one or two phandle's to the LCDs,
> > 2) or the LCDs have a phandle to the DE.
> >=20
> > I chose the 1st way, the DE ports pointing to the endpoint of the LCDs
> > which is part of the video link (OF-graph LCD <-> connector).
> > It would be possible to have phandles to the LCDs themselves, but this
> > asks for more code.
> >=20
> > The second way is also possible, but it also complexifies a bit the
> > exchanges DE <-> LCD.
>=20
> I'm still not sure how it would complexify anything, and why you can't
> use the display graph to model the relation between the display engine
> and the TCON (and why you want to use a generic property that refers
> to the of-graph while it really isn't).

Complexification:
1- my solution:
  At startup time, the DE device is the DRM device. It has to know the
  devices entering in the video chains.
  The CRTCs (LCD/TCON) are found by
	ports[i] -> parent
  The connectors are found by
	ports[i] -> endpoint -> remote_endpoint -> parent
2- with ports pointing to the LCDs:
  The CRTCs (LCD/TCON) are simply
	ports[i]
  The connectors are found by
	loop on all ports of ports[i]
		ports[i][j] -> endpoint -> remote_endpoint -> parent
3- with a phandle to the DE in the LCDs:
  The DE cannot be the DRM device because there is no information about
  the video devices in the DT. Then, the DRM devices are the LCDs.
  These LCDs must give their indices to the DE. So, the DE must implement
  some callback function to accept a LCD definition, and there must be
  a list of DEs in the driver to make the association DE <-> LCD[i]
  Some more problem may be raised if a user wants to have the same frame
  buffer on the 2 LCDs of a DE.

Anyway, my solution is already used in the IMX Soc.
See 'display-subsystem' in arch/arm/boot/dts/imx6q.dtsi for an example.

> > > > > > +void de2_disable_vblank(struct drm_device *drm, unsigned crtc)
> > > > > > +{
> > > > > > +	struct priv *priv =3D drm->dev_private;
> > > > > > +	struct lcd *lcd =3D priv->lcds[crtc];
> > > > > > +
> > > > > > +	tcon_write(lcd->mmio, gint0,
> > > > > > +			 tcon_read(lcd->mmio, gint0) &
> > > > > > +					~TCON_GINT0_TCON1_Vb_Int_En);
> > > > > > +}
> > > > > > +
> > > > > > +/* panel functions */
> > > > >=20
> > > > > Panel functions? In the CRTC driver?
> > > >=20
> > > > Yes, dumb panel.
> > >=20
> > > What do you mean by that? Using a Parallel/RGB interface?
> >=20
> > Sorry, I though this was a well-known name. The 'dump panel' was used
> > in the documentation of my previous ARM machine as the video frame sent
> > to the HDMI controller. 'video_frame' is OK for you?
>=20
> If it's the frame sent to the encoder, then it would be the CRTC by
> DRM's nomenclature.

The CRTC is a software entity. The frame buffer is a hardware entity.

> > > > > > +static const struct {
> > > > > > +	char chan;
> > > > > > +	char layer;
> > > > > > +	char pipe;
> > > > > > +} plane2layer[DE2_N_PLANES] =3D {
> > > > > > +	[DE2_PRIMARY_PLANE] =3D	{0, 0, 0},
> > > > > > +	[DE2_CURSOR_PLANE] =3D	{1, 0, 1},
> > > > > > +	[DE2_VI_PLANE] =3D	{0, 1, 0},
> > > > > > +};
	[snip]
> > > > >=20
> > > > > Comments?
> > > >=20
> > > > This
> > > > 	primary plane is channel 0 (VI), layer 0, pipe 0
> > > > 	cursor plane is channel 1 (UI), layer 0, pipe 1
> > > > 	overlay plane is channel 0 (VI), layer 1, pipe 0
> > > > or the full explanation:
> > > >     Constraints:
> > > > 	The VI channels can do RGB or YUV, while UI channels can do RGB
> > > > 	only.
> > > > 	The LCD 0 has 1 VI channel and 4 UI channels, while
> > > > 	LCD 1 has only 1 VI channel and 1 UI channel.
> > > > 	The cursor must go to a channel bigger than the primary channel,
> > > > 	otherwise it is not transparent.
> > > >     First try:
> > > > 	Letting the primary plane (usually RGB) in the 2nd channel (UI),
> > > > 	as this is done in the legacy driver, asks for the cursor to go
> > > > 	to the next channel (UI), but this one does not exist in LCD1.
> > > >     Retained layout:
> > > > 	So, we must use only 2 channels for the same behaviour on LCD0
> > > > 	(H3) and LCD1 (A83T)
> > > > 	The retained combination is:
> > > > 		- primary plane in the first channel (VI),
> > > > 		- cursor plane inthe 2nd channel (UI), and
> > > > 		- overlay plane in the 1st channel (VI).
> > > >=20
> > > > 	Note that there could be 3 overlay planes (a channel has 4
> > > > 	layers), but I am not sure that the A83T or the H3 could
> > > > 	support 3 simultaneous video streams...
> > >=20
> > > Do you know if the pipe works in the old display engine?
> > >=20
> > > Especially about the two-steps composition that wouldn't allow you to
> > > have alpha on all the planes?
> > >=20
> > > If it is similar, I think hardcoding the pipe number is pretty bad,
> > > because that would restrict the combination of planes and formats,
> > > while some other might have worked.
> >=20
> > From what I understood about the DE2, the pipes just define the priorit=
y
> > of the overlay channels (one pipe for one channel).
> > With the cursor constraint, there must be at least 2 channels in
> > order (primary, cursor). Then, with these 2 channels/pipes, there can b=
e
> > 6 so-called overlay planes (3 RGB/YUV and 3 RGB only).
> > Enabling the pipes 2 and 3 (LCD 0 only) would offer 8 more planes, but
> > RGB only. Then, it might be useful to have dynamic pipes.
>=20
> That's very valuable (and definitely should go into a comment),
> thanks!
>=20
> I still believe that's it should be into a (simple at first)
> atomic_check. That would be easier to extend and quite easy to
> document and get simply by looking at the code.

Sorry for I don't understand what you mean.

> > > > > > +static int __init de2_drm_init(void)
> > > > > > +{
> > > > > > +	int ret;
> > > > > > +
> > > > > > +/* uncomment to activate the drm traces at startup time */
> > > > > > +/*	drm_debug =3D DRM_UT_CORE | DRM_UT_DRIVER | DRM_UT_KMS |
> > > > > > +			DRM_UT_PRIME | DRM_UT_ATOMIC; */
> > > > >=20
> > > > > That's useless.
> > > >=20
> > > > Right, but it seems that some people don't know how to debug a DRM
> > > > driver. This is only a reminder.
> > > >=20
> > > > > > +	DRM_DEBUG_DRIVER("\n");
> > > > > > +
> > > > > > +	ret =3D platform_driver_register(&de2_lcd_platform_driver);
> > > > > > +	if (ret < 0)
> > > > > > +		return ret;
> > > > > > +
> > > > > > +	ret =3D platform_driver_register(&de2_drm_platform_driver);
> > > > > > +	if (ret < 0)
> > > > > > +		platform_driver_unregister(&de2_lcd_platform_driver);
> > > > > > +
> > > > > > +	return ret;
> > > > > > +}
> > > > >=20
> > > > > And that really shouldn't be done that way.
> > > >=20
> > > > May you explain?
> > >=20
> > > This goes against the whole idea of the device and driver
> > > model. Drivers should only register themselves, device should be
> > > created by buses (or by using some external components if the bus
> > > can't: DT, ACPI, etc.). If there's a match, you get probed.
> > >=20
> > > A driver that creates its own device just to probe itself violates
> > > that.
> >=20
> > In this function (module init), there is no driver yet.
> > The module contains 2 drivers: the DE (planes) and the LCD (CRTC),
> > and there is no macro to handle such modules.
>=20
> Ah, yes, my bad. I thought you were registering a device and a
> driver. Still this is a very unusual pattern. Why do you need to split
> the two? Can't you just merge them?

The DE and the LCDs are different devices on different drivers.
A DE must be only one device because it has to handle concurent
accesses from its 2 LCDs. Then 2 drivers.

But only one module. Why? Because there cannot be double direction
calls from one module to an other one, and, in our case, for example,
- the DRM (DE) device must call vblank functions which are handled in
  the CRTC (TCON) device, and
- the CRTC device must call DE initialization functions at startup time.

> > > > > > +int de2_plane_init(struct drm_device *drm, struct lcd *lcd)
> > > > > > +{
> > > > > > +	int ret, possible_crtcs =3D 1 << lcd->crtc_idx;
> > > > > > +
> > > > > > +	ret =3D de2_one_plane_init(drm, &lcd->planes[DE2_PRIMARY_PLAN=
E],
> > > > > > +				DRM_PLANE_TYPE_PRIMARY, possible_crtcs,
> > > > > > +				ui_formats, ARRAY_SIZE(ui_formats));
> > > > > > +	if (ret >=3D 0)
> > > > > > +		ret =3D de2_one_plane_init(drm, &lcd->planes[DE2_CURSOR_PLAN=
E],
> > > > > > +				DRM_PLANE_TYPE_CURSOR, possible_crtcs,
> > > > > > +				ui_formats, ARRAY_SIZE(ui_formats));
> > > > >=20
> > > > > Nothing looks really special about that cursor plane. Any reasion=
 not
> > > > > to make it an overlay?
> > > >=20
> > > > As explained above (channel/layer/pipe plane definitions), the curs=
or
> > > > cannot go in a channel lower or equal to the one of the primary pla=
ne.
> > > > Then, it must be known and, so, have an explicit plane.
> > >=20
> > > If you were to make it a plane, you could use atomic_check to check
> > > this and make sure this doesn't happen. And you would gain a generic
> > > plane that can be used for other purposes if needed.
> >=20
> > The function drm_crtc_init_with_planes() offers a cursor plane for free=
.
> > On the other side, having 6 overlay planes is more than the SoCs can
> > support.
>=20
> It's not really for free, it costs you a generic plane that could
> definitely be used for something else and cannot anymore because
> they've been hardcoded to a cursor.
>=20
> And having a camera, the VPU or even an application directly output
> directly into one of these planes seems a much better use of a generic
> plane than a cursor.

Looking at the harder case (A83T), there may be 8 planes on 2 channels.
Using a primary plane and the cursor,
	8 planes - primary plane - cursor plane =3D 6 planes
6 planes are available.
If I count correctly, in your example:
	one camera + one VPU + one application =3D 3 planes
3 planes are used.
So, 3 planes are still available.

On the other side, removing the cursor would just let one more plane.
Do we really need this one? In other words, I'd be pleased to know how
you run 7 applications doing video overlay.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
