From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/2] ASoC: wm5110: Add missing input PGA routes
Date: Fri, 10 Aug 2012 15:53:43 +0100
Message-ID: <1344610424-29057-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1344610424-29057-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 75CE926658C
 for <alsa-devel@alsa-project.org>; Fri, 10 Aug 2012 16:24:00 +0200 (CEST)
In-Reply-To: <1344610424-29057-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm5110.c |   12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index 3db6e6e..57c7d9c 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -685,6 +685,18 @@ static const struct snd_soc_dapm_route wm5110_dapm_routes[] = {
 	{ "AIF2 Capture", NULL, "SYSCLK" },
 	{ "AIF3 Capture", NULL, "SYSCLK" },
 
+	{ "IN1L PGA", NULL, "IN1L" },
+	{ "IN1R PGA", NULL, "IN1R" },
+
+	{ "IN2L PGA", NULL, "IN2L" },
+	{ "IN2R PGA", NULL, "IN2R" },
+
+	{ "IN3L PGA", NULL, "IN3L" },
+	{ "IN3R PGA", NULL, "IN3R" },
+
+	{ "IN4L PGA", NULL, "IN4L" },
+	{ "IN4R PGA", NULL, "IN4R" },
+
 	ARIZONA_MIXER_ROUTES("OUT1L", "HPOUT1L"),
 	ARIZONA_MIXER_ROUTES("OUT1R", "HPOUT1R"),
 	ARIZONA_MIXER_ROUTES("OUT2L", "HPOUT2L"),
-- 
1.7.10.4
