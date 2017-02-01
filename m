From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/2] ASoC: rt5645: fix error handling for gpio
	detection
Date: Wed,  1 Feb 2017 12:27:04 -0600
Message-ID: <1485973625-20553-2-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1485973625-20553-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 140BB2674E1
 for <alsa-devel@alsa-project.org>; Wed,  1 Feb 2017 19:27:20 +0100 (CET)
In-Reply-To: <1485973625-20553-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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
Cc: tiwai@suse.de, broonie@kernel.org, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

Optional gpio handling should not cause an error status and prevent
probing if it's missing.  Remove error return for -ENOENT case and
move error message to dev_info

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt5645.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 65ac841..e149f3c 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3660,8 +3660,14 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 						       GPIOD_IN);
 
 	if (IS_ERR(rt5645->gpiod_hp_det)) {
-		dev_err(&i2c->dev, "failed to initialize gpiod\n");
-		return PTR_ERR(rt5645->gpiod_hp_det);
+		dev_info(&i2c->dev, "failed to initialize gpiod\n");
+		ret = PTR_ERR(rt5645->gpiod_hp_det);
+		/*
+		 * Continue if optional gpiod is missing, bail for all other
+		 * errors, including -EPROBE_DEFER
+		 */
+		if (ret != -ENOENT)
+			return ret;
 	}
 
 	for (i = 0; i < ARRAY_SIZE(rt5645->supplies); i++)
-- 
2.7.4
