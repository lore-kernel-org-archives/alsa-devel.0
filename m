From: Randy Cushman <rcushman_linux@earthlink.net>
Subject: Re: Patch for AD1985 AC97 CODEC
Date: Tue, 12 Dec 2006 19:31:33 -0500
Message-ID: <457F49E5.5010104@earthlink.net>
References: <456F9B57.5020107@earthlink.net> <45749990.1080900@earthlink.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------000001080000010904010309"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45749990.1080900@earthlink.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------000001080000010904010309
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Attached please find my latest patch of AC '97 CODEC improvements.  This 
supersedes the patches I submitted on 30-Nov-2006 and 4-Dec-2006.

I am including my enhancements for the AD1985 and the AD1986/AD1986A 
CODECs in a single patch due to interdependencies.

Notes:
- I have tested AD1985 functionality to the extent possible (mostly by 
diffing register outputs).
- I have tested nearly all AD1986 functionality, except:
  - My hardware is not equipped to test the Jack Sense mixer controls.
  - I do not have any convenient method of testing the S/PDIF output at 
this time.
  - I made no effort to resolve anticipated Power Management issues.
- I noticed that the first time I booted with these new drivers 
installed, the front speaker balance was off.  Moving the Master 
Surround slider all the way down and then back resolved the issue.

Randy Cushman


Randy Cushman wrote:
> Attached please find my revision 2 patch of improvements to the AD1985 
> CODEC driver.  This supersedes the patch I submitted on 30-Nov-2006, 
> and patches the latest Mercurial source.
>
> At this time I am figuring that I may be able to reduce the amount of 
> work I create for the ALSA-Project team if I combine my work into a 
> smaller number of patches.  This combined patch includes all of the 
> modifications I have planned for the AD1985 CODEC driver.  I am 
> continuing work on a patch to create separate AD1986/AD1986A CODEC 
> driver code.
>
> In this revised, combined patch I have included my "fix microphone and 
> line_in selection logic" patch that should help users of the AD1985, 
> along with many other multichannel CODECs.  I have also decided to 
> provide an enhanced V_REFOUT control, rather than simply remove the 
> faulty control, as I had done in my previous revision.
>
> Again, any feedback regarding my work is welcome.
>
> Randy Cushman
>
>
> Randy Cushman wrote:
>> (This message references ALSA bugtracking issue ID 2655.
>> https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2655)
>>
>> I am researching issues I am having with the audio chipsets onboard my
>> ASUS A8S-X Motherboard, which has an AD1986A CODEC, using its AC'97
>> interface.
>>
>> $ cat /proc/asound/cards
>>  0 [SI7012 ]: ICH - SiS SI7012
>>                       SiS SI7012 with AD1986 at 0x8000, irq 50
>>
>> The attached patch file removes the "V_REFOUT Enable" mixer control that
>> recently was added to the driver for the AD1888 CODEC, and was inherited
>> by the driver for the AD1985 CODEC.  The AD1986/AD1986A CODECs currently
>> utilize the AD1985 driver.
>>
>> I am preparing additional patches that will provide improved support for
>> these CODECs.  Please let me know if my work thus far is satisfactory.
>>
>> Randy Cushman
>>
>>
>> ------------------------------------------------------------------------
>>
>> ------------------------------------------------------------------------- 
>>
>> Take Surveys. Earn Cash. Influence the Future of IT
>> Join SourceForge.net's Techsay panel and you'll get the chance to 
>> share your
>> opinions on IT & business topics through brief surveys - and earn cash
>> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV 
>>
>> ------------------------------------------------------------------------
>>
>> _______________________________________________
>> Alsa-devel mailing list
>> Alsa-devel@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>>   
>
> ------------------------------------------------------------------------
>
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> ------------------------------------------------------------------------
>
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
>   


--------------000001080000010904010309
Content-Type: text/plain;
 name="ac97_ad1986_1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ac97_ad1986_1.patch"

Summary: fix microphone and line_in selection logic

This patch fixes the Microphone and LINE_IN select logic for
surround codecs with shared jacks.  This issue appears to apply
to most, if not all AC'97 surround codecs.  The existing code
can never utilize the shared jacks for Microphone and LINE_IN
due to the reversed jack selection logic.  The patched code
correctly selects the shared jack for input if the "Channel Mode"
selector does not specify that the jack is to be used for output.

