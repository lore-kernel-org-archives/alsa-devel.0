From: "huang.zijiang" <huang.zijiang@zte.com.cn>
Subject: [PATCH] sound:emu10k1:Use kmemdup instead of duplicating its function
Date: Mon, 24 Dec 2018 16:42:48 +0800
Message-ID: <1545640968-42357-1-git-send-email-huang.zijiang@zte.com.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz
Cc: tiwai@suse.com, keescook@chromium.org, colin.king@canonical.com, w@1wt.eu, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, xue.zhihong@zte.com.cn, wang.yi59@zte.com.cn, "huang.zijiang" <huang.zijiang@zte.com.cn>
List-Id: alsa-devel@alsa-project.org

From: "huang.zijiang" <huang.zijiang@zte.com.cn>

kmemdup has implemented the function that kmalloc() and memcpy().

Signed-off-by: huang.zijiang <huang.zijiang@zte.com.cn>
---
 sound/pci/emu10k1/emufx.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/pci/emu10k1/emufx.c b/sound/pci/emu10k1/emufx.c
index 6ebe817..b4fe4c5 100644
--- a/sound/pci/emu10k1/emufx.c
+++ b/sound/pci/emu10k1/emufx.c
@@ -671,10 +671,9 @@ static unsigned int *copy_tlv(const unsigned int __user *_tlv, bool in_kernel)
 		return NULL;
 	if (data[1] >= MAX_TLV_SIZE)
 		return NULL;
-	tlv = kmalloc(data[1] + sizeof(data), GFP_KERNEL);
+	tlv =  kmemdup(data, data[1] + sizeof(data), GFP_KERNEL);
 	if (!tlv)
 		return NULL;
-	memcpy(tlv, data, sizeof(data));
 	if (in_kernel) {
 		memcpy(tlv + 2, (__force void *)(_tlv + 2),  data[1]);
 	} else if (copy_from_user(tlv + 2, _tlv + 2, data[1])) {
-- 
1.8.3.1
