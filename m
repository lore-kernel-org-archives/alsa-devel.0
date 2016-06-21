From: fgao@ikuai8.com
Subject: [PATCH 1/1] sound: Fix one compile error of seq_device.c
Date: Tue, 21 Jun 2016 17:32:26 +0800
Message-ID: <1466501546-30094-1-git-send-email-fgao@ikuai8.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: gfree.wind@gmail.com, Gao Feng <fgao@ikuai8.com>
List-Id: alsa-devel@alsa-project.org

From: Gao Feng <fgao@ikuai8.com>

The gcc reports the following compile error on CentOS7.
include/linux/init.h:216:2: error: expected ',' or ';' before 'static'
  static exitcall_t __exitcall_##fn __exit_call = fn
  ^
include/linux/init.h:279:24: note: in expansion of macro '__exitcall'
 #define module_exit(x) __exitcall(x);
                        ^
sound/core/seq/seq_device.c:315:1: note: in expansion of macro 'module_exit'
 module_exit(alsa_seq_device_exit)
 ^
make[3]: *** [sound/core/seq/seq_device.o] Error 1
make[2]: *** [sound/core/seq] Error 2
make[1]: *** [sound/core] Error 2
make: *** [sound] Error 2

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
