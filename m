From: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Subject: [PATCH] ASOC: wm8753: Remove unneeded header file
Date: Fri, 24 Jun 2016 11:51:36 +0530
Message-ID: <20160624062135.GA23457@amitoj-Inspiron-3542>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, patches@opensource.wolfsonmicro.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: julia.lawall@lip6.fr
List-Id: alsa-devel@alsa-project.org

Drop redundant include of moduleparam.h

The Coccinelle semantic patch used to make this change is as follows:
@ includesmodule @
@@

#include <linux/module.h>

@ depends on includesmodule @
@@

- #include <linux/moduleparam.h>

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 sound/soc/codecs/wm8753.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index 6f1024f..b4e6893 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -32,7 +32,6 @@
  */
 
 #include <linux/module.h>
-#include <linux/moduleparam.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
-- 
1.9.1
