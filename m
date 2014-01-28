From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 11/11] ALSA: hda/conexant - Disable static
	quirks
Date: Tue, 28 Jan 2014 11:06:40 +0100
Message-ID: <1390903600-22772-12-git-send-email-tiwai@suse.de>
References: <1390903600-22772-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 2ADA12651D8
 for <alsa-devel@alsa-project.org>; Tue, 28 Jan 2014 11:06:43 +0100 (CET)
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
 by mx2.suse.de (Postfix) with ESMTP id 0EFC5AC88
 for <alsa-devel@alsa-project.org>; Tue, 28 Jan 2014 10:06:43 +0000 (UTC)
In-Reply-To: <1390903600-22772-1-git-send-email-tiwai@suse.de>
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

Now all weird setups have been converted to fixups for the generic
parser, and we can disable the static quirks.  This commit just turns
the build off.  The bulky static quirk code still remains for a while,
in case we get an overlooked regression.  It'll be removed at the next
kernel version.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_conexant.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_conexant.c b/sound/pci/hda/patch_conexant.c
index cf2ee7ff6fef..6cc646531ce8 100644
--- a/sound/pci/hda/patch_conexant.c
+++ b/sound/pci/hda/patch_conexant.c
@@ -35,7 +35,7 @@
 #include "hda_jack.h"
 #include "hda_generic.h"
 
-#define ENABLE_CXT_STATIC_QUIRKS
+#undef ENABLE_CXT_STATIC_QUIRKS
 
 #define CXT_PIN_DIR_IN              0x00
 #define CXT_PIN_DIR_OUT             0x01
-- 
1.8.5.2
