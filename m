From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] staging: &&/|| typo
Date: Sun, 15 Feb 2009 20:51:19 +0100
Message-ID: <49987237.7040604@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f19.google.com (mail-ew0-f19.google.com
	[209.85.219.19]) by alsa0.perex.cz (Postfix) with ESMTP id EBAE3243CD
	for <alsa-devel@alsa-project.org>; Sun, 15 Feb 2009 20:51:19 +0100 (CET)
Received: by ewy12 with SMTP id 12so1851327ewy.8
	for <alsa-devel@alsa-project.org>; Sun, 15 Feb 2009 11:51:19 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: alsa-devel@alsa-project.org

&&/|| typo

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
// vi sound/oss/ad1848.c +83
#define MD_1845         4
...
#define MD_1845_SSCAPE  9 /* Ensoniq Soundscape PNP*/

diff --git a/sound/oss/ad1848.c b/sound/oss/ad1848.c
index 7cf9913..a5b8356 100644
--- a/sound/oss/ad1848.c
+++ b/sound/oss/ad1848.c
@@ -2107,7 +2107,7 @@ int ad1848_control(int cmd, int arg)
 	switch (cmd)
 	{
 		case AD1848_SET_XTAL:	/* Change clock frequency of AD1845 (only ) */
-			if (devc->model != MD_1845 || devc->model != MD_1845_SSCAPE)
+			if (devc->model != MD_1845 && devc->model != MD_1845_SSCAPE)
 				return -EINVAL;
 			spin_lock_irqsave(&devc->lock,flags);
 			ad_enter_MCE(devc);
