From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Increase default bdl_pos_adj
	for Baytrail/Braswell
Date: Tue, 15 Dec 2015 14:02:56 +0100
Message-ID: <1450184576-11227-2-git-send-email-tiwai@suse.de>
References: <1450184576-11227-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 73BCE261B21
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2015 14:02:55 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0E9A0ADA9
 for <alsa-devel@alsa-project.org>; Tue, 15 Dec 2015 13:02:55 +0000 (UTC)
In-Reply-To: <1450184576-11227-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Intel Atom processors seem to have a problem at recording when
bdl_pos_adj is set to an odd value.  Actually, for the old Atoms, we
set AZX_DRIVER_SCH type, and this assigns 32 as default.  Meanwhile
the newer chips, Baytrail and Braswell, are set as AZX_DRIVER_PCH, and
the lower default value, 1, is assigned.

This patch changes the default values for these chipsets to a safer
default, 32, again.  Since changing the driver type (AZX_DRIVER_XXX)
leads to the rename of the driver string, it would result in a
possible regression.  So, we can't change the type.  Instead, in this
patch, manual (ugly) PCI ID checks are added on top.

A drawback by this increase is the slight increase of the latency, but
it's a sub-ms order in normal situations, so mostly negligible.

Reported-and-tested-by: Jochen Henneberg <jh@henneberg-systemdesign.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_intel.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index a17bf0467edc..56ef6b6fb546 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1490,6 +1490,15 @@ static void azx_probe_work(struct work_struct *work)
 
 static int default_bdl_pos_adj(struct azx *chip)
 {
+	/* some exceptions: Atoms seem problematic with value 1 */
+	if (chip->pci->vendor == PCI_VENDOR_ID_INTEL) {
+		switch (chip->pci->device) {
+		case 0x0f04: /* Baytrail */
+		case 0x2284: /* Braswell */
+			return 32;
+		}
+	}
+
 	switch (chip->driver_type) {
 	case AZX_DRIVER_ICH:
 	case AZX_DRIVER_PCH:
-- 
2.6.4
