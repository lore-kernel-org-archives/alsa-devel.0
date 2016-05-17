From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH 1/2] device property: Add function to search
 for named child of device
Date: Tue, 17 May 2016 11:28:58 +0100
Message-ID: <39ccf372455f0b21a9ca29e58baf30ac4cd0c281.1463477116.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1463477116.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta3.messagelabs.com (mail1.bemta3.messagelabs.com
 [195.245.230.163])
 by alsa0.perex.cz (Postfix) with ESMTP id D83F82607C8
 for <alsa-devel@alsa-project.org>; Tue, 17 May 2016 12:29:02 +0200 (CEST)
In-Reply-To: <cover.1463477116.git.Adam.Thomson.Opensource@diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J.Wysocki" <rafael.j.wysocki@intel.com>, Len Brown <lenb@kernel.org>
Cc: alsa-devel@alsa-project.org, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Support Opensource <support.opensource@diasemi.com>, Hanjun Guo <hanjun.guo@linaro.org>, linux-kernel@vger.kernel.org, Suthikulpanit@diasemi.com, linux-acpi@vger.kernel.org, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, Suravee <Suravee.Suthikulpanit@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, devel@acpica.org
List-Id: alsa-devel@alsa-project.org

For device nodes in both DT and ACPI, it possible to have named
child nodes which contain properties (an existing example being
gpio-leds). This adds a function to find a named child node for
a device which can be used by drivers for property retrieval.

For ACPI data node name matching, a helper function is also added
which returns false if CONFIG_ACPI is not set, otherwise it
performs a string comparison on the data node name. This avoids
using the acpi_data_node struct for non CONFIG_ACPI builds,
which would otherwise cause a build failure.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Tested-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
---
 drivers/base/property.c  | 28 ++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h  |  7 +++++++
 include/linux/acpi.h     |  6 ++++++
 include/linux/property.h |  3 +++
 4 files changed, 44 insertions(+)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index 7f692ac..8b2cb09 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -880,6 +880,34 @@ struct fwnode_handle *device_get_next_child_node(struct device *dev,
 EXPORT_SYMBOL_GPL(device_get_next_child_node);

 /**
+ * device_get_named_child_node - Return first matching named child node handle
+ * @dev: Device to find the named child node for.
+ * @childname: String to match child node name against.
+ */
+struct fwnode_handle *device_get_named_child_node(struct device *dev,
+						  const char *childname)
+{
+	struct fwnode_handle *child;
+
+	/*
+	 * Find first matching named child node of this device.
+	 * For ACPI this will be a data only sub-node.
+	 */
+	device_for_each_child_node(dev, child) {
+		if (is_of_node(child)) {
+			if (!strcasecmp(to_of_node(child)->name, childname))
+				return child;
+		} else if (is_acpi_data_node(child)) {
+			if (acpi_data_node_match(child, childname))
+				return child;
+		}
+	}
+
+	return NULL;
+}
+EXPORT_SYMBOL_GPL(device_get_named_child_node);
+
+/**
  * fwnode_handle_put - Drop reference to a device node
  * @fwnode: Pointer to the device node to drop the reference to.
  *
diff --git a/include/acpi/acpi_bus.h b/include/acpi/acpi_bus.h
index 3a93250..6dc3544 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -420,6 +420,13 @@ static inline struct acpi_data_node *to_acpi_data_node(struct fwnode_handle *fwn
 		container_of(fwnode, struct acpi_data_node, fwnode) : NULL;
 }

+static inline bool acpi_data_node_match(struct fwnode_handle *fwnode,
+					const char *name)
+{
+	return is_acpi_data_node(fwnode) ?
+		(!strcasecmp(to_acpi_data_node(fwnode)->name, name)) : false;
+}
+
 static inline struct fwnode_handle *acpi_fwnode_handle(struct acpi_device *adev)
 {
 	return &adev->fwnode;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 06ed7e5..c37a385 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -576,6 +576,12 @@ static inline struct acpi_data_node *to_acpi_data_node(struct fwnode_handle *fwn
 	return NULL;
 }

+static inline bool acpi_data_node_match(struct fwnode_handle *fwnode,
+					const char *name)
+{
+	return false;
+}
+
 static inline struct fwnode_handle *acpi_fwnode_handle(struct acpi_device *adev)
 {
 	return NULL;
diff --git a/include/linux/property.h b/include/linux/property.h
index b51fcd3..d2752dc 100644
--- a/include/linux/property.h
+++ b/include/linux/property.h
@@ -77,6 +77,9 @@ struct fwnode_handle *device_get_next_child_node(struct device *dev,
 	for (child = device_get_next_child_node(dev, NULL); child;	\
 	     child = device_get_next_child_node(dev, child))

+struct fwnode_handle *device_get_named_child_node(struct device *dev,
+						  const char *childname);
+
 void fwnode_handle_put(struct fwnode_handle *fwnode);

 unsigned int device_get_child_node_count(struct device *dev);
--
1.9.3
