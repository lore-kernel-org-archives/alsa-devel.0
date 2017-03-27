From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: cs35l35: Clear reset_gpio on the error
	path in probe
Date: Mon, 27 Mar 2017 16:54:27 +0100
Message-ID: <1490630067-23455-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 0D42E26583C
 for <alsa-devel@alsa-project.org>; Mon, 27 Mar 2017 17:53:24 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: brian.austin@cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The error path in probe attempts to put the device back into reset.
Should we fail to get the reset_gpio (such as a probe defer) we will
leave the error value in there, which the gpiod_set_value_cansleep on
the error path will attempt to deference.

Fix this issue by clearing reset_gpio before we head into the error
path.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs35l35.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
index 1d9f332..9688274 100644
--- a/sound/soc/codecs/cs35l35.c
+++ b/sound/soc/codecs/cs35l35.c
@@ -1412,10 +1412,10 @@ static int cs35l35_i2c_probe(struct i2c_client *i2c_client,
 						      GPIOD_OUT_LOW);
 	if (IS_ERR(cs35l35->reset_gpio)) {
 		ret = PTR_ERR(cs35l35->reset_gpio);
+		cs35l35->reset_gpio = NULL;
 		if (ret == -EBUSY) {
 			dev_info(dev,
 				 "Reset line busy, assuming shared reset\n");
-			cs35l35->reset_gpio = NULL;
 		} else {
 			dev_err(dev, "Failed to get reset GPIO: %d\n", ret);
 			goto err;
-- 
2.1.4
