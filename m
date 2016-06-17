From: weiyj_lk@163.com
Subject: [PATCH -next] ASoC: max9860: fix non static symbol
	warnings
Date: Fri, 17 Jun 2016 17:21:51 +0000
Message-ID: <1466184111-12667-1-git-send-email-weiyj_lk@163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from m12-11.163.com (m12-11.163.com [220.181.12.11])
 by alsa0.perex.cz (Postfix) with ESMTP id 4627C266468
 for <alsa-devel@alsa-project.org>; Fri, 17 Jun 2016 19:21:54 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Rosin <peda@axentia.se>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Wei Yongjun <yongjun_wei@trendmicro.com.cn>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>

Fixes the following sparse warnings:

sound/soc/codecs/max9860.c:120:28: warning:
 symbol 'max9860_regmap' was not declared. Should it be static?
sound/soc/codecs/max9860.c:596:25: warning:
 symbol 'max9860_pm_ops' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
---
 sound/soc/codecs/max9860.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/max9860.c b/sound/soc/codecs/max9860.c
index 2b0dd6a..68074c9 100644
--- a/sound/soc/codecs/max9860.c
+++ b/sound/soc/codecs/max9860.c
@@ -117,7 +117,7 @@ static bool max9860_precious(struct device *dev, unsigned int reg)
 	return false;
 }
 
-const struct regmap_config max9860_regmap = {
+static const struct regmap_config max9860_regmap = {
 	.reg_bits = 8,
 	.val_bits = 8,
 
@@ -593,7 +593,7 @@ static int max9860_resume(struct device *dev)
 }
 #endif
 
-const struct dev_pm_ops max9860_pm_ops = {
+static const struct dev_pm_ops max9860_pm_ops = {
 	SET_RUNTIME_PM_OPS(max9860_suspend, max9860_resume, NULL)
 };
