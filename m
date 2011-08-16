From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Clear completions from late WM8996 FLL
	lock IRQs
Date: Tue, 16 Aug 2011 16:59:10 +0900
Message-ID: <1313481550-25139-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 5E17124601
	for <alsa-devel@alsa-project.org>;
	Tue, 16 Aug 2011 09:59:28 +0200 (CEST)
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

In case we have a pending completion, for example due to a problem with
the input clock which got corrected after we timed out.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8996.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index ab8e9d1..a44a0e5 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -2106,6 +2106,9 @@ static int wm8996_set_fll(struct snd_soc_codec *codec, int fll_id, int source,
 
 	snd_soc_write(codec, WM8996_FLL_EFS_1, fll_div.lambda);
 
+	/* Clear any pending completions (eg, from failed startups) */
+	try_wait_for_completion(&wm8996->fll_lock);
+
 	snd_soc_update_bits(codec, WM8996_FLL_CONTROL_1,
 			    WM8996_FLL_ENA, WM8996_FLL_ENA);
 
-- 
1.7.5.4
