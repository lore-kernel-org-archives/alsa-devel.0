From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: arizona: Hookup SYSCLK to inputs and
	noise generators
Date: Wed,  5 Jun 2013 14:51:31 +0100
Message-ID: <1370440291-2876-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1370440291-2876-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id CE37926548F
 for <alsa-devel@alsa-project.org>; Wed,  5 Jun 2013 16:02:30 +0200 (CEST)
In-Reply-To: <1370440291-2876-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

All sources and sinks should enable SYSCLK.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5102.c |   11 +++++++++++
 sound/soc/codecs/wm5110.c |   13 +++++++++++++
 2 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 100fdad..82dd0c6 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1304,10 +1304,21 @@ static const struct snd_soc_dapm_route wm5102_dapm_routes[] = {
 	{ "OUT5L", NULL, "SYSCLK" },
 	{ "OUT5R", NULL, "SYSCLK" },
 
+	{ "IN1L", NULL, "SYSCLK" },
+	{ "IN1R", NULL, "SYSCLK" },
+	{ "IN2L", NULL, "SYSCLK" },
+	{ "IN2R", NULL, "SYSCLK" },
+	{ "IN3L", NULL, "SYSCLK" },
+	{ "IN3R", NULL, "SYSCLK" },
+
 	{ "MICBIAS1", NULL, "MICVDD" },
 	{ "MICBIAS2", NULL, "MICVDD" },
 	{ "MICBIAS3", NULL, "MICVDD" },
 
+	{ "Noise Generator", NULL, "SYSCLK" },
+	{ "Tone Generator 1", NULL, "SYSCLK" },
+	{ "Tone Generator 2", NULL, "SYSCLK" },
+
 	{ "Noise Generator", NULL, "NOISE" },
 	{ "Tone Generator 1", NULL, "TONE" },
 	{ "Tone Generator 2", NULL, "TONE" },
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 88ad7db..be7216c 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -736,10 +736,23 @@ static const struct snd_soc_dapm_route wm5110_dapm_routes[] = {
 	{ "OUT6L", NULL, "SYSCLK" },
 	{ "OUT6R", NULL, "SYSCLK" },
 
+	{ "IN1L", NULL, "SYSCLK" },
+	{ "IN1R", NULL, "SYSCLK" },
+	{ "IN2L", NULL, "SYSCLK" },
+	{ "IN2R", NULL, "SYSCLK" },
+	{ "IN3L", NULL, "SYSCLK" },
+	{ "IN3R", NULL, "SYSCLK" },
+	{ "IN4L", NULL, "SYSCLK" },
+	{ "IN4R", NULL, "SYSCLK" },
+
 	{ "MICBIAS1", NULL, "MICVDD" },
 	{ "MICBIAS2", NULL, "MICVDD" },
 	{ "MICBIAS3", NULL, "MICVDD" },
 
+	{ "Noise Generator", NULL, "SYSCLK" },
+	{ "Tone Generator 1", NULL, "SYSCLK" },
+	{ "Tone Generator 2", NULL, "SYSCLK" },
+
 	{ "Noise Generator", NULL, "NOISE" },
 	{ "Tone Generator 1", NULL, "TONE" },
 	{ "Tone Generator 2", NULL, "TONE" },
-- 
1.7.2.5
