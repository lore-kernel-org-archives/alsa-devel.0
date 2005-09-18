From: James Courtier-Dutton <James@superbug.co.uk>
Subject: [PATCH] Implement support for display of dB gain in alsamixer.
Date: Sun, 18 Sep 2005 14:31:38 +0100
Message-ID: <432D6C3A.4000001@superbug.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090505010804010400080603"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

This is a multi-part message in MIME format.
--------------090505010804010400080603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Here is a first draft of one possible way to implement dB gain display 
in alsamixer.

This particular method modifies the alsa-driver to alsa-lib API 
interface by modifying one of the structures there.

If alsa-driver does not match alsa-lib, alsamixer fails to work with the 
following error message:
alsamixer: function snd_mixer_load failed: Inappropriate ioctl for device

I have then implemented support for it in the snd-ca0106 driver.
For any sound card that has not yet had the implementation, this results 
in no extra information being displayed in alsamixer.

As one can see, the work required to implement support in any particular 
driver is minimal.

This should be a good place to start discussions.

Any comments?

James

--------------090505010804010400080603
Content-Type: text/x-patch;
 name="dBdriver.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dBdriver.patch"

Index: alsa-driver/alsa-kernel/include/asound.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/include/asound.h,v
retrieving revision 1.55
diff -u -r1.55 asound.h
--- alsa-driver/alsa-kernel/include/asound.h	16 Aug 2005 10:32:04 -0000	1.55
+++ alsa-driver/alsa-kernel/include/asound.h	18 Sep 2005 13:21:42 -0000
@@ -844,6 +844,16 @@
 		} bytes;
 		struct sndrv_aes_iec958 iec958;
         } value;                /* RO */
+        union {
+		union {
+			long scale[128]; /* Index into conversion to dB function. */
+			long *scale_ptr;
+		} integer;
+		union {
+			long long scale[64]; /* Index into conversion to dB function. */
+			long long *scale_ptr;
+		} integer64;
+        } scale;                /* RO */
 	struct timespec tstamp;
         unsigned char reserved[128-sizeof(struct timespec)];
 };
Index: alsa-driver/alsa-kernel/pci/ca0106/ca0106_mixer.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ca0106/ca0106_mixer.c,v
retrieving revision 1.7
diff -u -r1.7 ca0106_mixer.c
--- alsa-driver/alsa-kernel/pci/ca0106/ca0106_mixer.c	30 Aug 2005 20:00:46 -0000	1.7
+++ alsa-driver/alsa-kernel/pci/ca0106/ca0106_mixer.c	18 Sep 2005 13:21:42 -0000
@@ -331,7 +331,9 @@
 
         value = snd_ca0106_ptr_read(emu, reg, channel_id);
         ucontrol->value.integer.value[0] = 0xff - ((value >> 24) & 0xff); /* Left */
+	ucontrol->scale.integer.scale[0] = 1;
         ucontrol->value.integer.value[1] = 0xff - ((value >> 16) & 0xff); /* Right */
+	ucontrol->scale.integer.scale[1] = 1;
         return 0;
 }
 

--------------090505010804010400080603
Content-Type: text/x-patch;
 name="dBlib.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="dBlib.patch"

Index: alsa-lib/include/control.h
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/include/control.h,v
retrieving revision 1.101
diff -u -r1.101 control.h
--- alsa-lib/include/control.h	9 Jun 2005 17:12:08 -0000	1.101
+++ alsa-lib/include/control.h	18 Sep 2005 13:21:21 -0000
@@ -402,6 +402,7 @@
 void snd_ctl_elem_value_set_index(snd_ctl_elem_value_t *obj, unsigned int val);
 int snd_ctl_elem_value_get_boolean(const snd_ctl_elem_value_t *obj, unsigned int idx);
 long snd_ctl_elem_value_get_integer(const snd_ctl_elem_value_t *obj, unsigned int idx);
+long snd_ctl_elem_scale_get_integer(const snd_ctl_elem_value_t *obj, unsigned int idx);
 long long snd_ctl_elem_value_get_integer64(const snd_ctl_elem_value_t *obj, unsigned int idx);
 unsigned int snd_ctl_elem_value_get_enumerated(const snd_ctl_elem_value_t *obj, unsigned int idx);
 unsigned char snd_ctl_elem_value_get_byte(const snd_ctl_elem_value_t *obj, unsigned int idx);
Index: alsa-lib/include/sound/asound.h
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/include/sound/asound.h,v
retrieving revision 1.20
diff -u -r1.20 asound.h
--- alsa-lib/include/sound/asound.h	19 May 2005 16:59:05 -0000	1.20
+++ alsa-lib/include/sound/asound.h	18 Sep 2005 13:21:21 -0000
@@ -839,6 +839,16 @@
 		} bytes;
 		struct sndrv_aes_iec958 iec958;
         } value;                /* RO */
