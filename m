From: Benson Leung <bleung@google.com>
Subject: Re: [PATCH v2 00/30] Update cros_ec_commands.h
Date: Wed, 8 May 2019 16:19:54 -0700
Message-ID: <20190508231954.GA41543@google.com>
References: <20190503220233.64546-1-gwendal@chromium.org>
 <20190507094446.GD4529@dell>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4607715805174036768=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 8CA03F807B5
 for <alsa-devel@alsa-project.org>; Thu,  9 May 2019 01:20:03 +0200 (CEST)
Received: by mail-pf1-x442.google.com with SMTP id s11so218962pfm.12
 for <alsa-devel@alsa-project.org>; Wed, 08 May 2019 16:20:03 -0700 (PDT)
In-Reply-To: <20190507094446.GD4529@dell>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Lee Jones <lee.jones@linaro.org>
Cc: Gwendal Grignou <gwendal@chromium.org>, alsa-devel@alsa-project.org, linux-iio@vger.kernel.org, tiwai@suse.com, groeck@chromium.org, broonie@kernel.org, enric.balletbo@collabora.com, bleung@chromium.org, jic23@kernel.org, cychiang@chromium.org
List-Id: alsa-devel@alsa-project.org


--===============4607715805174036768==
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Gwendal, Hi Lee,

On Tue, May 07, 2019 at 10:44:46AM +0100, Lee Jones wrote:
> On Fri, 03 May 2019, Gwendal Grignou wrote:
>=20
> > The interface between CrosEC embedded controller and the host,
> > described by cros_ec_commands.h, as diverged from what the embedded
> > controller really support.
> >=20
> > The source of thruth is at
> > https://chromium.googlesource.com/chromiumos/platform/ec/+/master/inclu=
de/ec_commands.h
> >=20
> > That include file is converted to remove ACPI and Embedded only code.
> >=20
> > From now on, cros_ec_commands.h will be automatically generated from
> > the file above, do not modify directly.
> >=20
> > Fell free to squash the commits below.
> >=20
> > Changes in v2:
> > - Move I2S changes at the end of the patchset, squashed with change in
> >   sound/soc/codecs/cros_ec_codec.c to match new interface.
> > - Add Acked-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> >=20
> > Gwendal Grignou (30):
> >   mfd: cros_ec: Update license term
> >   mfd: cros_ec: Zero BUILD_ macro
> >   mfd: cros_ec: set comments properly
> >   mfd: cros_ec: add ec_align macros
> >   mfd: cros_ec: Define commands as 4-digit UPPER CASE hex values
> >   mfd: cros_ec: use BIT macro
> >   mfd: cros_ec: Update ACPI interface definition
> >   mfd: cros_ec: move HDMI CEC API definition
> >   mfd: cros_ec: Remove zero-size structs
> >   mfd: cros_ec: Add Flash V2 commands API
> >   mfd: cros_ec: Add PWM_SET_DUTY API
> >   mfd: cros_ec: Add lightbar v2 API
> >   mfd: cros_ec: Expand hash API
> >   mfd: cros_ec: Add EC transport protocol v4
> >   mfd: cros_ec: Complete MEMS sensor API
> >   mfd: cros_ec: Fix event processing API
> >   mfd: cros_ec: Add fingerprint API
> >   mfd: cros_ec: Fix temperature API
> >   mfd: cros_ec: Complete Power and USB PD API
> >   mfd: cros_ec: Add API for keyboard testing
> >   mfd: cros_ec: Add Hibernate API
> >   mfd: cros_ec: Add Smart Battery Firmware update API
> >   mfd: cros_ec: Add I2C passthru protection API
> >   mfd: cros_ec: Add API for EC-EC communication
> >   mfd: cros_ec: Add API for Touchpad support
> >   mfd: cros_ec: Add API for Fingerprint support
> >   mfd: cros_ec: Add API for rwsig
> >   mfd: cros_ec: Add SKU ID and Secure storage API
> >   mfd: cros_ec: Add Management API entry points
> >   mfd: cros_ec: Update I2S API
> >=20
> >  include/linux/mfd/cros_ec_commands.h | 3735 +++++++++++++++++++++-----
> >  sound/soc/codecs/cros_ec_codec.c     |    8 +-
> >  2 files changed, 2997 insertions(+), 746 deletions(-)
>=20
> Again, it would be good to get 1 or 2 more Chromium Acks, given the
> extent of the changes.

I've gone ahead and looked through all 30 of the changes here. It looks goo=
d to me.

Acked-By: Benson Leung <bleung@chromium.org>

Thanks Gwendal.

Benson

--=20
Benson Leung
Staff Software Engineer
Chrome OS Kernel
Google Inc.
bleung@google.com
Chromium OS Project
bleung@chromium.org

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAABCgAdFiEE6gYDF28Li+nEiKLaHwn1ewov5lgFAlzTZBcACgkQHwn1ewov
5lhjUA/3fA/KxWw5Iys7vvzAAJjcfVmJy+xWem/JAjKjAe0kVJIX/t6badYGOTsI
KkdhoeXjrd+UDnhCQ3zAfRNz8UbAB0GFh1xOg7Tx9ooy2RiGHjcwyGvp1F+d9T9A
9LWavFRzNj+NECuV91pdMHi1VN7UOYoQj8o7f/LMIdsv2dfjfT7/grsYj3q3cjzX
gyi8a5QUb46vcmSSR+hh9KX/ymAjegSEPLWPBC7B237PHmdRSQ3W0C3M0V8ke7nB
gNH+7T8p9/ZzEfVSVydNogTpNDRiXpdEG1PIk5eXbRIr3C3Kv25JR76k5Ljkf6U8
zXdNMZUYFISYPqsqtp2YAbDrZh0Ok7M5I63Wf5SioUFI4bCEQUq0PZjM0//q3/RE
8+walobqHB/+zCLHwh8hqEmy/67J6b6Cww+1pO7l2YUa3ohit6xYTSzs+kGZ3MJ5
s0goLRIMvOvduBuRmW1JrJ57JQSypGL5idWnaX104t/1qHBllKs2w4O1jK1xx4tE
2XvTf/h/8Oq1k4/BYsmI3Tg+beXZogpNEmoXwzxDxE8PNlJ2aEJmZhdcnzT0ZCM8
fGutiblcNwe0JyceAgNrwhlTcVMIlu8tyyXLZBovccSMLBP3w/Fhw5bQbVN5YdRQ
kxXbzvKM6IqwtoqtcWwkKfMahw3ViEpJm41VSrwU5Esz3Ryk0w==
=O6+L
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--

--===============4607715805174036768==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============4607715805174036768==--
