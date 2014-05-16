From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 2/7] ASoC: max98090: Fix reset at resume time.
Date: Fri, 16 May 2014 16:55:20 +0300
Message-ID: <1400248525-21900-3-git-send-email-jarkko.nikula@linux.intel.com>
References: <1400248525-21900-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 5BB98260864
 for <alsa-devel@alsa-project.org>; Fri, 16 May 2014 15:55:40 +0200 (CEST)
In-Reply-To: <1400248525-21900-1-git-send-email-jarkko.nikula@linux.intel.com>
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
Cc: Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

From: Liam Girdwood <liam.r.girdwood@linux.intel.com>

Reset needs to wait 20ms before other codec IO is performed. This wait
was not being performed. Fix this by making sure the reset register is not
restored with the cache, but use the manual reset method in resume with
the wait.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/codecs/max98090.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 9e08c4768bc0..4accf9ba447e 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -256,6 +256,7 @@ static struct reg_default max98090_reg[] = {
 static bool max98090_volatile_register(struct device *dev, unsigned int reg)
 {
 	switch (reg) {
+	case M98090_REG_SOFTWARE_RESET:
 	case M98090_REG_DEVICE_STATUS:
 	case M98090_REG_JACK_STATUS:
 	case M98090_REG_REVISION_ID:
@@ -2374,6 +2375,8 @@ static int max98090_runtime_resume(struct device *dev)
 
 	regcache_cache_only(max98090->regmap, false);
 
+	max98090_reset(max98090);
+
 	regcache_sync(max98090->regmap);
 
 	return 0;
-- 
2.0.0.rc0
