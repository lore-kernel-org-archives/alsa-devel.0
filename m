From: Richard Fitzgerald <rf@opensource.wolfsonmicro.com>
Subject: [PATCH v2 1/1] ASoC: arizona: Set FLL to free-run
	before disabling
Date: Wed, 20 Nov 2013 14:37:09 +0000
Message-ID: <20131120143709.GA12897@opensource.wolfsonmicro.com>
References: <20131120131547.GA7357@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 9B2612615F3
 for <alsa-devel@alsa-project.org>; Wed, 20 Nov 2013 15:37:11 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20131120131547.GA7357@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lgirdwood@gmail.com, tiwai@suse.de, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The FLL must be placed into free-run mode before disabling
to allow it to entirely shut down.

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
