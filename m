From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/4] acpi: allow for an override to set _REV
Date: Tue, 30 Jun 2015 22:11:28 +0200
Message-ID: <5115175.tbCl1JQVaV@vostro.rjw.lan>
References: <20150517174144.GA17503@light.dominikbrodowski.net> <DB6E482E89290547898851B8CC9D8110016A5EBC17@AUSX7MCPS302.AMER.DELL.COM> <23116293.JAxziy2cCE@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <23116293.JAxziy2cCE@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Mario_Limonciello@dell.com, linux-acpi@vger.kernel.org
Cc: matthew.garrett@coreos.com, linux@dominikbrodowski.net, broonie@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Saturday, May 23, 2015 12:15:54 AM Rafael J. Wysocki wrote:
> On Friday, May 22, 2015 04:19:05 PM Mario_Limonciello@Dell.com wrote:
> > > OK, so do we have any proof that anything in addition to the sound thing is broken by returning 2 from _REV?
> > > 
> > > If not, then we're probably spending too much time discussing this.
> > 
> > From a Dell perspective I'm not aware of anything else breaking, but I'll be sure to raise its attention and any associated details if I become privy to them.  I'm working with architecture to ensure that future products are not relying on _REV values as well.
> > I know Matthew had mentioned that another OEM's product was using this as well, but I don't know what for.
> 
> OK, here's a deal.
> 
> I'll wait for the next few days for someone to tell me if there's any
> known system in addition to the XPS 13 (2015) which breaks as a result
> of the change to return 2 from _REV.  If none are reported before the
> next Friday, I'll just apply the patch I posted some time ago.  If any
> reports come in later, we'll still be able to rearrange things during
> the 4.2 cycle or even later.
> 
> If *something* is reported next week, I'll reconsider the approach depending
> on what that thing is.

OK, so nobody has reported anything and below is the patch I'm planning to
apply (before restoring _REV=2).

Please let me know if there are objections.

Thanks,
Rafael


---
From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Subject: ACPI / init: Make it possible to override _REV

The platform firmware on some systems expects Linux to return "5" as
the supported ACPI revision which makes it expose system configuration
information in a special way.

For example, based on what ACPI exports as the supported revision,
Dell XPS 13 (2015) configures its audio device to either work in HDA
mode or in I2S mode, where the former is supposed to be used on Linux
until the latter is fully supported (in the kernel as well as in user
space).

Since ACPI 6 mandates that _REV should return "2" if ACPI 2 or later
is supported by the OS, a subsequent change will make that happen, so
make it possible to override that on systems where "5" is expected to
be returned for Linux to work correctly one them (such as the Dell
machine mentioned above).

Original-by: Dominik Brodowski <linux@dominikbrodowski.net>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 Documentation/kernel-parameters.txt |    6 ++++++
 drivers/acpi/Kconfig                |   20 ++++++++++++++++++++
 drivers/acpi/blacklist.c            |   26 ++++++++++++++++++++++++++
 drivers/acpi/internal.h             |    1 +
 drivers/acpi/osl.c                  |   18 ++++++++++++++++++
 5 files changed, 71 insertions(+)

Index: linux-pm/drivers/acpi/blacklist.c
===================================================================
--- linux-pm.orig/drivers/acpi/blacklist.c
+++ linux-pm/drivers/acpi/blacklist.c
@@ -162,6 +162,15 @@ static int __init dmi_disable_osi_win8(c
 	acpi_osi_setup("!Windows 2012");
 	return 0;
 }
+#ifdef CONFIG_ACPI_REV_OVERRIDE_POSSIBLE
+static int __init dmi_enable_rev_override(const struct dmi_system_id *d)
+{
+	printk(KERN_NOTICE PREFIX "DMI detected: %s (force ACPI _REV to 5)\n",
+	       d->ident);
+	acpi_rev_override_setup(NULL);
+	return 0;
+}
+#endif
 
 static struct dmi_system_id acpi_osi_dmi_table[] __initdata = {
 	{
@@ -325,6 +334,23 @@ static struct dmi_system_id acpi_osi_dmi
 		     DMI_MATCH(DMI_PRODUCT_NAME, "1015PX"),
 		},
 	},
