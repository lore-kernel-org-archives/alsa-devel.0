From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH] asihpi: Fix compatibility with 64-bit
	resource_size_t
Date: Mon, 11 Jun 2007 20:26:48 +0400
Message-ID: <20070611162648.GB5347@procyon.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from master.altlinux.org (master.altlinux.org [62.118.250.235])
	by alsa0.perex.cz (Postfix) with ESMTP id 31EE110381C
	for <alsa-devel@alsa-project.org>;
	Mon, 11 Jun 2007 18:27:26 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

In recent kernels the resource_size_t type can be either 32-bit or
64-bit depending on config options.  The proper way to printk such
values is to cast them to unsigned long long.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>

---
Without the patch compilation on 2.6.18 produces warnings:

.../pci/asihpi/hpimod.c: In function 'adapter_probe':
.../pci/asihpi/hpimod.c:460: warning: format '%x' expects type 'unsigned int', but argument 4 has type 'resource_size_t'
.../pci/asihpi/hpimod.c:460: warning: format '%x' expects type 'unsigned int', but argument 5 has type 'resource_size_t'


--- alsa-driver-1.0.14/pci/asihpi/hpimod.c.alt-asihpi-warnings	2007-06-11 16:29:28 +0400
+++ alsa-driver-1.0.14/pci/asihpi/hpimod.c	2007-06-11 19:58:30 +0400
@@ -457,10 +457,10 @@ static int __devinit adapter_probe(struc
 
 	// fill in HPI_PCI information from kernel provided information
 	for (idx = 0; idx < HPI_MAX_ADAPTER_MEM_SPACES; idx++) {
-		HPI_DEBUG_LOG4(DEBUG, "Resource %d %s %x-%x\n", idx,
+		HPI_DEBUG_LOG4(DEBUG, "Resource %d %s %llx-%llx\n", idx,
 			       pci_dev->resource[idx].name,
-			       pci_resource_start(pci_dev, idx),
-			       pci_resource_end(pci_dev, idx));
+			       (unsigned long long)pci_resource_start(pci_dev, idx),
+			       (unsigned long long)pci_resource_end(pci_dev, idx));
 
 		memlen = pci_resource_len(pci_dev, idx);
 		if (memlen) {