Specifically, in "2ch" mode the Center/LFE jack is used for
microphone input and the Surround jack is used for LINE_IN,
in "4ch" mode the Center/LFE jack is used for microphone input
and the Surround jack is used for output, and in "6ch" mode
both jacks are used for output.

Signed-off-by: Randy Cushman <rcushman_linux@earthlink.net>


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


Summary: fix various issues with AD1986/AD1986A support

Previously, ac97_codec.c was coded to support AD1986 and AD1986A
CODECs using code written for the AD1985 CODEC.  This allowed the
LINE_OUT and HEADPHONE jacks to function properly, however register
differences between the CODECs prevented line and microphone inputs
from functioning.

Specifically, this patch fixes issues with the following mixer
controls:  'V_REFOUT', 'Spread Front to Surround and Center/LFE',
'Exchange Front/Surround', 'Surround Jack Mode', and 'Channel Mode'.
This patch removes the undocumented AD1888 control
'High Pass Filter Enable' and adds the new control
'Exchange Mic/Line In'.

Signed-off-by: Randy Cushman <rcushman_linux@earthlink.net>


diff -r bc7ef767d0cf include/ac97_codec.h
--- a/include/ac97_codec.h	Wed Nov 29 15:29:40 2006 +0100
+++ b/include/ac97_codec.h	Wed Dec 06 09:59:58 2006 -0500
@@ -282,9 +282,11 @@
 #define AC97_AD_TEST		0x5a	/* test register */
 #define AC97_AD_TEST2		0x5c	/* undocumented test register 2 */
 #define AC97_AD_CODEC_CFG	0x70	/* codec configuration */
+#define AC97_AD_MISC2		0x70	/* Misc Control Bits 2 (AD1986) */
 #define AC97_AD_JACK_SPDIF	0x72	/* Jack Sense & S/PDIF */
 #define AC97_AD_SERIAL_CFG	0x74	/* Serial Configuration */
 #define AC97_AD_MISC		0x76	/* Misc Control Bits */
+#define AC97_AD_MISC3		0x7a	/* Misc Control Bits 3 (AD1986) */
 
 /* specific - Cirrus Logic */
 #define AC97_CSR_ACMODE		0x5e	/* AC Mode Register */
@@ -503,6 +505,7 @@ struct snd_ac97 {
 			unsigned short id[3];		// codec IDs (lower 16-bit word)
 			unsigned short pcmreg[3];	// PCM registers
 			unsigned short codec_cfg[3];	// CODEC_CFG bits
+			unsigned short swap_mic_linein;
 		} ad18xx;
 		unsigned int dev_flags;		/* device specific */
 	} spec;
diff -r bc7ef767d0cf pci/ac97/ac97_codec.c
--- a/pci/ac97/ac97_codec.c	Wed Nov 29 15:29:40 2006 +0100
+++ b/pci/ac97/ac97_codec.c	Fri Dec 01 15:19:51 2006 -0500
@@ -111,7 +111,7 @@ static const struct ac97_codec_id snd_ac
 { 0x41445372, 0xffffffff, "AD1981A",		patch_ad1981a,	NULL },
 { 0x41445374, 0xffffffff, "AD1981B",		patch_ad1981b,	NULL },
 { 0x41445375, 0xffffffff, "AD1985",		patch_ad1985,	NULL },
-{ 0x41445378, 0xffffffff, "AD1986",		patch_ad1985,	NULL },
+{ 0x41445378, 0xffffffff, "AD1986",		patch_ad1986,	NULL },
 { 0x414c4300, 0xffffff00, "ALC100,100P", 	NULL,		NULL },
 { 0x414c4710, 0xfffffff0, "ALC200,200P",	NULL,		NULL },
 { 0x414c4721, 0xffffffff, "ALC650D",		NULL,	NULL }, /* already patched */
