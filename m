From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 3/4] ALSA: au88x0: Remove superfluous ifdef
	__KERNEL__
Date: Wed, 28 Jan 2015 17:37:45 +0100
Message-ID: <1422463066-18969-4-git-send-email-tiwai@suse.de>
References: <1422463066-18969-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 95A80261B02
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 17:37:48 +0100 (CET)
Received: from relay1.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 1F496ADDB
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 16:37:48 +0000 (UTC)
In-Reply-To: <1422463066-18969-1-git-send-email-tiwai@suse.de>
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

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/au88x0/au88x0.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/pci/au88x0/au88x0.h b/sound/pci/au88x0/au88x0.h
index 98c53bbf8837..bcc648bf6478 100644
--- a/sound/pci/au88x0/au88x0.h
+++ b/sound/pci/au88x0/au88x0.h
@@ -17,7 +17,6 @@
 #ifndef __SOUND_AU88X0_H
 #define __SOUND_AU88X0_H
 
-#ifdef __KERNEL__
 #include <linux/pci.h>
 #include <linux/io.h>
 #include <sound/core.h>
@@ -27,7 +26,6 @@
 #include <sound/hwdep.h>
 #include <sound/ac97_codec.h>
 #include <sound/tlv.h>
-#endif
 
 #ifndef CHIP_AU8820
 #include "au88x0_eq.h"
-- 
2.2.2
