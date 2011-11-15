From: Wu Fengguang <fengguang.wu@intel.com>
Subject: [PATCH 2/2] hda - delayed ELD repoll
Date: Tue, 15 Nov 2011 22:33:15 +0800
Message-ID: <20111115143315.GA28561@localhost>
References: <20111115143155.GA28175@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <20111115143155.GA28175@localhost>
List-Unsubscribe: <http://lists.freedesktop.org/mailman/options/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <http://lists.freedesktop.org/archives/intel-gfx>
List-Post: <mailto:intel-gfx@lists.freedesktop.org>
List-Help: <mailto:intel-gfx-request@lists.freedesktop.org?subject=help>
List-Subscribe: <http://lists.freedesktop.org/mailman/listinfo/intel-gfx>,
	<mailto:intel-gfx-request@lists.freedesktop.org?subject=subscribe>
Sender: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
Errors-To: intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, "Wang, Zhenyu Z" <zhenyu.z.wang@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Barnes, Jesse" <jesse.barnes@intel.com>, Jeremy Bush <contractfrombelow@gmail.com>, Christopher White <c.white@pulseforce.com>, "Bossart,
	Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

The Intel HDMI chips (ironlake at least) are found to have ~250ms delay
between the ELD_Valid=1 hotplug event is send and the ELD buffer becomes
actually readable. During the time the ELD buffer is mysteriously all 0.

Fix it by scheduling a delayed work to re-read ELD buffer after 300ms.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/hda_local.h  |    2 +
 sound/pci/hda/patch_hdmi.c |   49 ++++++++++++++++++++++++++++++-----
 2 files changed, 44 insertions(+), 7 deletions(-)

--- linux.orig/sound/pci/hda/hda_local.h	2011-11-15 21:29:53.000000000 +0800
+++ linux/sound/pci/hda/hda_local.h	2011-11-15 21:29:54.000000000 +0800
@@ -655,6 +655,8 @@ struct hdmi_eld {
 #ifdef CONFIG_PROC_FS
 	struct snd_info_entry *proc_entry;
 #endif
+	struct hda_codec *codec;
+	struct delayed_work work;
 };
 
 int snd_hdmi_get_eld_size(struct hda_codec *codec, hda_nid_t nid);
--- linux.orig/sound/pci/hda/patch_hdmi.c	2011-11-15 21:29:53.000000000 +0800
+++ linux/sound/pci/hda/patch_hdmi.c	2011-11-15 21:31:48.000000000 +0800
@@ -746,7 +746,7 @@ static void hdmi_setup_audio_infoframe(s
  */
 
 static void hdmi_present_sense(struct hda_codec *codec, hda_nid_t pin_nid,
-			       struct hdmi_eld *eld);
+			       struct hdmi_eld *eld, bool retry);
 
 static void hdmi_intrinsic_event(struct hda_codec *codec, unsigned int res)
 {
@@ -766,7 +766,7 @@ static void hdmi_intrinsic_event(struct 
 		return;
 	eld = &spec->pins[pin_idx].sink_eld;
 
-	hdmi_present_sense(codec, pin_nid, eld);
+	hdmi_present_sense(codec, pin_nid, eld, true);
 
 	/*
 	 * HDMI sink's ELD info cannot always be retrieved for now, e.g.
@@ -969,7 +969,7 @@ static int hdmi_read_pin_conn(struct hda
 }
 
 static void hdmi_present_sense(struct hda_codec *codec, hda_nid_t pin_nid,
-			       struct hdmi_eld *eld)
+			       struct hdmi_eld *eld, bool retry)
 {
 	/*
 	 * Always execute a GetPinSense verb here, even when called from
@@ -992,13 +992,31 @@ static void hdmi_present_sense(struct hd
 		"HDMI status: Codec=%d Pin=%d Presence_Detect=%d ELD_Valid=%d\n",
 		codec->addr, pin_nid, eld->monitor_present, eld_valid);
 
-	if (eld_valid)
+	if (eld_valid) {
 		if (!snd_hdmi_get_eld(eld, codec, pin_nid))
 			snd_hdmi_show_eld(eld);
+		else {
+			queue_delayed_work(codec->bus->workq,
+					   &eld->work,
+					   msecs_to_jiffies(300));
+		}
+	}
 
 	snd_hda_input_jack_report(codec, pin_nid);
 }
 
+static void hda_eld_work(struct work_struct *work)
+{
+	struct hdmi_eld *eld = container_of(
+				container_of(work, struct delayed_work, work),
+				struct hdmi_eld, work);
+	struct hdmi_spec_per_pin *per_pin =
+			container_of(eld, struct hdmi_spec_per_pin, sink_eld);
+	struct hda_codec *codec = eld->codec;
+
+	hdmi_present_sense(codec, per_pin->pin_nid, eld, false);
+}
+
 static int hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
 {
 	struct hdmi_spec *spec = codec->spec;
@@ -1227,7 +1245,7 @@ static int generic_hdmi_build_jack(struc
 	if (err < 0)
 		return err;
 
-	hdmi_present_sense(codec, per_pin->pin_nid, &per_pin->sink_eld);
+	hdmi_present_sense(codec, per_pin->pin_nid, &per_pin->sink_eld, false);
 	return 0;
 }
 
@@ -1263,6 +1281,23 @@ static int generic_hdmi_build_controls(s
 	return 0;
 }
 
+static void snd_hda_eld_init(struct hda_codec *codec, struct hdmi_eld *eld,
+			     int pin_idx)
+{
+	eld->codec = codec;
+	INIT_DELAYED_WORK(&eld->work, hda_eld_work);
+
+	snd_hda_eld_proc_new(codec, eld, pin_idx);
+}
+
+static void snd_hda_eld_free(struct hda_codec *codec, struct hdmi_eld *eld)
+{
+	cancel_delayed_work(&eld->work);
+	flush_workqueue(codec->bus->workq);
+
+	snd_hda_eld_proc_free(codec, eld);
+}
+
 static int generic_hdmi_init(struct hda_codec *codec)
 {
 	struct hdmi_spec *spec = codec->spec;
@@ -1278,7 +1313,7 @@ static int generic_hdmi_init(struct hda_
 				    AC_VERB_SET_UNSOLICITED_ENABLE,
 				    AC_USRSP_EN | pin_nid);
 
-		snd_hda_eld_proc_new(codec, eld, pin_idx);
+		snd_hda_eld_init(codec, eld, pin_idx);
 	}
 	return 0;
 }
@@ -1292,7 +1327,7 @@ static void generic_hdmi_free(struct hda
 		struct hdmi_spec_per_pin *per_pin = &spec->pins[pin_idx];
 		struct hdmi_eld *eld = &per_pin->sink_eld;
 
-		snd_hda_eld_proc_free(codec, eld);
+		snd_hda_eld_free(codec, eld);
 	}
 	snd_hda_input_jack_free(codec);
