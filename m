From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
Subject: Re: A: VIA Technologies Inc. VT1720/24
Date: Thu, 25 Jan 2007 11:13:19 +0100
Message-ID: <20070125101319.GA3340@titan.lahn.de>
References: <45AFE785.6020307@informatik.uni-oldenburg.de>
	<45B74CC0.4060905@svs.Informatik.Uni-Oldenburg.de>
	<s5hac08cvct.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5hac08cvct.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: ALSA developers <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hello Takashi!

On Wed, Jan 24, 2007 at 04:12:02PM +0100, Takashi Iwai wrote:
> I recommend you to use the same string for this driver name here.

Yes.

> This string is referred by alsa-lib to pick up the corresponding
> config file.  As Prodigy 7.1 Hifi is almost identical with Prodigy 7.1
> LT from the configuration POV, it should use "Prodigy71LT", too, so
> that you don't have to change alsa-lib at all.

No, the HiFi seems to be more like the Prodigy71 (without 'LT' or 'XT')
But I might err. Is there something I can do to test is it has 3 or 4
DACs, which seems to be the main difference?

> Otherwise changes look OK to me, but your patch conflicts with the
> latest ALSA HG tree because of the patch applied prior to this.
> Could you regenerate the patch to ALSA HG tree (with the fix above)?

Yes, see below. Three more questions:
1. Since the "Aureon7.1", "Prodigy7.1" and my "Prodigy7.1HiFi"; as well
as the "Prodigy7.1LT" and the "Prodigy7.1XT" respectively seem so share
the same EEPROM-Date, wouldn't it be better to re-use/share those
eeprom-data instead of declaring them 3 respectively 2 times?
Not much space saving, but gcc seems to be too stupid to recognize this;
Even const'ifying the structures doesn't help.

2. Most arrays and structures seem to be read only, what about adding
'const' to them?

3. Do you prefer array initialization in the form of
 {1, 2, 3, } /* IDX0, IDX1, IDX2 */
or as
 { [IDX0] = 1, [IDX1] = 2, [IDX2] = 3, }

> thanks,

You're doing the main job, I have to thank you.

> Takashi

Philipp


From: Philipp Matthias Hahn <pmhahn@pmhahn.de>

Fix small typo in comment of Prodigy 7.1 Light/XT
Add support for AudioTrak Prodigy 7.1 HiFi

Signed-of-by: Philipp Matthias Hahn <pmhahn@pmhahn.de>
---

--- pci/ice1712/aureon.c~	2007-01-25 10:07:50.000000000 +0100
+++ pci/ice1712/aureon.c	2007-01-25 10:46:56.000000000 +0100
@@ -2141,6 +2141,9 @@ static unsigned char aureon71_eeprom[] _
 	0x00,	/* GPIO_STATE2 */
 };
 
+#if 1 /* Prodigy7.1 has same EEPROM as Aureon7.1 */
+#define prodigy71_eeprom aureon71_eeprom
+#else
 static unsigned char prodigy71_eeprom[] __devinitdata = {
 	0x0b,	/* SYSCONF: clock 512, spdif-in/ADC, 4DACs */
 	0x80,	/* ACLINK: I2S */
@@ -2156,9 +2159,10 @@ static unsigned char prodigy71_eeprom[] 
 	0x00,	/* GPIO_STATE1 */
 	0x00,	/* GPIO_STATE2 */
 };
