From: Yaowei Bai <bywxiaobai@163.com>
Subject: [PATCH 1/4] sound/onyx: remove redundant case entry
Date: Mon, 21 Sep 2015 21:57:11 +0800
Message-ID: <1442843834-4648-1-git-send-email-bywxiaobai@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, johannes@sipsolutions.net, k.kozlowski@samsung.com, elfring@users.sourceforge.net, fabf@skynet.be, lars@metafoo.de
Cc: linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Case ti->tag == 0 can be included in the last return,
remove it.

No functional change.

Signed-off-by: Yaowei Bai <bywxiaobai@163.com>
---
 sound/aoa/codecs/onyx.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/aoa/codecs/onyx.c b/sound/aoa/codecs/onyx.c
index a04edff..a407e1f 100644
--- a/sound/aoa/codecs/onyx.c
+++ b/sound/aoa/codecs/onyx.c
@@ -683,7 +683,6 @@ static int onyx_usable(struct codec_info_item *cii,
 	mutex_unlock(&onyx->mutex);
 
 	switch (ti->tag) {
-	case 0: return 1;
 	case 1:	return analog_enabled;
 	case 2: return spdif_enabled;
 	}
-- 
1.9.1
