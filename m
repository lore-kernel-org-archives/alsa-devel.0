From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH v2 4/4] ALSA: hda - hdmi: Notify userspace when
	ELD control changes
Date: Tue, 19 Feb 2013 09:47:37 +0100
Message-ID: <1361263657-15888-5-git-send-email-david.henningsson@canonical.com>
References: <1361263657-15888-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id 5F1B52651BF
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2013 09:47:34 +0100 (CET)
In-Reply-To: <1361263657-15888-1-git-send-email-david.henningsson@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.de
Cc: fengguang.wu@intel.com, pierre-louis.bossart@linux.intel.com, David Henningsson <david.henningsson@canonical.com>
List-Id: alsa-devel@alsa-project.org

ELD validity can change during the lifetime of a presence detect,
so we need to be able to listen for changes on the ELD control.

Signed-off-by: David Henningsson <david.henningsson@canonical.com>
---
 sound/pci/hda/patch_hdmi.c |   19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 52b1afc..bfaa0ee 100644
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
 
@@ -1182,6 +1184,7 @@ static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 	 */
 	int present = snd_hda_pin_sense(codec, pin_nid);
 	bool update_eld = false;
+	bool eld_changed = false;
 
 	memset(eld, 0, offsetof(struct hdmi_eld, eld_buffer));
 
@@ -1208,10 +1211,20 @@ static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 	spin_lock(&pin_eld->lock);
 	if (pin_eld->eld_valid && !eld->eld_valid)
 		update_eld = true;
-	if (update_eld)
-		memcpy(&pin_eld->monitor_present, &eld->monitor_present,
-		       sizeof(struct hdmi_eld) - sizeof(spinlock_t));
+	if (update_eld) {
+		void *dest = &pin_eld->monitor_present;
+		void *src = &eld->monitor_present;
+		size_t size = sizeof(struct hdmi_eld) - sizeof(spinlock_t);
+		eld_changed = memcmp(dest, src, size) != 0;
+		if (eld_changed)
+			memcpy(dest, src, size);
+	}
 	spin_unlock(&pin_eld->lock);
+
+	if (eld_changed)
+		snd_ctl_notify(codec->bus->card,
+			       SNDRV_CTL_EVENT_MASK_VALUE | SNDRV_CTL_EVENT_MASK_INFO,
+			       &per_pin->eld_ctl->id);
 }
 
 static void hdmi_repoll_eld(struct work_struct *work)
-- 
1.7.9.5
