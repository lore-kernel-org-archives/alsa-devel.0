From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ASoC: pcm: Fix vague codec and cpu DAI prepare
	error messages
Date: Tue, 23 Dec 2014 11:04:41 +0200
Message-ID: <1419325481-32094-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 0E2AC2605BF
 for <alsa-devel@alsa-project.org>; Tue, 23 Dec 2014 10:04:50 +0100 (CET)
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
Cc: Mark Brown <broonie@kernel.org>, Jarkko Nikula <jarkko.nikula@linux.intel.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Both codec and cpu DAI prepare print the same error message making it a bit
more difficult to grep quickly from sources. Fix this by telling it
explicitly.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/soc-pcm.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/soc-pcm.c b/sound/soc/soc-pcm.c
index eb87d96e2cf0..0ae0e2a9eed7 100644
--- a/sound/soc/soc-pcm.c
+++ b/sound/soc/soc-pcm.c
@@ -746,7 +746,8 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 							      codec_dai);
 			if (ret < 0) {
 				dev_err(codec_dai->dev,
-					"ASoC: DAI prepare error: %d\n", ret);
+					"ASoC: codec DAI prepare error: %d\n",
+					ret);
 				goto out;
 			}
 		}
@@ -755,8 +756,8 @@ static int soc_pcm_prepare(struct snd_pcm_substream *substream)
 	if (cpu_dai->driver->ops && cpu_dai->driver->ops->prepare) {
 		ret = cpu_dai->driver->ops->prepare(substream, cpu_dai);
 		if (ret < 0) {
-			dev_err(cpu_dai->dev, "ASoC: DAI prepare error: %d\n",
-				ret);
+			dev_err(cpu_dai->dev,
+				"ASoC: cpu DAI prepare error: %d\n", ret);
 			goto out;
 		}
 	}
-- 
2.1.3
