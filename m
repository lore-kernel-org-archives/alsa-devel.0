From: Wu Fengguang <fengguang.wu@intel.com>
Subject: Re: [PATCH] hda: add IbexPeak/Clarkdale HDMI
	model	with static cvt/pin number
Date: Sun, 2 Aug 2009 11:39:57 +0800
Message-ID: <20090802033957.GA11657@localhost>
References: <20090801122700.GA17330@localhost>
	<alpine.LNX.2.00.0908011515340.21927@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [143.182.124.37])
	by alsa0.perex.cz (Postfix) with ESMTP id 292602437F
	for <alsa-devel@alsa-project.org>;
	Sun,  2 Aug 2009 05:40:11 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.LNX.2.00.0908011515340.21927@eeebox2.perex-int.cz>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jaroslav Kysela <perex@perex.cz>
Cc: Takashi Iwai <tiwai@suse.de>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Sat, Aug 01, 2009 at 09:17:10PM +0800, Jaroslav Kysela wrote:
> On Sat, 1 Aug 2009, Wu Fengguang wrote:
> 
> > -#define CVT_NID		0x02	/* audio converter */
> > -#define PIN_NID		0x03	/* HDMI output pin */
> > +static hda_nid_t cvt_nid;	/* audio converter */
> > +static hda_nid_t pin_nid;	/* HDMI output pin */
> 
> I don't like to use static variables here. I would recommend to use a 
> runtime structure to store these values.

Good idea. But let's keep this first step simple?  I'll do the
conversion in subsequent patches. I'd like to add some hda_hdmi struct
into the hda_codec structure. Like this one. What do you think?

Thanks,
Fengguang

---
 sound/pci/hda/hda_codec.h |   21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--- sound-2.6.orig/sound/pci/hda/hda_codec.h
+++ sound-2.6/sound/pci/hda/hda_codec.h
@@ -555,6 +555,7 @@ static inline unsigned int snd_array_ind
 
 struct hda_bus;
 struct hda_beep;
+struct hda_hdmi;
 struct hda_codec;
 struct hda_pcm;
 struct hda_pcm_stream;
@@ -788,6 +789,9 @@ struct hda_codec {
 	unsigned short spdif_ctls;	/* SPDIF control bits */
 	unsigned int spdif_in_enable;	/* SPDIF input enable? */
 	hda_nid_t *slave_dig_outs; /* optional digital out slave widgets */
+
+	struct hda_hdmi	hdmi;
+
 	struct snd_array init_pins;	/* initial (BIOS) pin configurations */
 	struct snd_array driver_pins;	/* pin configs set by codec parser */
 
@@ -823,6 +827,23 @@ enum {
 	HDA_INPUT, HDA_OUTPUT
 };
 
+/*
+ * The HDMI/DisplayPort configuration can be highly dynamic. A graphics device
+ * could support two independent pipes, each of them can be connected to one or
+ * more monitors (DVI, HDMI or DisplayPort).
+ *
+ * The HDA correspondence of pipes/monitors are converter/pin nodes.
+ */
+#define HDA_HDMI_CVTS	2
+#define HDA_HDMI_PINS	3
+struct hda_hdmi {
+	int num_cvts;
+	hda_nid_t cvt[HDA_HDMI_CVTS];
+	int num_pins;
+	hda_nid_t pin[HDA_HDMI_PINS];
+	/* the converter each pin connects to */
+	hda_nid_t pin_cvt[HDA_HDMI_PINS];
+};
 
 /*
  * constructors
