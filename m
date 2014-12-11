From: Abhilash Kesavan <a.kesavan@samsung.com>
Subject: [PATCH 1/2] lib: devres: add a helper function for ioremap_wc
Date: Thu, 11 Dec 2014 08:28:45 +0530
Message-ID: <1418266726-12004-1-git-send-email-a.kesavan@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: catalin.marinas@arm.com, Will.Deacon@arm.com, heiko@sntech.de, Li.Xiubo@freescale.com, shc_work@mail.ru, p.zabel@pengutronix.de, nicoleotsuka@gmail.com, arnd@arndb.de, gregkh@linuxfoundation.org, robh+dt@kernel.org, grant.likely@linaro.org, linux-kernel@vger.kernel.org, corbet@lwn.net
Cc: padma.v@samsung.com, alsa-devel@alsa-project.org, shawn.guo@freescale.com, bcousson@baylibre.com, tony@atomide.com, kernel@pengutronix.de, kgene@kernel.org, kesavan.abhilash@gmail.com, pawel.moll@arm.com
List-Id: alsa-devel@alsa-project.org

Implement a resource managed writecombine ioremap function.

Signed-off-by: Abhilash Kesavan <a.kesavan@samsung.com>
---
 Documentation/driver-model/devres.txt |    1 +
 include/linux/io.h                    |    2 ++
 lib/devres.c                          |   28 ++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+)

diff --git a/Documentation/driver-model/devres.txt b/Documentation/driver-model/devres.txt
index b5ab416..0f80cee 100644
--- a/Documentation/driver-model/devres.txt
+++ b/Documentation/driver-model/devres.txt
@@ -274,6 +274,7 @@ IOMAP
   devm_ioport_unmap()
   devm_ioremap()
   devm_ioremap_nocache()
+  devm_ioremap_wc()
   devm_ioremap_resource() : checks resource, requests memory region, ioremaps
   devm_iounmap()
   pcim_iomap()
diff --git a/include/linux/io.h b/include/linux/io.h
index fa02e55..42b33f0 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -64,6 +64,8 @@ void __iomem *devm_ioremap(struct device *dev, resource_size_t offset,
 			   resource_size_t size);
 void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
 				   resource_size_t size);
+void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
+				   resource_size_t size);
 void devm_iounmap(struct device *dev, void __iomem *addr);
 int check_signature(const volatile void __iomem *io_addr,
 			const unsigned char *signature, int length);
diff --git a/lib/devres.c b/lib/devres.c
index 0f1dd2e..e8e1738 100644
--- a/lib/devres.c
+++ b/lib/devres.c
@@ -72,6 +72,34 @@ void __iomem *devm_ioremap_nocache(struct device *dev, resource_size_t offset,
 EXPORT_SYMBOL(devm_ioremap_nocache);
 
 /**
+ * devm_ioremap_wc - Managed ioremap_wc()
+ * @dev: Generic device to remap IO address for
+ * @offset: BUS offset to map
+ * @size: Size of map
+ *
+ * Managed ioremap_wc().  Map is automatically unmapped on driver detach.
+ */
+void __iomem *devm_ioremap_wc(struct device *dev, resource_size_t offset,
+			   resource_size_t size)
+{
+	void __iomem **ptr, *addr;
+
+	ptr = devres_alloc(devm_ioremap_release, sizeof(*ptr), GFP_KERNEL);
+	if (!ptr)
+		return NULL;
+
+	addr = ioremap_wc(offset, size);
+	if (addr) {
+		*ptr = addr;
+		devres_add(dev, ptr);
+	} else
+		devres_free(ptr);
+
+	return addr;
+}
+EXPORT_SYMBOL(devm_ioremap_wc);
+
+/**
  * devm_iounmap - Managed iounmap()
  * @dev: Generic device to unmap for
  * @addr: Address to unmap
-- 
1.7.9.5
