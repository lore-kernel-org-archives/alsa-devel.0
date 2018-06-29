From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH v2] ALSA: hda - Handle pm failure during hotplug
Date: Fri, 29 Jun 2018 14:44:40 +0200
Message-ID: <20180629124440.3578-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id BD3EB2675C8
 for <alsa-devel@alsa-project.org>; Fri, 29 Jun 2018 14:44:46 +0200 (CEST)
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
Cc: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>, Chris Wilson <chris@chris-wilson.co.uk>
List-Id: alsa-devel@alsa-project.org

From: Chris Wilson <chris@chris-wilson.co.uk>

Obtaining the runtime pm wakeref can fail, especially in a hotplug
scenario where i915.ko has been unloaded. If we do not catch the
failure, we end up with an unbalanced pm.

[ Additional changes:
  hdmi_present_sense() checks the return value and handle only a
  negative error case and bails out only if it's really still
  suspended.  Also, snd_hda_power_down() is called at the error path
  so that the refcount is balanced.

  Along with it, the spec->pcm_lock is taken outside
  hdmi_present_sense() in the caller side, so that it won't cause
  deadlock at reentrace via runtime resume. -- tiwai ]

References: 222bde03881c ("ALSA: hda - Fix mutex deadlock at HDMI/DP hotplug")
Signed-off-by: Chris Wilson <chris@chris-wilson.co.uk>
Cc: <stable@vger.kernel.org>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/hda/patch_hdmi.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 98e1c411c56a..9e3916ed2588 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -764,8 +764,10 @@ static void check_presence_and_report(struct hda_codec *codec, hda_nid_t nid,
 
 	if (pin_idx < 0)
 		return;
+	mutex_lock(&spec->pcm_lock);
 	if (hdmi_present_sense(get_pin(spec, pin_idx), 1))
 		snd_hda_jack_report_sync(codec);
+	mutex_unlock(&spec->pcm_lock);
 }
 
 static void jack_callback(struct hda_codec *codec,
@@ -1628,21 +1630,23 @@ static void sync_eld_via_acomp(struct hda_codec *codec,
 static bool hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, int repoll)
 {
 	struct hda_codec *codec = per_pin->codec;
-	struct hdmi_spec *spec = codec->spec;
 	int ret;
 
 	/* no temporary power up/down needed for component notifier */
-	if (!codec_has_acomp(codec))
-		snd_hda_power_up_pm(codec);
+	if (!codec_has_acomp(codec)) {
+		ret = snd_hda_power_up_pm(codec);
+		if (ret < 0 && pm_runtime_suspended(hda_codec_dev(codec))) {
+			snd_hda_power_down_pm(codec);
+			return false;
+		}
+	}
 
-	mutex_lock(&spec->pcm_lock);
 	if (codec_has_acomp(codec)) {
 		sync_eld_via_acomp(codec, per_pin);
 		ret = false; /* don't call snd_hda_jack_report_sync() */
 	} else {
 		ret = hdmi_present_sense_via_verbs(per_pin, repoll);
 	}
-	mutex_unlock(&spec->pcm_lock);
 
 	if (!codec_has_acomp(codec))
 		snd_hda_power_down_pm(codec);
@@ -1654,12 +1658,16 @@ static void hdmi_repoll_eld(struct work_struct *work)
 {
 	struct hdmi_spec_per_pin *per_pin =
 	container_of(to_delayed_work(work), struct hdmi_spec_per_pin, work);
+	struct hda_codec *codec = per_pin->codec;
+	struct hdmi_spec *spec = codec->spec;
 
 	if (per_pin->repoll_count++ > 6)
 		per_pin->repoll_count = 0;
 
+	mutex_lock(&spec->pcm_lock);
 	if (hdmi_present_sense(per_pin, per_pin->repoll_count))
 		snd_hda_jack_report_sync(per_pin->codec);
+	mutex_unlock(&spec->pcm_lock);
 }
 
 static void intel_haswell_fixup_connect_list(struct hda_codec *codec,
-- 
2.17.1
