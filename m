From: "Adrian McMenamin" <adrianmcmenamin@gmail.com>
Subject: [PATCH] Patch for AICA
Date: Tue, 24 Jul 2007 11:51:53 +0100
Message-ID: <92a12cdb0707240351h147b35a7r8d99252aab2f18b1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by alsa0.perex.cz (Postfix) with ESMTP id 3305624375
	for <alsa-devel@alsa-project.org>;
	Tue, 24 Jul 2007 12:51:58 +0200 (CEST)
Received: by wa-out-1112.google.com with SMTP id m33so2514305wag
	for <alsa-devel@alsa-project.org>; Tue, 24 Jul 2007 03:51:54 -0700 (PDT)
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
To: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>
Cc: Paul Mundt <lethal@linux-sh.org>
List-Id: alsa-devel@alsa-project.org

I submitted this yesterday via lkml and it was accepted by the SH
maintainer. Probably should have copied in the ALSA list too - though
the change is so small and consequential of another issue I was
dealing with I forgot.

The change is necessary because of a fix in the SH DMA API (see
http://lkml.org/lkml/2007/7/23/445 for the larger patch)

Signed-off by: Adrian McMenamin ,adrian@mcmen.demon.co.uk>


diff --git a/sound/sh/aica.h b/sound/sh/aica.h
index 8c11e3d..d098baa 100644
--- a/sound/sh/aica.h
+++ b/sound/sh/aica.h
@@ -52,7 +52,7 @@
 #define AICA_CHANNEL1_OFFSET 0x21000
 #define CHANNEL_OFFSET 0x10000

-#define AICA_DMA_CHANNEL 0
+#define AICA_DMA_CHANNEL 5
 #define AICA_DMA_MODE 5
