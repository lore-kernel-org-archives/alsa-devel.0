From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH v9 3/4] ASoC: tda998x: add a codec to the HDMI
 transmitter
Date: Wed, 7 Jan 2015 19:02:41 +0100
Message-ID: <20150107190241.27ebac8b@armhf>
References: <cover.1420628786.git.moinejf@free.fr>
	<23b36acc1f769418a06f3e929eba288b5911da12.1420628786.git.moinejf@free.fr>
	<54AD4C77.5000401@arm.com>
	<20150107154138.GL12302@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150107154138.GL12302@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Andrew Jackson <Andrew.Jackson@arm.com>, Mark Brown <broonie@kernel.org>, Dave Airlie <airlied@gmail.com>, Jyri Sarha <jsarha@ti.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

On Wed, 7 Jan 2015 15:41:38 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Wed, Jan 07, 2015 at 03:10:47PM +0000, Andrew Jackson wrote:
> > On 01/07/15 10:51, Jean-Francois Moine wrote:
> > > diff --git a/drivers/gpu/drm/i2c/Kconfig b/drivers/gpu/drm/i2c/Kc=
onfig
> > > index 22c7ed6..24fc975 100644
> > > --- a/drivers/gpu/drm/i2c/Kconfig
> > > +++ b/drivers/gpu/drm/i2c/Kconfig
> > > @@ -28,6 +28,7 @@ config DRM_I2C_SIL164
> > >  config DRM_I2C_NXP_TDA998X
> > >         tristate "NXP Semiconductors TDA998X HDMI encoder"
> > >         default m if DRM_TILCDC
> > > +       select SND_SOC_TDA998X
> >=20
> > Do you need this since sound/soc/codecs/Kconfig conditionally bring=
s in the
> > CODEC driver?

=46or SND_SOC_ALL_CODECS only.

> More importantly, it's broken, because it'll cause Kconfig to complai=
n
> if you enable DRM_I2C_NXP_TDA998X, but have ASoC disabled.
>=20
> Moreover, if you decide you want the sound and ASoC built as a module=
,
> but want to build in DRM and TDA998x support (so you can get video
> output working on boot before initramfs/rootfs), Kconfig may well
> complain.

	select SND_SOC_TDA998X if SND_SOC

should work in all cases.

> > > +static int __init tda998x_codec_init(void)
> > > +{
> > > +       return 0;
> > > +}
> > > +static void __exit tda998x_codec_exit(void)
> > > +{
> > > +}
> > > +module_init(tda998x_codec_init);
> > > +module_exit(tda998x_codec_exit);
>=20
> There's no need for these if they remain as the above.  Modules can h=
ave
> both init/exit functions, or neither, and they are still unloadable.
> Only modules which provide only an init function get locked in on loa=
d.

Thanks.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
