From: Krzysztof Helt <krzysztof.h1@poczta.fm>
Subject: [PATCH] s3c2443-ac97: compilation fix
Date: Thu, 18 Oct 2007 22:42:56 +0200
Message-ID: <20071018224256.c6bcfff0.krzysztof.h1@poczta.fm>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2939331322366602654=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp4.poczta.interia.pl (smtp35.poczta.interia.pl [80.48.65.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 262942489B
	for <alsa-devel@alsa-project.org>;
	Thu, 18 Oct 2007 22:33:29 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Alsa-devel <alsa-devel@alsa-project.org>
Cc: akpm@linux-foundation.org
List-Id: alsa-devel@alsa-project.org

--===============2939331322366602654==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Krzysztof Helt <krzysztof.h1@wp.pl>

The Samsung S3C24xx uses new architecture file 
layout in the post 2.6.23 kernel.
This patch fixes include path for the s3c2443-ac97.c.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---
The patch was done against the 2.6.23-git13 kernel.

diff -urp linux-ref/sound/soc/s3c24xx/s3c2443-ac97.c linux-new/sound/soc/s3c24xx/s3c2443-ac97.c
--- linux-ref/sound/soc/s3c24xx/s3c2443-ac97.c	2007-10-09 22:31:38.000000000 +0200
+++ linux-new/sound/soc/s3c24xx/s3c2443-ac97.c	2007-10-18 22:27:43.547470033 +0200
@@ -32,7 +32,7 @@
 
 #include <asm/hardware.h>
 #include <asm/io.h>
-#include <asm/arch/regs-ac97.h>
+#include <asm/plat-s3c/regs-ac97.h>
 #include <asm/arch/regs-gpio.h>
 #include <asm/arch/regs-clock.h>
 #include <asm/arch/audio.h>


----------------------------------------------------------------------
Jaros³aw Drob, Przyjdziemy i Spie***ymy - poznaj kandydata!
Kliknij >>> http://link.interia.pl/f1bef


--===============2939331322366602654==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============2939331322366602654==--
