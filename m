From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH 3/4] ASoc: kirkwood: merge kirkwood-i2c and kirkwood-dma
Date: Fri, 26 Jul 2013 09:38:50 +0200
Message-ID: <20130726093850.2d2cd45c@armhf>
References: <20130725111428.419ee278@armhf>
	<20130725191604.GQ9858@sirena.org.uk>
	<20130725225816.GG24642@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130725225816.GG24642@n2100.arm.linux.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Rob Herring <rob.herring@calxeda.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

On Thu, 25 Jul 2013 23:58:16 +0100
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Thu, Jul 25, 2013 at 08:16:04PM +0100, Mark Brown wrote:
> > On Thu, Jul 25, 2013 at 11:14:28AM +0200, Jean-Francois Moine wrote=
:
> > > To avoid the declaration of a 'kirkwood-pcm-audio' device in the =
DT,
> > > this patch merges the kirkwood-i2c and kirkwood-dma drivers into =
one
> > > module.
> >=20
> > This seems mostly fine, though it may be best to keep kirkwood-dma =
as a
> > separate module for the benefit of the S/PDIF support when it gets =
added
> > - I had a look at the implementation Russell has and it looks like =
it
> > can be added as a separate interface.
>=20
> You wouldn't want I2S and SPDIF to be separate modules though - they'=
re
> the same hardware but different output stream formatters attached to =
the
> DMA FIFO output.  Don't forget the requirements concerning the simult=
aneous
> use of I2S and SPDIF - these "output formatters" must both be enabled=
 and
> disabled in unison when concurrent use is required - both bits must b=
e
> set or cleared together with a single register write.
>=20
> > > -	.platform_name =3D "kirkwood-pcm-audio",
> > > +	.platform_name =3D "kirkwood-i2s",
> >=20
> > Should the name be done as dev_name() for the interface (I don't kn=
ow if
> > there is ever more than one)?
>=20
> Getting away from "kirkwood-i2s" would be sensible, because it may no=
t be
> just "i2s" in this hardware block.  The documentation calls this an "=
audio
> controller" but I guess "kirkwood-pcm" would be a reasonable compromi=
se,
> even though it has a separate AC'97 block which could also be constru=
ed
> as being "pcm".
>=20
> The AC'97 block uses a separate peripheral DMA controller and so woul=
dn't
> make use of kirkwood-dma.c either.

As the kirkwood audio subsystem is used in the other mvebu machines,
the name of the module kirkwood-i2s/kirkwood-dma could be
"mvebu-pcm-audio".

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
