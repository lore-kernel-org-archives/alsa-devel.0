From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] hda_intel: Add Oaktrail identifiers
Date: Wed, 28 Dec 2011 15:17:26 +0000
Message-ID: <20111228151715.2032.87840.stgit@bob.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from lxorguk.ukuu.org.uk (lxorguk.ukuu.org.uk [81.2.110.251])
	by alsa0.perex.cz (Postfix) with ESMTP id 2C29D103954
	for <alsa-devel@alsa-project.org>; Wed, 28 Dec 2011 16:04:47 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

From: Li Peng <pengi.li@intel.com>

Oaktrail has 0x8086, 0x080a - AZX_DRIVER_SCH

Taken from the Meego patches for Oaktrail

Signed-off-by: Li Peng <peng.li@intel.com>
Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 sound/pci/hda/hda_intel.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)


diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index c2f79e6..b339eb5 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -2972,6 +2972,9 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
 	{ PCI_DEVICE(0x8086, 0x811b),
 	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_SCH_SNOOP |
 	  AZX_DCAPS_BUFSIZE | AZX_DCAPS_POSFIX_LPIB }, /* Poulsbo */
+	{ PCI_DEVICE(0x8086, 0x080a),
+	  .driver_data = AZX_DRIVER_SCH | AZX_DCAPS_SCH_SNOOP |
+	  AZX_DCAPS_BUFSIZE},
 	/* ICH */
 	{ PCI_DEVICE(0x8086, 0x2668),
 	  .driver_data = AZX_DRIVER_ICH | AZX_DCAPS_OLD_SSYNC |
