From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 2/4] acpi: allow for an override to set _REV
Date: Sun, 17 May 2015 19:41:44 +0200
Message-ID: <20150517174144.GA17503@light.dominikbrodowski.net>
References: <20150514141823.GA29030@light.dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150514141823.GA29030@light.dominikbrodowski.net>
 <40911270.BDUfRW4XxV@vostro.rjw.lan>
 <1582352.6U4javOB0e@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org, mario_limonciello@dell.com, broonie@kernel.org, matthew.garrett@coreos.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2015 at 11:55:33 PM Rafael J. Wysocki wrote:
> On Thursday, May 14, 2015 10:36:52 PM Rafael J. Wysocki wrote:
> > So the only value that would really make sense here is 5.

> Overall, what about the appended patch instead of your [2-3/4] (modulo the
> new command line parameter description which is missing here ATM)?

Well, this approach works as well -- limiting it to an override for just 5
seems reasonable; expanding blacklist.c to also cover this case (even though
it's not a blacklisting per se) isn't worth any discussion.

Nonetheless, a few specifics:

> +config ACPI_REV_OVERRIDE_POSSIBLE

Why should that be a config option at all? The code savings should be
really, really tiny; and especially in the beginning we might see a few
machines where testing the override might seem to be a good idea. So I'd
favour having the command line optional, and then only specific quirks
behind a config option: For the Dell XPS 13 it makes sense to disable the
quirk if userspace can manage i2s sound; for other systems, there may not be
such hope. And as this is a machine-specific decision, I fear that we have
to do CONFIG options for each and every such DMI entry.

> +#ifdef CONFIG_ACPI_REV_OVERRIDE_POSSIBLE
> +static bool acpi_rev_override;
> +
> +int __init acpi_rev_override_setup(char *str)
> +{
> +	acpi_rev_override =3D true;
> +	return 1;
> +}
> +__setup("acpi_rev_override", acpi_rev_override_setup);
> +#else
> +#define acpi_rev_override	false
> +#endif

Why __setup, and not module_param? Should mean a smaller diffstat...

So, here's what I'd do based on your modification:


 Documentation/kernel-parameters.txt |   16 ++++++++++++++++
 drivers/acpi/Kconfig                |   20 ++++++++++++++++++++
 drivers/acpi/blacklist.c            |   26 ++++++++++++++++++++++++++
 drivers/acpi/internal.h             |    1 +
 drivers/acpi/osl.c                  |    8 ++++++++
 5 files changed, 71 insertions(+)


[PATCH] acpi: override to set _REV, especially on Dell XPS 13 (2015)

By using a module parameter named acpi.override_rev=3D1, the BIOS
may be told a different supported ACPI revision compared to the default
(which currently is 5, but will be modified to 2 when the revert of
b1ef29725865 is reverted).

Such an override is needed, for example, on a Dell XPS 13 (2015):
Based on what ACPI exports as is supported version (_REV), the firmware
configures the audio device to either work in HDA mode or in I2S mode.
As the latter only works on sufficiently new userspace, add a quirk and
an associated config option to force sound to HDA mode.

Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>


diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-par=
ameters.txt
index 61ab162..1edb048 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -335,6 +335,22 @@ bytes respectively. Such letter suffixes can also be e=
ntirely omitted.
 			to assume that this machine's pmtimer latches its value
 			and always returns good values.
=20
+	acpi.rev_override=3D [HW,ACPI]
+			Export 5 as the supported ACPI REV
+			Format: { "0" | "1" } (0 =3D DMI-based quirks,
+					       1 =3D force-enabled)
+			Up to and including Linux v4.1, the BIOS was told which
+			ACPI revision the ACPICA subsystem in Linux actually
+			supports (which was 5 at the time); from v4.2 on, this
+			value will be set statically to 2 to match the behavior
+			of other ACPI implementations. As some BIOS may operate
+			differently depending on which value _REV is set to, this
+			parameter offers the capability to specify that the
+			previously used value 5 is to be exported to the firmware.
+			Note that such changes in the behavior of the BIOS may
+			only be visible after cold booting the system with this
+			parameter _twice_.
+
 	acpi_sci=3D	[HW,ACPI] ACPI System Control Interrupt trigger mode
 			Format: { level | edge | high | low }
=20
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index ab2cbb5..a5272c2 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -430,4 +430,24 @@ config XPOWER_PMIC_OPREGION
=20
 endif
=20
+config ACPI_REV_OVERRIDE_DELL_XPS_13_2015
+	bool "Dell XPS 13 (2015) quirk to force HDA sound"
+	depends on X86 && SND_HDA
+	default y
+	help
+	  Based on what ACPI exports as the supported revision to the firmware,
+	  Dell XPS 13 (2015) configures its audio device to either work in HDA
+	  mode or in I2S mode, where the former is supposed to be used on Linux
+	  until the latter is fully supported (in the kernel as well as in user
+	  space).
+
+	  This option enables a DMI-based quirk for the above Dell machine (so
+	  that HDA audio is exposed by the platform  firmware to the kernel) and
+	  makes it possible to force the kernel to return "5" as the supported
+	  ACPI revision via the "acpi_rev_override" command line switch (when
+	  using that switch it may be necessary to carry out a cold reboot
+	  _twice_ in a row to make it take effect on the firmware).
+
+	  If in doubt, say Y.
+
 endif	# ACPI
diff --git a/drivers/acpi/blacklist.c b/drivers/acpi/blacklist.c
index 1d17919..ed55ad7 100644
--- a/drivers/acpi/blacklist.c
+++ b/drivers/acpi/blacklist.c
@@ -162,6 +162,15 @@ static int __init dmi_disable_osi_win8(const struct dm=
i_system_id *d)
 	acpi_osi_setup("!Windows 2012");
 	return 0;
 }
