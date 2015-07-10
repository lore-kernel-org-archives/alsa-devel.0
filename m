From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH] ALSA: aoa: Drop owner assignment from i2c_driver
Date: Fri, 10 Jul 2015 15:39:02 +0900
Message-ID: <1436510344-5889-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Johannes Berg <johannes@sipsolutions.net>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, "open list:AOA Apple Onboard Audio ALSA
	DRIVER" <linuxppc-dev@lists.ozlabs.org>, "moderated list:AOA Apple Onboard Audio
	ALSA DRIVER" <alsa-devel@alsa-project.org>, open list <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

i2c_driver does not need to set an owner because i2c_register_driver()
will set it.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>

---

The coccinelle script which generated the patch was sent here:
http://www.spinics.net/lists/kernel/msg2029903.html
---
 sound/aoa/codecs/onyx.c | 1 -
 sound/aoa/codecs/tas.c  | 1 -
 2 files changed, 2 deletions(-)

diff --git a/sound/aoa/codecs/onyx.c b/sound/aoa/codecs/onyx.c
index 23c371ecfb6b..a04edff8b729 100644
--- a/sound/aoa/codecs/onyx.c
+++ b/sound/aoa/codecs/onyx.c
@@ -1050,7 +1050,6 @@ MODULE_DEVICE_TABLE(i2c,onyx_i2c_id);
 static struct i2c_driver onyx_driver = {
 	.driver = {
 		.name = "aoa_codec_onyx",
-		.owner = THIS_MODULE,
 	},
 	.probe = onyx_i2c_probe,
 	.remove = onyx_i2c_remove,
diff --git a/sound/aoa/codecs/tas.c b/sound/aoa/codecs/tas.c
index 364c7c4416e8..78ed1ffbf786 100644
--- a/sound/aoa/codecs/tas.c
+++ b/sound/aoa/codecs/tas.c
@@ -939,7 +939,6 @@ MODULE_DEVICE_TABLE(i2c,tas_i2c_id);
 static struct i2c_driver tas_driver = {
 	.driver = {
 		.name = "aoa_codec_tas",
-		.owner = THIS_MODULE,
 	},
 	.probe = tas_i2c_probe,
 	.remove = tas_i2c_remove,
-- 
1.9.1