+
+#ifdef CONFIG_ACPI_REV_OVERRIDE_POSSIBLE
+	/*
+	 * DELL XPS 13 (2015) switches sound between HDA and I2S
+	 * depending on the ACPI _REV callback. If userspace supports
+	 * I2S sufficiently (or if you do not care about sound), you
+	 * can safely disable this quirk.
+	 */
+	{
+	 .callback = dmi_enable_rev_override,
+	 .ident = "DELL XPS 13 (2015)",
+	 .matches = {
+		      DMI_MATCH(DMI_SYS_VENDOR, "Dell Inc."),
+		      DMI_MATCH(DMI_PRODUCT_NAME, "XPS 13 9343"),
+		},
+	},
+#endif
 	{}
 };
 
Index: linux-pm/drivers/acpi/internal.h
===================================================================
--- linux-pm.orig/drivers/acpi/internal.h
+++ linux-pm/drivers/acpi/internal.h
@@ -58,6 +58,7 @@ void acpi_cmos_rtc_init(void);
 #else
 static inline void acpi_cmos_rtc_init(void) {}
 #endif
+int acpi_rev_override_setup(char *str);
 
 extern bool acpi_force_hot_remove;
 
Index: linux-pm/drivers/acpi/osl.c
===================================================================
--- linux-pm.orig/drivers/acpi/osl.c
+++ linux-pm/drivers/acpi/osl.c
@@ -530,6 +530,19 @@ acpi_os_get_physical_address(void *virt,
 }
 #endif
 
+#ifdef CONFIG_ACPI_REV_OVERRIDE_POSSIBLE
+static bool acpi_rev_override;
+
+int __init acpi_rev_override_setup(char *str)
+{
+	acpi_rev_override = true;
+	return 1;
+}
+__setup("acpi_rev_override", acpi_rev_override_setup);
+#else
+#define acpi_rev_override	false
+#endif
+
 #define ACPI_MAX_OVERRIDE_LEN 100
 
 static char acpi_os_name[ACPI_MAX_OVERRIDE_LEN];
@@ -548,6 +561,11 @@ acpi_os_predefined_override(const struct
 		*new_val = acpi_os_name;
 	}
 
+	if (!memcmp(init_val->name, "_REV", 4) && acpi_rev_override) {
+		printk(KERN_INFO PREFIX "Overriding _REV return value to 5\n");
+		*new_val = (char *)5;
+	}
+
 	return AE_OK;
 }
 
Index: linux-pm/drivers/acpi/Kconfig
===================================================================
--- linux-pm.orig/drivers/acpi/Kconfig
+++ linux-pm/drivers/acpi/Kconfig
@@ -431,6 +431,26 @@ config XPOWER_PMIC_OPREGION
 	help
 	  This config adds ACPI operation region support for XPower AXP288 PMIC.
 
++config ACPI_REV_OVERRIDE_POSSIBLE
+	bool "Allow supported ACPI revision to be overriden"
+	depends on X86
+	default y
+	help
+	  The platform firmware on some systems expects Linux to return "5" as
+	  the supported ACPI revision which makes it expose system configuration
+	  information in a special way.
+
+	  For example, based on what ACPI exports as the supported revision,
+	  Dell XPS 13 (2015) configures its audio device to either work in HDA
+	  mode or in I2S mode, where the former is supposed to be used on Linux
+	  until the latter is fully supported (in the kernel as well as in user
+	  space).
+
+	  This option enables a DMI-based quirk for the above Dell machine (so
+	  that HDA audio is exposed by the platform firmware to the kernel) and
+	  makes it possible to force the kernel to return "5" as the supported
+	  ACPI revision via the "acpi_rev_override" command line switch.
+
 endif
 
 endif	# ACPI
Index: linux-pm/Documentation/kernel-parameters.txt
===================================================================
--- linux-pm.orig/Documentation/kernel-parameters.txt
+++ linux-pm/Documentation/kernel-parameters.txt
@@ -285,6 +285,12 @@ bytes respectively. Such letter suffixes
 			dynamic table installation which will install SSDT
 			tables to /sys/firmware/acpi/tables/dynamic.
 
+	acpi_rev_override [ACPI] Override the _REV object to return 5 (instead
+			of 2 which is mandated by ACPI 6) as the supported ACPI
+			specification revision (when using this switch, it may
+			be necessary to carry out a cold reboot _twice_ in a
+			row to make it take effect on the platform firmware).
+
 	acpi_rsdp=	[ACPI,EFI,KEXEC]
 			Pass the RSDP address to the kernel, mostly used
 			on machines running EFI runtime service to boot the

