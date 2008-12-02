From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ALSA: ac97 - Include ac97_codec.h for
	ac97_bus_type declaration
Date: Tue,  2 Dec 2008 15:15:50 +0000
Message-ID: <1228230950-20204-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id A48C51037EC
	for <alsa-devel@alsa-project.org>; Tue,  2 Dec 2008 16:15:51 +0100 (CET)
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

This fixes a sparse warning caused by the lack of a connection with the
prototype for ac97_bus_type.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/ac97_bus.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/ac97_bus.c b/sound/ac97_bus.c
index 7fa37e1..a351dd0 100644
--- a/sound/ac97_bus.c
+++ b/sound/ac97_bus.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/string.h>
+#include <sound/ac97_codec.h>
 
 /*
  * Let drivers decide whether they want to support given codec from their
-- 
1.5.6.5
