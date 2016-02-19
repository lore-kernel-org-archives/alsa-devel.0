From: libin.yang@linux.intel.com
Subject: [PATCH] ALSA: hda - hdmi get jack from hda_jack_tbl
	when not dyn_pcm_assign
Date: Fri, 19 Feb 2016 15:42:06 +0800
Message-ID: <1455867726-42566-1-git-send-email-libin.yang@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 113CE261521
 for <alsa-devel@alsa-project.org>; Fri, 19 Feb 2016 08:46:13 +0100 (CET)
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
Cc: libin.yang@intel.com, mengdong.lin@intel.com, Libin Yang <libin.yang@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Libin Yang <libin.yang@linux.intel.com>

On Intel platform, if !dyn_pcm_assign, spec->pcm_rec[].jack is not
NULL even after snd_hda_jack_tbl_clear() is called to free snd_jack.
This may cause access invalid memory when calling snd_jack_report.

Signed-off-by: Libin Yang <libin.yang@linux.intel.com>
---
 sound/pci/hda/patch_hdmi.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index f4443b5..541986f 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -1956,6 +1956,29 @@ static bool hdmi_present_sense_via_verbs(struct hdmi_spec_per_pin *per_pin,
 	return ret;
 }
 
+static struct snd_jack *pin_idx_to_jack(struct hda_codec *codec,
+				 struct hdmi_spec_per_pin *per_pin)
+{
+	struct hdmi_spec *spec = codec->spec;
+	struct snd_jack *jack = NULL;
+	struct hda_jack_tbl *jack_tbl;
+
+	/* if !dyn_pcm_assign, get jack from hda_jack_tbl
+	 * in !dyn_pcm_assign case, spec->pcm_rec[].jack is not
+	 * NULL even after snd_hda_jack_tbl_clear() is called to
+	 * free snd_jack. This may cause access invalid memory
+	 * when calling snd_jack_report
+	 */
+	if (per_pin->pcm_idx >= 0 && spec->dyn_pcm_assign)
+		jack = spec->pcm_rec[per_pin->pcm_idx].jack;
+	else if (!spec->dyn_pcm_assign) {
+		jack_tbl = snd_hda_jack_tbl_get(codec, per_pin->pin_nid);
+		if (jack_tbl)
+			jack = jack_tbl->jack;
+	}
+	return jack;
+}
+
 /* update ELD and jack state via audio component */
 static void sync_eld_via_acomp(struct hda_codec *codec,
 			       struct hdmi_spec_per_pin *per_pin)
@@ -1989,11 +2012,10 @@ static void sync_eld_via_acomp(struct hda_codec *codec,
 	/* pcm_idx >=0 before update_eld() means it is in monitor
 	 * disconnected event. Jack must be fetched before update_eld()
 	 */
-	if (per_pin->pcm_idx >= 0)
-		jack = spec->pcm_rec[per_pin->pcm_idx].jack;
+	jack = pin_idx_to_jack(codec, per_pin);
 	update_eld(codec, per_pin, eld);
-	if (jack == NULL && per_pin->pcm_idx >= 0)
-		jack = spec->pcm_rec[per_pin->pcm_idx].jack;
+	if (jack == NULL)
+		jack = pin_idx_to_jack(codec, per_pin);
 	if (jack == NULL)
 		goto unlock;
 	snd_jack_report(jack,
-- 
1.9.1
