From: Joe Perches <joe@perches.com>
Subject: [PATCH] sound: use bitmap_weight
Date: Fri, 16 Nov 2012 23:35:16 -0800
Message-ID: <1353137716.12430.3.camel@joe-AO722>
References: <1353134389-25583-1-git-send-email-akinobu.mita@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from labridge.com (perches-mx.perches.com [206.117.179.246])
 by alsa0.perex.cz (Postfix) with ESMTP id E0147264F09
 for <alsa-devel@alsa-project.org>; Sat, 17 Nov 2012 08:35:18 +0100 (CET)
In-Reply-To: <1353134389-25583-1-git-send-email-akinobu.mita@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Akinobu Mita <akinobu.mita@gmail.com>, LKML <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

Use bitmap_weight to count the total number of bits set in bitmap.

Signed-off-by: Joe Perches <joe@perches.com>
---
 sound/usb/endpoint.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/sound/usb/endpoint.c b/sound/usb/endpoint.c
index 34de6f2..51a9aa3 100644
--- a/sound/usb/endpoint.c
+++ b/sound/usb/endpoint.c
@@ -485,15 +485,10 @@ __exit_unlock:
 static int wait_clear_urbs(struct snd_usb_endpoint *ep)
 {
 	unsigned long end_time = jiffies + msecs_to_jiffies(1000);
-	unsigned int i;
 	int alive;
 
 	do {
-		alive = 0;
-		for (i = 0; i < ep->nurbs; i++)
-			if (test_bit(i, &ep->active_mask))
-				alive++;
-
+		alive = bitmap_weight(&ep->active_mask, ep->nurbs);
 		if (!alive)
 			break;
 
