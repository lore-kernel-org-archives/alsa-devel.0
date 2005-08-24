From: Dorin Lazar <lazar@deuromedia.ro>
Subject: Soundblaster Live! 24 bit (snd-ca0106) and the oss emulation
Date: Wed, 24 Aug 2005 12:27:21 +0300
Message-ID: <200508241227.21292.lazar@deuromedia.ro>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_51DDDLwb1xTzxIe"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from outdoor.Deuromedia.ro (outdoor.Deuromedia.ro [194.176.161.44])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 44B2624C
	for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2005 11:27:30 +0200 (MEST)
Received: (from root@localhost)
	by outdoor.Deuromedia.ro (8.11.2/8.11.2) id j7O9RWV08823
	for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2005 12:27:32 +0300
Received: from dvb26 (dvb26.Deuromedia.ro [192.168.3.26] (may be forged))
	by outdoor.Deuromedia.ro (8.11.2/8.11.0) with ESMTP id j7O9RPk08418
	for <alsa-devel@alsa-project.org>; Wed, 24 Aug 2005 12:27:26 +0300
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

--Boundary-00=_51DDDLwb1xTzxIe
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

  Hello,
  There is a problem regarding the ca0106 used through the oss-emulation. The 
volume doesn't work (since the only controls that the card is offering are 
"Analog Front/Center_LFE/Rear/Unknown" and "SPDIF Front/etc."
  The solution I found, and perhaps other people might find useful is to 
create a control named "PCM" that will adjust the proper controls. I find the 
following patch useful but incorrect at best. Perhaps there should be a 
legitimate version of this patch included in the distribution.
  Patch is attached.
  Dorin

--Boundary-00=_51DDDLwb1xTzxIe
Content-Type: text/x-diff;
  charset="us-ascii";
  name="oss_pcm_ca0106_hack.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="oss_pcm_ca0106_hack.diff"

--- alsa-kernel/pci/ca0106/ca0106_mixer.c.orig	2005-08-08 16:41:05.000000000 +0300
+++ alsa-kernel/pci/ca0106/ca0106_mixer.c	2005-08-23 09:52:25.879161046 +0300
@@ -393,6 +393,11 @@
 	int reg = PLAYBACK_VOLUME2;
         return snd_ca0106_volume_get(kcontrol, ucontrol, reg, channel_id);
 }
+static int snd_ca0106_volume_get_pcm(snd_kcontrol_t * kcontrol,
+                                       snd_ctl_elem_value_t * ucontrol)
+{
+	return snd_ca0106_volume_get_analog_front(kcontrol, ucontrol);
+}
 
 static int snd_ca0106_volume_get_feedback(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol)
@@ -463,6 +468,14 @@
 	int reg = PLAYBACK_VOLUME2;
         return snd_ca0106_volume_put(kcontrol, ucontrol, reg, channel_id);
 }
+static int snd_ca0106_volume_put_pcm(snd_kcontrol_t * kcontrol,
+                                       snd_ctl_elem_value_t * ucontrol)
+{
+	snd_ca0106_volume_put_analog_unknown(kcontrol, ucontrol);
+	snd_ca0106_volume_put_analog_rear(kcontrol, ucontrol);
+	snd_ca0106_volume_put_analog_center_lfe(kcontrol, ucontrol);
+	return snd_ca0106_volume_put_analog_front(kcontrol, ucontrol);
+}
 static int snd_ca0106_volume_put_analog_rear(snd_kcontrol_t * kcontrol,
                                        snd_ctl_elem_value_t * ucontrol)
 {
@@ -511,6 +524,14 @@
         .get =          snd_ca0106_volume_get_analog_rear,
         .put =          snd_ca0106_volume_put_analog_rear
 };
+static snd_kcontrol_new_t snd_ca0106_volume_control_pcm =
+{
+        .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
+        .name =         "PCM",
+        .info =         snd_ca0106_volume_info,
+        .get =          snd_ca0106_volume_get_pcm,
+        .put =          snd_ca0106_volume_put_pcm
+};
 static snd_kcontrol_new_t snd_ca0106_volume_control_spdif_front =
 {
         .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
@@ -633,6 +654,10 @@
 		rename_ctl(card, c[0], c[1]);
 #endif
 
+        if ((kctl = snd_ctl_new1(&snd_ca0106_volume_control_pcm, emu)) == NULL)
+                return -ENOMEM;
+        if ((err = snd_ctl_add(card, kctl)))
+                return err;
         if ((kctl = snd_ctl_new1(&snd_ca0106_volume_control_analog_front, emu)) == NULL)
                 return -ENOMEM;
         if ((err = snd_ctl_add(card, kctl)))

--Boundary-00=_51DDDLwb1xTzxIe--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
