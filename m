From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH] ACPI / device_sysfs: change _ADR representation to 64 bits
Date: Mon, 15 Apr 2019 10:18:57 -0500
Message-ID: <20190415151857.25531-1-pierre-louis.bossart@linux.intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org, vkoul@kernel.org, gregkh@linuxfoundation.org, liam.r.girdwood@linux.intel.com, jank@cadence.com, joe@perches.com, srinivas.kandagatla@linaro.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Robert Moore <robert.moore@intel.com>, Erik Schmauss <erik.schmauss@intel.com>, "open list:ACPI" <linux-acpi@vger.kernel.org>, "open list:ACPI COMPONENT ARCHITECTURE ACPICA" <devel@acpica.org>
List-Id: alsa-devel@alsa-project.org

Standards such as the MIPI DisCo for SoundWire 1.0 specification
assume the _ADR field is 64 bits.

_ADR is defined as an "Integer" represented as 64 bits since ACPI 2.0
released in 2002. The low levels already use _ADR as 64 bits, e.g. in
struct acpi_device_info.

This patch bumps the representation used for sysfs to 64 bits.

Example with a SoundWire device, the results show the complete
vendorID and linkID which were omitted before:

Before:
$ more /sys/bus/acpi/devices/device\:38/adr
0x5d070000
After:
$ more /sys/bus/acpi/devices/device\:38/adr
0x000010025d070000

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 drivers/acpi/device_sysfs.c | 3 +--
 include/acpi/acpi_bus.h     | 2 +-
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/acpi/device_sysfs.c b/drivers/acpi/device_sysfs.c
index 8940054d6250..f8d73ae42529 100644
--- a/drivers/acpi/device_sysfs.c
+++ b/drivers/acpi/device_sysfs.c
@@ -428,8 +428,7 @@ static ssize_t acpi_device_adr_show(struct device *dev,
 {
 	struct acpi_device *acpi_dev = to_acpi_device(dev);
 
-	return sprintf(buf, "0x%08x\n",
-		       (unsigned int)(acpi_dev->pnp.bus_address));
+	return sprintf(buf, "0x%016llx\n", acpi_dev->pnp.bus_address);
 }
 static DEVICE_ATTR(adr, 0444, acpi_device_adr_show, NULL);
 
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index f7981751ac77..9075e28ea60a 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -230,7 +230,7 @@ struct acpi_device_dir {
 /* Plug and Play */
 
 typedef char acpi_bus_id[8];
-typedef unsigned long acpi_bus_address;
+typedef u64 acpi_bus_address;
 typedef char acpi_device_name[40];
 typedef char acpi_device_class[20];
 
-- 
2.17.1
