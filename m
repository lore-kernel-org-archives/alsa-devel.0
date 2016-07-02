From: murray foster <mrafoster@gmail.com>
Subject: [PATCH] ASoC: cs4270: fix DAPM stream name mismatch
Date: Fri, 1 Jul 2016 18:18:25 -0700 (PDT)
Message-ID: <alpine.LNX.2.00.1607011810410.27916@acc-1004367-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f66.google.com (mail-pa0-f66.google.com
 [209.85.220.66])
 by alsa0.perex.cz (Postfix) with ESMTP id 4AB02261B01
 for <alsa-devel@alsa-project.org>; Sat,  2 Jul 2016 03:19:09 +0200 (CEST)
Received: by mail-pa0-f66.google.com with SMTP id ts6so10870175pac.0
 for <alsa-devel@alsa-project.org>; Fri, 01 Jul 2016 18:19:09 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: timur@freescale.com
Cc: brian.austin@cirrus.com, alsa-devel@alsa-project.org, Paul.Handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org


Mismatching stream names in DAPM route and widget definitions are
causing compilation errors. Fixing these names allows the cs4270
driver to compile and function.

Signed-off-by: Murray Foster <mrafoster@gmail.com>
---
 sound/soc/codecs/cs4270.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index e07807d..4ffdca4 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
@@ -1,4 +1,4 @@
-/*
+s/*
  * CS4270 ALSA SoC (ASoC) codec driver
  *
  * Author: Timur Tabi <timur@freescale.com>
@@ -148,11 +148,11 @@ SND_SOC_DAPM_OUTPUT("AOUTR"),
 };

 static const struct snd_soc_dapm_route cs4270_dapm_routes[] = {
-	{ "Capture", NULL, "AINA" },
-	{ "Capture", NULL, "AINB" },
+	{ "Capture", NULL, "AINL" },
+	{ "Capture", NULL, "AINR" },

-	{ "AOUTA", NULL, "Playback" },
-	{ "AOUTB", NULL, "Playback" },
+	{ "AOUTL", NULL, "Playback" },
+	{ "AOUTR", NULL, "Playback" },
 };

 /**
-- 
2.4.9
