From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 17/30] ALSA: oxfw: Move to its own directory
Date: Sat, 29 Nov 2014 00:59:26 +0900
Message-ID: <1417190379-4172-18-git-send-email-o-takashi@sakamocchi.jp>
References: <1417190379-4172-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id 714B72604E7
 for <alsa-devel@alsa-project.org>; Fri, 28 Nov 2014 16:59:52 +0100 (CET)
In-Reply-To: <1417190379-4172-1-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: clemens@ladisch.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org, ffado-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Followed commits add much codes. To make the work easy, this commit creates
own directory and move current file to it.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/firewire/Makefile          | 2 +-
 sound/firewire/oxfw/Makefile     | 2 ++
 sound/firewire/{ => oxfw}/oxfw.c | 8 ++++----
 3 files changed, 7 insertions(+), 5 deletions(-)
 create mode 100644 sound/firewire/oxfw/Makefile
 rename sound/firewire/{ => oxfw}/oxfw.c (99%)

diff --git a/sound/firewire/Makefile b/sound/firewire/Makefile
index 5ed6fb7..8b37f08 100644
--- a/sound/firewire/Makefile
+++ b/sound/firewire/Makefile
@@ -6,7 +6,7 @@ snd-scs1x-objs := scs1x.o
 
 obj-$(CONFIG_SND_FIREWIRE_LIB) += snd-firewire-lib.o
 obj-$(CONFIG_SND_DICE) += dice/
-obj-$(CONFIG_SND_OXFW) += snd-oxfw.o
+obj-$(CONFIG_SND_OXFW) += oxfw/
 obj-$(CONFIG_SND_ISIGHT) += snd-isight.o
 obj-$(CONFIG_SND_SCS1X) += snd-scs1x.o
 obj-$(CONFIG_SND_FIREWORKS) += fireworks/
diff --git a/sound/firewire/oxfw/Makefile b/sound/firewire/oxfw/Makefile
new file mode 100644
index 0000000..9ca49c0
--- /dev/null
+++ b/sound/firewire/oxfw/Makefile
@@ -0,0 +1,2 @@
+snd-oxfw-objs := oxfw.o
+obj-m += snd-oxfw.o
diff --git a/sound/firewire/oxfw.c b/sound/firewire/oxfw/oxfw.c
similarity index 99%
rename from sound/firewire/oxfw.c
rename to sound/firewire/oxfw/oxfw.c
index b7498e9..55c687e 100644
--- a/sound/firewire/oxfw.c
+++ b/sound/firewire/oxfw/oxfw.c
@@ -17,10 +17,10 @@
 #include <sound/initval.h>
 #include <sound/pcm.h>
 #include <sound/pcm_params.h>
-#include "cmp.h"
-#include "fcp.h"
-#include "amdtp.h"
-#include "lib.h"
+#include "../cmp.h"
+#include "../fcp.h"
+#include "../amdtp.h"
+#include "../lib.h"
 
 #define OXFORD_FIRMWARE_ID_ADDRESS	(CSR_REGISTER_BASE + 0x50000)
 /* 0x970?vvvv or 0x971?vvvv, where vvvv = firmware version */
-- 
2.1.0
