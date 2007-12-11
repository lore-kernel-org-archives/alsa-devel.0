From: zhejiang <zhe.jiang@intel.com>
Subject: [patch] Device ID for MSI L745
Date: Tue, 11 Dec 2007 15:45:31 +0800
Message-ID: <1197359131.668.71.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id 25F46103822
	for <alsa-devel@alsa-project.org>; Tue, 11 Dec 2007 08:46:20 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Please refer to the [0003641] on bugtracking system.
The user found that "model=targa-2ch-dig" works and provided the ID.


diff -Nur a/alsa-driver-hg20071211/alsa-kernel/pci/hda/patch_realtek.c
b/alsa-driver-hg20071211/alsa-kernel/pci/hda/patch_realtek.c
--- a/alsa-driver-hg20071211/alsa-kernel/pci/hda/patch_realtek.c
2007-12-04 09:00:07.000000000 +0800
+++ b/alsa-driver-hg20071211/alsa-kernel/pci/hda/patch_realtek.c
2007-12-11 15:30:20.000000000 +0800
@@ -7173,6 +7173,7 @@
 	SND_PCI_QUIRK(0x1462, 0x7327, "MSI", ALC883_6ST_DIG),
 	SND_PCI_QUIRK(0x1462, 0x0349, "MSI", ALC883_TARGA_2ch_DIG),
 	SND_PCI_QUIRK(0x1462, 0x0579, "MSI", ALC883_TARGA_2ch_DIG),
+	SND_PCI_QUIRK(0x1462, 0x040d, "MSI", ALC883_TARGA_2ch_DIG),
 	SND_PCI_QUIRK(0x1462, 0x3729, "MSI S420", ALC883_TARGA_DIG),
 	SND_PCI_QUIRK(0x1462, 0x3ef9, "MSI", ALC883_TARGA_DIG),
 	SND_PCI_QUIRK(0x1462, 0x3b7f, "MSI", ALC883_TARGA_2ch_DIG),
