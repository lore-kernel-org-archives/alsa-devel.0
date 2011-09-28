From: Susan Gao <sgao@opensource.wolfsonmicro.com>
Subject: [PATCH] fix the bug for WM8962 DSP_A and DSP_B settings
Date: Wed, 28 Sep 2011 11:28:00 -0700
Message-ID: <1317234480.4164.57.camel@susan-PowerEdge-T100>
Reply-To: sgao@opensource.wolfsonmicro.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E0A95103A96
	for <alsa-devel@alsa-project.org>;
	Wed, 28 Sep 2011 20:28:08 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Susan Gao <sgao@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8962.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 117349b..49ea487 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3030,8 +3030,7 @@ static int wm8962_set_dai_fmt(struct snd_soc_dai
*dai, unsigned int fmt)
 	switch (fmt & SND_SOC_DAIFMT_FORMAT_MASK) {
 	case SND_SOC_DAIFMT_DSP_A:
-		aif0 |= WM8962_LRCLK_INV;
-	case SND_SOC_DAIFMT_DSP_B:
 		aif0 |= 3;
+	case SND_SOC_DAIFMT_DSP_B:
+		aif0 |= 3 | WM8962_LRCLK_INV;
 		switch (fmt & SND_SOC_DAIFMT_INV_MASK) {
 		case SND_SOC_DAIFMT_NB_NF:
--
1.7.1
