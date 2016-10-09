From: murray foster <mrafoster@gmail.com>
Subject: [PATCH v2] ASoC: cs4270: fix DAPM stream name mismatch
Date: Sun, 9 Oct 2016 13:28:45 -0700 (PDT)
Message-ID: <alpine.LNX.2.00.1610091322540.27835@acc-1004367-dev>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pa0-f67.google.com (mail-pa0-f67.google.com
 [209.85.220.67])
 by alsa0.perex.cz (Postfix) with ESMTP id 2063A261560
 for <alsa-devel@alsa-project.org>; Sun,  9 Oct 2016 22:28:58 +0200 (CEST)
Received: by mail-pa0-f67.google.com with SMTP id qn10so5743391pac.2
 for <alsa-devel@alsa-project.org>; Sun, 09 Oct 2016 13:28:58 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "broonie@kernel.org" <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Austin,
 Brian" <Brian.Austin@cirrus.com>, "Handrigan,
 Paul" <Paul.Handrigan@cirrus.com>
List-Id: alsa-devel@alsa-project.org


Mismatching stream names in DAPM route and widget definitions are
causing compilation errors. Fixing these names allows the cs4270
driver to compile and function.

Signed-off-by: Murray Foster <mrafoster@gmail.com>
Acked-by: Paul Handrigan <Paul.Handrigan@cirrus.com>
---
 sound/soc/codecs/cs4270.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/cs4270.c b/sound/soc/codecs/cs4270.c
index e07807d..3670086 100644
--- a/sound/soc/codecs/cs4270.c
+++ b/sound/soc/codecs/cs4270.c
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
