From: Stas Sergeev <stsp@aknet.ru>
Subject: [patch] snd-pcsp: fix pcsp_treble_info() to honour the
	item number
Date: Sat, 24 May 2008 00:04:33 +0400
Message-ID: <48372351.9090900@aknet.ru>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------020706030701010104020500"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.aknet.ru (mail.aknet.ru [78.158.192.26])
	by alsa0.perex.cz (Postfix) with ESMTP id 23022246C7
	for <alsa-devel@alsa-project.org>;
	Fri, 23 May 2008 22:04:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Andreas Mohr <andi@lisas.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------020706030701010104020500
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hello.

The attached patch fixes the problem
with mixers not properly displaying
the PWM freq. The bug was that the
pcsp_treble_info() didn't take the
item number into an account.

Takashi, could you please apply?

--------------020706030701010104020500
Content-Type: text/x-patch;
 name="pcsp_tre.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pcsp_tre.diff"

# HG changeset patch
# User Stas Sergeev <stsp@users.sourceforge.net>
# Date 1211572692 -14400
# Node ID 15efd0d72bdec6b30cad2ea225c0d9d2be07e150
# Parent  2278b9a6058f5b45081f8227902df585474a81a6
snd-pcsp: fix pcsp_treble_info() to honour an item number.
This solves the problem with mixers wrongly displaying the PWM freq.

Signed-off-by: Stas Sergeev <stsp@aknet.ru>
CC: Andreas Mohr <andi@lisas.de>

diff -r 2278b9a6058f -r 15efd0d72bde drivers/pcsp/pcsp.h
--- a/drivers/pcsp/pcsp.h	Sat May 17 19:40:49 2008 +0400
+++ b/drivers/pcsp/pcsp.h	Fri May 23 23:58:12 2008 +0400
@@ -24,7 +24,8 @@
 /* default timer freq for PC-Speaker: 18643 Hz */
 #define DIV_18KHZ 64
 #define MAX_DIV DIV_18KHZ
-#define CUR_DIV() (MAX_DIV >> chip->treble)
+#define CALC_DIV(d) (MAX_DIV >> (d))
+#define CUR_DIV() CALC_DIV(chip->treble)
 #define PCSP_MAX_TREBLE 1
 
 /* unfortunately, with hrtimers 37KHz does not work very well :( */
@@ -36,7 +37,8 @@
 #define PCSP_DEFAULT_SDIV (DIV_18KHZ >> 1)
 #define PCSP_DEFAULT_SRATE (PIT_TICK_RATE / PCSP_DEFAULT_SDIV)
 #define PCSP_INDEX_INC() (1 << (PCSP_MAX_TREBLE - chip->treble))
-#define PCSP_RATE() (PIT_TICK_RATE / CUR_DIV())
+#define PCSP_CALC_RATE(i) (PIT_TICK_RATE / CALC_DIV(i))
+#define PCSP_RATE() PCSP_CALC_RATE(chip->treble)
 #define PCSP_MIN_RATE__1 MAX_DIV/PIT_TICK_RATE
 #define PCSP_MAX_RATE__1 MIN_DIV/PIT_TICK_RATE
 #define PCSP_MAX_PERIOD_NS (1000000000ULL * PCSP_MIN_RATE__1)
diff -r 2278b9a6058f -r 15efd0d72bde drivers/pcsp/pcsp_mixer.c
--- a/drivers/pcsp/pcsp_mixer.c	Sat May 17 19:40:49 2008 +0400
+++ b/drivers/pcsp/pcsp_mixer.c	Fri May 23 23:58:12 2008 +0400
@@ -50,7 +50,8 @@
 	uinfo->value.enumerated.items = chip->max_treble + 1;
 	if (uinfo->value.enumerated.item > chip->max_treble)
 		uinfo->value.enumerated.item = chip->max_treble;
-	sprintf(uinfo->value.enumerated.name, "%d", PCSP_RATE());
+	sprintf(uinfo->value.enumerated.name, "%d",
+			PCSP_CALC_RATE(uinfo->value.enumerated.item));
 	return 0;
 }
 

--------------020706030701010104020500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------020706030701010104020500--
