From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ALSA: Include linux/pci.h in sound/core.h
Date: Mon, 30 Jan 2012 13:44:35 +0800
Message-ID: <1327902275.12540.1.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
	[209.85.160.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 6FE7724485
	for <alsa-devel@alsa-project.org>; Mon, 30 Jan 2012 06:44:46 +0100 (CET)
Received: by ghbz2 with SMTP id z2so1649632ghb.38
	for <alsa-devel@alsa-project.org>; Sun, 29 Jan 2012 21:44:44 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

commit d1458279b "ALSA: Add snd_pci_quirk_lookup_id()" introduces below build
waring:
  CC      sound/sound_core.o
In file included from sound/sound_core.c:15:
include/sound/core.h:454: warning: 'struct pci_dev' declared inside parameter list
include/sound/core.h:454: warning: its scope is only this definition or declaration, which is probably not what you want

Include linux/pci.h to fix the build warning.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 include/sound/core.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/include/sound/core.h b/include/sound/core.h
index 5ab255f..4ea14f2 100644
--- a/include/sound/core.h
+++ b/include/sound/core.h
@@ -28,6 +28,7 @@
 #include <linux/pm.h>			/* pm_message_t */
 #include <linux/device.h>
 #include <linux/stringify.h>
+#include <linux/pci.h>
 
 /* number of supported soundcards */
 #ifdef CONFIG_SND_DYNAMIC_MINORS
-- 
1.7.5.4