+        union {
+		union {
+			long scale[128]; /* Index into conversion to dB function. */
+			long *scale_ptr;
+		} integer;
+		union {
+			long long scale[64]; /* Index into conversion to dB function. */
+			long long *scale_ptr;
+		} integer64;
+        } scale;                /* RO */
 	struct timespec tstamp;
         unsigned char reserved[128-sizeof(struct timespec)];
 };
Index: alsa-lib/src/control/control.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/control/control.c,v
retrieving revision 1.107
diff -u -r1.107 control.c
--- alsa-lib/src/control/control.c	28 Jun 2005 10:24:44 -0000	1.107
+++ alsa-lib/src/control/control.c	18 Sep 2005 13:21:21 -0000
@@ -2302,6 +2302,19 @@
 }
 
 /**
+ * \brief Get scale for an entry of a #SND_CTL_ELEM_TYPE_INTEGER CTL element id/value 
+ * \param obj CTL element id/value
+ * \param idx Entry index
+ * \return value for the entry
+ */ 
+long snd_ctl_elem_scale_get_integer(const snd_ctl_elem_value_t *obj, unsigned int idx)
+{
+	assert(obj);
+	assert(idx < sizeof(obj->value.integer.value) / sizeof(obj->value.integer.value[0]));
+	return obj->scale.integer.scale[idx];
+}
+
+/**
  * \brief Get value for an entry of a #SND_CTL_ELEM_TYPE_INTEGER CTL element id/value 
  * \param obj CTL element id/value
  * \param idx Entry index
Index: alsa-lib/src/mixer/simple_none.c
===================================================================
RCS file: /cvsroot/alsa/alsa-lib/src/mixer/simple_none.c,v
retrieving revision 1.5
diff -u -r1.5 simple_none.c
--- alsa-lib/src/mixer/simple_none.c	23 Jun 2005 07:45:17 -0000	1.5
+++ alsa-lib/src/mixer/simple_none.c	18 Sep 2005 13:21:22 -0000
@@ -78,6 +78,7 @@
 		long min, max;
 		unsigned int channels;
 		long vol[32];
+		long scale[32]; /* scale to use to convert volume to dB */
 		unsigned int sw;
 	} str[2];
 } selem_none_t;
@@ -236,6 +237,11 @@
 		if (idx >= c->values)
 			idx1 = 0;
 		s->str[dir].vol[idx] = to_user(s, dir, c, snd_ctl_elem_value_get_integer(ctl, idx1));
+		s->str[dir].scale[idx] = snd_ctl_elem_scale_get_integer(ctl, idx1);
+	//FIXME:jcd
+	//printf("s:vol=0x%x, scale=0x%x       \n", 
+	//		s->str[dir].vol[idx],
+	//		s->str[dir].scale[idx]);
 	}
 	return 0;
 }
@@ -963,12 +969,46 @@
 	return 0;
 }
 
-static int get_dB_ops(snd_mixer_elem_t *elem ATTRIBUTE_UNUSED,
-		      int dir ATTRIBUTE_UNUSED,
-		      snd_mixer_selem_channel_id_t channel ATTRIBUTE_UNUSED,
-		      long *value ATTRIBUTE_UNUSED)
+static int get_volume_scale(snd_mixer_elem_t *elem, int dir,
+			  snd_mixer_selem_channel_id_t channel, long *value)
 {
-	return -ENXIO;
+	selem_none_t *s = snd_mixer_elem_get_private(elem);
+	if ((unsigned int) channel >= s->str[dir].channels)
+		return -EINVAL;
+	*value = s->str[dir].scale[channel];
+	return 0;
+}
+
+static get_dB_convert(long volume, long scale, long *value)
+{
+	switch (scale) {
+	case 1:  /* Scale from -51.50 dB to +12.00 dB in steps of 0.75 dB. 256 steps. */
+		if (volume == 0) {
+			*value=-9999; /* Muted */
+			break;
+		}
+		*value=(volume * 25) - 5175; /* For ca0106 controls */
+		break;
+	default:
+		return 1;
+	}
+	return 0;
+}
+
+
+static int get_dB_ops(snd_mixer_elem_t *elem,
+		      int dir,
+		      snd_mixer_selem_channel_id_t channel,
+		      long *value)
+{
+	long volume, scale;
+	if (get_volume_ops(elem, dir, channel, &volume)) 
+		return -EINVAL;
+	if (get_volume_scale(elem, dir, channel, &scale)) 
+		return -EINVAL;
+        if (get_dB_convert(volume, scale, value))
+		return -ENXIO;
+	return 0;
 }
 
 static int get_switch_ops(snd_mixer_elem_t *elem, int dir,

--------------090505010804010400080603--


-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. 
Download it for free - -and be entered to win a 42" plasma tv or your very
own Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
