From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 1/2] sound: oss: make the function argument as
	const
Date: Fri, 13 Oct 2017 19:16:32 +0200
Message-ID: <1507914993-6015-2-git-send-email-bhumirks@gmail.com>
References: <1507914993-6015-1-git-send-email-bhumirks@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-wr0-f194.google.com (mail-wr0-f194.google.com
 [209.85.128.194])
 by alsa0.perex.cz (Postfix) with ESMTP id 39697266E90
 for <alsa-devel@alsa-project.org>; Fri, 13 Oct 2017 19:16:40 +0200 (CEST)
Received: by mail-wr0-f194.google.com with SMTP id z96so1255069wrb.0
 for <alsa-devel@alsa-project.org>; Fri, 13 Oct 2017 10:16:40 -0700 (PDT)
In-Reply-To: <1507914993-6015-1-git-send-email-bhumirks@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: julia.lawall@lip6.fr, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make the function argument struct audio_driver *driver of the function
sound_install_audiodrv as const as it's memory contents are only copied
during a memcpy call. So, the fields of the structure to which driver
points to never gets modified and therefore the argument can be made
const.
Add const to the prototype too.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/oss/dev_table.c | 2 +-
 sound/oss/dev_table.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/oss/dev_table.c b/sound/oss/dev_table.c
index 6dad515..dbb9a3b 100644
--- a/sound/oss/dev_table.c
+++ b/sound/oss/dev_table.c
@@ -48,7 +48,7 @@ struct sound_timer_operations *sound_timer_devs[MAX_TIMER_DEV] = {
 
 static int sound_alloc_audiodev(void);
 
-int sound_install_audiodrv(int vers, char *name, struct audio_driver *driver,
+int sound_install_audiodrv(int vers, char *name, const struct audio_driver *driver,
 			int driver_size, int flags, unsigned int format_mask,
 			void *devc, int dma1, int dma2)
 {
diff --git a/sound/oss/dev_table.h b/sound/oss/dev_table.h
index 0199a31..b388ed0 100644
--- a/sound/oss/dev_table.h
+++ b/sound/oss/dev_table.h
@@ -371,7 +371,7 @@ struct sound_timer_operations
 
 #define AUDIO_DRIVER_VERSION	2
 #define MIXER_DRIVER_VERSION	2
-int sound_install_audiodrv(int vers, char *name, struct audio_driver *driver,
+int sound_install_audiodrv(int vers, char *name, const struct audio_driver *driver,
 			int driver_size, int flags, unsigned int format_mask,
 			void *devc, int dma1, int dma2);
 int sound_install_mixer(int vers, char *name, struct mixer_operations *driver,
-- 
1.9.1