diff -r bc7ef767d0cf pci/ac97/ac97_patch.c
--- a/pci/ac97/ac97_patch.c	Wed Nov 29 15:29:40 2006 +0100
+++ b/pci/ac97/ac97_patch.c	Tue Dec 12 16:28:49 2006 -0500
@@ -192,12 +192,12 @@ static inline int is_clfe_on(struct snd_
 
 static inline int is_shared_linein(struct snd_ac97 *ac97)
 {
-	return ! ac97->indep_surround && is_surround_on(ac97);
+	return ! ac97->indep_surround && ! is_surround_on(ac97);
 }
 
 static inline int is_shared_micin(struct snd_ac97 *ac97)
 {
-	return ! ac97->indep_surround && is_clfe_on(ac97);
+	return ! ac97->indep_surround && ! is_clfe_on(ac97);
 }
 
 
@@ -1609,14 +1609,16 @@ int patch_ad1886(struct snd_ac97 * ac97)
 	return 0;
 }
 
-/* MISC bits */
+/* MISC bits (AD1888/AD1980/AD1985 register 0x76) */
 #define AC97_AD198X_MBC		0x0003	/* mic boost */
 #define AC97_AD198X_MBC_20	0x0000	/* +20dB */
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
@@ -1629,6 +1631,68 @@ int patch_ad1886(struct snd_ac97 * ac97)
 #define AC97_AD198X_MSPLT	0x2000	/* mute split */
 #define AC97_AD198X_AC97NC	0x4000	/* AC97 no compatible mode */
 #define AC97_AD198X_DACZ	0x8000	/* DAC zero-fill mode */
