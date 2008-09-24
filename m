From: <20080924115907.GA12401@opensource.wolfsonmicro.com>
Subject: [PATCH 1/4] ASoC: Fix inverted input PGA mute bits in
	WM8903
Date: Wed, 24 Sep 2008 13:01:07 +0100
Message-ID: <1222257670-12527-1-git-send-email-20080924115907.GA12401@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3E6662415D
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Sep 2008 14:01:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@opensource.wolfsonmicro.com>

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index a3f54ec..ce40d78 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -653,14 +653,14 @@ static const struct snd_kcontrol_new wm8903_snd_controls[] = {
 
 /* Input PGAs - No TLV since the scale depends on PGA mode */
 SOC_SINGLE("Left Input PGA Switch", WM8903_ANALOGUE_LEFT_INPUT_0,
-	   7, 1, 0),
+	   7, 1, 1),
 SOC_SINGLE("Left Input PGA Volume", WM8903_ANALOGUE_LEFT_INPUT_0,
 	   0, 31, 0),
 SOC_SINGLE("Left Input PGA Common Mode Switch", WM8903_ANALOGUE_LEFT_INPUT_1,
 	   6, 1, 0),
 
 SOC_SINGLE("Right Input PGA Switch", WM8903_ANALOGUE_RIGHT_INPUT_0,
-	   7, 1, 0),
+	   7, 1, 1),
 SOC_SINGLE("Right Input PGA Volume", WM8903_ANALOGUE_RIGHT_INPUT_0,
 	   0, 31, 0),
 SOC_SINGLE("Right Input PGA Common Mode Switch", WM8903_ANALOGUE_RIGHT_INPUT_1,
-- 
1.5.6.5
