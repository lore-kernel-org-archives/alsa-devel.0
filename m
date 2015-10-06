From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH 1/2] ASoC: WM8962: mark cache_dirty flag after
	software reset in pm_resume
Date: Tue, 6 Oct 2015 16:06:54 +0900
Message-ID: <1444115215-4388-2-git-send-email-jiada_wang@mentor.com>
References: <1444115215-4388-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by alsa0.perex.cz (Postfix) with ESMTP id E8B88262631
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 09:06:59 +0200 (CEST)
In-Reply-To: <1444115215-4388-1-git-send-email-jiada_wang@mentor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: jiada_wang@mentor.com
List-Id: alsa-devel@alsa-project.org

By doing software reset of wm8962 in pm_resume, all registers which
have already been set will be reset to default value without regmap
interface be involved, thus driver need to mark cache_dirty flag,
to let regcache can be updated by regcache_sync().

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 sound/soc/codecs/wm8962.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 293e47a..319ee38 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3805,6 +3805,13 @@ static int wm8962_runtime_resume(struct device *dev)
 
 	wm8962_reset(wm8962);
 
+	/* All registers have been reset to default value without calling
+	 * to regmap interface, even if reset fails, some registers
+	 * maybe in intermediate status, so we need to mark regmap
+	 * cache_dirty flag.
+	 */
+	regcache_mark_dirty(wm8962->regmap);
+
 	/* SYSCLK defaults to on; make sure it is off so we can safely
 	 * write to registers if the device is declocked.
 	 */
-- 
2.4.5
