From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 1/2] ALSA: HDA: export process_unsol_events()
Date: Fri, 30 Nov 2018 18:54:36 -0600
Message-ID: <20181201005437.5198-2-pierre-louis.bossart@linux.intel.com>
References: <20181201005437.5198-1-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id C3ACB267BA2
 for <alsa-devel@alsa-project.org>; Sat,  1 Dec 2018 01:54:58 +0100 (CET)
In-Reply-To: <20181201005437.5198-1-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tiwai@suse.de, broonie@kernel.org, Keyon Jie <yang.jie@linux.intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Keyon Jie <yang.jie@linux.intel.com>

The SOF implementation does not rely on the hdac_bus library, however
for HDMI and HDaudio codec support it does need to deal with
unsolicited events. Instead of re-inventing the wheel, export this
symbol to reuse this part of the library directly.

Signed-off-by: Keyon Jie <yang.jie@linux.intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 include/sound/hdaudio.h | 1 +
 sound/hda/hdac_bus.c    | 7 +++----
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index cd1773d0e08f..2ee9eccf8d54 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -389,6 +389,7 @@ void snd_hdac_bus_queue_event(struct hdac_bus *bus, u32 res, u32 res_ex);
 int snd_hdac_bus_add_device(struct hdac_bus *bus, struct hdac_device *codec);
 void snd_hdac_bus_remove_device(struct hdac_bus *bus,
 				struct hdac_device *codec);
+void snd_hdac_bus_process_unsol_events(struct work_struct *work);
 
 static inline void snd_hdac_codec_link_up(struct hdac_device *codec)
 {
diff --git a/sound/hda/hdac_bus.c b/sound/hda/hdac_bus.c
index 714a51721a31..012305177f68 100644
--- a/sound/hda/hdac_bus.c
+++ b/sound/hda/hdac_bus.c
@@ -9,8 +9,6 @@
 #include <sound/hdaudio.h>
 #include "trace.h"
 
-static void process_unsol_events(struct work_struct *work);
-
 static const struct hdac_bus_ops default_ops = {
 	.command = snd_hdac_bus_send_cmd,
 	.get_response = snd_hdac_bus_get_response,
@@ -37,7 +35,7 @@ int snd_hdac_bus_init(struct hdac_bus *bus, struct device *dev,
 	bus->io_ops = io_ops;
 	INIT_LIST_HEAD(&bus->stream_list);
 	INIT_LIST_HEAD(&bus->codec_list);
-	INIT_WORK(&bus->unsol_work, process_unsol_events);
+	INIT_WORK(&bus->unsol_work, snd_hdac_bus_process_unsol_events);
 	spin_lock_init(&bus->reg_lock);
 	mutex_init(&bus->cmd_mutex);
 	bus->irq = -1;
@@ -148,7 +146,7 @@ EXPORT_SYMBOL_GPL(snd_hdac_bus_queue_event);
 /*
  * process queued unsolicited events
  */
-static void process_unsol_events(struct work_struct *work)
+void snd_hdac_bus_process_unsol_events(struct work_struct *work)
 {
 	struct hdac_bus *bus = container_of(work, struct hdac_bus, unsol_work);
 	struct hdac_device *codec;
@@ -171,6 +169,7 @@ static void process_unsol_events(struct work_struct *work)
 			drv->unsol_event(codec, res);
 	}
 }
+EXPORT_SYMBOL_GPL(snd_hdac_bus_process_unsol_events);
 
 /**
  * snd_hdac_bus_add_device - Add a codec to bus
-- 
2.17.1
