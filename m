From: Colin King <colin.king@canonical.com>
Subject: [PATCH][sound-next] ASoC: zx_aud96p22: make
	aud96p22_dt_ids static
Date: Mon, 26 Jun 2017 10:00:14 +0100
Message-ID: <20170626090014.8977-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E5F5266F04
 for <alsa-devel@alsa-project.org>; Mon, 26 Jun 2017 11:00:19 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Baoyou Xie <baoyou.xie@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

The structure aud96p22_dt_ids does not need to be in global scope,
so make it static.

Cleans up sparse warning:
"warning: symbol 'aud96p22_dt_ids' was not declared. Should it be static?"

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/codecs/zx_aud96p22.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/zx_aud96p22.c b/sound/soc/codecs/zx_aud96p22.c
index 032fb7cf6cbd..bc23ce1a30a1 100644
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
