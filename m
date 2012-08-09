From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: wm8994: Add missing dapm routes for
	WM8958 rev A
Date: Thu,  9 Aug 2012 14:20:49 +0100
Message-ID: <1344518449-10730-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 66486266316
 for <alsa-devel@alsa-project.org>; Thu,  9 Aug 2012 14:51:05 +0200 (CEST)
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
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Chris Rattray <crattray@opensource.wolfsonmicro.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

From: Chris Rattray <crattray@opensource.wolfsonmicro.com>

Signed-off-by: Chris Rattray <crattray@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8994.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/wm8994.c b/sound/soc/codecs/wm8994.c
index 04ef031..6c9eeca 100644
--- a/sound/soc/codecs/wm8994.c
+++ b/sound/soc/codecs/wm8994.c
@@ -4038,6 +4038,8 @@ static int wm8994_codec_probe(struct snd_soc_codec *codec)
 		break;
 	case WM8958:
 		if (wm8994->revision < 1) {
+			snd_soc_dapm_add_routes(dapm, wm8994_intercon,
+						ARRAY_SIZE(wm8994_intercon));
 			snd_soc_dapm_add_routes(dapm, wm8994_revd_intercon,
 						ARRAY_SIZE(wm8994_revd_intercon));
 			snd_soc_dapm_add_routes(dapm, wm8994_lateclk_revd_intercon,
-- 
1.7.10.4
