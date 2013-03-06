From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: arizona: Increase FLL synchroniser
	bandwidth for high frequencies
Date: Wed,  6 Mar 2013 14:28:15 +0800
Message-ID: <1362551296-14920-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1362551296-14920-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id D6D02265329
 for <alsa-devel@alsa-project.org>; Wed,  6 Mar 2013 07:29:20 +0100 (CET)
In-Reply-To: <1362551296-14920-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <sameo@linux.intel.com>, Liam Girdwood <liam.r.girdwood@intel.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

If we are using a high freqency SYNCCLK then increasing the bandwidth of
the synchroniser improves performance.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 81da6ef..41c116f 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1342,6 +1342,17 @@ static void arizona_enable_fll(struct arizona_fll *fll,
 		return;
 	}
 
+	/*
+	 * Increase the bandwidth if we're not using a low frequency
+	 * sync source.
+	 */
+	if (fll->sync_src >= 0 && fll->sync_freq > 100000)
+		regmap_update_bits(arizona->regmap, fll->base + 0x17,
+				   ARIZONA_FLL1_SYNC_BW, 0);
+	else
+		regmap_update_bits(arizona->regmap, fll->base + 0x17,
+				   ARIZONA_FLL1_SYNC_BW, ARIZONA_FLL1_SYNC_BW);
+
 	if (!arizona_is_enabled_fll(fll))
 		pm_runtime_get(arizona->dev);
 
-- 
1.7.10.4
