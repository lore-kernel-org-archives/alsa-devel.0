From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH] hda: remove redundant get_amp_nid()
Date: Tue, 18 Nov 2008 10:21:55 +0800
Message-ID: <20081118022155.GA8746@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 7E79F2441C
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 03:22:06 +0100 (CET)
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
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Remove get_amp_nid(): it duplicates the one defined in hda_local.h

Signed-off-by: Wu Fengguang <wfg@linux.intel.com>
---
 sound/pci/hda/patch_via.c |    2 --
 1 file changed, 2 deletions(-)

--- sound-2.6.orig/sound/pci/hda/patch_via.c
+++ sound-2.6/sound/pci/hda/patch_via.c
@@ -142,8 +142,6 @@ enum {
 	AUTO_SEQ_SIDE
 };
 
-#define get_amp_nid(kc)	((kc)->private_value & 0xffff)
-
 /* Some VT1708S based boards gets the micboost setting wrong, so we have
  * to apply some brute-force and re-write the TLV's by software. */
 static int mic_boost_tlv(struct snd_kcontrol *kcontrol, int op_flag,
