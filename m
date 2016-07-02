From: murray foster <mrafoster@gmail.com>
Subject: [PATCH v2] ASoC: cs4270: fix DAPM stream name mismatch
Date: Sat, 2 Jul 2016 02:21:19 -0700 (PDT)
Message-ID: <alpine.LNX.2.00.1607020220500.27037@acc-1004367-dev>
References: <201607021540.sGu2oITV%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 by alsa0.perex.cz (Postfix) with ESMTP id 77172264F02
 for <alsa-devel@alsa-project.org>; Sat,  2 Jul 2016 11:22:06 +0200 (CEST)
Received: by mail-pf0-f195.google.com with SMTP id c74so11990584pfb.0
 for <alsa-devel@alsa-project.org>; Sat, 02 Jul 2016 02:22:06 -0700 (PDT)
In-Reply-To: <201607021540.sGu2oITV%fengguang.wu@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: kbuild test robot <lkp@intel.com>
Cc: brian.austin@cirrus.com, Paul.Handrigan@cirrus.com, kbuild-all@01.org, alsa-devel@alsa-project.org, timur@freescale.com
List-Id: alsa-devel@alsa-project.org


Mismatching stream names in DAPM route and widget definitions are
causing compilation errors. Fixing these names allows the cs4270
driver to compile and function.

Signed-off-by: Murray Foster <mrafoster@gmail.com>
---
Changes in v2:
  - Remove the 's' typo at the beginning of the codec driver.

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
