From: Colin King <colin.king@canonical.com>
Subject: [PATCH][-next] ASoC: rt5663: add in missing loop
	counter to avoid infinite loop
Date: Mon, 10 Jul 2017 16:20:45 +0100
Message-ID: <20170710152045.28898-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 4C0A3266D49
 for <alsa-devel@alsa-project.org>; Mon, 10 Jul 2017 17:20:53 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>, Oder Chiou <oder_chiou@realtek.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

The loop counter 'count' is missing an increment, so we could end up
with an infinite loop.  Add in a pre-increment to count to fix this.

Detected by CoverityScan, CID#1450120 ("Logically Dead Code")

Fixes: 1a425dbf1a10 ("ASoC: rt5663: Update the calibration funciton")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/rt5663.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index 82edbcf39caa..5b3c50c641d8 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -3044,7 +3044,7 @@ static void rt5663_calibrate(struct rt5663_priv *rt5663)
 		else
 			break;
 
-		if (count > 200)
+		if (++count > 200)
 			break;
 	}
 
-- 
2.11.0