+#ifdef CONFIG_ACPI_REV_OVERRIDE_DELL_XPS_13_2015
+static int __init dmi_enable_rev_override(const struct dmi_system_id *d)
+{
+	printk(KERN_NOTICE PREFIX "DMI detected: %s (force ACPI _REV to 5)\n",
+	       d->ident);
+	acpi_rev_override =3D true;
+	return 0;
+}
+#endif
=20
 static struct dmi_system_id acpi_osi_dmi_table[] __initdata =3D {
 	{
@@ -325,6 +334,23 @@ static struct dmi_system_id acpi_osi_dmi_table[] __ini=
tdata =3D {
 		     DMI_MATCH(DMI_PRODUCT_NAME, "1015PX"),
 		},
 	},
+
+#ifdef CONFIG_ACPI_REV_OVERRIDE_DELL_XPS_13_2015
+	/*
+	 * DELL XPS 13 (2015) switches sound between HDA and I2S
+	 * depending on the ACPI _REV callback. If userspace supports
+	 * I2S sufficiently (or if you do not care about sound), you
+	 * can safely disable this quirk.
+	 */
+	{
+	 .callback =3D dmi_enable_rev_override,
+	 .ident =3D "DELL XPS 13 (2015)",
+	 .matches =3D {
+		      DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		      DMI_MATCH(DMI_PRODUCT_NAME, "XPS 13 9343"),
+		},
+	},
+#endif
 	{}
 };
=20
diff --git a/drivers/acpi/internal.h b/drivers/acpi/internal.h
index ba4a61e..fc8db23 100644
--- a/drivers/acpi/internal.h
+++ b/drivers/acpi/internal.h
@@ -23,6 +23,7 @@
=20
 #define PREFIX "ACPI: "
=20
+extern bool acpi_rev_override;
 acpi_status acpi_os_initialize1(void);
 int init_acpi_device_notify(void);
 int acpi_scan_init(void);
diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
index 7ccba39..4d020d0 100644
--- a/drivers/acpi/osl.c
+++ b/drivers/acpi/osl.c
@@ -534,6 +534,9 @@ acpi_os_get_physical_address(void *virt, acpi_physical_=
address * phys)
 }
 #endif
=20
+bool acpi_rev_override;
+module_param_named(rev_override, acpi_rev_override, bool, 0);
+
 #define ACPI_MAX_OVERRIDE_LEN 100
=20
 static char acpi_os_name[ACPI_MAX_OVERRIDE_LEN];
@@ -552,6 +555,11 @@ acpi_os_predefined_override(const struct acpi_predefin=
ed_names *init_val,
 		*new_val =3D acpi_os_name;
 	}
=20
+	if (!memcmp(init_val->name, "_REV", 4) && acpi_rev_override) {
+		printk(KERN_INFO PREFIX "Overriding _REV return value to 5\n");
+		*new_val =3D (char *)5;
+	}
+
 	return AE_OK;
 }
=20

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVWNLYAAoJEJqXYIlMjaMNynwP/14FsybUuQVfhx1EWyqh1kkM
/kSGY4GIbu2/tKdO2jTOtZ9hmcWpTMl5Ph4MQHxovCJ2qjprJuhVTbJHVj5yKSCP
CE1ORmqF9XC8cEVAnDPB7UHv7pUdHyd6rg8fU7oOYgyCyZFkraXq0BBH+0/kHiHB
1VzGQgj0ruza1KHfPXpFYd+EkC704CovuOPkmUJO0L0JsirEWu1PAswadNTGVXNc
Bbi9aCpQQcPkXDh5Gz7K2DpQnOko+AmdFCDpiFpAp/jiULM8o2xPgg4GvxR7w4u9
eae3tv18R1p7XTNLqVzYfVjHD5VgNROfKrvaNPyc/UGJsEJkAJGYkOBlD/Ih93O/
REeckTvnp27r/L523l4fxT1uPpmaGx4TIQx3MCsgZXis+AaUiVLMvngI85E91nba
8XbMT620Q835sfdpVGgQZiBNYIifO34G+OsnYJCC76cVwDgLYhgjvHN2cEeKHNkK
LjGVSifQ12bUofsdjgZ4RvRAj5+b8eOraqwaqe56zCLn8VtmkAdCDTeKCeqIHGE+
Qm23sCnIbmmHMOrd4KTeSZiEoTY6AUXwn3xECmtLjwQ/v8NVjZl9TZP0QCPBsBaD
TPLv94CO7CS3HmeyKCPqYOsS489Dj7ngl4u9w8hncd0YIhWzVHhC3IVykjdrYdr0
PL9fzle/INDxHsnPvv+v
=zldo
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
