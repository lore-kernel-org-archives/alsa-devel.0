From: Jean-Francois Moine <moinejf@free.fr>
Subject: Re: [PATCH RFC 0/2] drivers/base: simplify simple DT-based
 components
Date: Fri, 7 Feb 2014 19:42:04 +0100
Message-ID: <20140207194204.4d4326bd@armhf>
References: <cover.1391793068.git.moinejf@free.fr>
	<20140207173326.GD26684@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <20140207173326.GD26684@n2100.arm.linux.org.uk>
Sender: linux-media-owner@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: devel@driverdev.osuosl.org, alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, dri-devel@lists.freedesktop.org, Takashi Iwai <tiwai@suse.de>, Sascha Hauer <kernel@pengutronix.de>, linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org, Daniel Vetter <daniel@ffwll.ch>
List-Id: alsa-devel@alsa-project.org

On Fri, 7 Feb 2014 17:33:26 +0000
Russell King - ARM Linux <linux@arm.linux.org.uk> wrote:

> On Fri, Feb 07, 2014 at 06:11:08PM +0100, Jean-Francois Moine wrote:
> > This patch series tries to simplify the code of simple devices in c=
ase
> > they are part of componentised subsystems, are declared in a DT, an=
d
> > are not using the component bin/unbind functions.
>=20
> I wonder - I said earlier today that this works absolutely fine witho=
ut
> modification with DT, so why are you messing about with it adding DT
> support?
>=20
> This is totally the wrong approach.  The idea is that this deals with
> /devices/ and /devices/ only.  It groups up /devices/.
>=20
> It's up to the add_component callback to the master device to decide
> how to deal with that.
>=20
> > Jean-Francois Moine (2):
> >   drivers/base: permit base components to omit the bind/unbind ops
>=20
> And this patch has me wondering if you even understand how to use
> this...  The master bind/unbind callbacks are the ones which establis=
h
> the "card" based context with the subsystem.
>=20
> Please, before buggering up this nicely designed implementation, plea=
se
> /first/ look at the imx-drm rework which was posted back in early Jan=
uary
> which illustrates how this is used in a DT context - which is somethi=
ng
> I've already pointed you at once today already.

As I told in a previous mail, your code works fine in my DT-based
Cubox. I am rewriting the TDA988x as a normal encoder/connector, and,
yes, the bind/unbind functions are useful in this case.

But you opened a door. In a DT context, you know that the probe_defer
mechanism does not work correctly. Your work permits to solve delicate
cases: your component_add tells exactly when a device is available, and
the master bind callback is the green signal for the device waiting for
its resources. Indeed, your system was not created for such a usage,
but it works as it is (anyway, the component bind/unbind functions may
be empty...).

--=20
Ken ar c'henta=C3=B1	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
