From: Benny Sjostrand <gorm@cucumelo.org>
Subject: [PATCH] cs46xx: SPDIF channel status more volume fixes
Date: Thu, 14 Nov 2002 21:02:10 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DD40142.8080209@cucumelo.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030303020808030605060905"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030303020808030605060905
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi!

Here's my final aproach for related to volume fixes. I hope that this 
possibly can solve the bass-problem. I've discovered that the volume was 
a little bit unbalanced in left vs. right channel,  however a human ear 
may not hear the difference maybe some audio equipment can react very 
weird on this, I've tested to change between Stereo 3Stereo or Dolbly 
Pro Logic modes on my receiver the sound is distributed very different. 
Well, this problem should be fixed with this patch, the level should be 
equal in left and right channel (depending on what you playing and your 
mixer settings).

About AC3, I've implemented the channel status as it's based on how it's 
done in ens1370.c. From what I can understand from the spec. it's only 
possible to set channel status byte 0, 1 and 3, the worst thing is that 
all bits are wrapped: byte0,bit0 -> csuv register, bit(32) byte 1 bit 
(8) -> csuv register bit(16)  I hope all weird byte and bits swappings 
are correct.
I've done some quick test with xine, AC3 still dont work forme, dont 
know exactly what's wrong. I would to have some stuff that could display 
the stream raw data the comes out from SPDIF interface .... :(

Summary:
- SPDIF channel status implementation (based on how it's done in ens1370.c)
- Removed the "AC3 Mode" control in mixer
- Final aproach for rewrite on the DAC and SPDIF input volume mechanism
- Change mixer control name on some mixer items "IEC 958" -> "IEC958", 
to  heave it in the
   same way like it's done in the rest of the ALSA code.

/Benny

--------------030303020808030605060905
Content-Type: text/plain;
 name="cs46xx.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cs46xx.patch"

diff --exclude=CVS -Naur alsa-kernel/include/cs46xx_dsp_spos.h ../cvs/alsa-kernel/include/cs46xx_dsp_spos.h
--- alsa-kernel/include/cs46xx_dsp_spos.h	Sun Nov 10 19:47:01 2002
+++ ../cvs/alsa-kernel/include/cs46xx_dsp_spos.h	Thu Nov 14 00:39:06 2002
@@ -63,7 +63,6 @@
 #define DSP_SPDIF_STATUS_OUTPUT_ENABLED 1
 #define DSP_SPDIF_STATUS_PLAYBACK_OPEN  2
 #define DSP_SPDIF_STATUS_HW_ENABLED     4
-#define DSP_SPDIF_STATUS_AC3_MODE       8
 
 struct _dsp_module_desc_t;
 
@@ -196,6 +195,10 @@
 	int spdif_status_in;
 	u16 spdif_input_volume_right;
 	u16 spdif_input_volume_left;
+	/* spdif channel status,
+	   left right and user validity bits */
+	int spdif_csuv_default;
+	int spdif_csuv_stream;
 
 	/* SPDIF input sample rate converter */
 	dsp_scb_descriptor_t * spdif_in_src;
diff --exclude=CVS -Naur alsa-kernel/pci/cs46xx/cs46xx_lib.c ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.c
--- alsa-kernel/pci/cs46xx/cs46xx_lib.c	Mon Nov 11 23:04:50 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.c	Thu Nov 14 20:30:35 2002
@@ -946,15 +946,15 @@
 	case SNDRV_PCM_TRIGGER_START:
 	case SNDRV_PCM_TRIGGER_RESUME:
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
+		/* magic value to unmute PCM stream  playback volume */
+		snd_cs46xx_poke(chip, (cpcm->pcm_channel->pcm_reader_scb->address + 
+				       SCBVolumeCtrl) << 2, 0x80007fff);
+
 		if (cpcm->pcm_channel->unlinked)
 			cs46xx_dsp_pcm_link(chip,cpcm->pcm_channel);
+
 		if (substream->runtime->periods != CS46XX_FRAGS)
 			snd_cs46xx_playback_transfer(substream, 0);
-
-		/* raise playback volume */
-		cs46xx_dsp_scb_set_volume (chip,cpcm->pcm_channel->pcm_reader_scb,
-					   chip->dsp_spos_instance->dac_volume_right,
-					   chip->dsp_spos_instance->dac_volume_left);
 #else
 		if (substream->runtime->periods != CS46XX_FRAGS)
 			snd_cs46xx_playback_transfer(substream, 0);
@@ -968,8 +968,9 @@
 	case SNDRV_PCM_TRIGGER_STOP:
 	case SNDRV_PCM_TRIGGER_SUSPEND:
 #ifdef CONFIG_SND_CS46XX_NEW_DSP
-		/* mute channel */
-		cs46xx_dsp_scb_set_volume (chip,cpcm->pcm_channel->pcm_reader_scb,0,0);
+		/* magic mute channel */
+		snd_cs46xx_poke(chip, (cpcm->pcm_channel->pcm_reader_scb->address + 
+				       SCBVolumeCtrl) << 2, 0xffffffff);
 
 		if (!cpcm->pcm_channel->unlinked)
 			cs46xx_dsp_pcm_unlink(chip,cpcm->pcm_channel);
@@ -1063,6 +1064,7 @@
 }
 #endif
 
+
 static int snd_cs46xx_playback_hw_params(snd_pcm_substream_t * substream,
 					 snd_pcm_hw_params_t * hw_params)
 {
@@ -1079,15 +1081,10 @@
 	down (&chip->spos_mutex);
 
 	snd_assert (cpcm->pcm_channel != NULL);
-
-	/* if IEC958 is opened in AC3 mode dont adjust SRCTask is not
-	   used so dont adjust sample rate */
-	if (cpcm->pcm_channel->pcm_channel_id != DSP_IEC958_CHANNEL ||
-	    !(chip->dsp_spos_instance->spdif_status_out & DSP_SPDIF_STATUS_AC3_MODE)) {
-		if (_cs46xx_adjust_sample_rate (chip,cpcm,sample_rate)) {
-			up (&chip->spos_mutex);
-			return -ENXIO;
-		}
+	
+	if (_cs46xx_adjust_sample_rate (chip,cpcm,sample_rate)) {
+		up (&chip->spos_mutex);
+		return -ENXIO;
 	}
 
 	if (cs46xx_dsp_pcm_channel_set_period (chip,cpcm->pcm_channel,period_size * 4)) {
@@ -2038,34 +2035,6 @@
 	return 0;
 }
 
-static int snd_cs46xx_iec958_ac3_mode_get(snd_kcontrol_t *kcontrol, 
-					  snd_ctl_elem_value_t *ucontrol) 
-{
-	cs46xx_t *chip = snd_kcontrol_chip(kcontrol);
-	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
-
-	if (!ins->spdif_status_out & DSP_SPDIF_STATUS_AC3_MODE) 
-		ucontrol->value.integer.value[0] = 1;
-	else
-		ucontrol->value.integer.value[0] = 0;
-
-	return 0;
-}
-
-static int snd_cs46xx_iec958_ac3_mode_put(snd_kcontrol_t *kcontrol, 
-                                      snd_ctl_elem_value_t *ucontrol) 
-{
-	cs46xx_t *chip = snd_kcontrol_chip(kcontrol);
-	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
-	int old = ins->spdif_status_out;
-
-	if (ucontrol->value.integer.value[0]) 
-		ins->spdif_status_out |= DSP_SPDIF_STATUS_AC3_MODE;
-	else
-		ins->spdif_status_out &= ~DSP_SPDIF_STATUS_AC3_MODE;
-
-	return (old != ins->spdif_status_out);
-}
 
 static int snd_cs46xx_pcm_capture_put(snd_kcontrol_t *kcontrol, 
                                       snd_ctl_elem_value_t *ucontrol)
@@ -2127,6 +2096,110 @@
 	return (val1 != snd_cs46xx_peekBA0(chip, BA0_EGPIODR));
 }
 
+
+static int snd_cs46xx_spdif_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
+	uinfo->count = 1;
+	return 0;
+}
+
+static int snd_cs46xx_spdif_default_get(snd_kcontrol_t * kcontrol,
+					snd_ctl_elem_value_t * ucontrol)
+{
+	cs46xx_t *chip = snd_kcontrol_chip(kcontrol);
+	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
+
+	down (&chip->spos_mutex);
+	ucontrol->value.iec958.status[0] = _wrap_all_bits((ins->spdif_csuv_default >> 24) & 0xff);
+	ucontrol->value.iec958.status[1] = _wrap_all_bits((ins->spdif_csuv_default >> 16) & 0xff);
+	ucontrol->value.iec958.status[2] = 0;
+	ucontrol->value.iec958.status[3] = _wrap_all_bits((ins->spdif_csuv_default) & 0xff);
+	up (&chip->spos_mutex);
+
+	return 0;
+}
+
+static int snd_cs46xx_spdif_default_put(snd_kcontrol_t * kcontrol,
+					snd_ctl_elem_value_t * ucontrol)
+{
+	cs46xx_t * chip = snd_kcontrol_chip(kcontrol);
+	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
+	unsigned int val;
+	int change;
+
+	down (&chip->spos_mutex);
+	val = _wrap_all_bits(((u32)ucontrol->value.iec958.status[0] << 24)) |
+	      _wrap_all_bits(((u32)ucontrol->value.iec958.status[2] << 16)) |
+	      _wrap_all_bits( (u32)ucontrol->value.iec958.status[3])  |
+		/* left and right validity bit */
+		(1 << 13) | (1 << 12);
+
+
+	change = ins->spdif_csuv_default != val;
+	ins->spdif_csuv_default = val;
+
+	if ( !(ins->spdif_status_out & DSP_SPDIF_STATUS_PLAYBACK_OPEN) )
+		cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV,val);
+
+	up (&chip->spos_mutex);
+
+	return change;
+}
+
+static int snd_cs46xx_spdif_mask_get(snd_kcontrol_t * kcontrol,
+				     snd_ctl_elem_value_t * ucontrol)
+{
+	ucontrol->value.iec958.status[0] = 0xff;
+	ucontrol->value.iec958.status[1] = 0xff;
+	ucontrol->value.iec958.status[2] = 0x00;
+	ucontrol->value.iec958.status[3] = 0xff;
+	return 0;
+}
+
+static int snd_cs46xx_spdif_stream_get(snd_kcontrol_t * kcontrol,
+                                         snd_ctl_elem_value_t * ucontrol)
+{
+	cs46xx_t *chip = snd_kcontrol_chip(kcontrol);
+	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
+
+	down (&chip->spos_mutex);
+	ucontrol->value.iec958.status[0] = _wrap_all_bits((ins->spdif_csuv_stream >> 24) & 0xff);
+	ucontrol->value.iec958.status[1] = _wrap_all_bits((ins->spdif_csuv_stream >> 16) & 0xff);
+	ucontrol->value.iec958.status[2] = 0;
+	ucontrol->value.iec958.status[3] = _wrap_all_bits((ins->spdif_csuv_stream) & 0xff);
+	up (&chip->spos_mutex);
+
+	return 0;
+}
+
+static int snd_cs46xx_spdif_stream_put(snd_kcontrol_t * kcontrol,
+                                        snd_ctl_elem_value_t * ucontrol)
+{
+	cs46xx_t * chip = snd_kcontrol_chip(kcontrol);
+	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
+	unsigned int val;
+	int change;
+
+	down (&chip->spos_mutex);
+	val = _wrap_all_bits(((u32)ucontrol->value.iec958.status[0] << 24)) |
+	      _wrap_all_bits(((u32)ucontrol->value.iec958.status[1] << 16)) |
+	      _wrap_all_bits( (u32)ucontrol->value.iec958.status[3]) |
+		/* left and right validity bit */
+		(1 << 13) | (1 << 12);
+
+
+	change = ins->spdif_csuv_stream != val;
+	ins->spdif_csuv_stream = val;
+
+	if ( ins->spdif_status_out & DSP_SPDIF_STATUS_PLAYBACK_OPEN )
+		cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV,val);
+
+	up (&chip->spos_mutex);
+
+	return change;
+}
+
 #endif /* CONFIG_SND_CS46XX_NEW_DSP */
 
 #ifdef CONFIG_SND_CS46XX_DEBUG_GPIO
