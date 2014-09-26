From: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Subject: [PATCH] ASoC: Intel: byt-max98090: Set card as fully
	routed
Date: Fri, 26 Sep 2014 11:17:15 +0300
Message-ID: <1411719435-15317-1-git-send-email-jarkko.nikula@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 6107A260472
 for <alsa-devel@alsa-project.org>; Fri, 26 Sep 2014 10:17:22 +0200 (CEST)
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

All byt-max98090 audio connections are known and described in DAPM routing
table. Set the fully_routed flag in order to disable unused codec pins.

Signed-off-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
---
 sound/soc/intel/byt-max98090.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/intel/byt-max98090.c b/sound/soc/intel/byt-max98090.c
index b8b8af571ef1..d52681e7225e 100644
--- a/sound/soc/intel/byt-max98090.c
+++ b/sound/soc/intel/byt-max98090.c
@@ -139,6 +139,7 @@ static struct snd_soc_card byt_max98090_card = {
 	.num_dapm_routes = ARRAY_SIZE(byt_max98090_audio_map),
 	.controls = byt_max98090_controls,
 	.num_controls = ARRAY_SIZE(byt_max98090_controls),
+	.fully_routed = true,
 };
 
 static int byt_max98090_probe(struct platform_device *pdev)
-- 
2.1.0
