From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: [PATCH] Audigy LS SPDIF output.
Date: Tue, 22 Jun 2004 20:17:15 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40D885BB.80502@superbug.demon.co.uk>
References: <40D72EBF.80108@superbug.demon.co.uk>	<40D7463C.5090406@ait.nrl.navy.mil>	<40D75C54.7010700@superbug.demon.co.uk>	<40D7AF33.5030405@superbug.demon.co.uk>	<40D84EE9.6000405@superbug.demon.co.uk> <s5hsmcnlia7.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------050405070501030509030401"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hsmcnlia7.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------050405070501030509030401
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Takashi Iwai wrote:
> At Tue, 22 Jun 2004 16:23:21 +0100,
> James Courtier-Dutton wrote:
> 
>>I have uploaded new versions of:
>>audigyls.c
>>AudigyLS.conf
>>
>>http://www.superbug.demon.co.uk/alsa
> 
> 
> Could you please send as patches to CVS version?
> 
> 
> thanks,
> 
> Takashi
> 
> 

This new patch, implements full SPDIF Stereo PCM and also AC3/DTS output.
These new versions implement AC3/DTS output where the others did not.

One can use a standard stereo mini-jack cable to two RCA plugs cable.
Full explanation in the audigyls.c source code, as comments.

See attachements.

Cheers
James


--------------050405070501030509030401
Content-Type: text/x-patch;
 name="alsa-lib.cvs.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-lib.cvs.diff"

cvs -q -f -z3 -d ":pserver:anonymous:@cvs.sourceforge.net:/cvsroot/alsa" diff -u alsa-lib


--------------050405070501030509030401
Content-Type: text/plain;
 name="alsa-driver.diff.txt"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="alsa-driver.diff.txt"

Index: alsa-driver/pci/emu10k1/audigyls.c
===================================================================
RCS file: /cvsroot/alsa/alsa-driver/pci/emu10k1/audigyls.c,v
retrieving revision 1.1
diff -u -r1.1 audigyls.c
--- alsa-driver/pci/emu10k1/audigyls.c	18 Jun 2004 14:21:20 -0000	1.1
+++ alsa-driver/pci/emu10k1/audigyls.c	22 Jun 2004 18:05:46 -0000
@@ -6,6 +6,9 @@
  *    Front, Rear and Center/LFE.
  *    Surround40 and Surround51.
  *    Capture from MIC input.
+ *    SPDIF digital playback of PCM stereo and AC3/DTS works.
+ *    (One can use a standard stereo mini-jack to two RCA plugs cable.
+ *     Plug one of the RCA plugs into the Coax input of the external decoder/receiver.)
  *
  *  BUGS:
  *    --
@@ -13,7 +16,6 @@
  *  TODO:
  *    Need to add a way to select capture source.
  *    4 Capture channels, only one implemented so far.
- *    SPDIF playback not implemented.
  *    Need to find out what the AC97 chip actually does.
  *    Other rates apart from 48khz not implemented.
  *    MIDI
@@ -128,7 +130,27 @@
 #define AC97ADDRESS		0x1e		/* AC97 register set address register (8 bit)	*/
 #define PLAYBACk_LAST_SAMPLE    0x20            /* The sample currently being played */
 #define BASIC_INTERRUPT         0x40            /* Used by both playback and capture interrupt handler */
