From: Randy Cushman <rcushman_linux@earthlink.net>
Subject: Patch for AD1985 AC97 CODEC
Date: Thu, 30 Nov 2006 22:02:47 -0500
Message-ID: <456F9B57.5020107@earthlink.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080105030307040107010500"
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
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------080105030307040107010500
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

(This message references ALSA bugtracking issue ID 2655.
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=2655)

I am researching issues I am having with the audio chipsets onboard my
ASUS A8S-X Motherboard, which has an AD1986A CODEC, using its AC'97
interface.

$ cat /proc/asound/cards
  0 [SI7012 ]: ICH - SiS SI7012
                       SiS SI7012 with AD1986 at 0x8000, irq 50

The attached patch file removes the "V_REFOUT Enable" mixer control that
recently was added to the driver for the AD1888 CODEC, and was inherited
by the driver for the AD1985 CODEC.  The AD1986/AD1986A CODECs currently
utilize the AD1985 driver.

I am preparing additional patches that will provide improved support for
these CODECs.  Please let me know if my work thus far is satisfactory.

Randy Cushman



--------------080105030307040107010500
Content-Type: text/plain;
 name="ac97_ad1985_1.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ac97_ad1985_1.patch"

Summary: remove malfunctioning mixer control for AD1985/AD1986

This patch removes the "V_REFOUT Enable" mixer control for the
AD1985 and AD1986 CODECs.

Previous patch "AD1888 mixer controls for DC mode" added
controls that were propogated to multiple codecs.  For the
AD1985 codec, the bits VREFH and VREFD function differently,
preventing the "V_REFOUT Enable" control from setting V_REFOUT
to Hi-Z. For the AD1986 codec, the V_REFOUT pins are controlled
by other register bits.

Signed-off-by: Randy Cushman <rcushman_linux@earthlink.net>

--- ./a/alsa-kernel/pci/ac97/ac97_patch.c	2006-11-30 10:29:25.000000000 -0500
+++ ./b/alsa-kernel/pci/ac97/ac97_patch.c	2006-11-30 11:30:52.000000000 -0500
@@ -1953,7 +1953,27 @@
 }
 
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
+	AC97_SINGLE("Spread Front to Surround and Center/LFE", AC97_AD_MISC, 7, 1, 0),
+	{
+		.iface = SNDRV_CTL_ELEM_IFACE_MIXER,
+		.name = "Downmix",
+		.info = snd_ac97_ad1888_downmix_info,
+		.get = snd_ac97_ad1888_downmix_get,
+		.put = snd_ac97_ad1888_downmix_put
+	},
+	AC97_SURROUND_JACK_MODE_CTL,
+	AC97_CHANNEL_MODE_CTL,
+
+	AC97_SINGLE("Headphone Jack Sense", AC97_AD_JACK_SPDIF, 10, 1, 0),
+	AC97_SINGLE("Line Jack Sense", AC97_AD_JACK_SPDIF, 12, 1, 0),
 };
 
 static void ad1985_update_jacks(struct snd_ac97 *ac97)
@@ -1967,8 +1987,13 @@
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
 


--------------080105030307040107010500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------080105030307040107010500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------080105030307040107010500--
