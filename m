From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 4/6] ALSA: timer: Use common error handling
 code in alsa_timer_init()
Date: Wed, 23 Aug 2017 10:27:14 +0200
Message-ID: <f390776b-343f-3787-8520-0754ddfe8154@users.sourceforge.net>
References: <b8c9e41b-a47e-1d99-3d1a-5d39772e4b54@users.sourceforge.net>
 <s5h378isw2d.wl-tiwai@suse.de>
 <800d7aa6-d8f2-cbf5-caaa-7e4006976e68@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 0614F2665D5
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 10:27:21 +0200 (CEST)
In-Reply-To: <800d7aa6-d8f2-cbf5-caaa-7e4006976e68@users.sourceforge.net>
Content-Language: en-GB
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Arvind Yadav <arvind.yadav.cs@gmail.com>, Dan Carpenter <dan.carpenter@oracle.com>, Ingo Molnar <mingo@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.de>, Takashi Sakamoto <o-takashi@sakamocchi.jp>, Vegard Nossum <vegard.nossum@oracle.com>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 23 Aug 2017 09:30:41 +0200

Add a jump target so that a bit of exception handling can be better reused
at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/core/timer.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index a9b9a277e00c..6d73a63f6e2b 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -2096,8 +2096,7 @@ static int __init alsa_timer_init(void)
 	err = snd_timer_register_system();
 	if (err < 0) {
 		pr_err("ALSA: unable to register system timer (%i)\n", err);
-		put_device(&timer_dev);
-		return err;
+		goto put_timer;
 	}
 
 	err = snd_register_device(SNDRV_DEVICE_TYPE_TIMER, NULL, 0,
@@ -2105,12 +2104,15 @@ static int __init alsa_timer_init(void)
 	if (err < 0) {
 		pr_err("ALSA: unable to register timer device (%i)\n", err);
 		snd_timer_free_all();
-		put_device(&timer_dev);
-		return err;
+		goto put_timer;
 	}
 
 	snd_timer_proc_init();
 	return 0;
+
+put_timer:
+	put_device(&timer_dev);
+	return err;
 }
 
 static void __exit alsa_timer_exit(void)
-- 
2.14.0
