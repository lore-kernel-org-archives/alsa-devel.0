From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 2/3] ASoC: Display WM8903 chip revision
	alphabetically
Date: Wed,  9 Feb 2011 13:47:07 +0000
Message-ID: <1297259228-1891-2-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <1297259228-1891-1-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 1C4E81038EA
	for <alsa-devel@alsa-project.org>; Wed,  9 Feb 2011 14:47:15 +0100 (CET)
In-Reply-To: <1297259228-1891-1-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@slimlogic.co.uk>
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, swarren@nvidia.com, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8903.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 04c3256..caf41ad 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -1983,8 +1983,8 @@ static int wm8903_probe(struct snd_soc_codec *codec)
 	}
 
 	val = snd_soc_read(codec, WM8903_REVISION_NUMBER);
-	dev_info(codec->dev, "WM8903 revision %d\n",
-		 val & WM8903_CHIP_REV_MASK);
+	dev_info(codec->dev, "WM8903 revision %c\n",
+		 (val & WM8903_CHIP_REV_MASK) + 'A');
 
 	wm8903_reset(codec);
 
-- 
1.7.2.3