-#define SPCS0			0x41		/* SPDIF output Channel Status 0 register default=0x02108004, non-audio=0x02108006	*/
+/* The Digital out jack is shared with the Center/LFE Analogue output. 
+ * The jack has 4 poles. I will call 1 - Tip, 2 - Next to 1, 3 - Next to 2, 4 - Next to 3
+ * For Analogue: 1 -> Center Speaker, 2 -> Sub Woofer, 3 -> Ground, 4 -> Ground
+ * For Digital: 1 -> Front SPDIF, 2 -> Rear SPDIF, 3 -> Center/Subwoofer SPDIF, 4 -> Ground.
+ * Standard 4 pole Video A/V cable with RCA outputs: 1 -> White, 2 -> Yellow, 3 -> Sheild on all three, 4 -> Red.
+ * So, from this you can see that you cannot use a Standard 4 pole Video A/V cable with the SB Audigy LS card.
+ */
+/* The Front SPDIF PCM gets mixed with samples from the AC97 codec, so can only work for Stereo PCM and not AC3/DTS
+ * The Rear SPDIF can be used for Stereo PCM and also AC3/DTS
+ * The Center/LFE SPDIF cannot be used for AC3/DTS, but can be used for Stereo PCM.
+ * Summary: For ALSA we use the Rear channel for SPDIF Digital AC3/DTS output
+ */
+/* A standard 2 pole mono mini-jack to RCA plug can be used for SPDIF Stereo PCM output from the Front channel.
+ * A standard 3 pole stereo mini-jack to 2 RCA plugs can be used for SPDIF AC3/DTS and Stereo PCM output utilising the Rear channel and just one of the RCA plugs. 
+ */
+
+
+#define SPCS0			0x41		/* SPDIF output Channel Status 0 register. For Rear. default=0x02108004, non-audio=0x02108006	*/
+#define SPCS1			0x42		/* SPDIF output Channel Status 1 register. For Front */
+#define SPCS2			0x43		/* SPDIF output Channel Status 2 register. For Center/LFE */
+#define SPCS3			0x44		/* SPDIF output Channel Status 3 register. Unknown */
 #define SPCS_CLKACCYMASK	0x30000000	/* Clock accuracy				*/
 #define SPCS_CLKACCY_1000PPM	0x00000000	/* 1000 parts per million			*/
 #define SPCS_CLKACCY_50PPM	0x10000000	/* 50 parts per million				*/
@@ -237,10 +259,10 @@
 	audigyls_voice_t voices[4];
 	audigyls_channel_t channels[4];
 	audigyls_channel_t capture_channel;
+	u32 spdif_bits[4];             /* s/pdif out setup */
 
 	struct snd_dma_device dma_dev;
 	struct snd_dma_buffer buffer;
-        snd_kcontrol_t *ctl_front_volume;
 };
 
 #define audigyls_t_magic        0xa15a4501
@@ -1068,35 +1090,45 @@
 	 *  AN                = 0     (Audio data)
 	 *  P                 = 0     (Consumer)
 	 */
-#if 0
 	snd_audigyls_ptr_write(chip, SPCS0, 0,
-			       SPCS_CLKACCY_1000PPM | SPCS_SAMPLERATE_48 |
-			       SPCS_CHANNELNUM_LEFT | SPCS_SOURCENUM_UNSPEC |
-			       SPCS_GENERATIONSTATUS | 0x00001200 |
-			       0x00000000 | SPCS_EMPHASIS_NONE | SPCS_COPYRIGHT);
+				chip->spdif_bits[0] =
+				SPCS_CLKACCY_1000PPM | SPCS_SAMPLERATE_48 |
+				SPCS_CHANNELNUM_LEFT | SPCS_SOURCENUM_UNSPEC |
+				SPCS_GENERATIONSTATUS | 0x00001200 |
+				0x00000000 | SPCS_EMPHASIS_NONE | SPCS_COPYRIGHT);
+	/* Only SPCS1 has been tested */
 	snd_audigyls_ptr_write(chip, SPCS1, 0,
-			       SPCS_CLKACCY_1000PPM | SPCS_SAMPLERATE_48 |
-			       SPCS_CHANNELNUM_LEFT | SPCS_SOURCENUM_UNSPEC |
-			       SPCS_GENERATIONSTATUS | 0x00001200 |
-			       0x00000000 | SPCS_EMPHASIS_NONE | SPCS_COPYRIGHT);
+				chip->spdif_bits[1] =
+				SPCS_CLKACCY_1000PPM | SPCS_SAMPLERATE_48 |
+				SPCS_CHANNELNUM_LEFT | SPCS_SOURCENUM_UNSPEC |
+				SPCS_GENERATIONSTATUS | 0x00001200 |
+				0x00000000 | SPCS_EMPHASIS_NONE | SPCS_COPYRIGHT);
 	snd_audigyls_ptr_write(chip, SPCS2, 0,
-			       SPCS_CLKACCY_1000PPM | SPCS_SAMPLERATE_48 |
-			       SPCS_CHANNELNUM_LEFT | SPCS_SOURCENUM_UNSPEC |
-			       SPCS_GENERATIONSTATUS | 0x00001200 |
-			       0x00000000 | SPCS_EMPHASIS_NONE | SPCS_COPYRIGHT);
-#endif
-/* Select analogue output */
+				chip->spdif_bits[2] =
+				SPCS_CLKACCY_1000PPM | SPCS_SAMPLERATE_48 |
+				SPCS_CHANNELNUM_LEFT | SPCS_SOURCENUM_UNSPEC |
+				SPCS_GENERATIONSTATUS | 0x00001200 |
+				0x00000000 | SPCS_EMPHASIS_NONE | SPCS_COPYRIGHT);
+	snd_audigyls_ptr_write(chip, SPCS3, 0,
+				chip->spdif_bits[3] =
+				SPCS_CLKACCY_1000PPM | SPCS_SAMPLERATE_48 |
+				SPCS_CHANNELNUM_LEFT | SPCS_SOURCENUM_UNSPEC |
+				SPCS_GENERATIONSTATUS | 0x00001200 |
+				0x00000000 | SPCS_EMPHASIS_NONE | SPCS_COPYRIGHT);
+
+	/* Select analogue output */
         //snd_audigyls_ptr_write(chip, 0x41, 0, 0x70f); // ???
         //snd_audigyls_ptr_write(chip, 0x65, 0, 0x1000);
 
         /* Write 0x8000 to AC97_REC_GAIN to mute it. */
         outb(AC97_REC_GAIN, chip->port + AC97ADDRESS);
         outw(0x8000, chip->port + AC97DATA);