@@ -2238,7 +2311,7 @@
 },
 {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "IEC 958 Output Switch",
+	.name = "IEC958 Output Switch",
 	.info = snd_mixer_boolean_info,
 	.get = snd_cs46xx_iec958_get,
 	.put = snd_cs46xx_iec958_put,
@@ -2246,14 +2319,7 @@
 },
 {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "IEC 958 AC3 Mode Switch",
-	.info = snd_mixer_boolean_info,
-	.get = snd_cs46xx_iec958_ac3_mode_get,
-	.put = snd_cs46xx_iec958_ac3_mode_put,
-},
-{
-	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "IEC 958 Input Switch",
+	.name = "IEC958 Input Switch",
 	.info = snd_mixer_boolean_info,
 	.get = snd_cs46xx_iec958_get,
 	.put = snd_cs46xx_iec958_put,
@@ -2261,12 +2327,34 @@
 },
 {
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.name = "IEC 958 Input Volume",
+	.name = "IEC958 Input Volume",
 	.info = snd_cs46xx_vol_info,
 	.get = snd_cs46xx_vol_iec958_get,
 	.put = snd_cs46xx_vol_iec958_put,
 	.private_value = (ASYNCRX_SCB_ADDR + 0xE) << 2,
 },
+{
+	.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+	.name =  SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT),
+	.info =	 snd_cs46xx_spdif_info,
+	.get =	 snd_cs46xx_spdif_default_get,
+	.put =   snd_cs46xx_spdif_default_put,
+},
+{
+	.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+	.name =	 SNDRV_CTL_NAME_IEC958("",PLAYBACK,MASK),
+	.info =	 snd_cs46xx_spdif_info,
+        .get =	 snd_cs46xx_spdif_mask_get,
+	.access = SNDRV_CTL_ELEM_ACCESS_READ
+},
+{
+	.iface = SNDRV_CTL_ELEM_IFACE_PCM,
+	.name =	 SNDRV_CTL_NAME_IEC958("",PLAYBACK,PCM_STREAM),
+	.info =	 snd_cs46xx_spdif_info,
+	.get =	 snd_cs46xx_spdif_stream_get,
+	.put =	 snd_cs46xx_spdif_stream_put
+},
+
 #endif
 #ifdef CONFIG_SND_CS46XX_DEBUG_GPIO
 {
diff --exclude=CVS -Naur alsa-kernel/pci/cs46xx/cs46xx_lib.h ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.h
--- alsa-kernel/pci/cs46xx/cs46xx_lib.h	Sun Nov 10 19:47:01 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/cs46xx_lib.h	Wed Nov 13 22:51:21 2002
@@ -217,6 +217,6 @@
 							       int period_size);
 int                        cs46xx_dsp_pcm_ostream_set_period (cs46xx_t * chip,
 							      int period_size);
