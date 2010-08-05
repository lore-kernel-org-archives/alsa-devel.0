From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 13/15] sound: oss: au1550_ac97.c removed
	duplicated #include
Date: Thu,  5 Aug 2010 15:51:37 +0200
Message-ID: <1281016299-23958-13-git-send-email-andrea.gelmini@gelma.net>
References: <1281016299-23958-1-git-send-email-andrea.gelmini@gelma.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ww0-f41.google.com (mail-ww0-f41.google.com [74.125.82.41])
	by alsa0.perex.cz (Postfix) with ESMTP id F37D71038FB
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Aug 2010 15:52:29 +0200 (CEST)
Received: by wwa36 with SMTP id 36so789392wwa.2
	for <alsa-devel@alsa-project.org>; Thu, 05 Aug 2010 06:52:29 -0700 (PDT)
In-Reply-To: <1281016299-23958-1-git-send-email-andrea.gelmini@gelma.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: gelma@gelma.net
Cc: alsa-devel@alsa-project.org, Takashi Iwai <tiwai@suse.de>, Ralf Baechle <ralf@linux-mips.org>, Manuel Lauss <manuel.lauss@gmail.com>, Andrea Gelmini <andrea.gelmini@gelma.net>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 sound/oss/au1550_ac97.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/oss/au1550_ac97.c b/sound/oss/au1550_ac97.c
index c1070e3..3964306 100644
--- a/sound/oss/au1550_ac97.c
+++ b/sound/oss/au1550_ac97.c
@@ -49,7 +49,6 @@
 #include <linux/poll.h>
 #include <linux/bitops.h>
 #include <linux/spinlock.h>
-#include <linux/smp_lock.h>
 #include <linux/ac97_codec.h>
 #include <linux/mutex.h>
 
-- 
1.7.2.1.85.g2d089
