From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] sound: sscape: add missing include of asm/io.h
Date: Wed, 28 Jan 2015 15:54:04 +0100
Message-ID: <7794866.XZSLAdxcrb@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.187])
 by alsa0.perex.cz (Postfix) with ESMTP id 5241D261A32
 for <alsa-devel@alsa-project.org>; Wed, 28 Jan 2015 15:54:10 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The soundscape driver uses the ISA inb/outb functions declared
in asm/io.h, so it needs to include this header to avoid
a build error:

sscape.c: In function 'sscape_write_unsafe':
sscape.c:203:2: error: implicit declaration of function 'outb' [-Werror=implicit-function-declaration]

Signed-off-by: Arnd Bergmann <arnd@arndb.de>

diff --git a/sound/isa/sscape.c b/sound/isa/sscape.c
index 018ab140c2be..7b248cdf06e2 100644
--- a/sound/isa/sscape.c
+++ b/sound/isa/sscape.c
@@ -23,6 +23,7 @@
 
 #include <linux/init.h>
 #include <linux/err.h>
+#include <linux/io.h>
 #include <linux/isa.h>
 #include <linux/delay.h>
 #include <linux/firmware.h>
