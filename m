From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: cs35l35: Add additional delay for reset
Date: Wed, 31 May 2017 16:51:13 +0100
Message-ID: <1496245873-9011-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com
 [67.231.152.168])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F9A126691F
 for <alsa-devel@alsa-project.org>; Wed, 31 May 2017 17:50:04 +0200 (CEST)
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
Cc: patches@opensource.cirrus.com, brian.austin@cirrus.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, Paul.Handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org

Very fast systems may violate the minimum constraints for time the reset
line needs to remain low, or communicate with the device too soon after
releasing the reset. Fix this by adding some delays in to allow the chip
to properly reset, also factor out the reset into a function as it is
likely it will be re-used in later additions to the driver.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/cs35l35.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l35.c b/sound/soc/codecs/cs35l35.c
index 375be49..f1ee184 100644
--- a/sound/soc/codecs/cs35l35.c
+++ b/sound/soc/codecs/cs35l35.c
@@ -162,6 +162,14 @@ static bool cs35l35_precious_register(struct device *dev, unsigned int reg)
 	}
 }
 
+static void cs35l35_reset(struct cs35l35_private *cs35l35)
+{
+	gpiod_set_value_cansleep(cs35l35->reset_gpio, 0);
+	usleep_range(2000, 2100);
+	gpiod_set_value_cansleep(cs35l35->reset_gpio, 1);
+	usleep_range(1000, 1100);
+}
+
 static int cs35l35_wait_for_pdn(struct cs35l35_private *cs35l35)
 {
 	int ret;
@@ -1536,7 +1544,7 @@ static int cs35l35_i2c_probe(struct i2c_client *i2c_client,
 		}
 	}
 
-	gpiod_set_value_cansleep(cs35l35->reset_gpio, 1);
+	cs35l35_reset(cs35l35);
 
 	init_completion(&cs35l35->pdn_done);
 
-- 
2.1.4
