From: thomas schorpp <t.schorpp@gmx.de>
Subject: Re: softvol plugin [Fwd: Re: [PATCH V0.1] C-Media	CMI9761A
 ]
Date: Sat, 19 Feb 2005 04:41:58 +0100
Message-ID: <4216B586.70602@gmx.de>
References: <1108782279.23185.38.camel@bastov>
Reply-To: t.schorpp@gmx.de
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050204080509050802060605"
In-Reply-To: <1108782279.23185.38.camel@bastov>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: sergio@sergiomb.no-ip.org
Cc: Jakob Schurdak <jakobs@myrealbox.com>, alsa-user@lists.sourceforge.net, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050204080509050802060605
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

uh-oh :)

i code with too much drink and the users like it, great! :]]

... sergio, this patch is crap, pls pull cvs with attached revisions and 
tell if your master vol works then.

my does. and so balance.

THEN update to head and apply both patches attached further below from 
takashi and report (especially if you get pcm sound after unmute of "iec 
capture" switch.)

y
tom


Sergio Monteiro Basto wrote:
> Sorry for cross posting, I am replying to 2 different threads 1 is alsa-
> user and other in alsa-devel!
> 
> Please cc to me!
> 
> Like Jakob Schurdak, I reinstall alsa from CVS (alsa-driver, alsa-lib,
> alsa-utils),  that already have Takashi patch,  but the mixer still have
> exactly the same behavior. 
> 
> I have one ASRock P4VT8+ with CMedia CMI9761 (not the same of Jakob) but
> same rev. of sound card.
> 00:11.5 Multimedia audio controller: VIA Technologies, Inc. VT8233/A/8235/8237 AC97 Audio Controller (rev 60)
> 
> Applying this patch from Thomas Schorpp, I have a better mixer and don't
> have mute nothing as before, I just unmute PCM and have sound, Master
> volume appears but don't have any effect when mute or unmute or change
> volume.
> 
> For me, try to set up a PCM config manually on my own ~/.asoundrc ,
> doesn't change noting ( unless when I forget close  "}") :)
> 
> thanks and regards,
> 

Index: ac97_codec.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_codec.c,v
retrieving revision 1.170
retrieving revision 1.171
diff -u -r1.170 -r1.171
--- ac97_codec.c	9 Feb 2005 10:27:15 -0000	1.170
+++ ac97_codec.c	16 Feb 2005 16:21:03 -0000	1.171
@@ -120,7 +120,8 @@
  { 0x434d4961, 0xffffffff, "CMI9739",		patch_cm9739,	NULL },
  { 0x434d4978, 0xffffffff, "CMI9761",		patch_cm9761,	NULL },
  { 0x434d4982, 0xffffffff, "CMI9761",		patch_cm9761,	NULL },
-{ 0x434d4983, 0xffffffff, "CMI9761",		patch_cm9761,	NULL },
+/* { 0x434d4983, 0xffffffff, "CMI9761",		patch_cm9761,	NULL }, */
+{ 0x434d4983, 0xffffffff, "CMI9761A",		patch_cm9761a,	NULL },
  { 0x43525900, 0xfffffff8, "CS4297",		NULL,		NULL },
  { 0x43525910, 0xfffffff8, "CS4297A",		patch_cirrus_spdif,	NULL },
  { 0x43525920, 0xfffffff8, "CS4298",		patch_cirrus_spdif,		NULL },

Index: ac97_patch.c
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_patch.c,v
retrieving revision 1.72
retrieving revision 1.73
diff -u -r1.72 -r1.73
--- ac97_patch.c	11 Feb 2005 09:56:09 -0000	1.72
+++ ac97_patch.c	16 Feb 2005 16:21:04 -0000	1.73
@@ -2094,6 +2094,34 @@
  	return 0;
  }