-
+#if 0
 	snd_audigyls_ptr_write(chip, SPCS0, 0, 0x2108006);
 	snd_audigyls_ptr_write(chip, 0x42, 0, 0x2108006);
 	snd_audigyls_ptr_write(chip, 0x43, 0, 0x2108006);
 	snd_audigyls_ptr_write(chip, 0x44, 0, 0x2108006);
+#endif
 
 	snd_audigyls_ptr_write(chip, 0x72, 0, 0xf0f003f);
 
@@ -1206,6 +1238,21 @@
 	}
 }
 
+static void snd_audigyls_proc_reg_write(snd_info_entry_t *entry, 
+				       snd_info_buffer_t * buffer)
+{
+	audigyls_t *emu = snd_magic_cast(audigyls_t, entry->private_data, return);
+        char line[64];
+        unsigned int reg, channel_id , val;
+        while (!snd_info_get_line(buffer, line, sizeof(line))) {
+                if (sscanf(line, "%x %x %x", &reg, &channel_id, &val) != 3)
+                        continue;
+                if ((reg < 0x80) && (reg >=0) && (val <= 0xffffffff) && (channel_id >=0) && (channel_id <= 3) )
+                        snd_audigyls_ptr_write(emu, reg, channel_id, val);
+        }
+}
+
+
 static int __devinit snd_audigyls_proc_init(audigyls_t * emu)
 {
 	snd_info_entry_t *entry;
@@ -1216,13 +1263,132 @@
 		snd_info_set_text_ops(entry, emu, 1024, snd_audigyls_proc_reg_read16);
 	if(! snd_card_proc_new(emu->card, "audigyls_reg8", &entry))
 		snd_info_set_text_ops(entry, emu, 1024, snd_audigyls_proc_reg_read8);
-	if(! snd_card_proc_new(emu->card, "audigyls_regs1", &entry))
+	if(! snd_card_proc_new(emu->card, "audigyls_regs1", &entry)) {
 		snd_info_set_text_ops(entry, emu, 1024, snd_audigyls_proc_reg_read1);
-	if(! snd_card_proc_new(emu->card, "audigyls_regs2", &entry))
+		entry->c.text.write_size = 64;
+		entry->c.text.write = snd_audigyls_proc_reg_write;
+//		entry->private_data = emu;
+	}
+	if(! snd_card_proc_new(emu->card, "audigyls_regs2", &entry)) 
 		snd_info_set_text_ops(entry, emu, 1024, snd_audigyls_proc_reg_read2);
 	return 0;
 }
 
