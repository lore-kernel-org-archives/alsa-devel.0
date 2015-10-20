From: Jiada Wang <jiada_wang@mentor.com>
Subject: [PATCH 1/2] ASoC: WM8962: mark cache_dirty flag after
	software reset in pm_resume
Date: Tue, 20 Oct 2015 11:47:11 +0900
Message-ID: <1445309232-24094-2-git-send-email-jiada_wang@mentor.com>
References: <1445309232-24094-1-git-send-email-jiada_wang@mentor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay1.mentorg.com (relay1.mentorg.com [192.94.38.131])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C653265E10
 for <alsa-devel@alsa-project.org>; Tue, 20 Oct 2015 04:47:11 +0200 (CEST)
In-Reply-To: <1445309232-24094-1-git-send-email-jiada_wang@mentor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com
Cc: jiada_wang@mentor.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

By doing software reset of wm8962 in pm_resume, all registers which
have already been set will be reset to default value without regmap
interface be involved, thus driver need to mark cache_dirty flag,
to let regcache can be updated by regcache_sync().

Signed-off-by: Jiada Wang <jiada_wang@mentor.com>
---
 sound/soc/codecs/wm8962.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 293e47a..a3d7778 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -3805,6 +3805,8 @@ static int wm8962_runtime_resume(struct device *dev)
 
 	wm8962_reset(wm8962);
 
+	regcache_mark_dirty(wm8962->regmap);
+
 	/* SYSCLK defaults to on; make sure it is off so we can safely
 	 * write to registers if the device is declocked.
 	 */
-- 
2.4.5
