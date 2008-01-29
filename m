From: Jason Gaston <jason.d.gaston@intel.com>
Subject: [PATCH 2.6.24] hda_intel: ALSA HD Audio patch for Intel ICH10 DeviceID's
Date: Mon, 28 Jan 2008 17:31:00 -0800
Message-ID: <200801281731.00789.jason.d.gaston@intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1763835AbYA2A2U@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: perex@suse.cz, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, tiwai@suse.de, jason.d.gaston@intel.com
List-Id: alsa-devel@alsa-project.org

This patch adds the Intel ICH10 HD Audio Controller DeviceID's.

Signed-off-by:  Jason Gaston <jason.d.gaston@intel.com>

--- linux-2.6.24/sound/pci/hda/hda_intel.c.orig	2008-01-24 14:58:37.000000000 -0800
+++ linux-2.6.24/sound/pci/hda/hda_intel.c	2008-01-28 14:58:22.000000000 -0800
@@ -98,6 +98,7 @@
 			 "{Intel, ESB2},"
 			 "{Intel, ICH8},"
 			 "{Intel, ICH9},"
+			 "{Intel, ICH10},"
 			 "{ATI, SB450},"
 			 "{ATI, SB600},"
 			 "{ATI, RS600},"
@@ -1936,6 +1937,8 @@
 	{ 0x8086, 0x284b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ICH }, /* ICH8 */
 	{ 0x8086, 0x293e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ICH }, /* ICH9 */
 	{ 0x8086, 0x293f, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ICH }, /* ICH9 */
+	{ 0x8086, 0x3a3e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ICH }, /* ICH10 */
+	{ 0x8086, 0x3a6e, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ICH }, /* ICH10 */
 	{ 0x1002, 0x437b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ATI }, /* ATI SB450 */
 	{ 0x1002, 0x4383, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ATI }, /* ATI SB600 */
 	{ 0x1002, 0x793b, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AZX_DRIVER_ATIHDMI }, /* ATI RS600 HDMI */
