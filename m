From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 10/31] ASoC: wm8900: Use WARN_ON() instead of
	BUG_ON()
Date: Tue,  5 Nov 2013 18:39:57 +0100
Message-ID: <1383673218-18405-11-git-send-email-tiwai@suse.de>
References: <1383673218-18405-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 309C7265208
 for <alsa-devel@alsa-project.org>; Tue,  5 Nov 2013 18:40:42 +0100 (CET)
In-Reply-To: <1383673218-18405-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

BUG_ON() is rather useless for debugging as it leads to panic().
Use WARN_ON() and handle the error cases accordingly.

Cc: patches@opensource.wolfsonmicro.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/soc/codecs/wm8900.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8900.c b/sound/soc/codecs/wm8900.c
index 7c8257c5a17b..de67e74dca0c 100644
--- a/sound/soc/codecs/wm8900.c
+++ b/sound/soc/codecs/wm8900.c
@@ -691,7 +691,8 @@ static int fll_factors(struct _fll_div *fll_div, unsigned int Fref,
 	unsigned int K, Ndiv, Nmod, target;
 	unsigned int div;
 
-	BUG_ON(!Fout);
+	if (WARN_ON(!Fout))
+		return -EINVAL;
 
 	/* The FLL must run at 90-100MHz which is then scaled down to
 	 * the output value by FLLCLK_DIV. */
@@ -742,8 +743,9 @@ static int fll_factors(struct _fll_div *fll_div, unsigned int Fref,
 	/* Move down to proper range now rounding is done */
 	fll_div->k = K / 10;
 
-	BUG_ON(target != Fout * (fll_div->fllclk_div << 2));
-	BUG_ON(!K && target != Fref * fll_div->fll_ratio * fll_div->n);
+	if (WARN_ON(target != Fout * (fll_div->fllclk_div << 2)) ||
+	    WARN_ON(!K && target != Fref * fll_div->fll_ratio * fll_div->n))
+		return -EINVAL;
 
 	return 0;
 }
-- 
1.8.4.2
