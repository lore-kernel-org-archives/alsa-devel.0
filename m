From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/6] ASoC: Don't resync WM8903 register cache
	on reset
Date: Fri,  2 Dec 2011 19:28:13 +0000
Message-ID: <1322854095-14437-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20111202192330.GA4333@opensource.wolfsonmicro.com>
	<1322854095-14437-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 3D30C2461B
	for <alsa-devel@alsa-project.org>; Fri,  2 Dec 2011 20:28:20 +0100 (CET)
In-Reply-To: <1322854095-14437-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Stephen Warren <swarren@nvidia.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

We only do this on initial power on so it's at best a waste of time as
the core will have already defaulted to the same values.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 5113e64..2f18c51 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -260,8 +260,6 @@ static int wm8903_volatile_register(struct snd_soc_codec *codec, unsigned int re
 static void wm8903_reset(struct snd_soc_codec *codec)
 {
 	snd_soc_write(codec, WM8903_SW_RESET_AND_ID, 0);
-	memcpy(codec->reg_cache, wm8903_reg_defaults,
-	       sizeof(wm8903_reg_defaults));
 }
 
 static int wm8903_cp_event(struct snd_soc_dapm_widget *w,
-- 
1.7.7.3
