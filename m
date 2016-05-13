From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/5] ASoC: arizona: Tie SYSCLK to DRC signal
	activity widgets
Date: Fri, 13 May 2016 16:45:15 +0100
Message-ID: <1463154319-10070-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1463154319-10070-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 78A6F2651A3
 for <alsa-devel@alsa-project.org>; Fri, 13 May 2016 17:45:16 +0200 (CEST)
In-Reply-To: <1463154319-10070-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lee.jones@linaro.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The intent is for SYSCLK to be tied to all input and output widgets such
that it turns on whenever the chip is in use. It is not tied to the DRC
signal activity detect virtual outputs, whilst in practice this is
unlikely to cause an issue (as an input will likely also be powered up)
best to correct.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs47l24.c | 2 ++
 sound/soc/codecs/wm5102.c  | 1 +
 sound/soc/codecs/wm5110.c  | 2 ++
 sound/soc/codecs/wm8998.c  | 1 +
 4 files changed, 6 insertions(+)

diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index 5ec5a68..23a14be 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -899,6 +899,8 @@ static const struct snd_soc_dapm_route cs47l24_dapm_routes[] = {
 
 	{ "MICSUPP", NULL, "SYSCLK" },
 
+	{ "DRC1 Signal Activity", NULL, "SYSCLK" },
+	{ "DRC2 Signal Activity", NULL, "SYSCLK" },
 	{ "DRC1 Signal Activity", NULL, "DRC1L" },
 	{ "DRC1 Signal Activity", NULL, "DRC1R" },
 	{ "DRC2 Signal Activity", NULL, "DRC2L" },
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index da60e3f..3f024b8 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1713,6 +1713,7 @@ static const struct snd_soc_dapm_route wm5102_dapm_routes[] = {
 
 	{ "MICSUPP", NULL, "SYSCLK" },
 
+	{ "DRC1 Signal Activity", NULL, "SYSCLK" },
 	{ "DRC1 Signal Activity", NULL, "DRC1L" },
 	{ "DRC1 Signal Activity", NULL, "DRC1R" },
 };
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index b5820e4..c2a9edc 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -1997,6 +1997,8 @@ static const struct snd_soc_dapm_route wm5110_dapm_routes[] = {
 
 	{ "MICSUPP", NULL, "SYSCLK" },
 
+	{ "DRC1 Signal Activity", NULL, "SYSCLK" },
+	{ "DRC2 Signal Activity", NULL, "SYSCLK" },
 	{ "DRC1 Signal Activity", NULL, "DRC1L" },
 	{ "DRC1 Signal Activity", NULL, "DRC1R" },
 	{ "DRC2 Signal Activity", NULL, "DRC2L" },
diff --git a/sound/soc/codecs/wm8998.c b/sound/soc/codecs/wm8998.c
index 449f666..3a5c896 100644
--- a/sound/soc/codecs/wm8998.c
+++ b/sound/soc/codecs/wm8998.c
@@ -1166,6 +1166,7 @@ static const struct snd_soc_dapm_route wm8998_dapm_routes[] = {
 
 	{ "MICSUPP", NULL, "SYSCLK" },
 
+	{ "DRC1 Signal Activity", NULL, "SYSCLK" },
 	{ "DRC1 Signal Activity", NULL, "DRC1L" },
 	{ "DRC1 Signal Activity", NULL, "DRC1R" },
 };
-- 
2.1.4
