From: libin.yang@intel.com
Subject: [PATCH] ALSA: hda - using POS_FIX_LPIB on Broadwell
	HDMI Audio
Date: Thu,  8 May 2014 02:03:24 +0800
Message-ID: <1399485804-75028-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id CEAEC26547A
 for <alsa-devel@alsa-project.org>; Thu,  8 May 2014 03:54:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: Libin Yang <libin.yang@intel.com>, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@intel.com>

Audio stream is not continuous if using position buffer on Broadwell
HDMI audio. Sound is clipped.
Fix this issue by using POS_FIX_LPIB.

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 sound/pci/hda/hda_intel.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index b540ad7..9cd40c6 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -993,6 +993,7 @@ static struct snd_pci_quirk position_fix_list[] = {
 	SND_PCI_QUIRK(0x1565, 0x8218, "Biostar Microtech", POS_FIX_LPIB),
 	SND_PCI_QUIRK(0x1849, 0x0888, "775Dual-VSTA", POS_FIX_LPIB),
 	SND_PCI_QUIRK(0x8086, 0x2503, "DG965OT AAD63733-203", POS_FIX_LPIB),
+	SND_PCI_QUIRK(0x8086, 0x2010, "Broadwell HDMI audio", POS_FIX_LPIB),
 	{}
 };
 
-- 
1.8.3.2