+#endif
 
 static unsigned char prodigy71lt_eeprom[] __devinitdata = {
-	0x4b,	/* SYSCINF: clock 512, spdif-in/ADC, 4DACs */
+	0x4b,	/* SYSCONF: clock 384, spdif-in/ADC, 4DACs */
 	0x80,	/* ACLINK: I2S */
 	0xfc,	/* I2S: vol, 96k, 24bit, 192k */
 	0xc3,	/* SPDIF: out-en, out-int, spdif-in */
@@ -2173,8 +2177,11 @@ static unsigned char prodigy71lt_eeprom[
 	0x00,	/* GPIO_STATE2 */
 };
 
+#if 1 /* Prodigy7.1XT has same EEPROM as Prodigy7.1LT */
+#define prodigy71xt_eeprom prodigy71lt_eeprom
+#else
 static unsigned char prodigy71xt_eeprom[] __devinitdata = {
-	0x4b,	/* SYSCINF: clock 512, spdif-in/ADC, 4DACs */
+	0x4b,	/* SYSCONF: clock 384, spdif-in/ADC, 4DACs */
 	0x80,	/* ACLINK: I2S */
 	0xfc,	/* I2S: vol, 96k, 24bit, 192k */
 	0xc3,	/* SPDIF: out-en, out-int, spdif-in */
@@ -2188,6 +2195,27 @@ static unsigned char prodigy71xt_eeprom[
 	0x00,	/* GPIO_STATE1 */
 	0x00,	/* GPIO_STATE2 */
 };
+#endif
+
+#if 1 /* Prodigy7.1HiFi has same EEPROM as Aureon7.1 */
+#define prodigy71hifi_eeprom aureon71_eeprom
+#else
+static unsigned char prodigy71hifi_eeprom[] __devinitdata = {
+	[ICE_EEP2_SYSCONF]     = 0x0b,	/* clock 512, spdif-in/ADC, 4DACs */
+	[ICE_EEP2_ACLINK]      = 0x80,	/* I2S */
+	[ICE_EEP2_I2S]         = 0xfc,	/* vol, 96k, 24bit, 192k */
+	[ICE_EEP2_SPDIF]       = 0xc3,	/* out-en, out-int, spdif-in */
+	[ICE_EEP2_GPIO_DIR]    = 0xff,
+	[ICE_EEP2_GPIO_DIR1]   = 0xff,
+	[ICE_EEP2_GPIO_DIR2]   = 0x5f,
+	[ICE_EEP2_GPIO_MASK]   = 0x00,
+	[ICE_EEP2_GPIO_MASK1]  = 0x00,
+	[ICE_EEP2_GPIO_MASK2]  = 0x00,
+	[ICE_EEP2_GPIO_STATE]  = 0x00,
+	[ICE_EEP2_GPIO_STATE1] = 0x00,
+	[ICE_EEP2_GPIO_STATE2] = 0x00,
+};
+#endif
 
 /* entry point */
 struct snd_ice1712_card_info snd_vt1724_aureon_cards[] __devinitdata = {
@@ -2251,5 +2279,15 @@ struct snd_ice1712_card_info snd_vt1724_
 		.eeprom_data = prodigy71xt_eeprom,
 		.driver = "Prodigy71LT",
 	},
+	{
+		.subvendor = VT1724_SUBDEVICE_PRODIGY71HIFI,
+		.name = "Audiotrak Prodigy 7.1 HiFi",
+		.model = "prodigy71hifi",
+		.chip_init = aureon_init,
+		.build_controls = aureon_add_controls,
+		.eeprom_size = sizeof(prodigy71hifi_eeprom),
+		.eeprom_data = prodigy71hifi_eeprom,
+		.driver = "Prodigy71", /* should be identical with Aureon71 */
+	},
 	{ } /* terminator */
 };
--- pci/ice1712/aureon.h~	2007-01-25 10:07:50.000000000 +0100
+++ pci/ice1712/aureon.h	2007-01-25 10:20:04.000000000 +0100
@@ -29,7 +29,8 @@
 				       "{Terratec,Aureon 7.1 Universe}," \
 					"{AudioTrak,Prodigy 7.1}," \
 					"{AudioTrak,Prodigy 7.1 LT},"\
-					"{AudioTrak,Prodigy 7.1 XT},"
+					"{AudioTrak,Prodigy 7.1 XT},"\
+					"{AudioTrak,Prodigy 7.1 HiFi},"
 
 #define VT1724_SUBDEVICE_AUREON51_SKY	0x3b154711	/* Aureon 5.1 Sky */
 #define VT1724_SUBDEVICE_AUREON71_SPACE	0x3b154511	/* Aureon 7.1 Space */
@@ -37,6 +38,7 @@
 #define VT1724_SUBDEVICE_PRODIGY71	0x33495345	/* PRODIGY 7.1 */
 #define VT1724_SUBDEVICE_PRODIGY71LT	0x32315441	/* PRODIGY 7.1 LT */
 #define VT1724_SUBDEVICE_PRODIGY71XT	0x36315441	/* PRODIGY 7.1 XT*/
+#define VT1724_SUBDEVICE_PRODIGY71HIFI	0x38315441	/* PRODIGY 7.1 HiFi */
 
 extern struct snd_ice1712_card_info  snd_vt1724_aureon_cards[];

-- 
  / /  (_)__  __ ____  __ Philipp Hahn
 / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
