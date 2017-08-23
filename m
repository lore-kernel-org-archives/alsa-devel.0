From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 5/6] ALSA: timer: Adjust a condition check in
 snd_timer_resolution()
Date: Wed, 23 Aug 2017 10:28:41 +0200
Message-ID: <4d1a6d05-6574-b1f4-80ee-59cb5238a74e@users.sourceforge.net>
References: <b8c9e41b-a47e-1d99-3d1a-5d39772e4b54@users.sourceforge.net>
 <s5h378isw2d.wl-tiwai@suse.de>
 <800d7aa6-d8f2-cbf5-caaa-7e4006976e68@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by alsa0.perex.cz (Postfix) with ESMTP id 281462665D5
 for <alsa-devel@alsa-project.org>; Wed, 23 Aug 2017 10:28:48 +0200 (CEST)
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
Date: Wed, 23 Aug 2017 09:45:06 +0200

The script "checkpatch.pl" pointed information out like the following.

ERROR: do not use assignment in if condition

Thus fix the affected source code place.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 sound/core/timer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/core/timer.c b/sound/core/timer.c
index 6d73a63f6e2b..6cdd04a45962 100644
--- a/sound/core/timer.c
+++ b/sound/core/timer.c
@@ -395,5 +395,6 @@ unsigned long snd_timer_resolution(struct snd_timer_instance *timeri)
 		return 0;
-	if ((timer = timeri->timer) != NULL) {
+	timer = timeri->timer;
+	if (timer) {
 		if (timer->hw.c_resolution)
 			return timer->hw.c_resolution(timer);
 		return timer->hw.resolution;
-- 
2.14.0
