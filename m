From: jianqun <xjq@rock-chips.com>
Subject: [PATCH] ASoC: max98090 not need to return fail if fail to request hpdet irq.
Date: Wed, 30 Jul 2014 09:50:10 +0800
Message-ID: <1406685010-25108-1-git-send-email-xjq@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org, lgirdwood@gmail.com, perex@perex.cz, tiwai@suse.de, tbleung@chromium.org, dgreid@chromium.org, kevin.strasser@intel.com, jarkko.nikula@linux.intel.com, swarren@nvidia.com, ralph.birt@maximintegrated.com
Cc: heiko@sntech.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, xujianqun <xjq@rock-chips.com>
List-Id: alsa-devel@alsa-project.org

From: xujianqun <xjq@rock-chips.com>

Since hardware may not MUST to use IRQ pin of max98090 as jack detect, the
driver can work well without it, can report jack trigger to CPU by a GPIO.

But here driver will register fail caused by failed to request irq.

Signed-off-by: xujianqun <xjq@rock-chips.com>
---
 sound/soc/codecs/max98090.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/max98090.c b/sound/soc/codecs/max98090.c
index 566919c..bc124ff 100644
--- a/sound/soc/codecs/max98090.c
+++ b/sound/soc/codecs/max98090.c
@@ -2515,6 +2515,8 @@ static int max98090_probe(struct snd_soc_codec *codec)
 
 	max98090_add_widgets(codec);
 
+	return 0;
+
 err_access:
 	return ret;
 }
-- 
1.7.9.5
