From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH 1/1] ASoC: arizona: Set FLL to free-run before disabling
Date: Wed, 20 Nov 2013 13:15:47 +0000
Message-ID: <20131120131547.GA7357@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, ckeepax@opensource.wolfsonmicro.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org


Signed-off-by: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/arizona.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 6f05b17..fea9910 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -1529,6 +1529,8 @@ static void arizona_enable_fll(struct arizona_fll *fll,
 	try_wait_for_completion(&fll->ok);
 
 	regmap_update_bits(arizona->regmap, fll->base + 1,
+			   ARIZONA_FLL1_FREERUN, 0);
+	regmap_update_bits(arizona->regmap, fll->base + 1,
 			   ARIZONA_FLL1_ENA, ARIZONA_FLL1_ENA);
 	if (use_sync)
 		regmap_update_bits(arizona->regmap, fll->base + 0x11,
@@ -1546,6 +1548,8 @@ static void arizona_disable_fll(struct arizona_fll *fll)
 	struct arizona *arizona = fll->arizona;
 	bool change;
 
+	regmap_update_bits(arizona->regmap, fll->base + 1,
+			   ARIZONA_FLL1_FREERUN, ARIZONA_FLL1_FREERUN);
 	regmap_update_bits_check(arizona->regmap, fll->base + 1,
 				 ARIZONA_FLL1_ENA, 0, &change);
 	regmap_update_bits(arizona->regmap, fll->base + 0x11,
-- 
1.7.2.5
