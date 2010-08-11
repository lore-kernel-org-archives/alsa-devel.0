From: Andrea Gelmini <andrea.gelmini@gelma.net>
Subject: [PATCH 1/4] sound: oss: sh_dac_audio.c removed
	duplicated #include
Date: Wed, 11 Aug 2010 21:07:33 +0200
Message-ID: <1281553657-18036-1-git-send-email-andrea.gelmini@gelma.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f51.google.com (mail-bw0-f51.google.com
	[209.85.214.51])
	by alsa0.perex.cz (Postfix) with ESMTP id EBFCC103803
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Aug 2010 21:07:51 +0200 (CEST)
Received: by bwz15 with SMTP id 15so365636bwz.38
	for <alsa-devel@alsa-project.org>; Wed, 11 Aug 2010 12:07:51 -0700 (PDT)
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
Cc: alsa-devel@alsa-project.org, Arnd Bergmann <arnd@arndb.de>, Takashi Iwai <tiwai@suse.de>, Roel Kluin <roel.kluin@gmail.com>, Andrea Gelmini <andrea.gelmini@gelma.net>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 sound/oss/sh_dac_audio.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/oss/sh_dac_audio.c b/sound/oss/sh_dac_audio.c
index fdb58eb..479e302 100644
--- a/sound/oss/sh_dac_audio.c
+++ b/sound/oss/sh_dac_audio.c
@@ -15,7 +15,6 @@
 #include <linux/linkage.h>
 #include <linux/slab.h>
 #include <linux/fs.h>
-#include <linux/smp_lock.h>
 #include <linux/sound.h>
 #include <linux/smp_lock.h>
 #include <linux/soundcard.h>
-- 
1.7.2.1.85.g2d089
