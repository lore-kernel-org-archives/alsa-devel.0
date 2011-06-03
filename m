From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 4/4] ASoC: Add missing break in WM8915 FLL
	source selection
Date: Fri,  3 Jun 2011 18:47:03 +0100
Message-ID: <1307123223-30847-4-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1307123223-30847-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id C296B103975
	for <alsa-devel@alsa-project.org>;
	Fri,  3 Jun 2011 19:47:06 +0200 (CEST)
In-Reply-To: <1307123223-30847-1-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8915.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8915.c b/sound/soc/codecs/wm8915.c
index 62e72fc..a1d8618 100644
--- a/sound/soc/codecs/wm8915.c
+++ b/sound/soc/codecs/wm8915.c
@@ -2041,6 +2041,7 @@ static int wm8915_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 		break;
 	case WM8915_FLL_MCLK2:
 		reg = 1;
+		break;
 	case WM8915_FLL_DACLRCLK1:
 		reg = 2;
 		break;
-- 
1.7.5.3
