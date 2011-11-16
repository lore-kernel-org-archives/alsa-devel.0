From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH 2/2 v2] hda - delayed ELD repoll
Date: Wed, 16 Nov 2011 10:35:19 +0800
Message-ID: <20111116023519.GA11375@localhost>
References: <20111115143155.GA28175@localhost>
	<20111115143315.GA28561@localhost>
	<20111115165623.GA4487@localhost> <20111115165708.GA5224@localhost>
	<s5hobwdpb02.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <intel-gfx-bounces+gcfxdi-intel-gfx=m.gmane.org@lists.freedesktop.org>
Content-Disposition: inline
In-Reply-To: <s5hobwdpb02.wl%tiwai@suse.de>
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
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Wang,
	Zhenyu Z" <zhenyu.z.wang@intel.com>, "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>, "Barnes, Jesse" <jesse.barnes@intel.com>, Jeremy Bush <contractfrombelow@gmail.com>, Christopher White <c.white@pulseforce.com>, "Bossart,
	Pierre-louis" <pierre-louis.bossart@intel.com>
List-Id: alsa-devel@alsa-project.org

On Wed, Nov 16, 2011 at 01:10:37AM +0800, Takashi Iwai wrote:
> At Wed, 16 Nov 2011 00:57:08 +0800,
> Wu Fengguang wrote:
> > +static void hda_eld_work(struct work_struct *work)
> > +{
> > +	struct hdmi_eld *eld = container_of(
> > +				container_of(work, struct delayed_work, work),
> > +				struct hdmi_eld, work);
> 
> Ugh, hardly to read.  Slightly better to use to_delayed_work()?
> 
> 	struct hdmi_eld *eld = container_of(to_delayed_work(work),
> 					    struct hdmi_eld, work);

Yeah that looks much better! Changed to:

+static void hdmi_repoll_eld(struct work_struct *work)
+{     
+       struct hdmi_spec_per_pin *per_pin =
+       container_of(to_delayed_work(work), struct hdmi_spec_per_pin, work);
+       
+       hdmi_present_sense(per_pin, false);
+}

> > +	struct hdmi_spec_per_pin *per_pin =
> > +			container_of(eld, struct hdmi_spec_per_pin, sink_eld);
> > +	struct hda_codec *codec = eld->codec;
> > +
> > +	hdmi_present_sense(codec, per_pin->pin_nid, eld, false);
> > +}
> > +
> >  static int hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
> >  {
> >  	struct hdmi_spec *spec = codec->spec;
> > @@ -1227,7 +1245,7 @@ static int generic_hdmi_build_jack(struc
> >  	if (err < 0)
> >  		return err;
> >  
> > -	hdmi_present_sense(codec, per_pin->pin_nid, &per_pin->sink_eld);
> > +	hdmi_present_sense(codec, per_pin->pin_nid, &per_pin->sink_eld, false);
> ...
> 
> Looking through the code, I wonder how about keeping work and codec
> pointer in struct hdmi_spec_per_pin instead of struct hdmi_eld.  Then
> we don't need to expose it in hda_local.h, and changes would be
> slightly more compact.
> 
> hdmi_present_sense() can be modified to receive hdmi_sepc_per_pin*
> directly instead of individual nid and eld pointer.

Good idea! With the changes I get a much smaller patch :-)

I'll repost the patch series after some more testing.

Thanks,
Fengguang
---

Subject: hda - delayed ELD repoll
Date: Mon Nov 14 11:31:00 CST 2011

The Intel HDMI chips (ironlake at least) are found to have ~250ms delay
between the ELD_Valid=1 hotplug event is send and the ELD buffer becomes
actually readable. During the time the ELD buffer is mysteriously all 0.

Fix it by scheduling a delayed work to re-read ELD buffer after 300ms.

Signed-off-by: Wu Fengguang <fengguang.wu@intel.com>
---
 sound/pci/hda/patch_hdmi.c |   36 ++++++++++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 7 deletions(-)

--- linux.orig/sound/pci/hda/patch_hdmi.c	2011-11-16 09:53:01.000000000 +0800
+++ linux/sound/pci/hda/patch_hdmi.c	2011-11-16 10:33:06.000000000 +0800
@@ -65,7 +65,10 @@ struct hdmi_spec_per_pin {
 	hda_nid_t pin_nid;
 	int num_mux_nids;
 	hda_nid_t mux_nids[HDA_MAX_CONNECTIONS];
+
+	struct hda_codec *codec;
 	struct hdmi_eld sink_eld;
+	struct delayed_work work;
 };
 
 struct hdmi_spec {
@@ -745,8 +748,7 @@ static void hdmi_setup_audio_infoframe(s
  * Unsolicited events
  */
 
-static void hdmi_present_sense(struct hda_codec *codec, hda_nid_t pin_nid,
-			       struct hdmi_eld *eld);
+static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, bool retry);
 
 static void hdmi_intrinsic_event(struct hda_codec *codec, unsigned int res)
 {
@@ -766,7 +768,7 @@ static void hdmi_intrinsic_event(struct 
 		return;
 	eld = &spec->pins[pin_idx].sink_eld;
 
-	hdmi_present_sense(codec, pin_nid, eld);
+	hdmi_present_sense(&spec->pins[pin_idx], true);
 
 	/*
 	 * HDMI sink's ELD info cannot always be retrieved for now, e.g.
@@ -968,9 +970,11 @@ static int hdmi_read_pin_conn(struct hda
 	return 0;
 }
 
-static void hdmi_present_sense(struct hda_codec *codec, hda_nid_t pin_nid,
-			       struct hdmi_eld *eld)
+static void hdmi_present_sense(struct hdmi_spec_per_pin *per_pin, bool retry)
 {
+	struct hda_codec *codec = per_pin->codec;
+	struct hdmi_eld *eld = &per_pin->sink_eld;
+	hda_nid_t pin_nid = per_pin->pin_nid;
 	/*
 	 * Always execute a GetPinSense verb here, even when called from
 	 * hdmi_intrinsic_event; for some NVIDIA HW, the unsolicited
@@ -992,13 +996,27 @@ static void hdmi_present_sense(struct hd
 		"HDMI status: Codec=%d Pin=%d Presence_Detect=%d ELD_Valid=%d\n",
 		codec->addr, pin_nid, eld->monitor_present, eld_valid);
 
-	if (eld_valid)
+	if (eld_valid) {
 		if (!snd_hdmi_get_eld(eld, codec, pin_nid))
 			snd_hdmi_show_eld(eld);
+		else if (retry) {
+			queue_delayed_work(codec->bus->workq,
+					   &per_pin->work,
+					   msecs_to_jiffies(300));
+		}
+	}
 
 	snd_hda_input_jack_report(codec, pin_nid);
 }
 
+static void hdmi_repoll_eld(struct work_struct *work)
+{
+	struct hdmi_spec_per_pin *per_pin =
+	container_of(to_delayed_work(work), struct hdmi_spec_per_pin, work);
+
+	hdmi_present_sense(per_pin, false);
+}
+
 static int hdmi_add_pin(struct hda_codec *codec, hda_nid_t pin_nid)
 {
 	struct hdmi_spec *spec = codec->spec;
@@ -1227,7 +1245,7 @@ static int generic_hdmi_build_jack(struc
 	if (err < 0)
 		return err;
 
-	hdmi_present_sense(codec, per_pin->pin_nid, &per_pin->sink_eld);
+	hdmi_present_sense(per_pin, false);
 	return 0;
 }
 
@@ -1278,6 +1296,8 @@ static int generic_hdmi_init(struct hda_
 				    AC_VERB_SET_UNSOLICITED_ENABLE,
 				    AC_USRSP_EN | pin_nid);
 
+		per_pin->codec = codec;
+		INIT_DELAYED_WORK(&per_pin->work, hdmi_repoll_eld);
 		snd_hda_eld_proc_new(codec, eld, pin_idx);
 	}
 	return 0;
@@ -1292,10 +1312,12 @@ static void generic_hdmi_free(struct hda
 		struct hdmi_spec_per_pin *per_pin = &spec->pins[pin_idx];
 		struct hdmi_eld *eld = &per_pin->sink_eld;
 
+		cancel_delayed_work(&per_pin->work);
 		snd_hda_eld_proc_free(codec, eld);
 	}
 	snd_hda_input_jack_free(codec);
 
+	flush_workqueue(codec->bus->workq);
 	kfree(spec);
 }
