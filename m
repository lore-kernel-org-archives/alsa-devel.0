From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 1/7] ALSA: hda - Remove superfluous MAX_AZX_DEV
Date: Mon, 30 Jun 2014 14:20:56 +0200
Message-ID: <1404130862-3152-2-git-send-email-tiwai@suse.de>
References: <1404130862-3152-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 92BAA265553
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 14:21:05 +0200 (CEST)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 6F2D0AD58
 for <alsa-devel@alsa-project.org>; Mon, 30 Jun 2014 12:21:05 +0000 (UTC)
In-Reply-To: <1404130862-3152-1-git-send-email-tiwai@suse.de>
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

MAX_AZX_DEV is no longer referred anywhere, let's kill it.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/hda_priv.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/pci/hda/hda_priv.h b/sound/pci/hda/hda_priv.h
index 4a7cb01fa912..da12d10b778f 100644
--- a/sound/pci/hda/hda_priv.h
+++ b/sound/pci/hda/hda_priv.h
@@ -120,9 +120,6 @@ enum { SDI0, SDI1, SDI2, SDI3, SDO0, SDO1, SDO2, SDO3 };
 #define TERA_NUM_CAPTURE	3
 #define TERA_NUM_PLAYBACK	4
 
-/* this number is statically defined for simplicity */
-#define MAX_AZX_DEV		16
-
 /* max number of fragments - we may use more if allocating more pages for BDL */
 #define BDL_SIZE		4096
 #define AZX_MAX_BDL_ENTRIES	(BDL_SIZE / 16)
-- 
2.0.0
