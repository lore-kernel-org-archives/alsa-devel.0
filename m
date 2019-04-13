From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH] ALSA: hda: Initialize ext-bus-specific fields
	in snd_hdac_bus_init(), too
Date: Sat, 13 Apr 2019 10:08:48 +0200
Message-ID: <20190413080848.21483-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id CFD1DF8075A
 for <alsa-devel@alsa-project.org>; Sat, 13 Apr 2019 10:08:51 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id C1862B01C
 for <alsa-devel@alsa-project.org>; Sat, 13 Apr 2019 08:08:50 +0000 (UTC)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Some fields in snd_hdac_bus are ext-bus specific, but they still
should be initialized in snd_hdac_bus_init() for consistency, at
least, for the ones that do need the explicit initialization like the
list head.

Also move the lock field to the more appropriate place and correct the
comment to reflect the recent change where it serves for both the
display power and the link management.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 include/sound/hdaudio.h      | 7 +++----
 sound/hda/ext/hdac_ext_bus.c | 2 --
 sound/hda/hdac_bus.c         | 1 +
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 45f944d57982..ca1d9a70d026 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -297,7 +297,7 @@ struct hdac_rb {
  * @num_streams: streams supported
  * @idx: HDA link index
  * @hlink_list: link list of HDA links
- * @lock: lock for link mgmt
+ * @lock: lock for link and display power mgmt
  * @cmd_dma_state: state of cmd DMAs: CORB and RIRB
  */
 struct hdac_bus {
@@ -363,6 +363,7 @@ struct hdac_bus {
 	/* locks */
 	spinlock_t reg_lock;
 	struct mutex cmd_mutex;
+	struct mutex lock;
 
 	/* DRM component interface */
 	struct drm_audio_component *audio_component;
@@ -373,11 +374,9 @@ struct hdac_bus {
 	int num_streams;
 	int idx;
 
+	/* link management */
 	struct list_head hlink_list;
-
-	struct mutex lock;
 	bool cmd_dma_state;
-
 };
 
 int snd_hdac_bus_init(struct hdac_bus *bus, struct device *dev,
diff --git a/sound/hda/ext/hdac_ext_bus.c b/sound/hda/ext/hdac_ext_bus.c
index ec7715c6b0c0..c203af71a099 100644
--- a/sound/hda/ext/hdac_ext_bus.c
+++ b/sound/hda/ext/hdac_ext_bus.c
@@ -104,9 +104,7 @@ int snd_hdac_ext_bus_init(struct hdac_bus *bus, struct device *dev,
 		return ret;
 
 	bus->ext_ops = ext_ops;
-	INIT_LIST_HEAD(&bus->hlink_list);
 	bus->idx = idx++;
-
 	bus->cmd_dma_state = true;
 
 	return 0;
diff --git a/sound/hda/hdac_bus.c b/sound/hda/hdac_bus.c
index ad8eee08013f..10e5d261fde1 100644
--- a/sound/hda/hdac_bus.c
+++ b/sound/hda/hdac_bus.c
@@ -39,6 +39,7 @@ int snd_hdac_bus_init(struct hdac_bus *bus, struct device *dev,
 	spin_lock_init(&bus->reg_lock);
 	mutex_init(&bus->cmd_mutex);
 	mutex_init(&bus->lock);
+	INIT_LIST_HEAD(&bus->hlink_list);
 	bus->irq = -1;
 	return 0;
 }
-- 
2.16.4
