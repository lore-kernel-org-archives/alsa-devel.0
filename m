From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [RFC][PATCH] fall back to reserved minor numbers
Date: Fri, 14 May 2010 11:28:28 +0800
Message-ID: <20100514032827.GA10883@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
	by alsa0.perex.cz (Postfix) with ESMTP id DACD9243C0
	for <alsa-devel@alsa-project.org>;
	Fri, 14 May 2010 05:28:32 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Clemens Ladisch <clemens@ladisch.de>
List-Id: alsa-devel@alsa-project.org

When the static minor numbers collide because of too many devices,
fall back to the reserved minor numbers 2 and 3.

This for example will allow Intel HDMI audio driver to create three PCM
devices (index 3, 7, 8; the minor number of the last index will
otherwise collide with the first record device).

The other option is to force enable CONFIG_SND_DYNAMIC_MINORS.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 include/sound/minors.h |    4 +++-
 sound/core/sound.c     |   10 ++++++++--
 2 files changed, 11 insertions(+), 3 deletions(-)

--- drm-intel.orig/include/sound/minors.h	2010-05-13 10:06:52.000000000 +0800
+++ drm-intel/include/sound/minors.h	2010-05-13 10:10:06.000000000 +0800
@@ -35,7 +35,9 @@
 #define SNDRV_MINOR_TIMER		(SNDRV_MINOR_GLOBAL + 1 * 32)
 
 #ifndef CONFIG_SND_DYNAMIC_MINORS
-						/* 2 - 3 (reserved) */
+
+#define SNDRV_MINOR_BACKUP1		2
+#define SNDRV_MINOR_BACKUP2		3
 #define SNDRV_MINOR_HWDEP		4	/* 4 - 7 */
 #define SNDRV_MINOR_RAWMIDI		8	/* 8 - 15 */
 #define SNDRV_MINOR_PCM_PLAYBACK	16	/* 16 - 23 */
--- drm-intel.orig/sound/core/sound.c	2010-05-13 10:06:04.000000000 +0800
+++ drm-intel/sound/core/sound.c	2010-05-13 10:11:19.000000000 +0800
@@ -269,8 +269,14 @@ int snd_register_device_for_dev(int type
 	minor = snd_find_free_minor();
 #else
 	minor = snd_kernel_minor(type, card, dev);
-	if (minor >= 0 && snd_minors[minor])
-		minor = -EBUSY;
+	if (minor >= 0) {
+		if (snd_minors[minor])
+			minor = SNDRV_MINOR_BACKUP1;
+		if (snd_minors[minor])
+			minor = SNDRV_MINOR_BACKUP2;
+		if (snd_minors[minor])
+			minor = -EBUSY;
+	}
 #endif
 	if (minor < 0) {
 		mutex_unlock(&sound_mutex);
