From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 16/29] ALSA: oxfw: Move to its own directory
Date: Sun, 26 Oct 2014 22:03:17 +0900
Message-ID: <1414328610-12729-17-git-send-email-o-takashi@sakamocchi.jp>
References: <1414328610-12729-1-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp310.phy.lolipop.jp (smtp310.phy.lolipop.jp [210.157.22.78])
 by alsa0.perex.cz (Postfix) with ESMTP id C56F72606FA
 for <alsa-devel@alsa-project.org>; Sun, 26 Oct 2014 14:04:02 +0100 (CET)
In-Reply-To: <1414328610-12729-1-git-send-email-o-takashi@sakamocchi.jp>
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
 sound/firewire/Makefile          | 3 +--
 sound/firewire/oxfw/Makefile     | 2 ++
 sound/firewire/{ => oxfw}/oxfw.c | 8 ++++----
 3 files changed, 7 insertions(+), 6 deletions(-)
 create mode 100644 sound/firewire/oxfw/Makefile
 rename sound/firewire/{ => oxfw}/oxfw.c (99%)

diff --git a/sound/firewire/Makefile b/sound/firewire/Makefile
index 021b877..edbe61d 100644
--- a/sound/firewire/Makefile
+++ b/sound/firewire/Makefile
@@ -1,6 +1,5 @@
 snd-firewire-lib-objs := lib.o iso-resources.o packets-buffer.o \
 			 fcp.o cmp.o amdtp.o
-snd-oxfw-objs := oxfw.o
 snd-isight-objs := isight.o
 snd-scs1x-objs := scs1x.o
 
@@ -10,4 +9,4 @@ obj-$(CONFIG_SND_ISIGHT) += snd-isight.o
 obj-$(CONFIG_SND_SCS1X) += snd-scs1x.o
 obj-$(CONFIG_SND_FIREWORKS) += fireworks/
 obj-$(CONFIG_SND_BEBOB) += bebob/
-obj-$(CONFIG_SND_OXFW) += snd-oxfw.o
+obj-$(CONFIG_SND_OXFW) += oxfw/
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
1.9.1
