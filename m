From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH] ALSA: hda - add explicit include of err.h
Date: Tue, 23 Sep 2014 09:04:49 +0200
Message-ID: <1411455890-8324-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id AC6AB261B1A
 for <alsa-devel@alsa-project.org>; Tue, 23 Sep 2014 09:04:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Since every caller of snd_hda_jack_detect_enable_callback needs to
use the macros from err.h, it makes sense to include it directly
from hda_jack.h.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/hda_jack.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/pci/hda/hda_jack.h b/sound/pci/hda/hda_jack.h
index b41e0a3..13cb375 100644
--- a/sound/pci/hda/hda_jack.h
+++ b/sound/pci/hda/hda_jack.h
@@ -12,6 +12,8 @@
 #ifndef __SOUND_HDA_JACK_H
 #define __SOUND_HDA_JACK_H
 
+#include <linux/err.h>
+
 struct auto_pin_cfg;
 struct hda_jack_tbl;
 struct hda_jack_callback;
-- 
1.9.1