+
+/* MISC 1 bits (AD1986 register 0x76) */
+#define AC97_AD1986_MBC		0x0003	/* mic boost */
+#define AC97_AD1986_MBC_20	0x0000	/* +20dB */
+#define AC97_AD1986_MBC_10	0x0001	/* +10dB */
+#define AC97_AD1986_MBC_30	0x0002	/* +30dB */
+#define AC97_AD1986_LISEL0	0x0004	/* LINE_IN select bit 0 */
+#define AC97_AD1986_LISEL1	0x0008	/* LINE_IN select bit 1 */
+#define AC97_AD1986_LISEL_MASK	(AC97_AD1986_LISEL1 | AC97_AD1986_LISEL0)
+#define AC97_AD1986_LISEL_LI	0x0000  /* LINE_IN pins as LINE_IN source */
+#define AC97_AD1986_LISEL_SURR	0x0004  /* SURROUND pins as LINE_IN source */
+#define AC97_AD1986_LISEL_MIC	0x0008  /* MIC_1/2 pins as LINE_IN source */
+#define AC97_AD1986_SRU		0x0010	/* sample rate unlock */
+#define AC97_AD1986_SOSEL	0x0020	/* SURROUND_OUT amplifiers input select */
+#define AC97_AD1986_2MIC	0x0040	/* 2-channel mic select */
+#define AC97_AD1986_SPRD	0x0080	/* SPREAD enable */
+#define AC97_AD1986_DMIX0	0x0100	/* downmix mode: 0 = 6-to-4, 1 = 6-to-2 downmix */
+#define AC97_AD1986_DMIX1	0x0200	/* downmix mode: 1 = enabled */
+#define AC97_AD1986_CLDIS	0x0800	/* center/lfe disable */
+#define AC97_AD1986_SODIS	0x1000	/* SURROUND_OUT disable */
+#define AC97_AD1986_MSPLT	0x2000	/* mute split (read only 1) */
+#define AC97_AD1986_AC97NC	0x4000	/* AC97 no compatible mode (r/o 1) */
+#define AC97_AD1986_DACZ	0x8000	/* DAC zero-fill mode */
+
+/* MISC 2 bits (AD1986 register 0x70) */
+#define AC97_AD1986_CVREF0	0x0004	/* C/LFE VREF_OUT 2.25V */
+#define AC97_AD1986_CVREF1	0x0008	/* C/LFE VREF_OUT 0V */
+#define AC97_AD1986_CVREF2	0x0010	/* C/LFE VREF_OUT 3.7V */
+#define AC97_AD1986_CVREF_MASK	(AC97_AD1986_CVREF2 | AC97_AD1986_CVREF1 | AC97_AD1986_CVREF0)
+#define AC97_AD1986_JSMAP	0x0020	/* Jack Sense Mapping 1 = alternate */
+#define AC97_AD1986_MMDIS	0x0080	/* Mono Mute Disable */
+#define AC97_AD1986_MVREF0	0x0400	/* MIC VREF_OUT 2.25V */
+#define AC97_AD1986_MVREF1	0x0800	/* MIC VREF_OUT 0V */
+#define AC97_AD1986_MVREF2	0x1000	/* MIC VREF_OUT 3.7V */
+#define AC97_AD1986_MVREF_MASK	(AC97_AD1986_MVREF2 | AC97_AD1986_MVREF1 | AC97_AD1986_MVREF0)
+
+/* MISC 3 bits (AD1986 register 0x7a) */
+#define AC97_AD1986_MMIX	0x0004	/* Mic Mix, left/right */
+#define AC97_AD1986_GPO		0x0008	/* General Purpose Out */
+#define AC97_AD1986_LOHPEN	0x0010	/* LINE_OUT headphone drive */
+#define AC97_AD1986_LVREF0	0x0100	/* LINE_OUT VREF_OUT 2.25V */
+#define AC97_AD1986_LVREF1	0x0200	/* LINE_OUT VREF_OUT 0V */
+#define AC97_AD1986_LVREF2	0x0400	/* LINE_OUT VREF_OUT 3.7V */
+#define AC97_AD1986_LVREF_MASK	(AC97_AD1986_LVREF2 | AC97_AD1986_LVREF1 | AC97_AD1986_LVREF0)
+#define AC97_AD1986_JSINVA	0x0800	/* Jack Sense Invert SENSE_A */
+#define AC97_AD1986_LOSEL	0x1000	/* LINE_OUT amplifiers input select */
+#define AC97_AD1986_HPSEL0	0x2000	/* Headphone amplifiers input select surround DACs */
+#define AC97_AD1986_HPSEL1	0x4000	/* Headphone amplifiers input select C/LFE DACs */
+#define AC97_AD1986_JSINVB	0x8000	/* Jack Sense Invert SENSE_B */
+
+/* Serial Config bits (AD1986 register 0x74) (incomplete) */
+#define AC97_AD1986_OMS0	0x0100	/* Optional Mic Selector bit 0 */
+#define AC97_AD1986_OMS1	0x0200	/* Optional Mic Selector bit 1 */
+#define AC97_AD1986_OMS2	0x0400	/* Optional Mic Selector bit 2 */
+#define AC97_AD1986_OMS_MASK	(AC97_AD1986_OMS2 | AC97_AD1986_OMS1 | AC97_AD1986_OMS0)
+#define AC97_AD1986_OMS_M	0x0000  /* MIC_1/2 pins as MIC source */
+#define AC97_AD1986_OMS_L	0x0100  /* LINE_IN pins as MIC source */
+#define AC97_AD1986_OMS_C	0x0200  /* Center/LFE pins as MCI source */
+#define AC97_AD1986_OMS_MC	0x0400  /* Mix MIC and C/LFE pins as MIC source */
+#define AC97_AD1986_OMS_ML	0x0500  /* MIX MIC and LINE_IN pins as MIC source */
+#define AC97_AD1986_OMS_LC	0x0600  /* MIX LINE_IN and C/LFE pins as MIC source */
+#define AC97_AD1986_OMS_MLC	0x0700  /* MIX MIC, LINE_IN and C/LFE pins as MIC source */
 
 
 static int snd_ac97_ad198x_spdif_source_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
@@ -1952,8 +2016,75 @@ int patch_ad1980(struct snd_ac97 * ac97)
 	return 0;
 }
 
