From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 1/1] SOUND: wm8753, remove dead code
Date: Sat,  4 Sep 2010 15:12:09 +0200
Message-ID: <1283605929-15961-1-git-send-email-jslaby@suse.cz>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, jirislaby@gmail.com, Liam Girdwood <lg@opensource.wolfsonmicro.com>, Jaroslav Kysela <perex@suse.cz>
List-Id: alsa-devel@alsa-project.org

There is adangling code in wm8753_probe which is never executed.
Remove it.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Liam Girdwood <lg@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Jaroslav Kysela <perex@suse.cz>
---
 sound/soc/codecs/wm8753.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 4844232..4a945d3 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -1600,9 +1600,6 @@ static int wm8753_probe(struct snd_soc_codec *codec)
 	wm8753_add_widgets(codec);
 
 	return 0;
-
-	run_delayed_work(&codec->delayed_work);
-	return ret;
 }
 
 /* power down chip */
-- 
1.7.2.2
