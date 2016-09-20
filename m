From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/7] ASoC: arizona: Attach SYSCLK to DSP
	preloaders
Date: Tue, 20 Sep 2016 13:52:30 +0100
Message-ID: <1474375956-10443-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1474375956-10443-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com
 [67.231.149.25])
 by alsa0.perex.cz (Postfix) with ESMTP id 9F2A92666AA
 for <alsa-devel@alsa-project.org>; Tue, 20 Sep 2016 14:52:38 +0200 (CEST)
In-Reply-To: <1474375956-10443-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

Currently SYSCLK is attached to every compressed DAI as this follows the
pattern of attaching clocks to the chips inputs and outputs, however, it is
really the DSP that requires the clock here. As firmware download can be a
significant part of the path startup time for these devices occasionally it
would be desirable to download the firmware in advance of the path being
brought up.

To help facilitate this early firmware loading this patch attaches the
SYSCLK to the DSP preloader widget. This also saves us adding a new route
to SYSCLK every time a new compressed DAI is created.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.h | 1 +
 sound/soc/codecs/cs47l24.c | 2 --
 sound/soc/codecs/wm5102.c  | 1 -
 sound/soc/codecs/wm5110.c  | 2 --
 4 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 1728771..c3daa07 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -190,6 +190,7 @@ extern unsigned int arizona_mixer_values[ARIZONA_NUM_MIXER_INPUTS];
 
 #define ARIZONA_DSP_ROUTES(name) \
 	{ name, NULL, name " Preloader"}, \
+	{ name " Preloader", NULL, "SYSCLK" }, \
 	{ name " Preloader", NULL, name " Aux 1" }, \
 	{ name " Preloader", NULL, name " Aux 2" }, \
 	{ name " Preloader", NULL, name " Aux 3" }, \
diff --git a/sound/soc/codecs/cs47l24.c b/sound/soc/codecs/cs47l24.c
index 5e8f979..7df6a67 100644
--- a/sound/soc/codecs/cs47l24.c
+++ b/sound/soc/codecs/cs47l24.c
@@ -816,7 +816,6 @@ static const struct snd_soc_dapm_route cs47l24_dapm_routes[] = {
 	{ "AIF3 Capture", NULL, "SYSCLK" },
 
 	{ "Voice Control DSP", NULL, "DSP3" },
-	{ "Voice Control DSP", NULL, "SYSCLK" },
 
 	{ "IN1L PGA", NULL, "IN1L" },
 	{ "IN1R PGA", NULL, "IN1R" },
@@ -825,7 +824,6 @@ static const struct snd_soc_dapm_route cs47l24_dapm_routes[] = {
 	{ "IN2R PGA", NULL, "IN2R" },
 
 	{ "Audio Trace DSP", NULL, "DSP2" },
-	{ "Audio Trace DSP", NULL, "SYSCLK" },
 
 	ARIZONA_MIXER_ROUTES("OUT1L", "HPOUT1L"),
 	ARIZONA_MIXER_ROUTES("OUT1R", "HPOUT1R"),
diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index a891344..bb3de5b 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1615,7 +1615,6 @@ static const struct snd_soc_dapm_route wm5102_dapm_routes[] = {
 	{ "Slim3 Capture", NULL, "SYSCLK" },
 
 	{ "Audio Trace DSP", NULL, "DSP1" },
-	{ "Audio Trace DSP", NULL, "SYSCLK" },
 
 	{ "IN1L PGA", NULL, "IN1L" },
 	{ "IN1R PGA", NULL, "IN1R" },
diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index a4331ad..407dc4a 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -1846,10 +1846,8 @@ static const struct snd_soc_dapm_route wm5110_dapm_routes[] = {
 	{ "Slim3 Capture", NULL, "SYSCLK" },
 
 	{ "Voice Control DSP", NULL, "DSP3" },
-	{ "Voice Control DSP", NULL, "SYSCLK" },
 
 	{ "Audio Trace DSP", NULL, "DSP1" },
-	{ "Audio Trace DSP", NULL, "SYSCLK" },
 
 	{ "IN1L PGA", NULL, "IN1L" },
 	{ "IN1R PGA", NULL, "IN1R" },
-- 
2.1.4
