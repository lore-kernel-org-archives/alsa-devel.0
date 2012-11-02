From: "Lars R. Damerow" <lars@pixar.com>
Subject: [PATCH] ALSA: hda - support Teradici 2200 host card
	audio
Date: Fri,  2 Nov 2012 13:10:39 -0700
Message-ID: <1351887039-31760-2-git-send-email-lars@pixar.com>
References: <1351887039-31760-1-git-send-email-lars@pixar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smx.pixar.com (smx.pixar.com [12.25.180.94])
 by alsa0.perex.cz (Postfix) with ESMTP id D29862650EE
 for <alsa-devel@alsa-project.org>; Fri,  2 Nov 2012 21:10:45 +0100 (CET)
In-Reply-To: <1351887039-31760-1-git-send-email-lars@pixar.com>
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
Cc: "Lars R. Damerow" <lars@pixar.com>
List-Id: alsa-devel@alsa-project.org

The audio chipset used in Teradici's Tera2 host cards is the same as that in
the 1200 host cards. This patch allows ALSA to recognize the Tera2 cards.

Signed-off-by: Lars R. Damerow <lars@pixar.com>
---
 sound/pci/hda/hda_intel.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index 1c9c779..5071fd5 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -3543,6 +3543,8 @@ static DEFINE_PCI_DEVICE_TABLE(azx_ids) = {
 	/* Teradici */
 	{ PCI_DEVICE(0x6549, 0x1200),
 	  .driver_data = AZX_DRIVER_TERA | AZX_DCAPS_NO_64BIT },
+	{ PCI_DEVICE(0x6549, 0x2200),
+	  .driver_data = AZX_DRIVER_TERA | AZX_DCAPS_NO_64BIT },
 	/* Creative X-Fi (CA0110-IBG) */
 	/* CTHDA chips */
 	{ PCI_DEVICE(0x1102, 0x0010),
-- 
1.7.4