-int                        cs46xx_dsp_set_dac_volume (cs46xx_t * chip,u16 right,u16 left);
-int                        cs46xx_dsp_set_iec958_volume (cs46xx_t * chip,u16 right,u16 left);
+int                        cs46xx_dsp_set_dac_volume (cs46xx_t * chip,u16 left,u16 right);
+int                        cs46xx_dsp_set_iec958_volume (cs46xx_t * chip,u16 left,u16 right);
 #endif /* __CS46XX_LIB_H__ */
diff --exclude=CVS -Naur alsa-kernel/pci/cs46xx/dsp_spos.c ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.c
--- alsa-kernel/pci/cs46xx/dsp_spos.c	Sun Nov 10 19:47:01 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.c	Thu Nov 14 19:59:59 2002
@@ -31,6 +31,7 @@
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/info.h>
+#include <sound/asoundef.h>
 #include <sound/cs46xx.h>
 
 #include "cs46xx_lib.h"
@@ -262,6 +263,15 @@
 	ins->spdif_input_volume_right = 0x8000;
 	ins->spdif_input_volume_left = 0x8000;
 
+	/* set left and right validity bits and
+	   default channel status */
+	ins->spdif_csuv_default = 
+		ins->spdif_csuv_stream =  
+	 /* byte 0 */  (_wrap_all_bits(  (SNDRV_PCM_DEFAULT_CON_SPDIF        & 0xff)) << 24) |
+	 /* byte 1 */  (_wrap_all_bits( ((SNDRV_PCM_DEFAULT_CON_SPDIF >> 16) & 0xff)) << 16) |
+	 /* byte 3 */   _wrap_all_bits(  (SNDRV_PCM_DEFAULT_CON_SPDIF >> 24) & 0xff) |
+	 /* left and right validity bits */ (1 << 13) | (1 << 12);
+
 	return ins;
 }
 