+static int snd_ac97_ad1985_vrefout_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
+{
+	static char *texts[4] = {"High-Z", "3.7 V", "2.25 V", "0 V"};
+
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_ENUMERATED;
+	uinfo->count = 1;
+	uinfo->value.enumerated.items = 4;
+	if (uinfo->value.enumerated.item > 3)
+		uinfo->value.enumerated.item = 3;
+	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
+	return 0;
+}
+
+static int snd_ac97_ad1985_vrefout_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
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
+static int snd_ac97_ad1985_vrefout_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
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
+	AC97_SINGLE("Spread Front to Surround and Center/LFE", AC97_AD_MISC, 7, 1, 0),
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
@@ -1967,8 +2098,13 @@ static int patch_ad1985_specific(struct 
 {
 	int err;
 
-	if ((err = patch_ad1980_specific(ac97)) < 0)
+	/* rename 0x04 as "Master" and 0x02 as "Master Surround" */
+	snd_ac97_rename_vol_ctl(ac97, "Master Playback", "Master Surround Playback");
+	snd_ac97_rename_vol_ctl(ac97, "Headphone Playback", "Master Playback");
+
+	if ((err = patch_build_controls(ac97, &snd_ac97_ad198x_2cmic, 1)) < 0)
 		return err;
+
 	return patch_build_controls(ac97, snd_ac97_ad1985_controls, ARRAY_SIZE(snd_ac97_ad1985_controls));
 }
 
@@ -1989,23 +2125,303 @@ int patch_ad1985(struct snd_ac97 * ac97)
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
 }
