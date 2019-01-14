From: Chris Wilson <chris@chris-wilson.co.uk>
Subject: [PATCH 3/3] snd/hda: Protect concurrent
	display_power_status with a mutex
Date: Mon, 14 Jan 2019 17:37:53 +0000
Message-ID: <20190114173753.472-3-chris@chris-wilson.co.uk>
References: <20190114173753.472-1-chris@chris-wilson.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fireflyinternet.com (mail.fireflyinternet.com [109.228.58.192])
 by alsa0.perex.cz (Postfix) with ESMTP id C30ED266C08
 for <alsa-devel@alsa-project.org>; Mon, 14 Jan 2019 18:38:07 +0100 (CET)
In-Reply-To: <20190114173753.472-1-chris@chris-wilson.co.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: intel-gfx@lists.freedesktop.org
Cc: Takashi Iwai <tiwai@suse.de>, Jani Nikula <jani.nikula@intel.com>, alsa-devel@alsa-project.org, Chris Wilson <chris@chris-wilson.co.uk>
List-Id: alsa-devel@alsa-project.org

Just in case the audio linkage is swapped between components during the
runtime pm sequence, we need to protect the rpm tracking with a mutex.

Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: Takashi Iwai <tiwai@suse.de>
Cc: Jani Nikula <jani.nikula@intel.com>
---
 include/sound/hdaudio.h    | 1 +
 sound/hda/hdac_component.c | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/include/sound/hdaudio.h b/include/sound/hdaudio.h
index 39761120ee76..497335b24e18 100644
--- a/include/sound/hdaudio.h
+++ b/include/sound/hdaudio.h
@@ -368,6 +368,7 @@ struct hdac_bus {
 	struct drm_audio_component *audio_component;
 	unsigned long display_power_status;
 	unsigned long display_power_active;
+	struct mutex display_power_lock;
 
 	/* parameters required for enhanced capabilities */
 	int num_streams;
diff --git a/sound/hda/hdac_component.c b/sound/hda/hdac_component.c
index 2702548b788a..ea76c1de2927 100644
--- a/sound/hda/hdac_component.c
+++ b/sound/hda/hdac_component.c
@@ -77,6 +77,7 @@ void snd_hdac_display_power(struct hdac_bus *bus, unsigned int idx, bool enable)
 	if (!acomp || !acomp->ops)
 		return;
 
+	mutex_lock(&bus->display_power_lock);
 	if (bus->display_power_status) {
 		if (!bus->display_power_active) {
 			unsigned long cookie = -1;
@@ -98,6 +99,7 @@ void snd_hdac_display_power(struct hdac_bus *bus, unsigned int idx, bool enable)
 			bus->display_power_active = 0;
 		}
 	}
+	mutex_unlock(&bus->display_power_lock);
 }
 EXPORT_SYMBOL_GPL(snd_hdac_display_power);
 
@@ -290,6 +292,9 @@ int snd_hdac_acomp_init(struct hdac_bus *bus,
 			     GFP_KERNEL);
 	if (!acomp)
 		return -ENOMEM;
+
+	mutex_init(&bus->display_power_lock);
+
 	acomp->audio_ops = aops;
 	bus->audio_component = acomp;
 	devres_add(dev, acomp);
@@ -336,6 +341,8 @@ int snd_hdac_acomp_exit(struct hdac_bus *bus)
 	bus->display_power_active = 0;
 	bus->display_power_status = 0;
 
+	mutex_destroy(&bus->display_power_lock);
+
 	component_master_del(dev, &hdac_component_master_ops);
 
 	bus->audio_component = NULL;
-- 
2.20.1
