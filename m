From: Greg Dietsche <Gregory.Dietsche@cuw.edu>
Subject: [PATCH] wm8940: remove unecessary if statement
Date: Sun,  5 Jun 2011 19:47:54 -0500
Message-ID: <1307321274-21858-1-git-send-email-Gregory.Dietsche@cuw.edu>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.de
Cc: broonie@opensource.wolfsonmicro.com, dp@opensource.wolfsonmicro.com, lrg@ti.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Greg Dietsche <Gregory.Dietsche@cuw.edu>
List-Id: alsa-devel@alsa-project.org

the code always returns ret regardless, so if(ret) check is unecessary.

Signed-off-by: Greg Dietsche <Gregory.Dietsche@cuw.edu>
---
 sound/soc/codecs/wm8940.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8940.c b/sound/soc/codecs/wm8940.c
index 25580e3..1ada6d3 100644
--- a/sound/soc/codecs/wm8940.c
+++ b/sound/soc/codecs/wm8940.c
@@ -730,9 +730,6 @@ static int wm8940_probe(struct snd_soc_codec *codec)
 	if (ret)
 		return ret;
 	ret = wm8940_add_widgets(codec);
-	if (ret)
-		return ret;
-
 	return ret;
 }
 
-- 
1.7.2.5
