From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 13/16] ASoC: codecs: Add AB8500 codec-driver
Date: Mon, 19 Mar 2012 15:43:41 +0000
Message-ID: <20120319154341.GA5132@opensource.wolfsonmicro.com>
References: <20120313224529.GL3177@opensource.wolfsonmicro.com>
	<AC3CA153830A24419D7BF22D87B39D0557F2F28251@EXDCVYMBSTM006.EQ1STM.local>
	<20120314134508.GL3133@opensource.wolfsonmicro.com>
	<4F6201C1.1040006@stericsson.com>
	<20120315152906.GN3138@opensource.wolfsonmicro.com>
	<4F633B92.7030401@stericsson.com>
	<20120317223141.GK3315@opensource.wolfsonmicro.com>
	<4F66E934.1060909@stericsson.com>
	<20120319120956.GA3130@opensource.wolfsonmicro.com>
	<4F67489B.3050709@stericsson.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3309061129238453211=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 49093104141
	for <alsa-devel@alsa-project.org>; Mon, 19 Mar 2012 16:43:44 +0100 (CET)
In-Reply-To: <4F67489B.3050709@stericsson.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola Lilja <ola.o.lilja@stericsson.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============3309061129238453211==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 19, 2012 at 03:54:19PM +0100, Ola Lilja wrote:

> We have a routing situation that could be rendered something like this:
>=20
>                             D----->Speaker
>                             |
> I2S (playback)------>A----->B----->C----->Headset

> In this case, let's say that the bit at B needs to be set in HW before C =
is set
> to avoid pop/click noises.

This looks very standard, you've got a PGA at B and either further PGAs
or output drivers at C and D.

> If we just use a normal playback-switch that is associated with the bit a=
t C,
> then this switch would directly set the C bit before the stream is active=
 and
> then later when the stream is activated, the other widgets are enabled th=
us B
> would be set (i.e. after C was set which is not the desired order).
> Our solution to handle this is to introduce a virtual switch (in the form=
 of an
> enum_virt) between B and Headset.

It sounds like this non-specific register bit is just the power control
for C in which case it should just be a DAPM widget and machines should
be using a pin switch or jack pins for the outputs.

> I2S (playback)------>A----->B----->C----->Headset
>                             ^
>                             |
>          LineIn----->D------E----->F----->I2S (capture)

> As you can see neither of the endpoints "belongs" to the bypass-path (E->=
B) and
> therefore I can't see how it should be possible to use a simple pin switc=
h here
> as it would always affect other paths.

Again, this looks *very* standard - it's just a totally normal
bypass/sidetone path as far as I can see.  B is a mixer here and
presumably there's some control on B which turns on and off the path?

Depending on how the path is used you might want to mark the route as a
weak route to suppress power up from that path alone but really as with
the first example this doesn't seem at all unusual unless there's more
going on than your description.

> >> So, what you want is another device/driver pair where our current
> >> acc.det.-driver adds a driver to the device we add in the ASoC-driver?

> > I can't parse what you're saying here, sorry.

> OK, I was trying to understand what you meant with these comments:
> "breaking the device model" and "just embed a trivial input
> driver in the CODEC for the vibra if it's small enough."
> Could you explain this abit more?

The device model is this whole idea that we have devices which are
matched up automatically by the core.  "Embedding" means "putting in" -
see for example wm8962 which has a tiny little input driver in it.

> > No.  That's exactly the sort of stuff we don't want to see.  The fact
> > that the device needs power to operate isn't something that's specific
> > to a particular board, it's a property of the silicon.

> I agree that the fact that it needs power is not specific to the board, b=
ut we
> could have different regulators feeding the codec-chip. The regulators co=
uld be

You've completely failed to understand how requesting supplies in the
regulator API works, a regulator API like you describe would mean that
no chip driver was ever able to request a supply for itself.  The whole
point of the machine interface is to provide a mechanism for drivers to
talk about their supplies without having to know the details of how
they're wired up on an individual board.

Since your CODEC driver is a driver for a chip your CODEC driver should
be requesting whatever the supplies the chip has.

> > I've not suggested that.  Look at how other drivers manage their power.

> I have looked alot at other drivers, but in many cases I've found that our
> situation looks pretty different and often more complex.
> See the last comment below for more info on our regulator-usage.

I'm sorry but really I don't see anything in the text below which sounds
in the least bit unusual.  Could you be specific about what you think is
special about your device and/or system?

> > I'm not seeing any code in the driver which manages the regulators...

> This is all our regulator-widgets, currently located in the machine-drive=
r and
> connected to chains located in the codec-driver:

Things that are in the machine driver are not in the CODEC driver and
need to be cut and pasted into individual machine drivers.  If it's
something that's genuinely machine specific that's fine but we're
talking about basic core device supplies here.

--W/nzBZO5zC0uMSeA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPZ1QnAAoJEBus8iNuMP3dMusP/2K8TjkX/FQ5GQxYS1p4oqaL
V849VQDmEIjpxRm3bKyv1Yyq3SVRDqBfpyjeNde/phUinq1qF7VnHDRbJR1T8+bX
OHJnx1v7y8pMOeNnXfSg8rHO5y/nbjwj2PqHdAxnJJ3m26ENTDiPvv4iIj3ExqMb
9rtTVqcHzZb+zdjiUyJ7BH/IhQ28MLOeEb/CI1TKJEeEn+kN2Ovhc7ZK/9vWSwLJ
MbQpNyW9OWqJq5mePLvB9EFlPWO6E+0qo6mzK+11daoD4c0K+RSM2QkTTALpILzs
gwuhiVq7Yj3I3VWiahw8UP1IYHZJkywD6kzSNeXwB/tR4II8K5LsnAxwH8xWEZXp
Jgt+l3Z06nlSXiMaY77yvY63Rqnx/pTe0HNW4X51Bu8dh0J0Q56BYmgsoQiEe09J
UHHs4W1nFOesE4pnp7M3Tp7g6scnShG/6xMLfZVoa8HHz+6dleADPv8ZrO9Mz/zc
/KjhdhucFpKCI13swTdgwCqOtV8OEK3gqPYzfyG0JMG10y7EdavrdvdZgZr9Iv3t
BPJGpEulBldGcTSMGLBJSuf9BKT2TEet0gd2uBGtJxFIJpAH/fSAWdi1auQjwOZ1
f1GiHRUbsp9pXpv/wArTpzusMkzGQvM0aYydFwIlvkv2dx9EIcP627/Mt7hU1sVd
9/eB1wkxtnsgrNyWW25S
=jqs+
-----END PGP SIGNATURE-----

--W/nzBZO5zC0uMSeA--

--===============3309061129238453211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3309061129238453211==--
