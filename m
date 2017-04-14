From: Douglas Anderson <dianders@chromium.org>
Subject: [PATCH 1/3] ASoC: rt5514: Mark rt5514_i2c_driver as
	static
Date: Fri, 14 Apr 2017 09:40:30 -0700
Message-ID: <20170414164033.11681-1-dianders@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pg0-f41.google.com (mail-pg0-f41.google.com [74.125.83.41])
 by alsa0.perex.cz (Postfix) with ESMTP id A2B782671F1
 for <alsa-devel@alsa-project.org>; Fri, 14 Apr 2017 18:41:01 +0200 (CEST)
Received: by mail-pg0-f41.google.com with SMTP id x125so45519878pgb.0
 for <alsa-devel@alsa-project.org>; Fri, 14 Apr 2017 09:41:01 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: bardliao@realtek.com, oder_chiou@realtek.com
Cc: alsa-devel@alsa-project.org, Douglas Anderson <dianders@chromium.org>, lgirdwood@gmail.com, linux-kernel@vger.kernel.org, tiwai@suse.com, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

There's no reason for rt5514_i2c_driver to be non-static.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
 sound/soc/codecs/rt5514.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index b281a46d769d..481e77763fe4 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -1149,7 +1149,7 @@ static int rt5514_i2c_remove(struct i2c_client *i2c)
 	return 0;
 }
 
-struct i2c_driver rt5514_i2c_driver = {
+static struct i2c_driver rt5514_i2c_driver = {
 	.driver = {
 		.name = "rt5514",
 		.of_match_table = of_match_ptr(rt5514_of_match),
-- 
2.12.2.762.g0e3151a226-goog
