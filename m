From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 7/7] ASoC: Don't free static data in WM9713
Date: Mon,  1 Dec 2008 20:07:41 +0000
Message-ID: <1228162061-14769-7-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081201200703.GA14376@rakim.wolfsonmicro.main>
	<1228162061-14769-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228162061-14769-2-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228162061-14769-3-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228162061-14769-4-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228162061-14769-5-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1228162061-14769-6-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 78F941037F2
	for <alsa-devel@alsa-project.org>; Mon,  1 Dec 2008 21:07:43 +0100 (CET)
In-Reply-To: <1228162061-14769-6-git-send-email-broonie@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm9713.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/wm9713.c b/sound/soc/codecs/wm9713.c
index 49962a8..f3ca8aa 100644
--- a/sound/soc/codecs/wm9713.c
+++ b/sound/soc/codecs/wm9713.c
@@ -1283,7 +1283,6 @@ static int wm9713_soc_remove(struct platform_device *pdev)
 	snd_soc_free_ac97_codec(codec);
 	kfree(codec->private_data);
 	kfree(codec->reg_cache);
-	kfree(codec->dai);
 	kfree(codec);
 	return 0;
 }
-- 
1.5.6.5
