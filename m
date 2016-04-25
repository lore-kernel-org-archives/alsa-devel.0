From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: [PATCH] ASoC: cs42l56: Use IS_ENABLED() instead of checking for built-in or module
Date: Mon, 25 Apr 2016 19:30:39 -0400
Message-ID: <1461627039-28547-1-git-send-email-javier@osg.samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Brian Austin <brian.austin@cirrus.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The IS_ENABLED() macro checks if a Kconfig symbol has been enabled either
built-in or as a module, use that macro instead of open coding the same.

Signed-off-by: Javier Martinez Canillas <javier@osg.samsung.com>

---

 sound/soc/codecs/cs42l56.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs42l56.c b/sound/soc/codecs/cs42l56.c
index 7cd5f769bb61..eec1ff853b98 100644
--- a/sound/soc/codecs/cs42l56.c
+++ b/sound/soc/codecs/cs42l56.c
@@ -56,7 +56,7 @@ struct  cs42l56_private {
 	u8 iface;
 	u8 iface_fmt;
 	u8 iface_inv;
-#if defined(CONFIG_INPUT) || defined(CONFIG_INPUT_MODULE)
+#if IS_ENABLED(CONFIG_INPUT)
 	struct input_dev *beep;
 	struct work_struct beep_work;
 	int beep_rate;
-- 
2.5.5
