From: David Henningsson <david.henningsson@canonical.com>
Subject: [PATCH v3 5/5] ALSA: hda - hdmi: Notify userspace when
	ELD control changes
Date: Tue, 19 Feb 2013 11:51:14 +0100
Message-ID: <1361271074-17555-6-git-send-email-david.henningsson@canonical.com>
References: <1361271074-17555-1-git-send-email-david.henningsson@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from youngberry.canonical.com (youngberry.canonical.com
 [91.189.89.112])
 by alsa0.perex.cz (Postfix) with ESMTP id B005E2651CD
 for <alsa-devel@alsa-project.org>; Tue, 19 Feb 2013 11:51:10 +0100 (CET)
In-Reply-To: <1361271074-17555-1-git-send-email-david.henningsson@canonical.com>
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
 sound/pci/hda/patch_hdmi.c |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 0e1d69d..b270dc0 100644
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
 
@@ -1216,10 +1218,16 @@ static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
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
