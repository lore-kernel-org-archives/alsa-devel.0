From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH v2] ASoC: rl6347a: Use dev_err for I2C
	communication error prints
Date: Fri,  7 Oct 2016 10:59:51 +0300
Message-ID: <20161007075951.20386-1-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DF64266AD7
 for <alsa-devel@alsa-project.org>; Fri,  7 Oct 2016 10:01:56 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

It's difficult to guess from bunch of "ret=-121" errors what driver and
device actually caused them. Since struct i2c_client has the dev pointer
use that for dev_err() with meaningful error message.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/codecs/rl6347a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rl6347a.c b/sound/soc/codecs/rl6347a.c
index a4b910efbd45..8f571cf8edd4 100644
--- a/sound/soc/codecs/rl6347a.c
+++ b/sound/soc/codecs/rl6347a.c
@@ -51,7 +51,7 @@ int rl6347a_hw_write(void *context, unsigned int reg, unsigned int value)
 	if (ret == 4)
 		return 0;
 	else
-		pr_err("ret=%d\n", ret);
+		dev_err(&client->dev, "I2C error %d\n", ret);
 	if (ret < 0)
 		return ret;
 	else
-- 
2.9.3
