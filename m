From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 3/3] ASoC: Ux500: Add driver for
 Ux500/AB8500 platform/codec
Date: Tue, 13 Mar 2012 21:21:59 +0000
Message-ID: <20120313212158.GB3177@opensource.wolfsonmicro.com>
References: <1327933110-22229-1-git-send-email-ola.o.lilja@stericsson.com>
	<20120130172214.GM4882@opensource.wolfsonmicro.com>
	<AC3CA153830A24419D7BF22D87B39D0557F2EC71DA@EXDCVYMBSTM006.EQ1STM.local>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4980671616442723430=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id BE7AC104151
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 22:22:02 +0100 (CET)
In-Reply-To: <AC3CA153830A24419D7BF22D87B39D0557F2EC71DA@EXDCVYMBSTM006.EQ1STM.local>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Ola LILJA2 <ola.o.lilja@stericsson.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Liam Girdwood <lrg@ti.com>, Linus Walleij <linus.walleij@linaro.org>
List-Id: alsa-devel@alsa-project.org


--===============4980671616442723430==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 13, 2012 at 03:56:20PM +0100, Ola LILJA2 wrote:
> Answers inline.
>=20
> PS. New patch-set uploaded.

Ugh, you *really* should've sent this at the time (or in general before
sending the new patches) since now a bunch of review comments are going
to get repetitive...

> > Nothing in this header looks like it should be exported, I've not
> > actually looked at any of the code to see what this stuff is doing but
> > it all looks like it should be private to the relevant drivers.

> The machine-driver is split up in a main machine-driver and several
> sub-machine-drivers (one for each platform<->codec), so this inteface is
> just so that the main machine-file can call reach the functions implement=
ed
> in the sub-machine-driver-file. It is not meant for the world outside our
> driver.

This sounds suspicious, what is this "generic" machine driver?

> > > +ifdef CONFIG_SND_SOC_UX500_DEBUG
> > > +CFLAGS_ab8500_audio.o :=3D -DDEBUG
> > > +endif

> > No other driver has this.  Why does your driver have it?

> Can't answer to why other people don't have it =3D) I found it convenient
> to be able to turn on the debug-prints in our driver by just using a flag
> in menuncofig rather than modifying Makefiles every time.
> It is easier to tell our customer to just activate this flag.
> Do you want me to remove it?

Either make this a generic feature or remove it, we shouldn't have
stuff like this available randomly.

> > > +static int st_fir_value_control_get(struct snd_kcontrol *kcontrol,
> > > +			   struct snd_ctl_elem_value
> > *ucontrol) {
> > > +	return 0;
> > > +}

> > This looks obviously buggy.

> These are FIR-coeffecients and can (by HW-design) not be read. So there i=
s nothing to
> do here.

This still looks obviously buggy.  If readback is not supported there
shouldn't be a readback function, and returning success is clearly not
the right thinng to do.

> > > +	data =3D ab8500_codec_read_reg(codec, AB8500_MISC,
> > AB8500_GPIO_DIR4_REG);
> > > +	data |=3D GPIO27_DIR_OUTPUT | GPIO29_DIR_OUTPUT |
> > GPIO31_DIR_OUTPUT;
> > > +	ab8500_codec_write_reg(codec, AB8500_MISC,
> > AB8500_GPIO_DIR4_REG,
> > > +data);

> > This loooks like platform data...

> Well, this is actually GPIO on the codec-chip and not the base-chip.

That doesn't seem germane to it being provied as platform data.

> > > +void ab8500_audio_power_control(bool power_on) {
> > > +	if (ab8500_codec =3D=3D NULL) {
> > > +		pr_err("%s: ERROR: AB8500 ASoC-driver not yet
> > probed!\n", __func__);
> > > +		return;
> > > +	}

> > Use the framework features for power management, we've got enough ways
> > for your driver to get told when to power up and down none of which
> > require a global pointer to a device.

> This is called as an effect of a DAPM-chain so it is using the ASoC-frame=
work.
> The reason for having this like it is, is due to the fact that we need to=
 call
> this funtion not only from the DAPM-chain, but also from another kernel-d=
river
> (our vibra-driver). I would love to see this extra way into the audio-dri=
ver but
> as the design of our platform require this, we are stuck with this soluti=
on.

No, you're not.  Use a MFD like the existing drivers doing this.  Having
a global data thing like this is really not suitable for mainline.

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIbBAEBAgAGBQJPX7pBAAoJEBus8iNuMP3d2cUP92sSysYJftK1PkO9Hknn0Z2M
VU6VxFNEyQWK/E8Gs2RS/g8FMy3d6sOblkLQwf3OzpPb36DwRx8GKfqJSnEXWkuf
dxvwZcEJCQWc99CIM+7QDIISYoKzig6TQnUWD1LmJeF676/YjenZvdiYUriRv0L6
uzQQHPvf+CmYVVLkhU/DAb0UAQ19xMBazVDK+O+eJnLGVFj7fRa/TSARA9pEfxuv
mRSsIUgwP7wp29AIzQxd6ZuNi2sxD8sivXESaCqEbNnbQ1Qn8ddzyWgh4cFwSnLU
kT8DTYmzcQFGDRizUKIYswuXEu/TmdRnrBPwDaqZ7Zl/MSFCy0V8PftLMDX29CTu
aEWz/pvLyrrbuPQnqNybGsDKL0hF3QpCOg56w7Pj/GZ8masAWJnMJMA9QBgwHsoW
nIG21uzYBvkb67MKxAsS+MLPwKHDhDEh2IZEkxzBdFDfishEnKFps/LQ6DK0nMrk
fIW5Gl/Ivv8rvVE95cJLnaQe3sPArOYfLQy0oIF4fLusgg7sZTFej1u5nsRG5tKY
YiNFTJqIWRLrh+j3Umq24y8T07P/pHhr5UFw/QnUrGwpl/6lHtgGTLrIlby8/sfa
SmJ+OQYLT7tqy/oCE+2crMz5cs0fScCeE8XOBF8sXTVIszpblMqKansPoHr3JEUt
iCTP5HO9Uwz9/WvbKwE=
=rgsP
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--

--===============4980671616442723430==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4980671616442723430==--
