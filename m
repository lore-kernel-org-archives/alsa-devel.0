From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 4/5] ALSA: sparc: constify snd_timer_hardware structure
Date: Fri, 28 Jul 2017 18:38:30 +0530
Message-ID: <1501247311-19803-6-git-send-email-bhumirks@gmail.com>
References: <1501247311-19803-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501247311-19803-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Declare snd_timer_hardware structure as const as it is only used
during a copy operation. As it is  not modified anywhere, it
can be made const.

Cross compiled for sparc architecture.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/sparc/cs4231.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/sparc/cs4231.c b/sound/sparc/cs4231.c
index 3d7d425..0a97e97 100644
--- a/sound/sparc/cs4231.c
+++ b/sound/sparc/cs4231.c
@@ -868,7 +868,7 @@ static int snd_cs4231_timer_close(struct snd_timer *timer)
 	return 0;
 }
 
-static struct snd_timer_hardware snd_cs4231_timer_table = {
+static const struct snd_timer_hardware snd_cs4231_timer_table = {
 	.flags		=	SNDRV_TIMER_HW_AUTO,
 	.resolution	=	9945,
 	.ticks		=	65535,
-- 
1.9.1
