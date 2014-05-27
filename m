From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ASoC: jack: Fix multiple definition of
	`snd_soc_jack_add_gpiods'
Date: Tue, 27 May 2014 10:39:57 +0300
Message-ID: <1401176397-17591-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 18A35265553
 for <alsa-devel@alsa-project.org>; Tue, 27 May 2014 09:40:52 +0200 (CEST)
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
Cc: kbuild test robot <fengguang.wu@intel.com>, Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Commit f025d3b9c64e ("ASoC: jack: Add support for GPIO descriptor defined
jack pins") caused build error when CONFIG_GPIOLIB is not set:

sound/include/sound/soc.h:470: multiple definition of `snd_soc_jack_add_gpiods'
sound/soc/soc-core.o:sound/include/sound/soc.h:470: first defined here
make[2]: *** [sound/soc/snd-soc-core.o] Error 1
make[2]: *** Waiting for unfinished jobs....
make[1]: *** [sound/soc] Error 2
make: *** [sound] Error 2

Fix this by marking snd_soc_jack_add_gpiods() as static inline in soc.h.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 include/sound/soc.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 98dca42487bc..15ee2f71b92e 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -464,9 +464,10 @@ static inline int snd_soc_jack_add_gpios(struct snd_soc_jack *jack, int count,
 	return 0;
 }
 
-int snd_soc_jack_add_gpiods(struct device *gpiod_dev,
-			    struct snd_soc_jack *jack,
-			    int count, struct snd_soc_jack_gpio *gpios)
+static inline int snd_soc_jack_add_gpiods(struct device *gpiod_dev,
+					  struct snd_soc_jack *jack,
+					  int count,
+					  struct snd_soc_jack_gpio *gpios)
 {
 	return 0;
 }
-- 
2.0.0.rc2
