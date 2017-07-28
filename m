From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 5/5] ALSA: opl3: constify snd_timer_hardware structures
Date: Fri, 28 Jul 2017 18:38:31 +0530
Message-ID: <1501247311-19803-7-git-send-email-bhumirks@gmail.com>
References: <1501247311-19803-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501247311-19803-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Declare snd_timer_hardware structures as const as their only usage
is during a copy operation. As they are not modified anywhere, they
can be made const.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/drivers/opl3/opl3_lib.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/drivers/opl3/opl3_lib.c b/sound/drivers/opl3/opl3_lib.c
index d5e5b46..5259904 100644
--- a/sound/drivers/opl3/opl3_lib.c
+++ b/sound/drivers/opl3/opl3_lib.c
@@ -229,7 +229,7 @@ static int snd_opl3_timer2_stop(struct snd_timer * timer)
 
  */
 
-static struct snd_timer_hardware snd_opl3_timer1 =
+static const struct snd_timer_hardware snd_opl3_timer1 =
 {
 	.flags =	SNDRV_TIMER_HW_STOP,
 	.resolution =	80000,
@@ -238,7 +238,7 @@ static int snd_opl3_timer2_stop(struct snd_timer * timer)
 	.stop =		snd_opl3_timer1_stop,
 };
 
-static struct snd_timer_hardware snd_opl3_timer2 =
+static const struct snd_timer_hardware snd_opl3_timer2 =
 {
 	.flags =	SNDRV_TIMER_HW_STOP,
 	.resolution =	320000,
-- 
1.9.1
