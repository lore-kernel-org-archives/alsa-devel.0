From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH] ASoC: Squash error codes from regmap down to
	-1 on read
Date: Sun,  9 Oct 2011 14:06:38 +0100
Message-ID: <1318165598-10996-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2B7D42459B
	for <alsa-devel@alsa-project.org>;
	Sun,  9 Oct 2011 15:06:42 +0200 (CEST)
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

The ASoC code always uses -1 as the error code due to reporting errors in
band with the value. Ensure we don't confuse anything by making sure we
don't pass actual error codes back into the rest of the code on read.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/soc-io.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/soc-io.c b/sound/soc/soc-io.c
index d6535b8..c8610cb 100644
--- a/sound/soc/soc-io.c
+++ b/sound/soc/soc-io.c
@@ -56,7 +56,7 @@ static unsigned int hw_read(struct snd_soc_codec *codec, unsigned int reg)
 		if (ret == 0)
 			return val;
 		else
-			return ret;
+			return -1;
 	}
 
 	ret = snd_soc_cache_read(codec, reg, &val);
-- 
1.7.6.3
