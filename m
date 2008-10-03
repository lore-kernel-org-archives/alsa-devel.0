From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Subject: [PATCH 6/7] ASoC: Change include files at32-pcm.h and
 at32-ssc.h to new atmel_ssc_dai.h and atmel-pcm.h.
Date: Fri, 03 Oct 2008 16:58:56 +0200
Message-ID: <48E63330.4010703@atmel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030804090409000602000001"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from atmel-es2.atmel.fr (mail.atmel.fr [81.80.104.162])
	by alsa0.perex.cz (Postfix) with ESMTP id 13C3024141
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Oct 2008 16:59:13 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Mark Brown <broonie@sirena.org.uk>, Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030804090409000602000001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Change include files at32-pcm.h and at32-ssc.h(in playpaq_wm8510.c) to new atmel_ssc_dai.h and 
atmel-pcm.h.

Signed-off-by: Sedji Gaouaou <sedji.gaouaou@atmel.com>
---
 sound/soc/atmel/playpaq_wm8510.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/atmel/playpaq_wm8510.c b/sound/soc/atmel/playpaq_wm8510.c
index 7e6560b..ffad18f 100644
--- a/sound/soc/atmel/playpaq_wm8510.c
+++ b/sound/soc/atmel/playpaq_wm8510.c
@@ -40,8 +40,8 @@
 #include <mach/portmux.h>
 
 #include "../codecs/wm8510.h"
-#include "at32-pcm.h"
-#include "at32-ssc.h"
+#include "atmel-pcm.h"
+#include "atmel_ssc_dai.h"
 
 
 /*-------------------------------------------------------------------------*\
-- 
1.5.3.7




--------------030804090409000602000001
Content-Type: text/plain;
 name="Change-include-files-at32-pcm.h-and-at32-ssc.h.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="Change-include-files-at32-pcm.h-and-at32-ssc.h.txt"

>From 35c348266d0ddf8e47c3cf25a5db8ada2ff0a639 Mon Sep 17 00:00:00 2001
From: Sedji Gaouaou <sedji.gaouaou@atmel.com>
Date: Fri, 3 Oct 2008 16:10:47 +0200
Subject: [PATCH] Change include files at32-pcm.h and at32-ssc.h to new atmel_ssc_dai.h and
 atmel-pcm.h.

Signed-off-by: Sedji Gaouaou <sedji.gaouaou@atmel.com>
---
 sound/soc/atmel/playpaq_wm8510.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/atmel/playpaq_wm8510.c b/sound/soc/atmel/playpaq_wm8510.c
index 7e6560b..ffad18f 100644
--- a/sound/soc/atmel/playpaq_wm8510.c
+++ b/sound/soc/atmel/playpaq_wm8510.c
@@ -40,8 +40,8 @@
 #include <mach/portmux.h>
 
 #include "../codecs/wm8510.h"
-#include "at32-pcm.h"
-#include "at32-ssc.h"
+#include "atmel-pcm.h"
+#include "atmel_ssc_dai.h"
 
 
 /*-------------------------------------------------------------------------*\
-- 
1.5.3.7





--------------030804090409000602000001
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------030804090409000602000001--