+
+static int snd_ac97_ad1986_bool_info(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_info *uinfo)
+{
+	uinfo->type = SNDRV_CTL_ELEM_TYPE_BOOLEAN;
+	uinfo->count = 1;
+	uinfo->value.integer.min = 0;
+	uinfo->value.integer.max = 1;
+	return 0;
+}
+
+static int snd_ac97_ad1986_lososel_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *ac97 = snd_kcontrol_chip(kcontrol);
+	unsigned short val;
+
+	val = ac97->regs[AC97_AD_MISC3];
+	ucontrol->value.integer.value[0] = (val & AC97_AD1986_LOSEL) != 0;
+	return 0;
+}
+
+static int snd_ac97_ad1986_lososel_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *ac97 = snd_kcontrol_chip(kcontrol);
+	int ret0;
+	int ret1;
+	int sprd = (ac97->regs[AC97_AD_MISC] & AC97_AD1986_SPRD) != 0;
+
+	ret0 = snd_ac97_update_bits(ac97, AC97_AD_MISC3, AC97_AD1986_LOSEL,
+					ucontrol->value.integer.value[0] != 0
+				    ? AC97_AD1986_LOSEL : 0);
+	if (ret0 < 0)
+		return ret0;
+
+	/* SOSEL is set to values of "Spread" or "Exchange F/S" controls */
+	ret1 = snd_ac97_update_bits(ac97, AC97_AD_MISC, AC97_AD1986_SOSEL,
+				    (ucontrol->value.integer.value[0] != 0
+				     || sprd)
+				    ? AC97_AD1986_SOSEL : 0);
+	if (ret1 < 0)
+		return ret1;
+
+	return (ret0 > 0 || ret1 > 0) ? 1 : 0;
+}
+
+static int snd_ac97_ad1986_spread_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *ac97 = snd_kcontrol_chip(kcontrol);
+	unsigned short val;
+
+	val = ac97->regs[AC97_AD_MISC];
+	ucontrol->value.integer.value[0] = (val & AC97_AD1986_SPRD) != 0;
+	return 0;
+}
+
+static int snd_ac97_ad1986_spread_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *ac97 = snd_kcontrol_chip(kcontrol);
+	int ret0;
+	int ret1;
+	int losel = (ac97->regs[AC97_AD_MISC3] & AC97_AD1986_LOSEL) != 0;
+
+	ret0 = snd_ac97_update_bits(ac97, AC97_AD_MISC, AC97_AD1986_SPRD,
+					ucontrol->value.integer.value[0] != 0
+				    ? AC97_AD1986_SPRD : 0);
+	if (ret0 < 0)
+		return ret0;
+
+	/* SOSEL is set to values of "Spread" or "Exchange F/S" controls */
+	ret1 = snd_ac97_update_bits(ac97, AC97_AD_MISC, AC97_AD1986_SOSEL,
+				    (ucontrol->value.integer.value[0] != 0
+				     || losel)
+				    ? AC97_AD1986_SOSEL : 0);
+	if (ret1 < 0)
+		return ret1;
+
+	return (ret0 > 0 || ret1 > 0) ? 1 : 0;
+}
+
+static int snd_ac97_ad1986_miclisel_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *ac97 = snd_kcontrol_chip(kcontrol);
+
+	ucontrol->value.integer.value[0] = ac97->spec.ad18xx.swap_mic_linein;
+	return 0;
+}
+
+static int snd_ac97_ad1986_miclisel_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *ac97 = snd_kcontrol_chip(kcontrol);
+	unsigned char swap = ucontrol->value.integer.value[0] != 0;
+
+	if (swap != ac97->spec.ad18xx.swap_mic_linein) {
+		ac97->spec.ad18xx.swap_mic_linein = swap;
+		if (ac97->build_ops->update_jacks)
+			ac97->build_ops->update_jacks(ac97);
+		return 1;
+	}
+	return 0;
+}
+
+static int snd_ac97_ad1986_vrefout_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+{
+	/* Use MIC_1/2 V_REFOUT as the "get" value */
+	struct snd_ac97 *ac97 = snd_kcontrol_chip(kcontrol);
+	unsigned short val;
+	unsigned short reg = ac97->regs[AC97_AD_MISC2];
+	if ((reg & AC97_AD1986_MVREF0) != 0)
+		val = 2;
+	else if ((reg & AC97_AD1986_MVREF1) != 0)
+		val = 3;
+	else if ((reg & AC97_AD1986_MVREF2) != 0)
+		val = 1;
+	else
+		val = 0;
+	ucontrol->value.enumerated.item[0] = val;
+	return 0;
+}
+
+static int snd_ac97_ad1986_vrefout_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
+{
+	struct snd_ac97 *ac97 = snd_kcontrol_chip(kcontrol);
+	unsigned short cval;
+	unsigned short lval;
+	unsigned short mval;
+	int cret;
+	int lret;
+	int mret;
+
+	switch (ucontrol->value.enumerated.item[0])
+	{
+	case 0: /* High-Z */
+		cval = 0;
+		lval = 0;
+		mval = 0;
+		break;
+	case 1: /* 3.7 V */
+		cval = AC97_AD1986_CVREF2;
+		lval = AC97_AD1986_LVREF2;
+		mval = AC97_AD1986_MVREF2;
+		break;
+	case 2: /* 2.25 V */
+		cval = AC97_AD1986_CVREF0;
+		lval = AC97_AD1986_LVREF0;
+		mval = AC97_AD1986_MVREF0;
+		break;
+	case 3: /* 0 V */
+		cval = AC97_AD1986_CVREF1;
+		lval = AC97_AD1986_LVREF1;
+		mval = AC97_AD1986_MVREF1;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	cret = snd_ac97_update_bits(ac97, AC97_AD_MISC2,
+				    AC97_AD1986_CVREF_MASK, cval);
+	if (cret < 0)
+		return cret;
+	lret = snd_ac97_update_bits(ac97, AC97_AD_MISC3,
+				    AC97_AD1986_LVREF_MASK, lval);
+	if (lret < 0)
+		return lret;
+	mret = snd_ac97_update_bits(ac97, AC97_AD_MISC2,
+				    AC97_AD1986_MVREF_MASK, mval);
+	if (mret < 0)
+		return mret;
+
+	return (cret > 0 || lret > 0 || mret > 0) ? 1 : 0;
+}
+
+static const struct snd_kcontrol_new snd_ac97_ad1986_controls[] = {
+	AC97_SINGLE("Exchange Center/LFE", AC97_AD_SERIAL_CFG, 3, 1, 0),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Exchange Front/Surround",
+		.info = snd_ac97_ad1986_bool_info,
+		.get = snd_ac97_ad1986_lososel_get,
+		.put = snd_ac97_ad1986_lososel_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Exchange Mic/Line In",
+		.info = snd_ac97_ad1986_bool_info,
+		.get = snd_ac97_ad1986_miclisel_get,
+		.put = snd_ac97_ad1986_miclisel_put
+	},
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Spread Front to Surround and Center/LFE",
+		.info = snd_ac97_ad1986_bool_info,
+		.get = snd_ac97_ad1986_spread_get,
+		.put = snd_ac97_ad1986_spread_put
+	},
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
+		.get = snd_ac97_ad1986_vrefout_get,
+		.put = snd_ac97_ad1986_vrefout_put
+	},
+	AC97_SURROUND_JACK_MODE_CTL,
+	AC97_CHANNEL_MODE_CTL,
+
+	AC97_SINGLE("Headphone Jack Sense", AC97_AD_JACK_SPDIF, 10, 1, 0),
+	AC97_SINGLE("Line Jack Sense", AC97_AD_JACK_SPDIF, 12, 1, 0)
+};
+
+static void ad1986_update_jacks(struct snd_ac97 *ac97)
+{
+	unsigned short misc_val = 0;
+	unsigned short ser_val;
+
+	/* disable SURROUND and CENTER/LFE if not surround mode */
+	if (! is_surround_on(ac97))
+		misc_val |= AC97_AD1986_SODIS;
+	if (! is_clfe_on(ac97))
+		misc_val |= AC97_AD1986_CLDIS;
+
+	/* select line input (default=LINE_IN, SURROUND or MIC_1/2) */
+	if (is_shared_linein(ac97))
+		misc_val |= AC97_AD1986_LISEL_SURR;
+	else if (ac97->spec.ad18xx.swap_mic_linein != 0)
+		misc_val |= AC97_AD1986_LISEL_MIC;
+	snd_ac97_update_bits(ac97, AC97_AD_MISC,
+			     AC97_AD1986_SODIS | AC97_AD1986_CLDIS |
+			     AC97_AD1986_LISEL_MASK,
+			     misc_val);
+
+	/* select microphone input (MIC_1/2, Center/LFE or LINE_IN) */
+	if (is_shared_micin(ac97))
+		ser_val = AC97_AD1986_OMS_C;
+	else if (ac97->spec.ad18xx.swap_mic_linein != 0)
+		ser_val = AC97_AD1986_OMS_L;
+	else
+		ser_val = AC97_AD1986_OMS_M;
+	snd_ac97_update_bits(ac97, AC97_AD_SERIAL_CFG,
+			     AC97_AD1986_OMS_MASK,
+			     ser_val);
+}
+
+static int patch_ad1986_specific(struct snd_ac97 *ac97)
+{
+	int err;
+
+	/* rename 0x02 as "Master Surround" */
+	snd_ac97_rename_vol_ctl(ac97, "Master Playback", "Master Surround Playback");
+
+	if ((err = patch_build_controls(ac97, &snd_ac97_ad198x_2cmic, 1)) < 0)
+		return err;
+
+	return patch_build_controls(ac97, snd_ac97_ad1986_controls, ARRAY_SIZE(snd_ac97_ad1985_controls));
+}
+
+static struct snd_ac97_build_ops patch_ad1986_build_ops = {
+	.build_post_spdif = patch_ad198x_post_spdif,
+	.build_specific = patch_ad1986_specific,
+#ifdef CONFIG_PM
+	.resume = ad18xx_resume,
+#endif
+	.update_jacks = ad1986_update_jacks,
+};
+
+int patch_ad1986(struct snd_ac97 * ac97)
+{
+	patch_ad1881(ac97);
+	ac97->build_ops = &patch_ad1986_build_ops;
+	ac97->flags |= AC97_STEREO_MUTES;
+
+	/* update current jack configuration */
+	ad1986_update_jacks(ac97);
+
+	return 0;
+}
+
 
 /*
  * realtek ALC65x/850 codecs
diff -r bc7ef767d0cf pci/ac97/ac97_patch.h
--- a/pci/ac97/ac97_patch.h	Wed Nov 29 15:29:40 2006 +0100
+++ b/pci/ac97/ac97_patch.h	Fri Dec 01 15:20:42 2006 -0500
@@ -48,6 +48,7 @@ int patch_ad1981a(struct snd_ac97 * ac97
 int patch_ad1981a(struct snd_ac97 * ac97);
 int patch_ad1981b(struct snd_ac97 * ac97);
 int patch_ad1985(struct snd_ac97 * ac97);
+int patch_ad1986(struct snd_ac97 * ac97);
 int patch_alc650(struct snd_ac97 * ac97);
 int patch_alc655(struct snd_ac97 * ac97);
 int patch_alc850(struct snd_ac97 * ac97);

--------------000001080000010904010309
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------000001080000010904010309
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------000001080000010904010309--
