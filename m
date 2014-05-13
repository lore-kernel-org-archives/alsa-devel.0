From: mengdong.lin@intel.com
Subject: [PATCH v2] ALSA: hda - mask buggy stream DMA0 for
	Broadwell display controller
Date: Tue, 13 May 2014 16:57:08 +0800
Message-ID: <1399971428-18585-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by alsa0.perex.cz (Postfix) with ESMTP id 5C92C265451
 for <alsa-devel@alsa-project.org>; Tue, 13 May 2014 10:55:20 +0200 (CEST)
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
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

Broadwell display controller has 3 stream DMA engines. DMA0 cannot update DMA
postion buffer properly while DMA1 and DMA2 can work well. So this patch masks
the buggy DMA0 by keeping it as opened.

This is a tentative workaround, so keep the change small as Takashi suggested.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index d6bca62..6309b5b 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1366,6 +1366,12 @@ static int azx_first_init(struct azx *chip)
 	/* initialize streams */
 	azx_init_stream(chip);
 
+	/* workaround for Broadwell HDMI: the first stream is broken,
+	 * so mask it by keeping it as if opened
+	 */
+	if (pci->vendor == 0x8086 && pci->device == 0x160c)
+		chip->azx_dev[0].opened = 1;
+
 	/* initialize chip */
 	azx_init_pci(chip);
 	azx_init_chip(chip, (probe_only[dev] & 2) == 0);
-- 
1.8.1.2
