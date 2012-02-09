From: Masanari Iida <standby24x7@gmail.com>
Subject: [PATCH RESEND] [trivial] ASoC: Fix typo in twl4030.c
Date: Thu,  9 Feb 2012 23:46:08 +0900
Message-ID: <1328798768-2058-1-git-send-email-standby24x7@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lrg@ti.com, broonie@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org
Cc: trivial@kernel.org, linux-kernel@vger.kernel.org, standby24x7@gmail.com, tiwai@suse.de
List-Id: alsa-devel@alsa-project.org

Correct spelling "memroy" to "memory" in
sound/soc/codecs/twl4030.c

Signed-off-by: Masanari Iida <standby24x7@gmail.com>
---
 sound/soc/codecs/twl4030.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/twl4030.c b/sound/soc/codecs/twl4030.c
index 3039ba2..d7eee0d 100644
--- a/sound/soc/codecs/twl4030.c
+++ b/sound/soc/codecs/twl4030.c
@@ -2221,7 +2221,7 @@ static int twl4030_soc_probe(struct snd_soc_codec *codec)
 
 	twl4030 = kzalloc(sizeof(struct twl4030_priv), GFP_KERNEL);
 	if (twl4030 == NULL) {
-		printk("Can not allocate memroy\n");
+		printk("Can not allocate memory\n");
 		return -ENOMEM;
 	}
 	snd_soc_codec_set_drvdata(codec, twl4030);
-- 
1.7.6.5
