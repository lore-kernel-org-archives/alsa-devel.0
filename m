From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 3/4] ASoC: Remove core version number
Date: Wed,  5 Nov 2008 18:53:30 +0000
Message-ID: <1225911211-22474-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20081105185220.GA10816@rakim.wolfsonmicro.main>
	<1225911211-22474-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<1225911211-22474-2-git-send-email-broonie@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 2D70C2414F
	for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2008 19:53:33 +0100 (CET)
In-Reply-To: <1225911211-22474-2-git-send-email-broonie@opensource.wolfsonmicro.com>
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

Rather than try to remember to keep the core version number updated
(which hasn't been happening) just remove it.  It was much more useful
when ASoC was out of tree.

Signed-off-by: Mark brown <broonie@opensource.wolfsonmicro.com>
---
 include/sound/soc.h  |    2 --
 sound/soc/soc-core.c |    1 -
 2 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index da0040b..fa1b99b 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -21,8 +21,6 @@
 #include <sound/control.h>
 #include <sound/ac97_codec.h>
 
-#define SND_SOC_VERSION "0.13.2"
-
 /*
  * Convenience kcontrol builders
  */
diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 1a17368..9feaa7b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1965,7 +1965,6 @@ EXPORT_SYMBOL_GPL(snd_soc_dai_digital_mute);
 
 static int __devinit snd_soc_init(void)
 {
-	printk(KERN_INFO "ASoC version %s\n", SND_SOC_VERSION);
 	return platform_driver_register(&soc_driver);
 }
 
-- 
1.5.6.5
