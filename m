From: Eliot Blennerhassett <linux@audioscience.com>
Subject: [PATCH 3/5] asihpi: Remove HPI4000
Date: Thu, 06 Mar 2008 14:49:18 +1300
Message-ID: <200803061449.18512.linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.clear.net.nz (smtp4.clear.net.nz [203.97.37.64])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D1D5243D4
	for <alsa-devel@alsa-project.org>; Thu,  6 Mar 2008 02:47:26 +0100 (CET)
Received: from zaphod (121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp4.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0JXA00CSUCYZQB00@smtp4.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 06 Mar 2008 14:47:25 +1300 (NZDT)
Content-disposition: inline
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

Remove HPI4000
Signed-off-by: Eliot Blennerhassett <linux@audioscience.com
---
diff -r 6def4892d3f5 pci/asihpi/Makefile
--- a/pci/asihpi/Makefile	Mon Mar 03 11:05:48 2008 +0100
+++ b/pci/asihpi/Makefile	Thu Mar 06 14:31:55 2008 +1300
@@ -7,7 +7,7 @@ include $(SND_TOPDIR)/Makefile.conf
 
 snd-asihpi-objs := asihpi.o hpimod.o hpimsginit.o\
 	hpicmn.o hpifunc.o hpidebug.o hpidspcd.o\
-	hpios_linux_kernel.o hpi4000.o hpi6000.o hpi6205.o hpimsgx.o
+	hpios_linux_kernel.o hpi6000.o hpi6205.o hpimsgx.o
 
 obj-$(CONFIG_SND_ASIHPI) += snd-asihpi.o
 
diff -r 6def4892d3f5 pci/asihpi/hpimsgx.c
--- a/pci/asihpi/hpimsgx.c	Mon Mar 03 11:05:48 2008 +0100
+++ b/pci/asihpi/hpimsgx.c	Thu Mar 06 12:21:49 2008 +1300
@@ -476,8 +476,6 @@ void HPI_MessageEx(
 			ep_name = "HPI_6000";
 		else if (ep == HPI_6205)
 			ep_name = "HPI_6205";
-		else if (ep == HPI_4000)
-			ep_name = "HPI_4000";
 		else
 			ep_name = "unknown";
 
@@ -598,7 +596,8 @@ static void InStreamClose(
 	if (hOwner ==
 		aIStreamUserOpen[phm->wAdapterIndex][phm->u.d.wStreamIndex].
 		hOwner) {
-		/* HPI_DEBUG_LOG(INFO,"closing adapter %d instream %d owned by %p\n",
+		/* HPI_DEBUG_LOG(INFO,"closing adapter %d "
+		   "instream %d owned by %p\n",
 		   phm->wAdapterIndex, phm->u.d.wStreamIndex, hOwner); */
 		aIStreamUserOpen[phm->wAdapterIndex][phm->u.d.wStreamIndex].
 			hOwner = NULL;
@@ -701,7 +700,8 @@ static void OutStreamClose(
 	if (hOwner ==
 		aOStreamUserOpen[phm->wAdapterIndex][phm->u.d.wStreamIndex].
 		hOwner) {
-		/* HPI_DEBUG_LOG(INFO,"closing adapter %d outstream %d owned by %p\n",
+		/* HPI_DEBUG_LOG(INFO,"closing adapter %d "
+		   "outstream %d owned by %p\n",
 		   phm->wAdapterIndex, phm->u.d.wStreamIndex, hOwner); */
 		aOStreamUserOpen[phm->wAdapterIndex][phm->u.d.wStreamIndex].
 			hOwner = NULL;
@@ -904,8 +904,9 @@ static u16 HPIMSGX_Init(
 		phr->wError = HPI_ERROR_PROCESSING_MESSAGE;
 		return phr->wError;
 	}
-	/* if the adapter was created succesfully save the mapping for future use */
 	if (hr.wError == 0) {
+		/* the adapter was created succesfully
+		   save the mapping for future use */
 		hpi_entry_points[hr.u.s.wAdapterIndex] = entry_point_func;
 		/* prepare adapter (pre-open streams etc.) */
 		HPI_DEBUG_LOG(DEBUG,
@@ -936,7 +937,7 @@ static void HPIMSGX_Cleanup(
 	}
 
 	for (; wAdapter < wAdapterLimit; wAdapter++) {
-		/*	printk(KERN_INFO "Cleanup adapter #%d\n",wAdapter); */
+		/*      printk(KERN_INFO "Cleanup adapter #%d\n",wAdapter); */
 		for (i = 0; i < HPI_MAX_STREAMS; i++) {
 			if (hOwner == aOStreamUserOpen[wAdapter][i].hOwner) {
 				struct hpi_message hm;
diff -r 6def4892d3f5 pci/asihpi/hpipcida.h
--- a/pci/asihpi/hpipcida.h	Mon Mar 03 11:05:48 2008 +0100
+++ b/pci/asihpi/hpipcida.h	Wed Mar 05 21:59:17 2008 +1300
@@ -34,20 +34,4 @@ HPI_PCI_VENDOR_ID_TI, HPI_ADAPTER_PCI204
 		HPI_PCI_VENDOR_ID_AUDIOSCIENCE, PCI_ANY_ID, 0, 0,
 		(kernel_ulong_t) HPI_6000}
 , {
-HPI_PCI_VENDOR_ID_MOTOROLA, HPI_ADAPTER_DSP56301,
-		HPI_PCI_VENDOR_ID_AUDIOSCIENCE, PCI_ANY_ID, 0, 0,
-		(kernel_ulong_t) HPI_4000}
-,
-	/* look for ASI cards that have 0x12cf sub-vendor ID,
-	   like the 4300 and 4601 */
-{
-HPI_PCI_VENDOR_ID_MOTOROLA, HPI_ADAPTER_DSP56301, 0x12CF, PCI_ANY_ID,
-		0, 0, (kernel_ulong_t) HPI_4000}
-,
-	/* look for ASI cards that have sub-vendor-ID = 0,
-	   like the 4501, 4113 and 4215 revC and below */
-{
-HPI_PCI_VENDOR_ID_MOTOROLA, HPI_ADAPTER_DSP56301, 0, PCI_ANY_ID, 0, 0,
-		(kernel_ulong_t) HPI_4000}
-, {
 0,}
