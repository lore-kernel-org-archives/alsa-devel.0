From: Amitoj Kaur Chawla <amitoj1606@gmail.com>
Subject: [PATCH v2] sound: oss: Remove useless initialisation
Date: Tue, 12 Jul 2016 08:54:35 +0530
Message-ID: <20160712032435.GA26771@amitoj-Inspiron-3542>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: julia.lawall@lip6.fr
List-Id: alsa-devel@alsa-project.org

Remove useless initialisation of variable whose value is reinitialised
later.

The Coccinelle semantic patch used to make this change is as follows:
@@
type T;
identifier x;
constant C;
expression e;
@@

T x
- = C
 ;
x = e;

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
Changes in v2:
        -Modify commit message
 sound/oss/ad1848.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/oss/ad1848.c b/sound/oss/ad1848.c
index 10c8de1..6368e5c 100644
--- a/sound/oss/ad1848.c
+++ b/sound/oss/ad1848.c
@@ -254,7 +254,7 @@ static void ad_write(ad1848_info * devc, int reg, int data)
 
 static void wait_for_calibration(ad1848_info * devc)
 {
-	int timeout = 0;
+	int timeout;
 
 	/*
 	 * Wait until the auto calibration process has finished.
-- 
1.9.1
