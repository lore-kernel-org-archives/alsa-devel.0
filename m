From: Randy Cushman <rcushman_linux@earthlink.net>
Subject: Re: Patch for AD1985 AC97 CODEC
Date: Thu, 21 Dec 2006 11:17:28 -0500
Message-ID: <458AB398.3020501@earthlink.net>
References: <456F9B57.5020107@earthlink.net>	<45749990.1080900@earthlink.net>	<457F49E5.5010104@earthlink.net>
	<s5hk60ofcfz.wl%tiwai@suse.de> <45889489.80304@earthlink.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030304070000020506040001"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45889489.80304@earthlink.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: tiwai@suse.de
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030304070000020506040001
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Takashi,

Sorry about that.  I managed to attach the wrong patch file for my 
second installment.

This should be the correct patch.

Randy Cushman


Randy Cushman wrote:
> Takashi,
>
> Attached please find the second installment of separated patches you 
> requested.
>
> I decided to submit this patch before receiving your response to my 
> questions because only one of the questions pertained to this patch 
> (the question regarding the renaming of volume controls), and I have 
> come to the conclusion that this patch should maintain existing 
> functionality regarding the volume controls.
>
> My reasoning for this is that the mixer controls for the Analog 
> Devices surround CODECs appear to have multiple problems that justify 
> a separate project, time permitting.  I'd rather focus this patch on 
> the work I've done so far, and save these other enhancements for 
> another time.
>
> Randy Cushman
>


--------------030304070000020506040001
Content-Type: text/plain;
 name="ac97_ad1985_3.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ac97_ad1985_3.patch"

Summary: fix malfunctioning mixer controls for AD1985

This patch replaces the "V_REFOUT Enable" mixer switch control
with a listbox control for the AD1985 CODEC.

Previous patch "AD1888 mixer controls for DC mode" added
controls that were propogated to multiple codecs.  For the
AD1985 codec, the bits VREFH and VREFD function differently,
preventing the "V_REFOUT Enable" control from setting V_REFOUT
to Hi-Z.

This patch also corrects an issue in which register bits relating
to mixer controls "Surround Jack Mode" and "Channel Mode".
The register bits controlled by these controls were being set
at boot time to states inconsistent with the stored values of
these controls.

Signed-off-by: Randy Cushman <rcushman_linux@earthlink.net>


--- a/alsa-kernel/pci/ac97/ac97_patch.c	2006-12-19 14:41:26.000000000 -0500
+++ b/alsa-kernel/pci/ac97/ac97_patch.c	2006-12-21 10:03:42.000000000 -0500
@@ -1629,13 +1629,16 @@
 #define AC97_AD198X_MBC_10	0x0001	/* +10dB */
 #define AC97_AD198X_MBC_30	0x0002	/* +30dB */
 #define AC97_AD198X_VREFD	0x0004	/* VREF high-Z */
-#define AC97_AD198X_VREFH	0x0008	/* 2.25V, 3.7V */
-#define AC97_AD198X_VREF_0	0x000c	/* 0V */
+#define AC97_AD198X_VREFH	0x0008	/* 0=2.25V, 1=3.7V */
+#define AC97_AD198X_VREF_0	0x000c	/* 0V (AD1985 only) */
+#define AC97_AD198X_VREF_MASK	(AC97_AD198X_VREFH | AC97_AD198X_VREFD)
+#define AC97_AD198X_VREF_SHIFT	2
 #define AC97_AD198X_SRU		0x0010	/* sample rate unlock */
 #define AC97_AD198X_LOSEL	0x0020	/* LINE_OUT amplifiers input select */
 #define AC97_AD198X_2MIC	0x0040	/* 2-channel mic select */
 #define AC97_AD198X_SPRD	0x0080	/* SPREAD enable */
-#define AC97_AD198X_DMIX0	0x0100	/* downmix mode: 0 = 6-to-4, 1 = 6-to-2 downmix */
+#define AC97_AD198X_DMIX0	0x0100	/* downmix mode: */
+					/*  0 = 6-to-4, 1 = 6-to-2 downmix */
 #define AC97_AD198X_DMIX1	0x0200	/* downmix mode: 1 = enabled */
 #define AC97_AD198X_HPSEL	0x0400	/* headphone amplifier input select */
 #define AC97_AD198X_CLDIS	0x0800	/* center/lfe disable */
@@ -1966,8 +1969,80 @@
 	return 0;
 }
 
