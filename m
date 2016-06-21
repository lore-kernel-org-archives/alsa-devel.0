From: fgao@ikuai8.com
Subject: [PATCH 1/1] sound: Fix compile error of seq_device.c
Date: Tue, 21 Jun 2016 16:34:25 +0800
Message-ID: <1466498065-29692-1-git-send-email-fgao@ikuai8.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: gfree.wind@gmail.com, Gao Feng <fgao@ikuai8.com>
List-Id: alsa-devel@alsa-project.org

From: Gao Feng <fgao@ikuai8.com>

Signed-off-by: Gao Feng <fgao@ikuai8.com>
---
 sound/core/seq/seq_device.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/core/seq/seq_device.c b/sound/core/seq/seq_device.c
index c4acf17..4e859e4 100644
--- a/sound/core/seq/seq_device.c
+++ b/sound/core/seq/seq_device.c
@@ -311,5 +311,5 @@ static void __exit alsa_seq_device_exit(void)
 	bus_unregister(&snd_seq_bus_type);
 }
 
-subsys_initcall(alsa_seq_device_init)
-module_exit(alsa_seq_device_exit)
+subsys_initcall(alsa_seq_device_init);
+module_exit(alsa_seq_device_exit);
-- 
1.9.1
