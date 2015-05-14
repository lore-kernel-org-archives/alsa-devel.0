From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 2/4] acpi: allow for an override to set _REV
Date: Thu, 14 May 2015 23:55:33 +0200
Message-ID: <1582352.6U4javOB0e@vostro.rjw.lan>
References: <1431610288-26737-1-git-send-email-linux@dominikbrodowski.net> <1431610288-26737-3-git-send-email-linux@dominikbrodowski.net> <40911270.BDUfRW4XxV@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <40911270.BDUfRW4XxV@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: linux-acpi@vger.kernel.org, mario_limonciello@dell.com, broonie@kernel.org, matthew.garrett@coreos.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Thursday, May 14, 2015 10:36:52 PM Rafael J. Wysocki wrote:
> On Thursday, May 14, 2015 03:31:26 PM Dominik Brodowski wrote:
> > By using a module parameter named acpi.supported_rev=<value>, the BIOS
> > may be told a different supported ACPI revision compared to the default
> > (which currently is 5, but will be modified to 2 when the revert of
> > b1ef29725865 is reverted).
> > 
> > Signed-off-by: Dominik Brodowski <linux@dominikbrodowski.net>
> > ---
> >  Documentation/kernel-parameters.txt | 14 ++++++++++++++
> >  drivers/acpi/osl.c                  | 16 ++++++++++++++++
> >  2 files changed, 30 insertions(+)
> > 
> > diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
> > index 61ab162..75f1f8e 100644
> > --- a/Documentation/kernel-parameters.txt
> > +++ b/Documentation/kernel-parameters.txt
> > @@ -335,6 +335,20 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
> >  			to assume that this machine's pmtimer latches its value
> >  			and always returns good values.
> >  
> > +	acpi.rev= [HW,ACPI]
> > +			Tell ACPI BIOS the supported ACPI REV
> > +			Format: <int> in range 0..5
> > +			Up to and including Linux v4.1, the BIOS was told which
> > +			ACPI revision the ACPICA subsystem in Linux actually
> > +			supports (which was 5 at the time); from v4.2 on, this
> > +			value will be set statically to 2 to match the behavior
> > +			of other ACPI implementations. As some BIOS may operate
> > +			differently depending on which value _REV is set to, this
> > +			parameter offers the capability to specify what to export
> > +			to the BIOS. Note that such changes in the behavior of
> > +			the BIOS may only be visible after cold booting the
> > +			system with this parameter _twice_.
> > +
> >  	acpi_sci=	[HW,ACPI] ACPI System Control Interrupt trigger mode
> >  			Format: { level | edge | high | low }
> >  
> > diff --git a/drivers/acpi/osl.c b/drivers/acpi/osl.c
> > index db14a66..caa52f7 100644
> > --- a/drivers/acpi/osl.c
> > +++ b/drivers/acpi/osl.c
> > @@ -538,6 +538,11 @@ acpi_os_get_physical_address(void *virt, acpi_physical_address * phys)
> >  
> >  static char acpi_os_name[ACPI_MAX_OVERRIDE_LEN];
> >  
> > +/* acpi_supported_rev is 0 in case of no override; overrides are limited to
> > + *  values between 1 to 5. To simplify casting, use an unsigned long */
> > +static unsigned long acpi_supported_rev;
> > +module_param_named(rev, acpi_supported_rev, ulong, 0);
> > +
> >  acpi_status
> >  acpi_os_predefined_override(const struct acpi_predefined_names *init_val,
> >  			    char **new_val)
> > @@ -552,6 +557,17 @@ acpi_os_predefined_override(const struct acpi_predefined_names *init_val,
> >  		*new_val = acpi_os_name;
> >  	}
> >  
> > +	if (!memcmp(init_val->name, "_REV", 4) && (acpi_supported_rev > 0)) {
> > +		if (acpi_supported_rev <= 5) {
> 
> So the only value that would really make sense here is 5.
> 
> 1 should never ever be used with Linux, 2 is the default, 3 is equivalent to 5
> for all practical purposes and 4 has never been used in practice, so it is
> meaningless.
> 
> I'd be better to rename the command line switch to acpi.rev_override and
> simply do "acpi_supported_rev = 5" for it as well as in acpi_set_supported_rev()
> in [3/4].
> 
> > +			printk(KERN_INFO PREFIX
> > +				"Overriding _REV definition to %lu\n",
> > +				acpi_supported_rev);
> > +			*new_val = (char *) acpi_supported_rev;
> > +		} else
> > +			printk(KERN_INFO PREFIX
> > +				"_REV override must be between 1 to 5");
> > +	}
> > +
> >  	return AE_OK;
> >  }

Overall, what about the appended patch instead of your [2-3/4] (modulo the new
command line parameter description which is missing here ATM)?

---
 drivers/acpi/Kconfig     |   22 ++++++++++++++++++++++
 drivers/acpi/blacklist.c |   26 ++++++++++++++++++++++++++
 drivers/acpi/internal.h  |    4 ++++
 drivers/acpi/osl.c       |   18 ++++++++++++++++++
 4 files changed, 70 insertions(+)

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
@@ -23,6 +23,10 @@
 
 #define PREFIX "ACPI: "
 
+#ifdef CONFIG_ACPI_REV_OVERRIDE_POSSIBLE
+int __init acpi_rev_override_setup(char *str);
+#endif
+
 acpi_status acpi_os_initialize1(void);
 int init_acpi_device_notify(void);
 int acpi_scan_init(void);
Index: linux-pm/drivers/acpi/osl.c
===================================================================
--- linux-pm.orig/drivers/acpi/osl.c
+++ linux-pm/drivers/acpi/osl.c
@@ -534,6 +534,19 @@ acpi_os_get_physical_address(void *virt,
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
@@ -552,6 +565,11 @@ acpi_os_predefined_override(const struct
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
@@ -428,6 +428,28 @@ config XPOWER_PMIC_OPREGION
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
+	  that HDA audio is exposed by the platform  firmware to the kernel) and
+	  makes it possible to force the kernel to return "5" as the supported
+	  ACPI revision via the "acpi_rev_override" command line switch (when
+	  using that switch it may be necessary to carry out a cold reboot
+	  _twice_ in a row to make it take effect on the firmware).
+
 endif
 
 endif	# ACPI

