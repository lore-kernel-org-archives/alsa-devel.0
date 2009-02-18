From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 11/11] ASoC: Remove version display from the
	WM8753 driver
Date: Wed, 18 Feb 2009 12:02:33 +0000
Message-ID: <1234958553-16049-11-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090218120135.GA15414@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 95EFB1038A2
	for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2009 13:02:45 +0100 (CET)
In-Reply-To: <20090218120135.GA15414@sirena.org.uk>
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
 sound/soc/codecs/wm8753.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index dc6042c..31ff337 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -51,8 +51,6 @@
 
 #include "wm8753.h"
 
-#define WM8753_VERSION "0.16"
-
 static int caps_charge = 2000;
 module_param(caps_charge, int, 0);
 MODULE_PARM_DESC(caps_charge, "WM8753 cap charge time (msecs)");
@@ -1778,8 +1776,6 @@ static int wm8753_probe(struct platform_device *pdev)
 	struct wm8753_priv *wm8753;
 	int ret = 0;
 
-	pr_info("WM8753 Audio Codec %s", WM8753_VERSION);
-
 	setup = socdev->codec_data;
 	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
 	if (codec == NULL)
-- 
1.5.6.3