+static int snd_audigyls_shared_spdif_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	return 0;
+}
+
+static int snd_audigyls_shared_spdif_get(snd_kcontrol_t * kcontrol,
+					snd_ctl_elem_value_t * ucontrol)
+{
+	audigyls_t *emu = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = snd_audigyls_ptr_read(emu, SPDIF_SELECT, 0);
+        return 0;
+}
+
+static int snd_audigyls_shared_spdif_put(snd_kcontrol_t * kcontrol,
+					snd_ctl_elem_value_t * ucontrol)
+{
+	audigyls_t *emu = snd_kcontrol_chip(kcontrol);
+	unsigned int reg, val;
+	int change = 0;
+
+	reg = snd_audigyls_ptr_read(emu, SPDIF_SELECT, 0);
+	val = ucontrol->value.integer.value[0] ;
+	/* FIXME: Check whether we want ON == SPDIF on, or OFF == SPDIF on */
+	change = ((reg == 0xf00) != val);
+	if (change) {
+		reg ^= 0xf00;
+		snd_audigyls_ptr_write(emu, SPDIF_SELECT, 0, reg);
+	}
+        return change;
+}
+
+static snd_kcontrol_new_t snd_audigyls_shared_spdif __devinitdata =
+{
+	.iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
+	.name =		"Analog/Digital Output Jack",
+	.info =		snd_audigyls_shared_spdif_info,
+	.get =		snd_audigyls_shared_spdif_get,
+	.put =		snd_audigyls_shared_spdif_put
+};
+
+static int snd_audigyls_spdif_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_IEC958;
+	uinfo->count = 1;
+	return 0;
+}
+
+static int snd_audigyls_spdif_get(snd_kcontrol_t * kcontrol,
+                                 snd_ctl_elem_value_t * ucontrol)
+{
+	audigyls_t *emu = snd_kcontrol_chip(kcontrol);
+	unsigned int idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
+
+	ucontrol->value.iec958.status[0] = (emu->spdif_bits[idx] >> 0) & 0xff;
+	ucontrol->value.iec958.status[1] = (emu->spdif_bits[idx] >> 8) & 0xff;
+	ucontrol->value.iec958.status[2] = (emu->spdif_bits[idx] >> 16) & 0xff;
+	ucontrol->value.iec958.status[3] = (emu->spdif_bits[idx] >> 24) & 0xff;
+        return 0;
+}
+
+static int snd_audigyls_spdif_get_mask(snd_kcontrol_t * kcontrol,
+				      snd_ctl_elem_value_t * ucontrol)
+{
+	ucontrol->value.iec958.status[0] = 0xff;
+	ucontrol->value.iec958.status[1] = 0xff;
+	ucontrol->value.iec958.status[2] = 0xff;
+	ucontrol->value.iec958.status[3] = 0xff;
+        return 0;
+}
+
+static int snd_audigyls_spdif_put(snd_kcontrol_t * kcontrol,
+                                 snd_ctl_elem_value_t * ucontrol)
+{
+	audigyls_t *emu = snd_kcontrol_chip(kcontrol);
+	unsigned int idx = snd_ctl_get_ioffidx(kcontrol, &ucontrol->id);
+	int change;
+	unsigned int val;
+
+	val = (ucontrol->value.iec958.status[0] << 0) |
+	      (ucontrol->value.iec958.status[1] << 8) |
+	      (ucontrol->value.iec958.status[2] << 16) |
+	      (ucontrol->value.iec958.status[3] << 24);
+	change = val != emu->spdif_bits[idx];
+	if (change) {
+		snd_audigyls_ptr_write(emu, SPCS0 + idx, 0, val);
+		emu->spdif_bits[idx] = val;
+	}
+        return change;
+}
+
+static snd_kcontrol_new_t snd_audigyls_spdif_mask_control =
+{
+	.access =	SNDRV_CTL_ELEM_ACCESS_READ,
+        .iface =        SNDRV_CTL_ELEM_IFACE_MIXER,
+        .name =         SNDRV_CTL_NAME_IEC958("",PLAYBACK,MASK),
+	.count =	4,
+        .info =         snd_audigyls_spdif_info,
+        .get =          snd_audigyls_spdif_get_mask
+};
+
+static snd_kcontrol_new_t snd_audigyls_spdif_control =
+{
+        .iface =	SNDRV_CTL_ELEM_IFACE_MIXER,
+        .name =         SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT),
+	.count =	4,
+        .info =         snd_audigyls_spdif_info,
+        .get =          snd_audigyls_spdif_get,
+        .put =          snd_audigyls_spdif_put
+};
+
 static int snd_audigyls_volume_info(snd_kcontrol_t *kcontrol, snd_ctl_elem_info_t * uinfo, int channel_id)
 {
         uinfo->type = SNDRV_CTL_ELEM_TYPE_INTEGER;
@@ -1361,28 +1527,75 @@
         .put =          snd_audigyls_volume_put_rear
 };
 
