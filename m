From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm5102: Add missing routes for ASRC
	inputs
Date: Tue, 27 Nov 2012 19:11:22 +0000
Message-ID: <1354043482-25948-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D5AAC260817
 for <alsa-devel@alsa-project.org>; Tue, 27 Nov 2012 20:11:23 +0100 (CET)
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
 sound/soc/codecs/wm5102.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/wm5102.c b/sound/soc/codecs/wm5102.c
index 63c24a3..5a1eb5b 100644
--- a/sound/soc/codecs/wm5102.c
+++ b/sound/soc/codecs/wm5102.c
@@ -1221,6 +1221,11 @@ static const struct snd_soc_dapm_route wm5102_dapm_routes[] = {
 	{ "IN3L PGA", NULL, "IN3L" },
 	{ "IN3R PGA", NULL, "IN3R" },
 
+	{ "ASRC1L", NULL, "ASRC1L Input" },
+	{ "ASRC1R", NULL, "ASRC1R Input" },
+	{ "ASRC2L", NULL, "ASRC2L Input" },
+	{ "ASRC2R", NULL, "ASRC2R Input" },
+
 	ARIZONA_MIXER_ROUTES("OUT1L", "HPOUT1L"),
 	ARIZONA_MIXER_ROUTES("OUT1R", "HPOUT1R"),
 	ARIZONA_MIXER_ROUTES("OUT2L", "HPOUT2L"),
-- 
1.7.10.4
