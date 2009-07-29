From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] aedsp16: Buffer overflow
Date: Wed, 29 Jul 2009 11:46:59 +0200
Message-ID: <4A701A93.1060709@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f228.google.com (mail-ew0-f228.google.com
	[209.85.219.228])
	by alsa0.perex.cz (Postfix) with ESMTP id F3C9B103867
	for <alsa-devel@alsa-project.org>;
	Wed, 29 Jul 2009 11:44:07 +0200 (CEST)
Received: by ewy28 with SMTP id 28so702932ewy.32
	for <alsa-devel@alsa-project.org>; Wed, 29 Jul 2009 02:44:07 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: fizban@tin.it, alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

DSPVersion is declared as char[3], but the sprintf writes at least 4 bytes
including terminating null.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
Found with Parfait, http://research.sun.com/projects/parfait/

on line 498:
static char     DSPVersion[CARDVERLEN + 1] __initdata = {0, };

diff --git a/sound/oss/aedsp16.c b/sound/oss/aedsp16.c
index 3ee9900..35b5912 100644
--- a/sound/oss/aedsp16.c
+++ b/sound/oss/aedsp16.c
@@ -325,8 +325,9 @@
 /*
  * Size of character arrays that store name and version of sound card
  */
-#define CARDNAMELEN 15		/* Size of the card's name in chars     */
-#define CARDVERLEN  2		/* Size of the card's version in chars  */
+#define CARDNAMELEN	15	/* Size of the card's name in chars     */
+#define CARDVERLEN	10	/* Size of the card's version in chars	*/
+#define CARDVERDIGITS	2	/* Number of digits in the version	*/
 
 #if defined(CONFIG_SC6600)
 /*
@@ -410,7 +411,7 @@
 
 static int      soft_cfg __initdata = 0;	/* bitmapped config */
 static int      soft_cfg_mss __initdata = 0;	/* bitmapped mss config */
-static int      ver[CARDVERLEN] __initdata = {0, 0};	/* DSP Ver:
+static int      ver[CARDVERDIGITS] __initdata = {0, 0};	/* DSP Ver:
 						   hi->ver[0] lo->ver[1] */
 
 #if defined(CONFIG_SC6600)
@@ -957,7 +958,7 @@ static int __init aedsp16_dsp_version(int port)
 	 * string is finished.
 	 */
 		ver[len++] = ret;
-	  } while (len < CARDVERLEN);
+	  } while (len < CARDVERDIGITS);
 	sprintf(DSPVersion, "%d.%d", ver[0], ver[1]);
 
 	DBG(("success.\n"));
