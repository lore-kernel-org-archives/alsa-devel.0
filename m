From: mengdong.lin@intel.com
Subject: [PATCH] ALSA: hda - delay resume haswell hdmi codec in
	system resume
Date: Tue, 26 Mar 2013 14:12:52 -0400
Message-ID: <1364321572-2634-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 75AE7264F29
 for <alsa-devel@alsa-project.org>; Tue, 26 Mar 2013 06:14:52 +0100 (CET)
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
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

In system resume, Haswell codec cannot be programmed to D0 before Gfx driver
initializes the display pipeline and audio, which will trigger an unsol event
on the pin with HDMI/DP cable connected. Otherwise, the connected pin will
stay in D3 with right channel muted and thus no sound can be heard.

This patch
- adds a codec flag to delay resuming a codec. System resume will skip the
  codecs if this flag is set, and these codecs will be resumed on later codec
  access.
- adds a set_power_state ops for Haswell HDMI codec. In a delayed resume, this
  ops will enable and wait for the unsol event, and then resume the codec. A
  300ms timeout is set in case unsol event is lost.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/pci/hda/hda_codec.c b/sound/pci/hda/hda_codec.c
index 04b5738..bcb7205 100644
--- a/sound/pci/hda/hda_codec.c
+++ b/sound/pci/hda/hda_codec.c
@@ -5508,11 +5508,15 @@ int snd_hda_resume(struct hda_bus *bus)
 	struct hda_codec *codec;
 
 	list_for_each_entry(codec, &bus->codec_list, list) {
-		hda_call_codec_resume(codec);
+		if (codec->support_delay_resume)
+			codec->resume_delayed = 1;
+		else
+			hda_call_codec_resume(codec);
 	}
 	return 0;
 }
 EXPORT_SYMBOL_HDA(snd_hda_resume);
+
 #endif /* CONFIG_PM */
 
 /*
diff --git a/sound/pci/hda/hda_codec.h b/sound/pci/hda/hda_codec.h
index 23ca172..5b5e5f4 100644
--- a/sound/pci/hda/hda_codec.h
+++ b/sound/pci/hda/hda_codec.h
@@ -886,6 +886,8 @@ struct hda_codec {
 	unsigned int d3_stop_clk:1;	/* support D3 operation without BCLK */
 	unsigned int pm_down_notified:1; /* PM notified to controller */
 	unsigned int in_pm:1;		/* suspend/resume being performed */
+	unsigned int support_delay_resume:1; /* codec support delay resume */
+	unsigned int resume_delayed:1; /* resume delayed by PM */
 	int power_transition;	/* power-state in transition */
 	int power_count;	/* current (global) power refcount */
 	struct delayed_work power_work; /* delayed task for powerdown */
diff --git a/sound/pci/hda/patch_hdmi.c b/sound/pci/hda/patch_hdmi.c
index 78e1827..d116908 100644
--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -98,6 +98,14 @@ struct hdmi_spec {
 	 */
 	struct hda_multi_out multiout;
 	struct hda_pcm_stream pcm_playback;
+
+#ifdef CONFIG_PM
+	/*
+	 * Non-generic Intel Haswell specific
+	 */
+	unsigned int ready_to_resume:1;
+	wait_queue_head_t resume_wq;
+#endif
 };
 
 
@@ -977,6 +985,13 @@ static void hdmi_intrinsic_event(struct hda_codec *codec, unsigned int res)
 	if (pin_idx < 0)
 		return;
 
+#ifdef CONFIG_PM
+	if (codec->resume_delayed) {
+		spec->ready_to_resume = 1;
+		wake_up(&spec->resume_wq);
+	}
+#endif
+
 	hdmi_present_sense(&spec->pins[pin_idx], 1);
 	snd_hda_jack_report_sync(codec);
 }
@@ -1846,6 +1861,63 @@ static const struct hda_fixup hdmi_fixups[] = {
 };
 
 
+#ifdef CONFIG_PM
+static void intel_haswell_wait_ready_to_resume(struct hda_codec *codec)
+{
+	struct hdmi_spec *spec = codec->spec;
+	int pin_idx;
+
+	spec->ready_to_resume = 0;
+
+	for (pin_idx = 0; pin_idx < spec->num_pins; pin_idx++) {
+		struct hdmi_spec_per_pin *per_pin;
+		hda_nid_t pin_nid;
+		struct hda_jack_tbl *jack;
+
+		per_pin = &spec->pins[pin_idx];
+		pin_nid = per_pin->pin_nid;
+		jack = snd_hda_jack_tbl_get(codec, pin_nid);
+		if (jack)
+			snd_hda_codec_write(codec, pin_nid, 0,
+				 AC_VERB_SET_UNSOLICITED_ENABLE,
+				 AC_USRSP_EN | jack->tag);
+	}
+
+	wait_event_timeout(spec->resume_wq,
+			spec->ready_to_resume, msecs_to_jiffies(300));
+	if (!spec->ready_to_resume)
+		snd_printd(KERN_WARNING "HDMI: Haswell not ready to resume\n");
+}
+
+static void intel_haswell_set_power_state(struct hda_codec *codec, hda_nid_t fg,
+				 unsigned int power_state)
+{
+	if (codec->resume_delayed && power_state ==  AC_PWRST_D0) {
+		intel_haswell_wait_ready_to_resume(codec);
+		codec->resume_delayed = 0;
+	}
+
+	snd_hda_codec_read(codec, fg, 0,
+					   AC_VERB_SET_POWER_STATE,
+					   power_state);
+
+	snd_hda_codec_set_power_to_all(codec, fg, power_state);
+}
+
+static inline void intel_haswell_allow_delay_resume(struct hda_codec *codec)
+{
+	struct hdmi_spec *spec = codec->spec;
+
+	init_waitqueue_head(&spec->resume_wq);
+	codec->support_delay_resume = 1;
+
+	codec->patch_ops.set_power_state =
+				intel_haswell_set_power_state;
+}
+#else
+define intel_haswell_allow_delay_resume NULL
+#endif
+
 static int patch_generic_hdmi(struct hda_codec *codec)
 {
 	struct hdmi_spec *spec;
@@ -1868,6 +1940,10 @@ static int patch_generic_hdmi(struct hda_codec *codec)
 		return -EINVAL;
 	}
 	codec->patch_ops = generic_hdmi_patch_ops;
+
+	if (codec->vendor_id == 0x80862807)
+		intel_haswell_allow_delay_resume(codec);
+
 	generic_hdmi_init_per_pins(codec);
 
 	init_channel_allocations();
-- 
1.7.10.4
