From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: zx_aud96p22: make array aud96p22_dt_ids
	static
Date: Sun, 13 Aug 2017 16:28:08 +0100
Message-ID: <20170813152808.17774-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B0C52266884
 for <alsa-devel@alsa-project.org>; Sun, 13 Aug 2017 17:28:15 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Bhumika Goyal <bhumirks@gmail.com>, Shawn Guo <shawn.guo@linaro.org>, Baoyou Xie <baoyou.xie@linaro.org>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

The array aud96p22_dt_ids is local to the source and does not need to be
in global scope, so make it static.

Cleans up sparse warning:
symbol 'aud96p22_dt_ids' was not declared. Should it be static?

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/zx_aud96p22.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/zx_aud96p22.c b/sound/soc/codecs/zx_aud96p22.c
index 36d0a7087a54..78017fb69c04 100644
--- a/sound/soc/codecs/zx_aud96p22.c
+++ b/sound/soc/codecs/zx_aud96p22.c
@@ -382,7 +382,7 @@ static int aud96p22_i2c_remove(struct i2c_client *i2c)
 	return 0;
 }
 
-const struct of_device_id aud96p22_dt_ids[] = {
+static const struct of_device_id aud96p22_dt_ids[] = {
 	{ .compatible = "zte,zx-aud96p22", },
 	{ }
 };
-- 
2.11.0
