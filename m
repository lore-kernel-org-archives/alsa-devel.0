From: "Krzysztof Helt" <krzysztof.h1@gmail.com>
Subject: [PATCH] sc6000: documentation fix
Date: Thu, 13 Sep 2007 23:13:10 +0200
Message-ID: <8c74410a0709131413w7f8e09caub8f58314598c8506@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 67595243BB
	for <alsa-devel@alsa-project.org>;
	Thu, 13 Sep 2007 23:13:12 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so761855wag
	for <alsa-devel@alsa-project.org>; Thu, 13 Sep 2007 14:13:11 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Krzysztof Helt <krzysztof.h1@wp.pl>

This patch fixes MPU-401 irq values list in documentation.

Signed-off-by: Krzysztof Helt <krzysztof.h1@wp.pl>

---

diff -urp alsa-driver-1.0.15rc2/sound/Documentation/ALSA-Configuration.txt
alsa-driver-new/sound/Documentation/ALSA-Configuration.txt
--- alsa-driver-1.0.15rc2/sound/Documentation/ALSA-Configuration.txt	2007-09-12
13:33:51.000000000 +0200
+++ alsa-driver-new/sound/Documentation/ALSA-Configuration.txt	2007-09-13
23:12:23.920824623 +0200
@@ -1679,7 +1679,7 @@ Prior to version 0.9.0rc4 options had a
     port	- Port # (0x220 or 0x240)
     mss_port	- MSS Port # (0x530 or 0xe80)
     irq		- IRQ # (5,7,9,10,11)
-    mpu_irq	- MPU-401 IRQ # (ditto)
+    mpu_irq	- MPU-401 IRQ # (5,7,9,10) ,0 - no MPU-401 irq
     dma		- DMA # (1,3,0)

     This module supports multiple cards.
