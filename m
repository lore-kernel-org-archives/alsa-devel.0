From: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Subject: [PATCH] sound: aedsp16: Change structure initialisation to C99 style
Date: Wed, 15 Jun 2016 09:23:23 +0530
Message-ID: <20160615035323.GA5339@amitoj-Inspiron-3542>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: fizban@tin.it, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: julia.lawall@lip6.fr, michael.leibowitz@intel.com, keescook@chromium.org
List-Id: alsa-devel@alsa-project.org

Replace the in order struct initialisation style with explicit field
style.

The Coccinelle semantic patch used to make this change is as follows:

@decl@
identifier i1,fld;
type T;
field list[n] fs;
@@

struct i1 {
 fs
 T fld;
 ...};

@@
identifier decl.i1,i2,decl.fld;
expression e;
position bad.p, bad.fix;
@@

struct i1 i2@p = { ...,
+ .fld = e
- e@fix
 ,...};

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 sound/oss/aedsp16.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/sound/oss/aedsp16.c b/sound/oss/aedsp16.c
index 35b5912..bb477d5 100644
--- a/sound/oss/aedsp16.c
+++ b/sound/oss/aedsp16.c
@@ -482,13 +482,13 @@ static struct orVals orDMA[] __initdata = {
 };
 
 static struct aedsp16_info ae_config = {
-	DEF_AEDSP16_IOB,
-	DEF_AEDSP16_IRQ,
-	DEF_AEDSP16_MRQ,
-	DEF_AEDSP16_DMA,
-	-1,
-	-1,
-	INIT_NONE
+	.base_io = DEF_AEDSP16_IOB,
+	.irq = DEF_AEDSP16_IRQ,
+	.mpu_irq = DEF_AEDSP16_MRQ,
+	.dma = DEF_AEDSP16_DMA,
+	.mss_base = -1,
+	.mpu_base = -1,
+	.init = INIT_NONE
 };
 
 /*
-- 
1.9.1