@@ -1549,7 +1559,7 @@
 	cs46xx_poke_via_dsp (chip,SP_SPDOUT_CONTROL, 0x80000000);
 
 	/* right and left validate bit */
-	cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV, 0x00000000 | (1 << 13) | (1 << 12));
+	cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV, ins->spdif_csuv_default);
 
 	/* monitor state */
 	ins->spdif_status_out |= DSP_SPDIF_STATUS_HW_ENABLED;
@@ -1587,11 +1597,6 @@
 	cs46xx_poke_via_dsp (chip,SP_SPDIN_FIFOPTR, 0x0);
 	cs46xx_src_link(chip,ins->spdif_in_src);
 
-	/* restore SPDIF input volume */
-	cs46xx_dsp_scb_set_volume (chip,ins->spdif_in_src,
-				   ins->spdif_input_volume_right,
-				   ins->spdif_input_volume_left);
-
 	spin_unlock_irq(&chip->reg_lock);
 
 	/* set SPDIF input sample rate and unmute
@@ -1725,39 +1730,47 @@
 	return 0;
 }
 
-int cs46xx_dsp_set_dac_volume (cs46xx_t * chip,u16 right,u16 left)
+int cs46xx_dsp_set_dac_volume (cs46xx_t * chip,u16 left,u16 right)
 {
-	int i;
 	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
+	dsp_scb_descriptor_t * scb; 
 
 	down(&chip->spos_mutex);
+	
+	/* main output */
+	scb = ins->master_mix_scb->sub_list_ptr;
+	while (scb != ins->the_null_scb) {
+		cs46xx_dsp_scb_set_volume (chip,scb,left,right);
+		scb = scb->next_scb_ptr;
+	}
 
