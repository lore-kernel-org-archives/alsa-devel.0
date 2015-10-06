From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 15/18] ALSA: hda: move patch_sigmatel to use
	hdac helpers
Date: Tue,  6 Oct 2015 16:07:52 +0100
Message-ID: <1444144075-28963-16-git-send-email-vinod.koul@intel.com>
References: <1444144075-28963-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by alsa0.perex.cz (Postfix) with ESMTP id 6D68B2657B0
 for <alsa-devel@alsa-project.org>; Tue,  6 Oct 2015 17:09:53 +0200 (CEST)
In-Reply-To: <1444144075-28963-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, tiwai@suse.de, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

Move patch_sigmatel to use newly moved snd_hdac_read/write_codec()
APIs

This was done using coccinelle script

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 sound/pci/hda/patch_sigmatel.c | 78 +++++++++++++++++++++---------------------
 1 file changed, 39 insertions(+), 39 deletions(-)

diff --git a/sound/pci/hda/patch_sigmatel.c b/sound/pci/hda/patch_sigmatel.c
index 9d947aef2c8b..0fc42761a5d2 100644
--- a/sound/pci/hda/patch_sigmatel.c
+++ b/sound/pci/hda/patch_sigmatel.c
@@ -279,13 +279,13 @@ static void stac_capture_pcm_hook(struct hda_pcm_stream *hinfo,
 	switch (action) {
 	case HDA_GEN_PCM_ACT_OPEN:
 		msleep(40);
-		snd_hda_codec_write(codec, hinfo->nid, 0,
-				    AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
+		snd_hdac_codec_write(&codec->core, hinfo->nid, 0,
+				     AC_VERB_SET_POWER_STATE, AC_PWRST_D0);
 		spec->active_adcs |= (1 << idx);
 		break;
 	case HDA_GEN_PCM_ACT_CLOSE:
-		snd_hda_codec_write(codec, hinfo->nid, 0,
-				    AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
+		snd_hdac_codec_write(&codec->core, hinfo->nid, 0,
+				     AC_VERB_SET_POWER_STATE, AC_PWRST_D3);
 		spec->active_adcs &= ~(1 << idx);
 		break;
 	}
@@ -304,30 +304,30 @@ static void stac_gpio_set(struct hda_codec *codec, unsigned int mask,
 
 	codec_dbg(codec, "%s msk %x dir %x gpio %x\n", __func__, mask, dir_mask, data);
 
-	gpiostate = snd_hda_codec_read(codec, fg, 0,
-				       AC_VERB_GET_GPIO_DATA, 0);
+	gpiostate = snd_hdac_codec_read(&codec->core, fg, 0,
+					AC_VERB_GET_GPIO_DATA, 0);
 	gpiostate = (gpiostate & ~dir_mask) | (data & dir_mask);
 
-	gpiomask = snd_hda_codec_read(codec, fg, 0,
-				      AC_VERB_GET_GPIO_MASK, 0);
+	gpiomask = snd_hdac_codec_read(&codec->core, fg, 0,
+				       AC_VERB_GET_GPIO_MASK, 0);
 	gpiomask |= mask;
 
-	gpiodir = snd_hda_codec_read(codec, fg, 0,
-				     AC_VERB_GET_GPIO_DIRECTION, 0);
+	gpiodir = snd_hdac_codec_read(&codec->core, fg, 0,
+				      AC_VERB_GET_GPIO_DIRECTION, 0);
 	gpiodir |= dir_mask;
 
 	/* Configure GPIOx as CMOS */
-	snd_hda_codec_write(codec, fg, 0, 0x7e7, 0);
+	snd_hdac_codec_write(&codec->core, fg, 0, 0x7e7, 0);
 
-	snd_hda_codec_write(codec, fg, 0,
-			    AC_VERB_SET_GPIO_MASK, gpiomask);
-	snd_hda_codec_read(codec, fg, 0,
-			   AC_VERB_SET_GPIO_DIRECTION, gpiodir); /* sync */
+	snd_hdac_codec_write(&codec->core, fg, 0, AC_VERB_SET_GPIO_MASK,
+			     gpiomask);
+	snd_hdac_codec_read(&codec->core, fg, 0, AC_VERB_SET_GPIO_DIRECTION,
+			    gpiodir); /* sync */
 
 	msleep(1);
 
-	snd_hda_codec_read(codec, fg, 0,
-			   AC_VERB_SET_GPIO_DATA, gpiostate); /* sync */
+	snd_hdac_codec_read(&codec->core, fg, 0, AC_VERB_SET_GPIO_DATA,
+			    gpiostate); /* sync */
 }
 
 /* hook for controlling mic-mute LED GPIO */
@@ -366,8 +366,8 @@ static int stac_vrefout_set(struct hda_codec *codec,
 	int error, pinctl;
 
 	codec_dbg(codec, "%s, nid %x ctl %x\n", __func__, nid, new_vref);
-	pinctl = snd_hda_codec_read(codec, nid, 0,
-				AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
+	pinctl = snd_hdac_codec_read(&codec->core, nid, 0,
+				     AC_VERB_GET_PIN_WIDGET_CONTROL, 0);
 
 	if (pinctl < 0)
 		return pinctl;
@@ -434,7 +434,7 @@ static void stac_update_outputs(struct hda_codec *codec)
 
 	if (spec->gpio_mute)
 		spec->gen.master_mute =
-			!(snd_hda_codec_read(codec, codec->core.afg, 0,
+			!(snd_hdac_codec_read(&codec->core, codec->core.afg, 0,
 				AC_VERB_GET_GPIO_DATA, 0) & spec->gpio_mute);
 
 	snd_hda_gen_update_outputs(codec);
@@ -478,8 +478,8 @@ static void stac_toggle_power_map(struct hda_codec *codec, hda_nid_t nid,
 	if (val != spec->power_map_bits) {
 		spec->power_map_bits = val;
 		if (do_write)
-			snd_hda_codec_write(codec, codec->core.afg, 0,
-					    AC_VERB_IDT_SET_POWER_MAP, val);
+			snd_hdac_codec_write(&codec->core, codec->core.afg, 0,
+					     AC_VERB_IDT_SET_POWER_MAP, val);
 	}
 }
 
@@ -510,9 +510,8 @@ static void jack_update_power(struct hda_codec *codec,
 				      false);
 	}
 
-	snd_hda_codec_write(codec, codec->core.afg, 0,
-			    AC_VERB_IDT_SET_POWER_MAP,
-			    spec->power_map_bits);
+	snd_hdac_codec_write(&codec->core, codec->core.afg, 0,
+			     AC_VERB_IDT_SET_POWER_MAP, spec->power_map_bits);
 }
 
 static void stac_vref_event(struct hda_codec *codec,
@@ -520,11 +519,11 @@ static void stac_vref_event(struct hda_codec *codec,
 {
 	unsigned int data;
 
-	data = snd_hda_codec_read(codec, codec->core.afg, 0,
-				  AC_VERB_GET_GPIO_DATA, 0);
+	data = snd_hdac_codec_read(&codec->core, codec->core.afg, 0,
+				   AC_VERB_GET_GPIO_DATA, 0);
 	/* toggle VREF state based on GPIOx status */
-	snd_hda_codec_write(codec, codec->core.afg, 0, 0x7e0,
-			    !!(data & (1 << event->private_data)));
+	snd_hdac_codec_write(&codec->core, codec->core.afg, 0, 0x7e0,
+			     !!(data & (1 << event->private_data)));
 }
 
 /* initialize the power map and enable the power event to jacks that
@@ -625,8 +624,8 @@ static int stac_aloopback_put(struct snd_kcontrol *kcontrol,
 	/* Only return the bits defined by the shift value of the
 	 * first two bytes of the mask
 	 */
-	dac_mode = snd_hda_codec_read(codec, codec->core.afg, 0,
-				      kcontrol->private_value & 0xFFFF, 0x0);
+	dac_mode = snd_hdac_codec_read(&codec->core, codec->core.afg, 0,
+				       kcontrol->private_value & 0xFFFF, 0x0);
 	dac_mode >>= spec->aloopback_shift;
 
 	if (spec->aloopback & idx_val) {
@@ -4331,18 +4330,19 @@ static int stac_init(struct hda_codec *codec)
 
 	/* sync the power-map */
 	if (spec->num_pwrs)
-		snd_hda_codec_write(codec, codec->core.afg, 0,
-				    AC_VERB_IDT_SET_POWER_MAP,
-				    spec->power_map_bits);
+		snd_hdac_codec_write(&codec->core, codec->core.afg, 0,
+				     AC_VERB_IDT_SET_POWER_MAP,
+				     spec->power_map_bits);
 
 	/* power down inactive ADCs */
 	if (spec->powerdown_adcs) {
 		for (i = 0; i < spec->gen.num_all_adcs; i++) {
 			if (spec->active_adcs & (1 << i))
 				continue;
-			snd_hda_codec_write(codec, spec->gen.all_adcs[i], 0,
-					    AC_VERB_SET_POWER_STATE,
-					    AC_PWRST_D3);
+			snd_hdac_codec_write(&codec->core,
+					     spec->gen.all_adcs[i], 0,
+					     AC_VERB_SET_POWER_STATE,
+					     AC_PWRST_D3);
 		}
 	}
 
@@ -4369,7 +4369,7 @@ static void stac92hd_proc_hook(struct snd_info_buffer *buffer,
 {
 	if (nid == codec->core.afg)
 		snd_iprintf(buffer, "Power-Map: 0x%02x\n", 
-			    snd_hda_codec_read(codec, nid, 0,
+			    snd_hdac_codec_read(&codec->core, nid, 0,
 					       AC_VERB_IDT_GET_POWER_MAP, 0));
 }
 
@@ -4378,7 +4378,7 @@ static void analog_loop_proc_hook(struct snd_info_buffer *buffer,
 				  unsigned int verb)
 {
 	snd_iprintf(buffer, "Analog Loopback: 0x%02x\n",
-		    snd_hda_codec_read(codec, codec->core.afg, 0, verb, 0));
+		    snd_hdac_codec_read(&codec->core, codec->core.afg, 0, verb, 0));
 }
 
 /* stac92hd71bxx, stac92hd73xx */
-- 
2.4.3
