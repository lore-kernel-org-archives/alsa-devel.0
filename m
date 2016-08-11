From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Connect ASRCs to both clock
	domains
Date: Thu, 11 Aug 2016 14:42:55 +0100
Message-ID: <1470922975-15983-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id BA20326935F
 for <alsa-devel@alsa-project.org>; Thu, 11 Aug 2016 15:42:45 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The two clock domains are enabled based on each input and output of the
chip being connected to its respective clock domain. The ASRC however
can bridge the two domains and as such can function as an input/output
to either domain. The hardware also requires that both clocks are
enabled before the ASRC is. Ensure these constraints by linking the
ASRCs to both SYSCLK and ASYNCCLK.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs47l24.c | 10 ++++++++++
 sound/soc/codecs/wm5102.c  | 10 ++++++++++
 sound/soc/codecs/wm5110.c  | 10 ++++++++++
 sound/soc/codecs/wm8998.c  | 10 ++++++++++
 4 files changed, 40 insertions(+)

diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index 779a7bf..257b152 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -746,6 +746,16 @@ static const struct snd_soc_dapm_route cs47l24_dapm_routes[] = {
 	{ "IN2L", NULL, "SYSCLK" },
 	{ "IN2R", NULL, "SYSCLK" },
 
+	{ "ASRC1L", NULL, "SYSCLK" },
+	{ "ASRC1R", NULL, "SYSCLK" },
+	{ "ASRC2L", NULL, "SYSCLK" },
+	{ "ASRC2R", NULL, "SYSCLK" },
+
+	{ "ASRC1L", NULL, "ASYNCCLK" },
+	{ "ASRC1R", NULL, "ASYNCCLK" },
+	{ "ASRC2L", NULL, "ASYNCCLK" },
+	{ "ASRC2R", NULL, "ASYNCCLK" },
+
 	{ "MICBIAS1", NULL, "MICVDD" },
 	{ "MICBIAS2", NULL, "MICVDD" },
 
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 1295978..2d6c19d 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1521,6 +1521,16 @@ static const struct snd_soc_dapm_route wm5102_dapm_routes[] = {
 	{ "IN3L", NULL, "SYSCLK" },
 	{ "IN3R", NULL, "SYSCLK" },
 
+	{ "ASRC1L", NULL, "SYSCLK" },
+	{ "ASRC1R", NULL, "SYSCLK" },
+	{ "ASRC2L", NULL, "SYSCLK" },
+	{ "ASRC2R", NULL, "SYSCLK" },
+
+	{ "ASRC1L", NULL, "ASYNCCLK" },
+	{ "ASRC1R", NULL, "ASYNCCLK" },
+	{ "ASRC2L", NULL, "ASYNCCLK" },
+	{ "ASRC2R", NULL, "ASYNCCLK" },
+
 	{ "MICBIAS1", NULL, "MICVDD" },
 	{ "MICBIAS2", NULL, "MICVDD" },
 	{ "MICBIAS3", NULL, "MICVDD" },
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 3e7f873..fa35e19 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -1745,6 +1745,16 @@ static const struct snd_soc_dapm_route wm5110_dapm_routes[] = {
 	{ "IN4L", NULL, "SYSCLK" },
 	{ "IN4R", NULL, "SYSCLK" },
 
+	{ "ASRC1L", NULL, "SYSCLK" },
+	{ "ASRC1R", NULL, "SYSCLK" },
+	{ "ASRC2L", NULL, "SYSCLK" },
+	{ "ASRC2R", NULL, "SYSCLK" },
+
+	{ "ASRC1L", NULL, "ASYNCCLK" },
+	{ "ASRC1R", NULL, "ASYNCCLK" },
+	{ "ASRC2L", NULL, "ASYNCCLK" },
+	{ "ASRC2R", NULL, "ASYNCCLK" },
+
 	{ "MICBIAS1", NULL, "MICVDD" },
 	{ "MICBIAS2", NULL, "MICVDD" },
 	{ "MICBIAS3", NULL, "MICVDD" },
diff --git a/sound/soc/codecs/wm8998.c b/sound/soc/codecs/wm8998.c
index 315b23b..edaa4cf 100644
--- a/sound/soc/codecs/wm8998.c
+++ b/sound/soc/codecs/wm8998.c
@@ -966,6 +966,16 @@ static const struct snd_soc_dapm_route wm8998_dapm_routes[] = {
 	{ "IN2A", NULL, "SYSCLK" },
 	{ "IN2B", NULL, "SYSCLK" },
 
+	{ "ASRC1L", NULL, "SYSCLK" },
+	{ "ASRC1R", NULL, "SYSCLK" },
+	{ "ASRC2L", NULL, "SYSCLK" },
+	{ "ASRC2R", NULL, "SYSCLK" },
+
+	{ "ASRC1L", NULL, "ASYNCCLK" },
+	{ "ASRC1R", NULL, "ASYNCCLK" },
+	{ "ASRC2L", NULL, "ASYNCCLK" },
+	{ "ASRC2R", NULL, "ASYNCCLK" },
+
 	{ "SPD1", NULL, "SYSCLK" },
 	{ "SPD1", NULL, "SPD1TX1" },
 	{ "SPD1", NULL, "SPD1TX2" },
-- 
2.1.4
