From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH v4 5/5] ALSA: hda - hdmi: Notify userspace when
	ELD control changes
Date: Tue, 19 Feb 2013 13:23:05 +0100
Message-ID: <1361276585-20015-6-git-send-email-david.henningsson@canonical.com>
References: <1361276585-20015-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id D3E35265232
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2013 13:23:00 +0100 (CET)
In-Reply-To: <1361276585-20015-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
Cc: fengguang.wu@intel.com, pierre-louis.bossart@linux.intel.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

ELD validity can change during the lifetime of a presence detect,
so we need to be able to listen for changes on the ELD control.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_hdmi.c |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index ec3ff3f..a6b5ad0 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -75,6 +75,7 @@ struct hdmi_spec_per_pin {
 	struct hda_codec *codec;
 	struct hdmi_eld sink_eld;
 	struct delayed_work work;
+	struct snd_kcontrol *eld_ctl;
 	int repoll_count;
 	bool non_pcm;
 	bool chmap_set;		/* channel-map override by ALSA API? */
@@ -411,6 +412,7 @@ static int hdmi_create_eld_ctl(struct hda_codec *codec, int pin_idx,
 	if (err < 0)
 		return err;
 
+	spec->pins[pin_idx].eld_ctl = kctl;
 	return 0;
 }
 
@@ -1217,19 +1219,27 @@ static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 	}
 
 	mutex_lock(&pin_eld->lock);
-	if (pin_eld->eld_valid && !eld->eld_valid)
+	if (pin_eld->eld_valid && !eld->eld_valid) {
 		update_eld = true;
+		eld_changed = true;
+	}
 	if (update_eld) {
 		pin_eld->eld_valid = eld->eld_valid;
-		eld_changed = memcmp(pin_eld->eld_buffer, eld->eld_buffer,
+		eld_changed |= memcmp(pin_eld->eld_buffer, eld->eld_buffer,
 				     eld->eld_size) != 0;
 		if (eld_changed)
 			memcpy(pin_eld->eld_buffer, eld->eld_buffer,
 			       eld->eld_size);
+		eld_changed |= pin_eld->eld_size != eld->eld_size;
 		pin_eld->eld_size = eld->eld_size;
 		pin_eld->info = eld->info;
 	}
 	mutex_unlock(&pin_eld->lock);
+
+	if (eld_changed)
+		snd_ctl_notify(codec->bus->card,
+			       SNDRV_CTL_EVENT_MASK_VALUE | SNDRV_CTL_EVENT_MASK_INFO,
+			       &per_pin->eld_ctl->id);
 }
 
 static void hdmi_repoll_eld(struct work_struct *work)
-- 
1.7.9.5
