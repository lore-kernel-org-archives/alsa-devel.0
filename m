From: weiyj_lk@163.com
Subject: [PATCH] ASoC: tfa9879: Fix return value check in
	tfa9879_i2c_probe()
Date: Thu, 16 Apr 2015 20:17:46 +0800
Message-ID: <1429186666-20547-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m12-12.163.com (m12-12.163.com [220.181.12.12])
 by alsa0.perex.cz (Postfix) with ESMTP id B06032612C9
 for <alsa-devel@alsa-project.org>; Thu, 16 Apr 2015 14:17:55 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Rosin <peda@axentia.se>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

In case of error, the function devm_kzalloc() returns NULL
not ERR_PTR(). The IS_ERR() test in the return value check
should be replaced with NULL test.

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/codecs/tfa9879.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/tfa9879.c b/sound/soc/codecs/tfa9879.c
index 16f1b71..aab0af6 100644
--- a/sound/soc/codecs/tfa9879.c
+++ b/sound/soc/codecs/tfa9879.c
@@ -280,8 +280,8 @@ static int tfa9879_i2c_probe(struct i2c_client *i2c,
 	int i;
 
 	tfa9879 = devm_kzalloc(&i2c->dev, sizeof(*tfa9879), GFP_KERNEL);
-	if (IS_ERR(tfa9879))
-		return PTR_ERR(tfa9879);
+	if (!tfa9879)
+		return -ENOMEM;
 
 	i2c_set_clientdata(i2c, tfa9879);
 
