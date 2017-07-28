From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 2/5] ALSA: isa: constify snd_timer_hardware structures
Date: Fri, 28 Jul 2017 18:38:27 +0530
Message-ID: <1501247311-19803-3-git-send-email-bhumirks@gmail.com>
References: <1501247311-19803-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1501247311-19803-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Declare snd_timer_hardware structures as const as their only usage
is during a copy operation. As they are not modified anywhere, they can
be made const.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/isa/ad1816a/ad1816a_lib.c | 2 +-
 sound/isa/gus/gus_timer.c       | 4 ++--
 sound/isa/wss/wss_lib.c         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/isa/ad1816a/ad1816a_lib.c b/sound/isa/ad1816a/ad1816a_lib.c
index 5c815f5..6130fc3 100644
--- a/sound/isa/ad1816a/ad1816a_lib.c
+++ b/sound/isa/ad1816a/ad1816a_lib.c
@@ -431,7 +431,7 @@ static int snd_ad1816a_timer_stop(struct snd_timer *timer)
 	return 0;
 }
 
-static struct snd_timer_hardware snd_ad1816a_timer_table = {
+static const struct snd_timer_hardware snd_ad1816a_timer_table = {
 	.flags =	SNDRV_TIMER_HW_AUTO,
 	.resolution =	10000,
 	.ticks =	65535,
diff --git a/sound/isa/gus/gus_timer.c b/sound/isa/gus/gus_timer.c
index c537271..8fd0327 100644
--- a/sound/isa/gus/gus_timer.c
+++ b/sound/isa/gus/gus_timer.c
@@ -123,7 +123,7 @@ static void snd_gf1_interrupt_timer2(struct snd_gus_card * gus)
 
  */
 
-static struct snd_timer_hardware snd_gf1_timer1 =
+static const struct snd_timer_hardware snd_gf1_timer1 =
 {
 	.flags =	SNDRV_TIMER_HW_STOP,
 	.resolution =	80000,
@@ -132,7 +132,7 @@ static void snd_gf1_interrupt_timer2(struct snd_gus_card * gus)
 	.stop =		snd_gf1_timer1_stop,
 };
 
-static struct snd_timer_hardware snd_gf1_timer2 =
+static const struct snd_timer_hardware snd_gf1_timer2 =
 {
 	.flags =	SNDRV_TIMER_HW_STOP,
 	.resolution =	320000,
diff --git a/sound/isa/wss/wss_lib.c b/sound/isa/wss/wss_lib.c
index 9f4e2e3..4016677 100644
--- a/sound/isa/wss/wss_lib.c
+++ b/sound/isa/wss/wss_lib.c
@@ -975,7 +975,7 @@ static int snd_wss_timer_close(struct snd_timer *timer)
 	return 0;
 }
 
-static struct snd_timer_hardware snd_wss_timer_table =
+static const struct snd_timer_hardware snd_wss_timer_table =
 {
 	.flags =	SNDRV_TIMER_HW_AUTO,
 	.resolution =	9945,
-- 
1.9.1
