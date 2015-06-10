From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 2/2] ALSA: hda - Allow calling
	snd_hdac_i915_*() without actual binding
Date: Wed, 10 Jun 2015 12:26:05 +0200
Message-ID: <1433931965-12337-2-git-send-email-tiwai@suse.de>
References: <1433931965-12337-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 4495E2614D9
 for <alsa-devel@alsa-project.org>; Wed, 10 Jun 2015 12:26:07 +0200 (CEST)
In-Reply-To: <1433931965-12337-1-git-send-email-tiwai@suse.de>
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
Cc: Libin Yang <libin.yang@intel.com>, Mengdong Lin <mengdong.lin@intel.com>, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

Add the missing NULL checks so that snd_hdac_i915*() can be called
even after the binding with i915 failed.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
This is only for 4.2 (for-next branch).

 sound/hda/hdac_i915.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/sound/hda/hdac_i915.c b/sound/hda/hdac_i915.c
index cb78c25585ac..442500e06b7c 100644
--- a/sound/hda/hdac_i915.c
+++ b/sound/hda/hdac_i915.c
@@ -27,7 +27,7 @@ int snd_hdac_set_codec_wakeup(struct hdac_bus *bus, bool enable)
 {
 	struct i915_audio_component *acomp = bus->audio_component;
 
-	if (!acomp->ops)
+	if (!acomp || !acomp->ops)
 		return -ENODEV;
 
 	if (!acomp->ops->codec_wake_override) {
@@ -49,7 +49,7 @@ int snd_hdac_display_power(struct hdac_bus *bus, bool enable)
 {
 	struct i915_audio_component *acomp = bus->audio_component;
 
-	if (!acomp->ops)
+	if (!acomp || !acomp->ops)
 		return -ENODEV;
 
 	dev_dbg(bus->dev, "display power %s\n",
@@ -72,7 +72,7 @@ int snd_hdac_get_display_clk(struct hdac_bus *bus)
 {
 	struct i915_audio_component *acomp = bus->audio_component;
 
-	if (!acomp->ops)
+	if (!acomp || !acomp->ops)
 		return -ENODEV;
 
 	return acomp->ops->get_cdclk_freq(acomp->dev);
@@ -179,8 +179,11 @@ int snd_hdac_i915_exit(struct hdac_bus *bus)
 	struct device *dev = bus->dev;
 	struct i915_audio_component *acomp = bus->audio_component;
 
+	if (!acomp)
+		return 0;
+
 	WARN_ON(bus->i915_power_refcount);
-	if (bus->i915_power_refcount > 0 && acomp && acomp->ops)
+	if (bus->i915_power_refcount > 0 && acomp->ops)
 		acomp->ops->put_power(acomp->dev);
 
 	component_master_del(dev, &hdac_component_master_ops);
-- 
2.4.3
