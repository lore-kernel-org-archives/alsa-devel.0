From: Clemens Ladisch <clemens@ladisch.de>
Subject: [PATCH] trident: reduce stack usage
Date: Wed, 02 Jul 2003 17:17:08 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0307021713510.4037-100000@studcom.urz.uni-halle.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
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


reduce stack usage


Index: alsa-kernel/pci/trident/trident_main.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/trident/trident_main.c,v
retrieving revision 1.45
diff -u -r1.45 trident_main.c
--- alsa-kernel/pci/trident/trident_main.c	21 Jun 2003 07:52:38 -0000	1.45
+++ alsa-kernel/pci/trident/trident_main.c	3 Jul 2003 15:09:33 -0000
@@ -2958,10 +2958,12 @@
 	ac97_t _ac97;
 	snd_card_t * card = trident->card;
 	snd_kcontrol_t *kctl;
-	snd_ctl_elem_value_t uctl;
+	snd_ctl_elem_value_t *uctl;
 	int idx, err, retries = 2;

-	memset(&uctl, 0, sizeof(uctl));
+	uctl = (snd_ctl_elem_value_t *)snd_kcalloc(sizeof(*uctl), GFP_KERNEL);
+	if (!uctl)
+		return -ENOMEM;

 	memset(&_ac97, 0, sizeof(_ac97));
 	_ac97.write = snd_trident_codec_write;
@@ -2973,12 +2975,12 @@
 	if ((err = snd_ac97_mixer(trident->card, &_ac97, &trident->ac97)) < 0) {
 		if (trident->device == TRIDENT_DEVICE_ID_SI7018) {
 			if ((err = snd_trident_sis_reset(trident)) < 0)
-				return err;
+				goto __out;
 			if (retries-- > 0)
 				goto __again;
-			return -EIO;
+			err = -EIO;
 		}
-		return err;
+		goto __out;
 	}

 	/* secondary codec? */
@@ -3002,11 +3004,11 @@

 	if (trident->device != TRIDENT_DEVICE_ID_SI7018) {
 		if ((err = snd_ctl_add(card, kctl = snd_ctl_new1(&snd_trident_vol_wave_control, trident))) < 0)
-			return err;
-		kctl->put(kctl, &uctl);
+			goto __out;
+		kctl->put(kctl, uctl);
 		if ((err = snd_ctl_add(card, kctl = snd_ctl_new1(&snd_trident_vol_music_control, trident))) < 0)
-			return err;
-		kctl->put(kctl, &uctl);
+			goto __out;
+		kctl->put(kctl, uctl);
 		outl(trident->musicvol_wavevol = 0x00000000, TRID_REG(trident, T4D_MUSICVOL_WAVEVOL));
 	} else {
 		outl(trident->musicvol_wavevol = 0xffff0000, TRID_REG(trident, T4D_MUSICVOL_WAVEVOL));
@@ -3019,59 +3021,68 @@
 		tmix->voice = NULL;
 	}
 	if ((trident->ctl_vol = snd_ctl_new1(&snd_trident_pcm_vol_control, trident)) == NULL)
-		return -ENOMEM;
+		goto __nomem;
 	if ((err = snd_ctl_add(card, trident->ctl_vol)))
-		return err;
+		goto __out;

 	if ((trident->ctl_pan = snd_ctl_new1(&snd_trident_pcm_pan_control, trident)) == NULL)
-		return -ENOMEM;
+		goto __nomem;
 	if ((err = snd_ctl_add(card, trident->ctl_pan)))
-		return err;
+		goto __out;

 	if ((trident->ctl_rvol = snd_ctl_new1(&snd_trident_pcm_rvol_control, trident)) == NULL)
-		return -ENOMEM;
+		goto __nomem;
 	if ((err = snd_ctl_add(card, trident->ctl_rvol)))
-		return err;
+		goto __out;

 	if ((trident->ctl_cvol = snd_ctl_new1(&snd_trident_pcm_cvol_control, trident)) == NULL)
-		return -ENOMEM;
+		goto __nomem;
 	if ((err = snd_ctl_add(card, trident->ctl_cvol)))
-		return err;
+		goto __out;

 	if (trident->device == TRIDENT_DEVICE_ID_NX) {
 		if ((err = snd_ctl_add(card, kctl = snd_ctl_new1(&snd_trident_ac97_rear_control, trident))) < 0)
-			return err;
-		kctl->put(kctl, &uctl);
+			goto __out;
+		kctl->put(kctl, uctl);
 	}
 	if (trident->device == TRIDENT_DEVICE_ID_NX || trident->device == TRIDENT_DEVICE_ID_SI7018) {

 		if ((err = snd_ctl_add(card, kctl = snd_ctl_new1(&snd_trident_spdif_control, trident))) < 0)
-			return err;
+			goto __out;
 		if (trident->ac97->ext_id & AC97_EI_SPDIF)
 			kctl->id.index++;
 		if (trident->ac97_sec && (trident->ac97_sec->ext_id & AC97_EI_SPDIF))
 			kctl->id.index++;
 		idx = kctl->id.index;
-		kctl->put(kctl, &uctl);
+		kctl->put(kctl, uctl);

 		if ((err = snd_ctl_add(card, kctl = snd_ctl_new1(&snd_trident_spdif_default, trident))) < 0)
-			return err;
+			goto __out;
 		kctl->id.index = idx;
 		kctl->id.device = pcm_spdif_device;

 		if ((err = snd_ctl_add(card, kctl = snd_ctl_new1(&snd_trident_spdif_mask, trident))) < 0)
-			return err;
+			goto __out;
 		kctl->id.index = idx;
 		kctl->id.device = pcm_spdif_device;

 		if ((err = snd_ctl_add(card, kctl = snd_ctl_new1(&snd_trident_spdif_stream, trident))) < 0)
-			return err;
+			goto __out;
 		kctl->id.index = idx;
 		kctl->id.device = pcm_spdif_device;
 		trident->spdif_pcm_ctl = kctl;
 	}

-	return 0;
+	err = 0;
+	goto __out;
+
+      __nomem:
+	err = -ENOMEM;
+
+      __out:
+	kfree(uctl);
+
+	return err;
 }

 /*




-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100006ave/direct;at.asp_061203_01/01
