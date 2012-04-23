From: Felix Homann <linuxaudio@showlabor.de>
Subject: [PATCH 2/3] Add TLV to M-Audio volume controls
Date: Mon, 23 Apr 2012 11:16:07 +0200
Message-ID: <1335172568-13502-3-git-send-email-linuxaudio@showlabor.de>
References: <1335172568-13502-1-git-send-email-linuxaudio@showlabor.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1335172568-13502-1-git-send-email-linuxaudio@showlabor.de>
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


Signed-off-by: Felix Homann <linuxaudio@showlabor.de>

diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index c374c72..596744f 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -501,6 +501,11 @@ static int mixer_vol_tlv(struct snd_kcontrol *kcontrol, int op_flag,
 	return 0;
 }
 
+/* This symbol is exported in order to reuse it in mixer_quirks.c */
+int (*snd_usb_mixer_vol_tlv)(struct snd_kcontrol *kcontrol, int op_flag,
+			unsigned int size,
+			unsigned int __user *_tlv) = &mixer_vol_tlv;
+
 /*
  * parser routines begin here...
  */
diff --git a/sound/usb/mixer_quirks.c b/sound/usb/mixer_quirks.c
index e486c51..5b52275 100644
--- a/sound/usb/mixer_quirks.c
+++ b/sound/usb/mixer_quirks.c
@@ -41,6 +41,8 @@
 #include "helper.h"
 
 extern struct snd_kcontrol_new *snd_usb_feature_unit_ctl;
+extern int (*snd_usb_mixer_vol_tlv)(struct snd_kcontrol *kcontrol, int op_flag,
+				unsigned int size, unsigned int __user *_tlv);
 
 /* private_free callback */
 static void usb_mixer_elem_free(struct snd_kcontrol *kctl)
@@ -594,7 +596,7 @@ static int snd_maudio_ftu_create_volume_ctls(struct usb_mixer_interface *mixer)
 				in  + 1, out + 1);
 			err = snd_create_std_mono_ctl(mixer, id, control,
 							cmask, val_type, name,
-							NULL);
+							snd_usb_mixer_vol_tlv);
 			if (err < 0)
 				return err;
 		}
@@ -605,7 +607,7 @@ static int snd_maudio_ftu_create_volume_ctls(struct usb_mixer_interface *mixer)
 				in - 7, out + 1);
 			err = snd_create_std_mono_ctl(mixer, id, control,
 							cmask, val_type, name,
-							NULL);
+							snd_usb_mixer_vol_tlv);
 			if (err < 0)
 				return err;
 		}
-- 
1.7.5.4
