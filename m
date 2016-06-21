From: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Subject: [PATCH v4 1/2] device property: Add function to search
 for named child of device
Date: Tue, 21 Jun 2016 18:50:20 +0100
Message-ID: <a3dca0b22f9cfabdac6b8e9de0a349aa18721d9f.1466523027.git.Adam.Thomson.Opensource@diasemi.com>
References: <cover.1466523027.git.Adam.Thomson.Opensource@diasemi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail1.bemta14.messagelabs.com (mail1.bemta14.messagelabs.com
 [193.109.254.117])
 by alsa0.perex.cz (Postfix) with ESMTP id C18E1266C6C
 for <alsa-devel@alsa-project.org>; Tue, 21 Jun 2016 19:50:22 +0200 (CEST)
In-Reply-To: <cover.1466523027.git.Adam.Thomson.Opensource@diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, "Rafael J.Wysocki" <rafael.j.wysocki@intel.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Len Brown <lenb@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: devicetree <devicetree@vger.kernel.org>, alsa-devel <alsa-devel@alsa-project.org>, Support Opensource <support.opensource@diasemi.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-acpi <linux-acpi@vger.kernel.org>, Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
List-Id: alsa-devel@alsa-project.org

For device nodes in both DT and ACPI, it possible to have named
child nodes which contain properties (an existing example being
gpio-leds). This adds a function to find a named child node for
a device which can be used by drivers for property retrieval.

For DT data node name matching, of_node_cmp() and similar functions
are made available outside of CONFIG_OF block so the new function
can reference these for DT and non-DT builds.

For ACPI data node name matching, a helper function is also added
which returns false if CONFIG_ACPI is not set, otherwise it
performs a string comparison on the data node name. This avoids
using the acpi_data_node struct for non CONFIG_ACPI builds,
which would otherwise cause a build failure.

Signed-off-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Acked-by: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>
Acked-by: Rob Herring <robh@kernel.org>
---

Changes in v4:
 - Rebase to v4.7-rc4
 - Use strcmp() in acpi_data_node_match() for matching ACPI data node strings,
   as expected by ACPI specification.

Changes in v3:
 - Move of_*_cmp() functions in of.h outside of CONFIG_OF block so they are
   available for non-DT builds
 - In device_get_named_child_node(), use of_node_cmp() helper macro instead of
   strcasecmp() (node names not alway case insensitive, depending on platform).

Changes in v2:
 - Rebase to v4.7-rc1

 drivers/base/property.c  | 28 ++++++++++++++++++++++++++++
 include/acpi/acpi_bus.h  |  7 +++++++
 include/linux/acpi.h     |  6 ++++++
 include/linux/of.h       | 14 +++++++-------
 include/linux/property.h |  3 +++
 5 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/drivers/base/property.c b/drivers/base/property.c
index f38c21d..43a36d6 100644
--- a/drivers/base/property.c
+++ b/drivers/base/property.c
@@ -888,6 +888,34 @@ struct fwnode_handle *device_get_next_child_node(struct device *dev,
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
+			if (!of_node_cmp(to_of_node(child)->name, childname))
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
index 788c6c3..c1a524d 100644
--- a/include/acpi/acpi_bus.h
+++ b/include/acpi/acpi_bus.h
@@ -420,6 +420,13 @@ static inline struct acpi_data_node *to_acpi_data_node(struct fwnode_handle *fwn
 		container_of(fwnode, struct acpi_data_node, fwnode) : NULL;
 }

+static inline bool acpi_data_node_match(struct fwnode_handle *fwnode,
+					const char *name)
+{
+	return is_acpi_data_node(fwnode) ?
+		(!strcmp(to_acpi_data_node(fwnode)->name, name)) : false;
+}
+
 static inline struct fwnode_handle *acpi_fwnode_handle(struct acpi_device *adev)
 {
 	return &adev->fwnode;
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 288fac5..03039c4 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -568,6 +568,12 @@ static inline struct acpi_data_node *to_acpi_data_node(struct fwnode_handle *fwn
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
diff --git a/include/linux/of.h b/include/linux/of.h
index 74eb28c..310e32f 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -238,13 +238,6 @@ static inline unsigned long of_read_ulong(const __be32 *cell, int size)
 #define OF_ROOT_NODE_SIZE_CELLS_DEFAULT 1
 #endif

-/* Default string compare functions, Allow arch asm/prom.h to override */
-#if !defined(of_compat_cmp)
-#define of_compat_cmp(s1, s2, l)	strcasecmp((s1), (s2))
-#define of_prop_cmp(s1, s2)		strcmp((s1), (s2))
-#define of_node_cmp(s1, s2)		strcasecmp((s1), (s2))
-#endif
-
 #define OF_IS_DYNAMIC(x) test_bit(OF_DYNAMIC, &x->_flags)
 #define OF_MARK_DYNAMIC(x) set_bit(OF_DYNAMIC, &x->_flags)

@@ -726,6 +719,13 @@ static inline void of_property_clear_flag(struct property *p, unsigned long flag
 #define of_match_node(_matches, _node)	NULL
 #endif /* CONFIG_OF */

+/* Default string compare functions, Allow arch asm/prom.h to override */
+#if !defined(of_compat_cmp)
+#define of_compat_cmp(s1, s2, l)	strcasecmp((s1), (s2))
+#define of_prop_cmp(s1, s2)		strcmp((s1), (s2))
+#define of_node_cmp(s1, s2)		strcasecmp((s1), (s2))
+#endif
+
 #if defined(CONFIG_OF) && defined(CONFIG_NUMA)
 extern int of_node_to_nid(struct device_node *np);
 #else
diff --git a/include/linux/property.h b/include/linux/property.h
index ecab11e..3a2f9ae 100644
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
