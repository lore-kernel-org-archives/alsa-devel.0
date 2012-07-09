From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: arizona: Add IN4 to the mixer tables
Date: Mon,  9 Jul 2012 19:30:53 +0100
Message-ID: <1341858653-27371-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 4851224755
	for <alsa-devel@alsa-project.org>;
	Mon,  9 Jul 2012 20:30:58 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Some devices have four input structures rather than three.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |    4 ++++
 sound/soc/codecs/arizona.h |    2 +-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 901b53e..0970117 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -79,6 +79,8 @@ const char *arizona_mixer_texts[ARIZONA_NUM_MIXER_INPUTS] = {
 	"IN2R",
 	"IN3L",
 	"IN3R",
+	"IN4L",
+	"IN4R",
 	"AIF1RX1",
 	"AIF1RX2",
 	"AIF1RX3",
@@ -138,6 +140,8 @@ int arizona_mixer_values[ARIZONA_NUM_MIXER_INPUTS] = {
 	0x13,
 	0x14,
 	0x15,
+	0x16,
+	0x17,
 	0x20,  /* AIF1RX1 */
 	0x21,
 	0x22,
diff --git a/sound/soc/codecs/arizona.h b/sound/soc/codecs/arizona.h
index 896711e..b894b64 100644
--- a/sound/soc/codecs/arizona.h
+++ b/sound/soc/codecs/arizona.h
@@ -59,7 +59,7 @@ struct arizona_priv {
 	struct arizona_dai_priv dai[ARIZONA_MAX_DAI];
 };
 
-#define ARIZONA_NUM_MIXER_INPUTS 55
+#define ARIZONA_NUM_MIXER_INPUTS 57
 
 extern const unsigned int arizona_mixer_tlv[];
 extern const char *arizona_mixer_texts[ARIZONA_NUM_MIXER_INPUTS];
-- 
1.7.10