-	ins->dac_volume_right = right;
-	ins->dac_volume_left = left;
-
-	for (i = 0; i < DSP_MAX_PCM_CHANNELS; ++i) {
-		if (ins->pcm_channels[i].active &&
-		    !ins->pcm_channels[i].unlinked) {
-			cs46xx_dsp_scb_set_volume (chip,ins->pcm_channels[i].pcm_reader_scb,
-						   right,left);
-			
-		}
+	/* rear output */
+	scb = ins->rear_mix_scb->sub_list_ptr;
+	while (scb != ins->the_null_scb) {
+		cs46xx_dsp_scb_set_volume (chip,scb,left,right);
+		scb = scb->next_scb_ptr;
 	}
 
+	ins->dac_volume_left = left;
+	ins->dac_volume_right = right;
+
 	up(&chip->spos_mutex);
 
 	return 0;
 }
 
-int cs46xx_dsp_set_iec958_volume (cs46xx_t * chip,u16 right,u16 left) {
+int cs46xx_dsp_set_iec958_volume (cs46xx_t * chip,u16 left,u16 right) {
 	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
 
 	down(&chip->spos_mutex);
-	cs46xx_dsp_scb_set_volume (chip,ins->spdif_in_src,
-				   right,left);
 
-	ins->spdif_input_volume_right = right;
+	if (ins->asynch_rx_scb != NULL)
+		cs46xx_dsp_scb_set_volume (chip,ins->asynch_rx_scb,
+					   left,right);
+
 	ins->spdif_input_volume_left = left;
+	ins->spdif_input_volume_right = right;
+
 	up(&chip->spos_mutex);
 
 	return 0;
diff --exclude=CVS -Naur alsa-kernel/pci/cs46xx/dsp_spos.h ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.h
--- alsa-kernel/pci/cs46xx/dsp_spos.h	Sun Nov 10 19:47:01 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/dsp_spos.h	Thu Nov 14 09:36:26 2002
@@ -185,6 +185,25 @@
 #define SP_SPDOUT_CONTROL 0x804D
 #define SP_SPDOUT_CSUV    0x808E
 
+static inline u8 _wrap_all_bits (u8 val) {
+	u8 wrapped;
+	
+	/* wrap all 8 bits */
+	wrapped = 
+		((val & 0x1 ) << 7) |
+		((val & 0x2 ) << 5) |
+		((val & 0x4 ) << 3) |
+		((val & 0x8 ) << 1) |
+		((val & 0x10) >> 1) |
+		((val & 0x20) >> 3) |
+		((val & 0x40) >> 5) |
+		((val & 0x80) >> 6);
+
+	return wrapped;
+
+}
+
+
 static inline void cs46xx_dsp_spos_update_scb (cs46xx_t * chip,dsp_scb_descriptor_t * scb) 
 {
 	/* update nextSCB and subListPtr in SCB */
@@ -195,12 +214,11 @@
 }
 
 static inline void cs46xx_dsp_scb_set_volume (cs46xx_t * chip,dsp_scb_descriptor_t * scb,
-					      u16 right,u16 left) {
-	unsigned int val = ((0xffff - right) << 16 | (0xffff - left));	
+					      u16 left,u16 right) {
+	unsigned int val = ((0xffff - left) << 16 | (0xffff - right));
 
 	snd_cs46xx_poke(chip, (scb->address + SCBVolumeCtrl) << 2, val);
 	snd_cs46xx_poke(chip, (scb->address + SCBVolumeCtrl + 1) << 2, val);
 }
-
 #endif /* __DSP_SPOS_H__ */
 #endif /* CONFIG_SND_CS46XX_NEW_DSP  */
diff --exclude=CVS -Naur alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c ../cvs/alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c
--- alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c	Sun Nov 10 19:47:01 2002
+++ ../cvs/alsa-kernel/pci/cs46xx/dsp_spos_scb_lib.c	Thu Nov 14 09:08:14 2002
@@ -603,8 +603,8 @@
 		src_buffer_addr << 0x10,
 		0x04000000,
 		{ 
-			0x8000,0x8000,
-			0xffff,0xffff
+			0xffff - ins->dac_volume_right,0xffff - ins->dac_volume_left,
+			0xffff - ins->dac_volume_right,0xffff - ins->dac_volume_left
 		}
 	};
 
@@ -658,7 +658,7 @@
 		/* D */ 0,
 		{
 			/* E */ 0x8000,0x8000,
-			/* F */ 0xffff,0xffff
+			/* F */ 0x8000,0x8000
 		}
 	};
 
