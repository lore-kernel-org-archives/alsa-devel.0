From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH] hda: remove redundant get_amp_nid()
Date: Mon, 17 Nov 2008 21:55:02 +0800
Message-ID: <20081117135502.GA15838@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id BEF49243D8
	for <alsa-devel@alsa-project.org>; Tue, 18 Nov 2008 02:04:04 +0100 (CET)
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
