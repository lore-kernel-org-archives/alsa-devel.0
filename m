From: Liam Girdwood <liam.girdwood@wolfsonmicro.com>
Subject: [PATCH] Disable AC97 AUX and VIDEO controls for WM9705
	touchscreen
Date: Sun, 18 Jun 2006 14:13:36 +0100
Message-ID: <1150636416.2625.15.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-Kl5Yapo6WuKIUAwq7Pkk"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel <alsa-devel@lists.sourceforge.net>
Cc: Rodolfo Giometti <giometti@linux.it>
List-Id: alsa-devel@alsa-project.org


--=-Kl5Yapo6WuKIUAwq7Pkk
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch by Rodolfo Giometti disables the AC97 AUX and VIDEO controls
on the WM9705 when the touchscreen is selected as the AUX and VIDEO
lines are shared with the touch controller.

Changes:-

 o Added AC97_HAS_NO_AUX flag
 o Test for AC97_HAS_NO_AUX flag in snd_ac97_mixer_build()
 o Sets AC97_HAS_NO_VIDEO and AC97_HAS_NO_AUX in patch_wolfson05() when
WM9705 touch driver is selected.  

Signed-off-by: Rodolfo Giometti <giometti@linux.it>
Signed-off-by: Liam Girdwood <liam.girdwood@wolfsonmicro.com>



--=-Kl5Yapo6WuKIUAwq7Pkk
Content-Disposition: attachment; filename=wm9705-video.patch
Content-Type: text/x-patch; name=wm9705-video.patch; charset=UTF-8
Content-Transfer-Encoding: 7bit

Index: linux-2.6-asoc/include/sound/ac97_codec.h
===================================================================
--- linux-2.6-asoc.orig/include/sound/ac97_codec.h
+++ linux-2.6-asoc/include/sound/ac97_codec.h
@@ -378,6 +378,7 @@
 #define AC97_HAS_NO_MIC	(1<<15) /* no MIC volume */
 #define AC97_HAS_NO_TONE	(1<<16) /* no Tone volume */
 #define AC97_HAS_NO_STD_PCM	(1<<17)	/* no standard AC97 PCM volume and mute */
+#define AC97_HAS_NO_AUX		(1<<18) /* no standard AC97 AUX volume and mute */
 
 /* rates indexes */
 #define AC97_RATES_FRONT_DAC	0
Index: linux-2.6-asoc/sound/pci/ac97/ac97_codec.c
===================================================================
--- linux-2.6-asoc.orig/sound/pci/ac97/ac97_codec.c
+++ linux-2.6-asoc/sound/pci/ac97/ac97_codec.c
@@ -1335,9 +1335,11 @@ static int snd_ac97_mixer_build(struct s
 	}
 
 	/* build Aux controls */
-	if (snd_ac97_try_volume_mix(ac97, AC97_AUX)) {
-		if ((err = snd_ac97_cmix_new(card, "Aux Playback", AC97_AUX, ac97)) < 0)
-			return err;
+	if (!(ac97->flags & AC97_HAS_NO_AUX)) {
+		if (snd_ac97_try_volume_mix(ac97, AC97_AUX)) {
+			if ((err = snd_ac97_cmix_new(card, "Aux Playback", AC97_AUX, ac97)) < 0)
+				return err;
+		}
 	}
 
 	/* build PCM controls */
Index: linux-2.6-asoc/sound/pci/ac97/ac97_patch.c
===================================================================
--- linux-2.6-asoc.orig/sound/pci/ac97/ac97_patch.c
+++ linux-2.6-asoc/sound/pci/ac97/ac97_patch.c
@@ -464,6 +464,10 @@ int patch_wolfson05(struct snd_ac97 * ac
 {
 	/* WM9705, WM9710 */
 	ac97->build_ops = &patch_wolfson_wm9705_ops;
+#ifdef CONFIG_TOUCHSCREEN_WM9705
+	/* WM9705 touchscreen uses AUX and VIDEO for touch */
+	ac97->flags |=3D AC97_HAS_NO_VIDEO | AC97_HAS_NO_AUX;
+#endif
 	return 0;
 }
 

--=-Kl5Yapo6WuKIUAwq7Pkk
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--=-Kl5Yapo6WuKIUAwq7Pkk
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--=-Kl5Yapo6WuKIUAwq7Pkk--
