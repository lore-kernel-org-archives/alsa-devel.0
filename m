From: Felix Homann <linuxaudio@showlabor.de>
Subject: [PATCH 2/5] Rename and export mixer_vol_tlv
Date: Mon, 23 Apr 2012 20:24:24 +0200
Message-ID: <1335205467-12650-3-git-send-email-linuxaudio@showlabor.de>
References: <1335205467-12650-1-git-send-email-linuxaudio@showlabor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1335205467-12650-1-git-send-email-linuxaudio@showlabor.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Felix Homann <linuxaudio@showlabor.de>, mark@pogo.org.uk
List-Id: alsa-devel@alsa-project.org

Rename mixer_vol_tlv to snd_usb_mixer_vol_tlv and export it to make
it reuseable in mixer_quirks.c.

Signed-off-by: Felix Homann <linuxaudio@showlabor.de>

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index c374c72..bb56f53 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -486,7 +486,7 @@ static int set_cur_mix_value(struct usb_mixer_elem_info *cval, int channel,
 /*
  * TLV callback for mixer volume controls
  */
-static int mixer_vol_tlv(struct snd_kcontrol *kcontrol, int op_flag,
+int snd_usb_mixer_vol_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 			 unsigned int size, unsigned int __user *_tlv)
 {
 	struct usb_mixer_elem_info *cval = kcontrol->private_data;
@@ -1158,7 +1158,7 @@ static void build_feature_ctl(struct mixer_build *state, void *raw_desc,
 		if (control == UAC_FU_VOLUME) {
 			check_mapped_dB(map, cval);
 			if (cval->dBmin < cval->dBmax || !cval->initialized) {
-				kctl->tlv.c = mixer_vol_tlv;
+				kctl->tlv.c = snd_usb_mixer_vol_tlv;
 				kctl->vd[0].access |= 
 					SNDRV_CTL_ELEM_ACCESS_TLV_READ |
 					SNDRV_CTL_ELEM_ACCESS_TLV_CALLBACK;
diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index 81b2d8a..a7f3d45 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -68,4 +68,7 @@ int snd_usb_mixer_activate(struct usb_mixer_interface *mixer);
 int snd_usb_mixer_add_control(struct usb_mixer_interface *mixer,
 			      struct snd_kcontrol *kctl);
 
+int snd_usb_mixer_vol_tlv(struct snd_kcontrol *kcontrol, int op_flag,
+			  unsigned int size, unsigned int __user *_tlv);
+
 #endif /* __USBMIXER_H */
-- 
1.7.5.4
