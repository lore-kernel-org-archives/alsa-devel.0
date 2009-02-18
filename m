From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: [PATCH 03/11] ASoC: Remove version display from the
	WM8731 driver
Date: Wed, 18 Feb 2009 12:02:25 +0000
Message-ID: <1234958553-16049-3-git-send-email-broonie@opensource.wolfsonmicro.com>
References: <20090218120135.GA15414@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by alsa0.perex.cz (Postfix) with ESMTP id 23C4D10388D
	for <alsa-devel@alsa-project.org>; Wed, 18 Feb 2009 13:02:41 +0100 (CET)
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

It makes boot a bit more noisy and I never remember to update it.

Signed-off-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/wm8731.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8731.c b/sound/soc/codecs/wm8731.c
index 0150fe5..816e5bf 100644
--- a/sound/soc/codecs/wm8731.c
+++ b/sound/soc/codecs/wm8731.c
@@ -29,8 +29,6 @@
 
 #include "wm8731.h"
 
-#define WM8731_VERSION "0.13"
-
 struct snd_soc_codec_device soc_codec_dev_wm8731;
 
 /* codec private data */
@@ -702,8 +700,6 @@ static int wm8731_probe(struct platform_device *pdev)
 	struct wm8731_priv *wm8731;
 	int ret = 0;
 
-	pr_info("WM8731 Audio Codec %s", WM8731_VERSION);
-
 	setup = socdev->codec_data;
 	codec = kzalloc(sizeof(struct snd_soc_codec), GFP_KERNEL);
 	if (codec == NULL)
-- 
1.5.6.3
