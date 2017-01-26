From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 14/17] ASoC: rt5645: fix error handling for
	gpio detection
Date: Thu, 26 Jan 2017 14:09:42 -0600
Message-ID: <1485461385-14544-15-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1485461385-14544-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 0BFE526779E
 for <alsa-devel@alsa-project.org>; Thu, 26 Jan 2017 21:10:28 +0100 (CET)
In-Reply-To: <1485461385-14544-1-git-send-email-pierre-louis.bossart@linux.intel.com>
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

Optional gpio handling should not cause an error status
and prevent probing.
Remove error return and move error message to dev_info

Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/codecs/rt5645.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 65ac841..f216f9f 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3660,8 +3660,7 @@ static int rt5645_i2c_probe(struct i2c_client *i2c,
 						       GPIOD_IN);
 
 	if (IS_ERR(rt5645->gpiod_hp_det)) {
-		dev_err(&i2c->dev, "failed to initialize gpiod\n");
-		return PTR_ERR(rt5645->gpiod_hp_det);
+		dev_info(&i2c->dev, "failed to initialize gpiod\n");
 	}
 
 	for (i = 0; i < ARRAY_SIZE(rt5645->supplies); i++)
-- 
2.7.4
