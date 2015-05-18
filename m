From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/4] acpi: allow for an override to set _REV
Date: Mon, 18 May 2015 03:01:32 +0200
Message-ID: <3695901.X9t2lWziuY@vostro.rjw.lan>
References: <20150517174144.GA17503@light.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart4285974.i9AYQ5EKV5"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20150517174144.GA17503@light.dominikbrodowski.net>
Sender: linux-acpi-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-acpi@vger.kernel.org, mario_limonciello@dell.com, broonie@kernel.org, matthew.garrett@coreos.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--nextPart4285974.i9AYQ5EKV5
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Sunday, May 17, 2015 07:41:44 PM Dominik Brodowski wrote:
> On Thu, May 14, 2015 at 11:55:33 PM Rafael J. Wysocki wrote:
> > On Thursday, May 14, 2015 10:36:52 PM Rafael J. Wysocki wrote:
> > > So the only value that would really make sense here is 5.
>=20
> > Overall, what about the appended patch instead of your [2-3/4] (mod=
ulo the
> > new command line parameter description which is missing here ATM)?
>=20
> Well, this approach works as well -- limiting it to an override for j=
ust 5
> seems reasonable; expanding blacklist.c to also cover this case (even=
 though
> it's not a blacklisting per se) isn't worth any discussion.
>=20
> Nonetheless, a few specifics:
>=20
> > +config ACPI_REV_OVERRIDE_POSSIBLE
>=20
> Why should that be a config option at all? The code savings should be=

> really, really tiny;

The idea is not about the code savings, but about having a simple way t=
o disable
the whole thing entirely at one point.

All of the workarounds under this option *including* the command line s=
witch
should be temporary.

> and especially in the beginning we might see a few
> machines where testing the override might seem to be a good idea. So =
I'd
> favour having the command line optional, and then only specific quirk=
s
> behind a config option: For the Dell XPS 13 it makes sense to disable=
 the
> quirk if userspace can manage i2s sound; for other systems, there may=
 not be
> such hope. And as this is a machine-specific decision, I fear that we=
 have
> to do CONFIG options for each and every such DMI entry.

I'm not sure if we need a config option for Dell in particular.  We can=
 simply
drop the quirk when it is not necessary any more.

> > +#ifdef CONFIG_ACPI_REV_OVERRIDE_POSSIBLE
> > +static bool acpi_rev_override;
> > +
> > +int __init acpi_rev_override_setup(char *str)
> > +{
> > +=09acpi_rev_override =3D true;
> > +=09return 1;
> > +}
> > +__setup("acpi_rev_override", acpi_rev_override_setup);
> > +#else
> > +#define acpi_rev_override=09false
> > +#endif
>=20
> Why __setup, and not module_param? Should mean a smaller diffstat...

Because it is consistent with the other __setup things done in this fil=
e
(and none of them is a module_param, mind you).

> So, here's what I'd do based on your modification:
>=20
>=20
>  Documentation/kernel-parameters.txt |   16 ++++++++++++++++
>  drivers/acpi/Kconfig                |   20 ++++++++++++++++++++
>  drivers/acpi/blacklist.c            |   26 +++++++++++++++++++++++++=
+
>  drivers/acpi/internal.h             |    1 +
>  drivers/acpi/osl.c                  |    8 ++++++++
>  5 files changed, 71 insertions(+)
>=20
>=20
> [PATCH] acpi: override to set _REV, especially on Dell XPS 13 (2015)
>=20
> By using a module parameter named acpi.override_rev=3D1, the BIOS
> may be told a different supported ACPI revision compared to the defau=
lt
> (which currently is 5, but will be modified to 2 when the revert of
> b1ef29725865 is reverted).
>=20
> Such an override is needed, for example, on a Dell XPS 13 (2015):
> Based on what ACPI exports as is supported version (_REV), the firmwa=
re
> configures the audio device to either work in HDA mode or in I2S mode=
.
> As the latter only works on sufficiently new userspace, add a quirk a=
nd
> an associated config option to force sound to HDA mode.
>=20
> Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
>=20
>=20
> diff --git a/Documentation/kernel-parameters.txt b/Documentation/kern=
el-parameters.txt
> index 61ab162..1edb048 100644
> --- a/Documentation/kernel-parameters.txt
> +++ b/Documentation/kernel-parameters.txt
> @@ -335,6 +335,22 @@ bytes respectively. Such letter suffixes can als=
o be entirely omitted.
>  =09=09=09to assume that this machine's pmtimer latches its value
>  =09=09=09and always returns good values.
> =20
> +=09acpi.rev_override=3D [HW,ACPI]

Nope.  And I said why above.

> +=09=09=09Export 5 as the supported ACPI REV
> +=09=09=09Format: { "0" | "1" } (0 =3D DMI-based quirks,
> +=09=09=09=09=09       1 =3D force-enabled)
> +=09=09=09Up to and including Linux v4.1, the BIOS was told which
> +=09=09=09ACPI revision the ACPICA subsystem in Linux actually
> +=09=09=09supports (which was 5 at the time); from v4.2 on, this
> +=09=09=09value will be set statically to 2 to match the behavior
> +=09=09=09of other ACPI implementations. As some BIOS may operate
> +=09=09=09differently depending on which value _REV is set to, this
> +=09=09=09parameter offers the capability to specify that the
> +=09=09=09previously used value 5 is to be exported to the firmware.
> +=09=09=09Note that such changes in the behavior of the BIOS may
> +=09=09=09only be visible after cold booting the system with this
> +=09=09=09parameter _twice_.
> +
>  =09acpi_sci=3D=09[HW,ACPI] ACPI System Control Interrupt trigger mod=
e
>  =09=09=09Format: { level | edge | high | low }
> =20
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index ab2cbb5..a5272c2 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -430,4 +430,24 @@ config XPOWER_PMIC_OPREGION
> =20
>  endif
> =20
> +config ACPI_REV_OVERRIDE_DELL_XPS_13_2015

I'm still not seeing the point and this is just !@#$%^&*()_+ ugly.

> +=09bool "Dell XPS 13 (2015) quirk to force HDA sound"
> +=09depends on X86 && SND_HDA
> +=09default y
> +=09help
> +=09  Based on what ACPI exports as the supported revision to the fir=
mware,
> +=09  Dell XPS 13 (2015) configures its audio device to either work i=
n HDA
> +=09  mode or in I2S mode, where the former is supposed to be used on=
 Linux
> +=09  until the latter is fully supported (in the kernel as well as i=
n user
> +=09  space).
> +
> +=09  This option enables a DMI-based quirk for the above Dell machin=
e (so
> +=09  that HDA audio is exposed by the platform  firmware to the kern=
el) and
> +=09  makes it possible to force the kernel to return "5" as the supp=
orted
> +=09  ACPI revision via the "acpi_rev_override" command line switch (=
when
> +=09  using that switch it may be necessary to carry out a cold reboo=
t
> +=09  _twice_ in a row to make it take effect on the firmware).
> +
> +=09  If in doubt, say Y.
> +
>  endif=09# ACPI
> diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
> index 1d17919..ed55ad7 100644
> --- a/drivers/acpi/blacklist.c
> +++ b/drivers/acpi/blacklist.c
> @@ -162,6 +162,15 @@ static int __init dmi_disable_osi_win8(const str=
uct dmi_system_id *d)
>  =09acpi_osi_setup("!Windows 2012");
>  =09return 0;
>  }
> +#ifdef CONFIG_ACPI_REV_OVERRIDE_DELL_XPS_13_2015
> +static int __init dmi_enable_rev_override(const struct dmi_system_id=
 *d)