@@ -830,7 +830,7 @@
 		0,0x2aab,           /* Const 1/3 */
     
 		{
-			0,                /* Define the unused elements */
+			0,         /* Define the unused elements */
 			0,
 			0
 		},
@@ -846,7 +846,7 @@
 		   rate etc  */
 		0x18000000,                     /* Phi increment for approx 32k operation */
 		0x8000,0x8000,                  /* Volume controls are unused at this time */
-		0xffff,0xffff
+		0x8000,0x8000
 	};
   
 	scb = cs46xx_dsp_create_generic_scb(chip,scb_name,(u32 *)&asynch_fg_tx_scb,
@@ -864,7 +864,7 @@
                                    dsp_scb_descriptor_t * parent_scb,
                                    int scb_child_type)
 {
-
+	dsp_spos_instance_t * ins = chip->dsp_spos_instance;
 	dsp_scb_descriptor_t * scb;
 
 	asynch_fg_rx_scb_t asynch_fg_rx_scb = {
@@ -893,9 +893,9 @@
 		   rate etc  */
 		0x18000000,         
 
-		/* Mute stream */
-		0x8000,0x8000,       
-		0xffff,0xffff
+		/* Set IEC958 input volume */
+		0xffff - ins->spdif_input_volume_right,0xffff - ins->spdif_input_volume_left,
+		0xffff - ins->spdif_input_volume_right,0xffff - ins->spdif_input_volume_left,
 	};
 
 	scb = cs46xx_dsp_create_generic_scb(chip,scb_name,(u32 *)&asynch_fg_rx_scb,
@@ -1116,11 +1116,13 @@
 	case DSP_IEC958_CHANNEL:
 		snd_assert (ins->asynch_tx_scb != NULL, return NULL);
 		mixer_scb = ins->asynch_tx_scb;
+#if 0
 		if (ins->spdif_status_out & DSP_SPDIF_STATUS_AC3_MODE) {
 			snd_printdd ("IEC958 opened in AC3 mode\n");
 			/*src_scb = ins->asynch_tx_scb;
 			  ins->asynch_tx_scb->ref_count ++;*/
 		}
+#endif
 		break;
 	default:
 		snd_assert (0);
@@ -1198,9 +1200,7 @@
 			return NULL;
 		}
 
-		if (pcm_channel_id != DSP_IEC958_CHANNEL ||
-		    !(ins->spdif_status_out & DSP_SPDIF_STATUS_AC3_MODE))
-			cs46xx_dsp_set_src_sample_rate(chip,src_scb,sample_rate);
+		cs46xx_dsp_set_src_sample_rate(chip,src_scb,sample_rate);
 
 		ins->nsrc_scb ++;
 	} 