+static int snd_ac97_ad1985_vrefout_info(struct snd_kcontrol *kcontrol,
+					struct snd_ctl_elem_info *uinfo)
+{
+	static char *texts[4] = {"High-Z", "3.7 V", "2.25 V", "0 V"};
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 4;
+	if (uinfo->value.enumerated.item > 3)
+		uinfo->value.enumerated.item = 3;
+	strcpy(uinfo->value.enumerated.name,
+	       texts[uinfo->value.enumerated.item]);
+	return 0;
+}
+
+static int snd_ac97_ad1985_vrefout_get(struct snd_kcontrol *kcontrol,
+				       struct snd_ctl_elem_value *ucontrol)
+{
+	static const int reg2ctrl[4] = {2, 0, 1, 3};
+	struct snd_ac97 *ac97 = snd_kcontrol_chip(kcontrol);
+	unsigned short val;
+	val = (ac97->regs[AC97_AD_MISC] & AC97_AD198X_VREF_MASK)
+	      >> AC97_AD198X_VREF_SHIFT;
+	ucontrol->value.enumerated.item[0] = reg2ctrl[val];
+	return 0;
+}
+
+static int snd_ac97_ad1985_vrefout_put(struct snd_kcontrol *kcontrol, 
+				       struct snd_ctl_elem_value *ucontrol)
+{
+	static const int ctrl2reg[4] = {1, 2, 0, 3};
+	struct snd_ac97 *ac97 = snd_kcontrol_chip(kcontrol);
+	unsigned short val;
+
+	if (ucontrol->value.enumerated.item[0] > 3
+	    || ucontrol->value.enumerated.item[0] < 0)
+		return -EINVAL;
+	val = ctrl2reg[ucontrol->value.enumerated.item[0]]
+	      << AC97_AD198X_VREF_SHIFT;
+	return snd_ac97_update_bits(ac97, AC97_AD_MISC,
+				    AC97_AD198X_VREF_MASK, val);
+}
+
 static const struct snd_kcontrol_new snd_ac97_ad1985_controls[] = {
-	AC97_SINGLE("Exchange Center/LFE", AC97_AD_SERIAL_CFG, 3, 1, 0)
+	AC97_SINGLE("Exchange Center/LFE", AC97_AD_SERIAL_CFG, 3, 1, 0),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Exchange Front/Surround",
+		.info = snd_ac97_ad1888_lohpsel_info,
+		.get = snd_ac97_ad1888_lohpsel_get,
+		.put = snd_ac97_ad1888_lohpsel_put
+	},
+	AC97_SINGLE("High Pass Filter Enable", AC97_AD_TEST2, 12, 1, 1),
+	AC97_SINGLE("Spread Front to Surround and Center/LFE",
+		    AC97_AD_MISC, 7, 1, 0),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Downmix",
+		.info = snd_ac97_ad1888_downmix_info,
+		.get = snd_ac97_ad1888_downmix_get,
+		.put = snd_ac97_ad1888_downmix_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "V_REFOUT",
+		.info = snd_ac97_ad1985_vrefout_info,
+		.get = snd_ac97_ad1985_vrefout_get,
+		.put = snd_ac97_ad1985_vrefout_put
+	},
+	AC97_SURROUND_JACK_MODE_CTL,
+	AC97_CHANNEL_MODE_CTL,
+
+	AC97_SINGLE("Headphone Jack Sense", AC97_AD_JACK_SPDIF, 10, 1, 0),
+	AC97_SINGLE("Line Jack Sense", AC97_AD_JACK_SPDIF, 12, 1, 0),
 };
 
 static void ad1985_update_jacks(struct snd_ac97 *ac97)
@@ -1981,9 +2056,16 @@
 {
 	int err;
 
-	if ((err = patch_ad1980_specific(ac97)) < 0)
+	/* rename 0x04 as "Master" and 0x02 as "Master Surround" */
+	snd_ac97_rename_vol_ctl(ac97, "Master Playback",
+				"Master Surround Playback");
+	snd_ac97_rename_vol_ctl(ac97, "Headphone Playback", "Master Playback");
+
+	if ((err = patch_build_controls(ac97, &snd_ac97_ad198x_2cmic, 1)) < 0)
 		return err;
-	return patch_build_controls(ac97, snd_ac97_ad1985_controls, ARRAY_SIZE(snd_ac97_ad1985_controls));
+
+	return patch_build_controls(ac97, snd_ac97_ad1985_controls,
+				    ARRAY_SIZE(snd_ac97_ad1985_controls));
 }
 
 static struct snd_ac97_build_ops patch_ad1985_build_ops = {
@@ -2003,19 +2085,18 @@
 	ac97->build_ops = &patch_ad1985_build_ops;
 	misc = snd_ac97_read(ac97, AC97_AD_MISC);
 	/* switch front/surround line-out/hp-out */
-	/* center/LFE, mic in 3.75V mode */
 	/* AD-compatible mode */
 	/* Stereo mutes enabled */
-	/* in accordance with ADI driver: misc | 0x5c28 */
 	snd_ac97_write_cache(ac97, AC97_AD_MISC, misc |
-			     AC97_AD198X_VREFH |
 			     AC97_AD198X_LOSEL |
 			     AC97_AD198X_HPSEL |
-			     AC97_AD198X_CLDIS |
-			     AC97_AD198X_LODIS |
 			     AC97_AD198X_MSPLT |
 			     AC97_AD198X_AC97NC);
 	ac97->flags |= AC97_STEREO_MUTES;
+
+	/* update current jack configuration */
+	ad1985_update_jacks(ac97);
+
 	/* on AD1985 rev. 3, AC'97 revision bits are zero */
 	ac97->ext_id = (ac97->ext_id & ~AC97_EI_REV_MASK) | AC97_EI_REV_23;
 	return 0;

--------------030304070000020506040001
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------030304070000020506040001
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------030304070000020506040001--
