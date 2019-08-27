From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: [PATCH 1/2] PCI: Add a helper to check Power Resource Requirements _PR3 existence
Date: Tue, 27 Aug 2019 21:47:55 +0800
Message-ID: <20190827134756.10807-1-kai.heng.feng@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: bhelgaas@google.com, tiwai@suse.com
Cc: linux-pci@vger.kernel.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Kai-Heng Feng <kai.heng.feng@canonical.com>
List-Id: alsa-devel@alsa-project.org

A driver may want to know the existence of _PR3, to choose different
runtime suspend behavior. A user will be add in next patch.

This is mostly the same as nouveau_pr3_present().

Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
---
 drivers/pci/pci.c   | 20 ++++++++++++++++++++
 include/linux/pci.h |  2 ++
 2 files changed, 22 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 1b27b5af3d55..776af15b92c2 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5856,6 +5856,26 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
 	return 0;
 }
 
+bool pci_pr3_present(struct pci_dev *pdev)
+{
+	struct pci_dev *parent_pdev = pci_upstream_bridge(pdev);
+	struct acpi_device *parent_adev;
+
+	if (acpi_disabled)
+		return false;
+
+	if (!parent_pdev)
+		return false;
+
+	parent_adev = ACPI_COMPANION(&parent_pdev->dev);
+	if (!parent_adev)
+		return false;
+
+	return parent_adev->power.flags.power_resources &&
+		acpi_has_method(parent_adev->handle, "_PR3");
+}
+EXPORT_SYMBOL_GPL(pci_pr3_present);
+
 /**
  * pci_add_dma_alias - Add a DMA devfn alias for a device
  * @dev: the PCI device for which alias is added
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 82e4cd1b7ac3..9b6f7b67fac9 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2348,9 +2348,11 @@ struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus);
 
 void
 pci_msi_register_fwnode_provider(struct fwnode_handle *(*fn)(struct device *));
+bool pci_pr3_present(struct pci_dev *pdev);
 #else
 static inline struct irq_domain *
 pci_host_bridge_acpi_msi_domain(struct pci_bus *bus) { return NULL; }
+static bool pci_pr3_present(struct pci_dev *pdev) { return false; }
 #endif
 
 #ifdef CONFIG_EEH
-- 
2.17.1
