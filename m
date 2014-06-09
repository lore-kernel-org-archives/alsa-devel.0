From: libin.yang@intel.com
Subject: [PATCH 1/2] Revert "ALSA: hda - mask buggy stream DMA0
	for Broadwell display controller"
Date: Mon,  9 Jun 2014 15:28:58 +0800
Message-ID: <1402298939-18377-1-git-send-email-libin.yang@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 248D426554B
 for <alsa-devel@alsa-project.org>; Mon,  9 Jun 2014 09:29:43 +0200 (CEST)
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

This reverts commit 7189eb9b8f7962474956196c301676470542f253.

It will use LPIB to get the DMA position on Broadwell HDMI Audio.

Signed-off-by: Libin Yang <libin.yang@intel.com>
---
 sound/pci/hda/hda_intel.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/sound/pci/hda/hda_intel.c b/sound/pci/hda/hda_intel.c
index cd77b9b..f93f338 100644
--- a/sound/pci/hda/hda_intel.c
+++ b/sound/pci/hda/hda_intel.c
@@ -1367,12 +1367,6 @@ static int azx_first_init(struct azx *chip)
 	/* initialize streams */
 	azx_init_stream(chip);
 
-	/* workaround for Broadwell HDMI: the first stream is broken,
-	 * so mask it by keeping it as if opened
-	 */
-	if (pci->vendor == 0x8086 && pci->device == 0x160c)
-		chip->azx_dev[0].opened = 1;
-
 	/* initialize chip */
 	azx_init_pci(chip);
 	azx_init_chip(chip, (probe_only[dev] & 2) == 0);
-- 
1.8.3.2
