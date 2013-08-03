From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH v3 4/4] ASoC: kirkwood: change kirkwood-i2s to
 mvebu-pcm-audio and DT doc
Date: Sat, 3 Aug 2013 18:26:36 +0200
Message-ID: <20130803182636.012cccb2@armhf>
References: <20130731081858.53413597@armhf>
	<20130803134855.GZ23006@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130803134855.GZ23006@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Sat, 3 Aug 2013 14:48:55 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Wed, Jul 31, 2013 at 08:18:58AM +0200, Jean-Francois Moine wrote:
> > diff --git a/sound/soc/kirkwood/kirkwood-i2s.c b/sound/soc/kirkwood=
/kirkwood-i2s.c
> > index 9844010..4f817a2 100644
> > --- a/sound/soc/kirkwood/kirkwood-i2s.c
> > +++ b/sound/soc/kirkwood/kirkwood-i2s.c
> > @@ -25,7 +25,7 @@
> > =20
> >  #include "kirkwood.h"
> > =20
> > -#define DRV_NAME	"kirkwood-i2s"
> > +#define DRV_NAME	"mvebu-pcm-audio" =20
>=20
> This breaks non-DT users of this driver.  The device in arch/arm/mach=
-kirkwood
> is left as "kirkwood-i2s" but the platform device is now called somet=
hing
> different.

Oops, sorry, the patch to arch/arm/mach-kirkwood/common.c went away
when I pulled the last kernel.

> >  static struct of_device_id kirkwood_i2s_of_match[] =3D {
> > -	{ .compatible =3D "marvell,kirkwood-i2s" },
> > +	{ .compatible =3D "marvell,mvebu-pcm-audio" }, =20
>=20
> You've only just introduced "marvell,kirkwood-i2s" in the previous pa=
tch.
> Why introduce something and then immediately change its name?  This m=
akes
> no sense what so ever.

2 patches for 2 different purposes. The first one just adds the DT
support. It is enough for DT based kernels. But some people wanted the
device name to be changed to 'mvebu'. So, the second patch.

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