@@ -1461,17 +1461,11 @@
 	 */
 	spin_lock_irqsave(&chip->reg_lock, flags);
 
-	/* mute SCB */
-	/* cs46xx_dsp_scb_set_volume (chip,src,0,0); */
-
 	snd_cs46xx_poke(chip, (src->address + SRCCorPerGof) << 2,
 	  ((correctionPerSec << 16) & 0xFFFF0000) | (correctionPerGOF & 0xFFFF));
 
 	snd_cs46xx_poke(chip, (src->address + SRCPhiIncr6Int26Frac) << 2, phiIncr);
 
-	/* raise volume */
-	/* cs46xx_dsp_scb_set_volume (chip,src,0x7fff,0x7fff); */
-	
 	spin_unlock_irqrestore(&chip->reg_lock, flags);
 }
 
@@ -1641,9 +1635,8 @@
 								SCB_ON_PARENT_NEXT_SCB);
 
 
-	if (ins->spdif_status_out & DSP_SPDIF_STATUS_AC3_MODE) 
-		/* set left (13), right validity bit (12) , and non-audio(1) and profsional bit (0) */
-		cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV, 0x00000000 | (1 << 13) | (1 << 12) | (1 << 1) | 1);
+	/* set spdif channel status value for streaming */
+	cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV, ins->spdif_csuv_stream);
 
 	ins->spdif_status_out  |= DSP_SPDIF_STATUS_PLAYBACK_OPEN;
 
@@ -1659,7 +1652,7 @@
 	ins->spdif_status_out  &= ~DSP_SPDIF_STATUS_PLAYBACK_OPEN;
 
 	/* restore settings */
-	cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV, 0x00000000 | (1 << 13) | (1 << 12));
+	cs46xx_poke_via_dsp (chip,SP_SPDOUT_CSUV, ins->spdif_csuv_default);
 	
 	/* deallocate stuff */
 	cs46xx_dsp_remove_scb (chip,ins->asynch_tx_scb);

--------------030303020808030605060905--



-------------------------------------------------------
This sf.net email is sponsored by: To learn the basics of securing 
your web site with SSL, click here to get a FREE TRIAL of a Thawte 
Server Certificate: http://www.gothawte.com/rd524.html