+/* CM9761-A is incompatible with CM9761 */
+int patch_cm9761a(ac97_t *ac97)
+{
+	unsigned short val;
+
+	ac97->build_ops = &patch_cm9761_ops;
+
+#if 0
+	/* enable spdif */
+	/* force the SPDIF bit in ext_id - codec doesn't set this bit! */
+        ac97->ext_id |= AC97_EI_SPDIF;
+	/* to be sure: we overwrite the ext status bits */
+	snd_ac97_write_cache(ac97, AC97_EXTENDED_STATUS, 0x05c0);
+	snd_ac97_write_cache(ac97, AC97_CM9761_SPDIF_CTRL, 0x0209);
+	ac97->rates[AC97_RATES_SPDIF] = SNDRV_PCM_RATE_48000; /* 48k only */
+#endif
+	/* set-up multi channel */
+	val = snd_ac97_read(ac97, AC97_CM9761_MULTI_CHAN);
+	val |= (1 << 4);
+	snd_ac97_write_cache(ac97, AC97_CM9761_MULTI_CHAN, val);
+
+	/* FIXME: set up GPIO */
+	snd_ac97_write_cache(ac97, 0x70, 0x0100);
+	snd_ac97_write_cache(ac97, 0x72, 0x0020);
+
+	return 0;
+}
+

  /*
   * VIA VT1616 codec

Index: ac97_patch.h
===================================================================
RCS file: /cvsroot/alsa/alsa-kernel/pci/ac97/ac97_patch.h,v
retrieving revision 1.17
retrieving revision 1.18
diff -u -r1.17 -r1.18
--- ac97_patch.h	29 Sep 2004 15:45:52 -0000	1.17
+++ ac97_patch.h	16 Feb 2005 16:21:04 -0000	1.18
@@ -53,6 +53,7 @@
  int patch_cm9738(ac97_t * ac97);
  int patch_cm9739(ac97_t * ac97);
  int patch_cm9761(ac97_t * ac97);
+int patch_cm9761a(ac97_t * ac97);
  int patch_vt1616(ac97_t * ac97);
  int patch_it2646(ac97_t * ac97);
  int mpatch_si3036(ac97_t * ac97);


AFTER TESTING THEN UPDATE TO HEAD AND APPLY: ATT 2 PATCHES




--------------050204080509050802060605
Content-Type: text/x-patch;
 name="1226.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="1226.diff"

 
diff -u -r1.76 ac97_patch.c
--- alsa-kernel/pci/ac97/ac97_patch.c	16 Feb 2005 18:25:30 -0000	1.76
+++ alsa-kernel/pci/ac97/ac97_patch.c	17 Feb 2005 11:11:01 -0000
@@ -2038,8 +2038,8 @@
 
 	/* CM9761 has no Master and PCM volume although the register reacts */
 	ac97->flags |= AC97_HAS_NO_MASTER_VOL | AC97_HAS_NO_PCM_VOL;