+static int remove_ctl(snd_card_t *card, const char *name)
+{
+	snd_ctl_elem_id_t id;
+	memset(&id, 0, sizeof(id));
+	strcpy(id.name, name);
+	id.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	return snd_ctl_remove_id(card, &id);
+}
+
+static snd_kcontrol_t *ctl_find(snd_card_t *card, const char *name)
+{
+	snd_ctl_elem_id_t sid;
+	memset(&sid, 0, sizeof(sid));
+	/* FIXME: strcpy is bad. */
+	strcpy(sid.name, name);
+	sid.iface = SNDRV_CTL_ELEM_IFACE_MIXER;
+	return snd_ctl_find_id(card, &sid);
+}
+
+#if 0
+static int rename_ctl(snd_card_t *card, const char *src, const char *dst)
+{
+	snd_kcontrol_t *kctl = ctl_find(card, src);
+	if (kctl) {
+		strcpy(kctl->id.name, dst);
+		return 0;
+	}
+	return -ENOENT;
+}
+#endif
+
 static int __devinit snd_audigyls_mixer(audigyls_t *emu)
 {
         int err;
         snd_kcontrol_t *kctl;
         snd_card_t *card = emu->card;
-        if ((kctl = emu->ctl_front_volume = snd_ctl_new1(&snd_audigyls_volume_control_front, emu)) == NULL)
+        if ((kctl = snd_ctl_new1(&snd_audigyls_volume_control_front, emu)) == NULL)
                 return -ENOMEM;
         if ((err = snd_ctl_add(card, kctl)))
                 return err;
-        if ((kctl = emu->ctl_front_volume = snd_ctl_new1(&snd_audigyls_volume_control_rear, emu)) == NULL)
+        if ((kctl = snd_ctl_new1(&snd_audigyls_volume_control_rear, emu)) == NULL)
                 return -ENOMEM;
         if ((err = snd_ctl_add(card, kctl)))
                 return err;
-        if ((kctl = emu->ctl_front_volume = snd_ctl_new1(&snd_audigyls_volume_control_center_lfe, emu)) == NULL)
+        if ((kctl = snd_ctl_new1(&snd_audigyls_volume_control_center_lfe, emu)) == NULL)
                 return -ENOMEM;
         if ((err = snd_ctl_add(card, kctl)))
                 return err;
-        if ((kctl = emu->ctl_front_volume = snd_ctl_new1(&snd_audigyls_volume_control_unknown, emu)) == NULL)
+        if ((kctl = snd_ctl_new1(&snd_audigyls_volume_control_unknown, emu)) == NULL)
                 return -ENOMEM;
         if ((err = snd_ctl_add(card, kctl)))
                 return err;
-
+	if ((kctl = snd_ctl_new1(&snd_audigyls_spdif_mask_control, emu)) == NULL)
+		return -ENOMEM;
+	if ((err = snd_ctl_add(card, kctl)))
+		return err;
+	if ((kctl = snd_ctl_new1(&snd_audigyls_shared_spdif, emu)) == NULL)
+		return -ENOMEM;
+	if ((err = snd_ctl_add(card, kctl)))
+		return err;
+	if ((kctl = ctl_find(card, SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT))) != NULL) {
+		/* already defined by ac97, remove it */
+		/* FIXME: or do we need both controls? */
+		remove_ctl(card, SNDRV_CTL_NAME_IEC958("",PLAYBACK,DEFAULT));
+	}
+	if ((kctl = snd_ctl_new1(&snd_audigyls_spdif_control, emu)) == NULL)
+		return -ENOMEM;
+	if ((err = snd_ctl_add(card, kctl)))
+		return err;
         return 0;
 }
 

--------------050405070501030509030401--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
