From: Yaowei Bai <bywxiaobai@163.com>
Subject: [PATCH 2/4] sound/i2sbus/core: make format more appropriate
Date: Mon, 21 Sep 2015 21:57:12 +0800
Message-ID: <1442843834-4648-2-git-send-email-bywxiaobai@163.com>
References: <1442843834-4648-1-git-send-email-bywxiaobai@163.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1442843834-4648-1-git-send-email-bywxiaobai@163.com>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, johannes@sipsolutions.net, k.kozlowski@samsung.com, elfring@users.sourceforge.net, fabf@skynet.be, lars@metafoo.de
Cc: linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Make 'return' stay in a singe line.

No functional change.

Signed-off-by: Yaowei Bai <bywxiaobai@163.com>
---
 sound/aoa/soundbus/i2sbus/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/aoa/soundbus/i2sbus/core.c b/sound/aoa/soundbus/i2sbus/core.c
index 1cbf210..6f216c0 100644
--- a/sound/aoa/soundbus/i2sbus/core.c
+++ b/sound/aoa/soundbus/i2sbus/core.c
@@ -62,7 +62,8 @@ static int alloc_dbdma_descriptor_ring(struct i2sbus_dev *i2sdev,
 static void free_dbdma_descriptor_ring(struct i2sbus_dev *i2sdev,
 				       struct dbdma_command_mem *r)
 {
-	if (!r->space) return;
+	if (!r->space)
+		return;
 
 	dma_free_coherent(&macio_get_pci_dev(i2sdev->macio)->dev,
 			    r->size, r->space, r->bus_addr);
-- 
1.9.1
