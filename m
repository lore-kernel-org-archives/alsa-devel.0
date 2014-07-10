From: <bardliao@realtek.com>
Subject: [PATCH] ASoC: rt286: make rt286_i2c_driver static
Date: Thu, 10 Jul 2014 18:14:57 +0800
Message-ID: <1404987297-18313-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rtits2.realtek.com (rtits2.realtek.com [60.250.210.242])
 by alsa0.perex.cz (Postfix) with ESMTP id 9030F265218
 for <alsa-devel@alsa-project.org>; Thu, 10 Jul 2014 12:15:23 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org, lgirdwood@gmail.com
Cc: oder_chiou@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, Bard Liao <bardliao@realtek.com>, Fengguang Wu <fengguang.wu@intel.com>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

From: Bard Liao <bardliao@realtek.com>

Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
This is reported by kbuild test robot. I don't know if my sob line
is needed or not.
---
 sound/soc/codecs/rt286.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index 8103315..218f86e 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -1206,7 +1206,7 @@ static int rt286_i2c_remove(struct i2c_client *i2c)
 }
 
 
-struct i2c_driver rt286_i2c_driver = {
+static struct i2c_driver rt286_i2c_driver = {
 	.driver = {
 		   .name = "rt286",
 		   .owner = THIS_MODULE,
-- 
1.8.1.1.439.g50a6b54