-	snd_ac97_write_cache(ac97, AC97_MASTER, 0x8000);
-	snd_ac97_write_cache(ac97, AC97_PCM, 0x8000);
+	snd_ac97_write_cache(ac97, AC97_MASTER, 0x8808);
+	snd_ac97_write_cache(ac97, AC97_PCM, 0x8808);
 
 	ac97->spec.dev_flags = 0; /* 1 = model 82 revision B */
 	if (ac97->id == AC97_ID_CM9761_82) {

--------------050204080509050802060605
Content-Type: text/x-patch;
 name="2028.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2028.diff"

 
diff -u -r1.147 via82xx.c
--- alsa-kernel/pci/via82xx.c	28 Jan 2005 19:27:36 -0000	1.147
+++ alsa-kernel/pci/via82xx.c	17 Feb 2005 11:03:53 -0000
@@ -367,7 +367,7 @@
 	unsigned int mpu_port_saved;
 #endif
 
-	unsigned char playback_volume[4][2]; /* for VIA8233/C/8235; default = 0 */
+	unsigned char playback_volume[2]; /* for VIA8233/C/8235; default = 0 */
 
 	unsigned int intr_mask; /* SGD_SHADOW mask to check interrupts */
 
@@ -942,8 +942,8 @@
 	snd_assert((rbits & ~0xfffff) == 0, return -EINVAL);
 	snd_via82xx_channel_reset(chip, viadev);
 	snd_via82xx_set_table_ptr(chip, viadev);
-	outb(chip->playback_volume[viadev->reg_offset / 0x10][0], VIADEV_REG(viadev, OFS_PLAYBACK_VOLUME_L));
-	outb(chip->playback_volume[viadev->reg_offset / 0x10][1], VIADEV_REG(viadev, OFS_PLAYBACK_VOLUME_R));
+	outb(chip->playback_volume[0], VIADEV_REG(viadev, OFS_PLAYBACK_VOLUME_L));
+	outb(chip->playback_volume[1], VIADEV_REG(viadev, OFS_PLAYBACK_VOLUME_R));
 	outl((runtime->format == SNDRV_PCM_FORMAT_S16_LE ? VIA8233_REG_TYPE_16BIT : 0) | /* format */
 	     (runtime->channels > 1 ? VIA8233_REG_TYPE_STEREO : 0) | /* stereo */
 	     rbits | /* rate */
@@ -1497,29 +1497,33 @@
 static int snd_via8233_dxs_volume_get(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
 {
 	via82xx_t *chip = snd_kcontrol_chip(kcontrol);
-	unsigned int idx = snd_ctl_get_ioff(kcontrol, &ucontrol->id);
-	ucontrol->value.integer.value[0] = VIA_DXS_MAX_VOLUME - chip->playback_volume[idx][0];
-	ucontrol->value.integer.value[1] = VIA_DXS_MAX_VOLUME - chip->playback_volume[idx][1];
+	ucontrol->value.integer.value[0] = VIA_DXS_MAX_VOLUME - chip->playback_volume[0];
+	ucontrol->value.integer.value[1] = VIA_DXS_MAX_VOLUME - chip->playback_volume[1];
 	return 0;
 }
 
 static int snd_via8233_dxs_volume_put(snd_kcontrol_t *kcontrol, snd_ctl_elem_value_t *ucontrol)
 {
 	via82xx_t *chip = snd_kcontrol_chip(kcontrol);
-	unsigned int idx = snd_ctl_get_ioff(kcontrol, &ucontrol->id);
-	unsigned long port = chip->port + 0x10 * idx;
+	unsigned long port;
 	unsigned char val;
-	int i, change = 0;
+	int i, idx, change = 0;
 
 	for (i = 0; i < 2; i++) {
 		val = ucontrol->value.integer.value[i];
 		if (val > VIA_DXS_MAX_VOLUME)
 			val = VIA_DXS_MAX_VOLUME;
 		val = VIA_DXS_MAX_VOLUME - val;
-		change |= val != chip->playback_volume[idx][i];
-		if (change) {
-			chip->playback_volume[idx][i] = val;
-			outb(val, port + VIA_REG_OFS_PLAYBACK_VOLUME_L + i);
+		change |= val != chip->playback_volume[i];
+		chip->playback_volume[i] = val;
+	}
+	if (change) {
+		for (idx = 0; idx < idx; idx++) {
+			for (i = 0; i < 2; i++) {
+				port = chip->port + 0x10 * idx +
+					VIA_REG_OFS_PLAYBACK_VOLUME_L + i;
+				outb(chip->playback_volume[i], port);
+			}
 		}
 	}
 	return change;
@@ -1528,7 +1532,6 @@
 static snd_kcontrol_new_t snd_via8233_dxs_volume_control __devinitdata = {
 	.name = "VIA DXS Playback Volume",
 	.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
-	.count = 4,
 	.info = snd_via8233_dxs_volume_info,
 	.get = snd_via8233_dxs_volume_get,
 	.put = snd_via8233_dxs_volume_put,
@@ -1942,7 +1945,7 @@
 		for (idx = 0; idx < 4; idx++) {
 			unsigned long port = chip->port + 0x10 * idx;
 			for (i = 0; i < 2; i++)
-				outb(chip->playback_volume[idx][i], port + VIA_REG_OFS_PLAYBACK_VOLUME_L + i);
+				outb(chip->playback_volume[i], port + VIA_REG_OFS_PLAYBACK_VOLUME_L + i);
 		}
 	}
 

--------------050204080509050802060605--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