> +{
> +=09printk(KERN_NOTICE PREFIX "DMI detected: %s (force ACPI _REV to 5=
)\n",
> +=09       d->ident);
> +=09acpi_rev_override =3D true;
> +=09return 0;
> +}
> +#endif
> =20
>  static struct dmi_system_id acpi_osi_dmi_table[] __initdata =3D {
>  =09{
> @@ -325,6 +334,23 @@ static struct dmi_system_id acpi_osi_dmi_table[]=
 __initdata =3D {
>  =09=09     DMI_MATCH(DMI_PRODUCT_NAME, "1015PX"),
>  =09=09},
>  =09},
> +
> +#ifdef CONFIG_ACPI_REV_OVERRIDE_DELL_XPS_13_2015
> +=09/*
> +=09 * DELL XPS 13 (2015) switches sound between HDA and I2S
> +=09 * depending on the ACPI _REV callback. If userspace supports
> +=09 * I2S sufficiently (or if you do not care about sound), you
> +=09 * can safely disable this quirk.
> +=09 */
> +=09{
> +=09 .callback =3D dmi_enable_rev_override,
> +=09 .ident =3D "DELL XPS 13 (2015)",
> +=09 .matches =3D {
> +=09=09      DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
> +=09=09      DMI_MATCH(DMI_PRODUCT_NAME, "XPS 13 9343"),
> +=09=09},
> +=09},
> +#endif
>  =09{}
>  };
> =20
> diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
> index ba4a61e..fc8db23 100644
> --- a/drivers/acpi/internal.h
> +++ b/drivers/acpi/internal.h
> @@ -23,6 +23,7 @@
> =20
>  #define PREFIX "ACPI: "
> =20
> +extern bool acpi_rev_override;
>  acpi_status acpi_os_initialize1(void);
>  int init_acpi_device_notify(void);
>  int acpi_scan_init(void);
> diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> index 7ccba39..4d020d0 100644
> --- a/drivers/acpi/osl.c
> +++ b/drivers/acpi/osl.c
> @@ -534,6 +534,9 @@ acpi_os_get_physical_address(void *virt, acpi_phy=
sical_address * phys)
>  }
>  #endif
> =20
> +bool acpi_rev_override;
> +module_param_named(rev_override, acpi_rev_override, bool, 0);
> +
>  #define ACPI_MAX_OVERRIDE_LEN 100
> =20
>  static char acpi_os_name[ACPI_MAX_OVERRIDE_LEN];
> @@ -552,6 +555,11 @@ acpi_os_predefined_override(const struct acpi_pr=
edefined_names *init_val,
>  =09=09*new_val =3D acpi_os_name;
>  =09}
> =20
> +=09if (!memcmp(init_val->name, "_REV", 4) && acpi_rev_override) {
> +=09=09printk(KERN_INFO PREFIX "Overriding _REV return value to 5\n")=
;
> +=09=09*new_val =3D (char *)5;
> +=09}
> +
>  =09return AE_OK;
>  }
> =20

