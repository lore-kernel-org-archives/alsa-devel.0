From: Liam Girdwood <Liam.Girdwood@wolfsonmicro.com>
Subject: [PATCH 3/4] AC97 wm9713 support
Date: Fri, 25 Feb 2005 14:23:31 +0000
Message-ID: <1109341411.30473.675.camel@cearnarfon>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-01YgP7OI4+5SnsVH1Dhp"
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org


--=-01YgP7OI4+5SnsVH1Dhp
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

This patch is against ac97_local.h

Changes:-
  
  o Added AC97_ENUM,  AC97_ENUM_SINGLE and AC97_ENUM_DOUBLE
  o Moved AC97_DOUBLE from ac97_codec.c

Signed-off-by: Liam Girdwood <liam.girdwood@wolfsonmicro.com>

 

--=-01YgP7OI4+5SnsVH1Dhp
Content-Disposition: attachment; filename=ac97_local.h.diff
Content-Type: text/x-patch; name=ac97_local.h.diff; charset=
Content-Transfer-Encoding: 7bit

diff -u -r1.12 ac97_local.h
--- pci/ac97/ac97_local.h	19 Jan 2005 12:03:51 -0000	1.12
+++ pci/ac97/ac97_local.h	24 Feb 2005 16:49:55 -0000
@@ -32,6 +32,21 @@
 { .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .info = snd_ac97_info_volsw, \
   .get = snd_ac97_get_volsw, .put = snd_ac97_put_volsw, \
   .private_value =  AC97_PAGE_SINGLE_VALUE(reg, shift, mask, invert, page) }
+#define AC97_DOUBLE(xname, reg, shift_left, shift_right, mask, invert) \
+{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = (xname), .info = snd_ac97_info_volsw, \
+  .get = snd_ac97_get_volsw, .put = snd_ac97_put_volsw, \
+  .private_value = (reg) | ((shift_left) << 8) | ((shift_right) << 12) | ((mask) << 16) | ((invert) << 24) }
+#define AC97_ENUM(xreg, xshift_l, xshift_r, xmask, xtexts) \
+{ .reg = xreg, .shift_l = xshift_l, .shift_r = xshift_r, \
+  .mask = xmask, .texts = xtexts }
+#define AC97_ENUM_SINGLE(xname, xenum) \
+{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .info = snd_ac97_info_enum_single, \
+  .get = snd_ac97_get_enum_single, .put = snd_ac97_put_enum_single, \
+  .private_value = (unsigned long)&xenum }
+#define AC97_ENUM_DOUBLE(xname, xenum) \
+{ .iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, .info = snd_ac97_info_enum_double, \
+  .get = snd_ac97_get_enum_double, .put = snd_ac97_put_enum_double, \
+  .private_value = (unsigned long)&xenum }
 
 /* ac97_codec.c */
 extern const char *snd_ac97_stereo_enhancements[];
@@ -49,6 +64,12 @@
 void snd_ac97_rename_vol_ctl(ac97_t *ac97, const char *src, const char *dst);
 void snd_ac97_restore_status(ac97_t *ac97);
 void snd_ac97_restore_iec958(ac97_t *ac97);
+int snd_ac97_info_enum_single(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo);
+int snd_ac97_get_enum_single(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol);
+int snd_ac97_put_enum_single(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol);
+int snd_ac97_info_enum_double(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo);
+int snd_ac97_get_enum_double(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol);
+int snd_ac97_put_enum_double(snd_kcontrol_t * kcontrol, snd_ctl_elem_value_t * ucontrol);
 
 int snd_ac97_update_bits_nolock(ac97_t *ac97, unsigned short reg,
 				unsigned short mask, unsigned short value);

--=-01YgP7OI4+5SnsVH1Dhp--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
