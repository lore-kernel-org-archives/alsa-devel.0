From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Allow register defaults to be larger
	than unsigned short
Date: Wed, 24 Aug 2011 19:13:12 +0100
Message-ID: <1314209592-11433-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id E17AC2413F
	for <alsa-devel@alsa-project.org>;
	Wed, 24 Aug 2011 20:13:22 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Devices that need this exist; obviously the newer regmap defaults
mechanism will deal with this more happily.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 6da55a1..0fc8f15 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -622,7 +622,7 @@ struct snd_soc_codec_driver {
 	int (*volatile_register)(struct snd_soc_codec *, unsigned int);
 	int (*readable_register)(struct snd_soc_codec *, unsigned int);
 	int (*writable_register)(struct snd_soc_codec *, unsigned int);
-	short reg_cache_size;
+	unsigned int reg_cache_size;
 	short reg_cache_step;
 	short reg_word_size;
 	const void *reg_cache_default;
-- 
1.7.5.4
