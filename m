From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: [PATCH 4/5] ALSA: usb-audio: deallocate memory objects
	in error path
Date: Tue, 21 Feb 2017 05:09:20 +0900
Message-ID: <20170220200921.824-5-o-takashi@sakamocchi.jp>
References: <20170220200921.824-1-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-proxy001.phy.lolipop.jp (smtp-proxy001.phy.lolipop.jp
 [157.7.104.42]) by alsa0.perex.cz (Postfix) with ESMTP id 1CA54266569
 for <alsa-devel@alsa-project.org>; Mon, 20 Feb 2017 21:09:27 +0100 (CET)
In-Reply-To: <20170220200921.824-1-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: onkel@paraair.de, tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Some functions for quirks of Tascam US-16x08 have memory leaks.

This commit fixes the bugs.

Fixes: d2bb390a2081 ("ALSA: usb-audio: Tascam US-16x08 DSP mixer quirk")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 sound/usb/mixer_us16x08.c | 27 ++++++++++++++++-----------
 1 file changed, 16 insertions(+), 11 deletions(-)

diff --git a/sound/usb/mixer_us16x08.c b/sound/usb/mixer_us16x08.c
index 5dae63c..d34dd1c 100644
--- a/sound/usb/mixer_us16x08.c
+++ b/sound/usb/mixer_us16x08.c
@@ -1082,8 +1082,8 @@ static int add_new_ctl(struct usb_mixer_interface *mixer,
 
 	kctl = snd_ctl_new1(ncontrol, elem);
 	if (!kctl) {
-		kfree(elem);
-		return -ENOMEM;
+		err = -ENOMEM;
+		goto end;
 	}
 
 	kctl->private_free = freeer;
@@ -1092,11 +1092,12 @@ static int add_new_ctl(struct usb_mixer_interface *mixer,
 
 	err = snd_usb_mixer_add_control(&elem->head, kctl);
 	if (err < 0)
-		return err;
+		goto end;
 
 	if (elem_ret)
 		*elem_ret = elem;
-
+end:
+	kfree(elem);
 	return 0;
 }
 
@@ -1367,7 +1368,7 @@ int snd_us16x08_controls_create(struct usb_mixer_interface *mixer)
 			usb_audio_dbg(mixer->chip,
 				"Failed to create route control, err:%d\n",
 				err);
-			return err;
+			goto err_allocated;
 		}
 		for (i = 0; i < 8; i++)
 			elem->cache_val[i] = i < 2 ? i : i + 2;
@@ -1388,7 +1389,7 @@ int snd_us16x08_controls_create(struct usb_mixer_interface *mixer)
 				comp_store,
 				master_controls[i].freeer, &elem);
 			if (err < 0)
-				return err;
+				goto err_allocated;
 			elem->cache_val[0] = master_controls[i].default_val;
 			elem->cached = 1;
 		}
@@ -1408,7 +1409,7 @@ int snd_us16x08_controls_create(struct usb_mixer_interface *mixer)
 				comp_store,
 				channel_controls[i].freeer, &elem);
 			if (err < 0)
-				return err;
+				goto err_allocated;
 			for (j = 0; j < SND_US16X08_MAX_CHANNELS; j++) {
 				elem->cache_val[j] =
 					channel_controls[i].default_val;
@@ -1429,7 +1430,7 @@ int snd_us16x08_controls_create(struct usb_mixer_interface *mixer)
 				eq_store,
 				eq_controls[i].freeer, NULL);
 			if (err < 0)
-				return err;
+				goto err_allocated;
 		}
 
 		/* add compressor controls */
@@ -1447,7 +1448,7 @@ int snd_us16x08_controls_create(struct usb_mixer_interface *mixer)
 				comp_store,
 				comp_controls[i].freeer, NULL);
 			if (err < 0)
-				return err;
+				goto err_allocated;
 		}
 
 		/* meter function 'get' must access to compressor store
@@ -1458,9 +1459,13 @@ int snd_us16x08_controls_create(struct usb_mixer_interface *mixer)
 			SND_US16X08_ID_METER, USB_MIXER_U16, 0, "Level Meter",
 			(void *) meter_store, snd_usb_mixer_elem_free, NULL);
 		if (err < 0)
-			return err;
+			goto err_allocated;
 	}
 
 	return 0;
+err_allocated:
+	kfree(meter_store);
+	kfree(eq_store);
+	kfree(comp_store);
+	return err;
 }
-
-- 
2.9.3