=2D-=20
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
--nextPart4285974.i9AYQ5EKV5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAABCAAGBQJVWTnyAAoJEILEb/54YlRxPB0P/1WL08UkRAq58URkzHnFi0js
wKCmJDZATydyA795boz4EOGgnkbW72G7LubqzTcjzG9AZnT0F/KaeClgrWc0R90Y
mPqAwXZNBpWsI4zz4y1pg2jC5mTebzxl+cu+TTj94/H5HEqW56oLDm1AxtFWWAM2
I+sSfG8p6mbTD8bVR7029xQ0d00zyJK6GWaOBR4e7SAWhAB5onKG9j4VD8cn8uMV
ovGODDRYEGo63Exn+0MgoRKUVrP0kq3wuhRu5YJYQ4QdA4IsonlgDDBPwmENt9d+
trFH7M0hnjGKr19Gpjd90LuMpgeolwQnMvtnWHYWAZS0UA7QUyIM1NyDy+21hwvZ
k8a1NsmqcI0TQYevx9jlZkkc7v4dHu9fyrvyGDko8SLxkH0qgG02ScDYuHqHckQV
CDkLvnALvebEi8onelycjFzt16w2S+Dp9EdY17jIFSBqdgkmqoaLQFLrZIn5xFOa
XdZLCPfpR4LIqpPaID8zGg6nL3BTtkZCH15Z7jPUfHcpOQ7PmUKIwZRC1eEQQxlp
gk6QCelB9Jz9qltxFH87IlGsgYXFcjYpfq/0w8G6VBnLeNK7JyITLvXwNZ+srOYW
IzkXn0YJnsJMDyKPY59GhdMCaVCc6ENU7VwH+oq25LIIdFOdeSSQvraOiV1j3TqA
+2mavcVR7MvfJ+yNXa8y
=AV9f
-----END PGP SIGNATURE-----

--nextPart4285974.i9AYQ5EKV5--

