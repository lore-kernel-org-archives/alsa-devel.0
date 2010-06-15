From: Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH] alsa: riptide: don't use own hex_to_bin()
	method
Date: Tue, 15 Jun 2010 17:26:28 +0300
Message-ID: <1276611988-28658-1-git-send-email-andy.shevchenko@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 3E72D1038C0
	for <alsa-devel@alsa-project.org>;
	Tue, 15 Jun 2010 16:26:37 +0200 (CEST)
Received: by fxm20 with SMTP id 20so257855fxm.38
	for <alsa-devel@alsa-project.org>; Tue, 15 Jun 2010 07:26:36 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: linux-kernel@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
List-Id: alsa-devel@alsa-project.org

From: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>

Signed-off-by: Andy Shevchenko <ext-andriy.shevchenko@nokia.com>
Cc: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org
---
 sound/pci/riptide/riptide.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/sound/pci/riptide/riptide.c b/sound/pci/riptide/riptide.c
index ad44626..59d7996 100644
--- a/sound/pci/riptide/riptide.c
+++ b/sound/pci/riptide/riptide.c
@@ -97,6 +97,7 @@
 #include <linux/gameport.h>
 #include <linux/device.h>
 #include <linux/firmware.h>
+#include <linux/kernel.h>
 #include <asm/io.h>
 #include <sound/core.h>
 #include <sound/info.h>
@@ -667,13 +668,12 @@ static u32 atoh(const unsigned char *in, unsigned int len)
 	unsigned char c;
 
 	while (len) {
+		int value;
+
 		c = in[len - 1];
-		if ((c >= '0') && (c <= '9'))
-			sum += mult * (c - '0');
-		else if ((c >= 'A') && (c <= 'F'))
-			sum += mult * (c - ('A' - 10));
-		else if ((c >= 'a') && (c <= 'f'))
-			sum += mult * (c - ('a' - 10));
+		value = hex_to_bin(c);
+		if (value >= 0)
+			sum += mult * value;
 		mult *= 16;
 		--len;
 	}
-- 
1.6.6.1
