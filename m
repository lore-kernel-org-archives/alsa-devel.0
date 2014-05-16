From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH 4/7] ASoC: max98090: Mark cache as dirty prior
	to restoring
Date: Fri, 16 May 2014 16:55:22 +0300
Message-ID: <1400248525-21900-5-git-send-email-jarkko.nikula@linux.intel.com>
References: <1400248525-21900-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 5ACAE261691
 for <alsa-devel@alsa-project.org>; Fri, 16 May 2014 15:55:47 +0200 (CEST)
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

Make sure the cache is fully flushed at resume time.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/codecs/max98090.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index b3f447cc050c..8c88b4448f7e 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2398,6 +2398,8 @@ static int max98090_resume(struct device *dev)
 	struct max98090_priv *max98090 = dev_get_drvdata(dev);
 	unsigned int status;
 
+	regcache_mark_dirty(max98090->regmap);
+
 	max98090_reset(max98090);
 
 	/* clear IRQ status */
-- 
2.0.0.rc0
