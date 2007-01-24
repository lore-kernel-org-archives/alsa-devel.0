From: Philipp Matthias Hahn <pmhahn@svs.Informatik.Uni-Oldenburg.de>
Subject: Re: A: VIA Technologies Inc. VT1720/24
Date: Wed, 24 Jan 2007 13:10:40 +0100
Message-ID: <45B74CC0.4060905@svs.Informatik.Uni-Oldenburg.de>
References: <45AFE785.6020307@informatik.uni-oldenburg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------090806020102030001040802"
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <45AFE785.6020307@informatik.uni-oldenburg.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: ALSA developers <alsa-devel@lists.sourceforge.net>
Cc: ALSA users <alsa-user@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------090806020102030001040802
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Philipp Matthias Hahn wrote:
> I'm not subscribed, so please cc: me on replies.
> 
> I have several Fujitsu-Siemens Scenic W600 with an Onboard AD1885 AC97
> Audio Codec. (See
> http://www.fujitsu-siemens.co.uk/rl/servicesupport/techsupport/boards/Motherboards/FSC/D1321/D1321.htm

Wrong link, the right one is
http://www.fujitsu-siemens.co.uk/rl/servicesupport/techsupport/Boards/Motherboards/FSC/D1527/D1527.htm

> for the board description). This one is working fine with the
> snd-intel8x0 module from the Linux-2.6.18.6 kernel.
> 
> In one of those computers I plugged in an additional sound card:
> 
> 	AudioTrak Prodigy 7.1 HiFi
> 
> XXXXX:/dev# lspci -s 2:0d.0
> 02:0d.0 Multimedia audio controller: VIA Technologies Inc. VT1720/24
> [Envy24PT/HT] PCI Multi-Channel Audio Controller (rev 01)
> 
> XXXXX:/dev# lspci -s 2:0d.0 -nvxxx
> 02:0d.0 0401: 1412:1724 (rev 01)
>         Subsystem: 3138:4154
>         Flags: medium devsel, IRQ 21
>         I/O ports at 3c00 [disabled] [size=32]
>         I/O ports at 3800 [disabled] [size=128]
>         Capabilities: [80] Power Management version 1
> 00: 12 14 24 17 00 00 10 02 01 00 01 04 00 40 00 00
> 10: 01 3c 00 00 01 38 00 00 00 00 00 00 00 00 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 38 31 54 41
> 30: 00 00 00 00 80 00 00 00 00 00 00 00 05 01 00 00
> 40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 80: 01 00 01 04 00 00 00 00 00 00 00 00 00 00 00 00
> 90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 
> Now I have two problems:
> 
> 1. The onboard intel8x0-sound is now missing, that is, the following
> Device is no longer listed using "lspci":
> 0000:00:1f.5 Multimedia audio controller: Intel Corp. 82801DB/DBL/DBM
> (ICH4/ICH4-L/ICH4-M) AC'97 Audio Controller (rev 01)
> 
> Is there a way to re-enable it, so I can use both cards?
> (On a side node not relevant for ALSA: the board also has an onboard
> integrated graphics controller, which is also disables by plugging in an
> AGP card. Would also be nice to re-enable it.)

Solved: I had to switch the BIOS from "Auto" to "Always enable".

> 2. Loading the "snd-ice1724" module reports this failure:
> 
> ACPI: PCI Interrupt 0000:02:0d.0[A] -> GSI 21 (level, low) -> IRQ 21
> ice1724: No matching model found for ID 0x38315441
> ice1724: Invalid EEPROM (size = 120)
> ACPI: PCI interrupt for device 0000:02:0d.0 disabled
> ICE1724: probe of 0000:02:0d.0 failed with error -5
> 
> Can somebody help me to get this working?
> 
> Seemd I'm not alone, but I can't understand the language:
> http://www.google.com/search?q=cache:ZaBwG4Ge5b4J:forum.ubuntu.pl/viewtopic.php%3Ft%3D16017%26view%3Dprevious%26sid%3D0a6db6f9be5123927dfb6c3a582e3eef+ice1724+0x38315441&hl=de&gl=de&ct=clnk&cd=1&client=firefox

I did some reading and hacking myself, since it just seems to be the
same as the Prodigy 7.1 with just a different model ID. See the attached
patch for a first version. It seems to work thus far without any problems.

Sincerly

Philipp Hahn
-- 
      Dipl.-Inform. Philipp.Hahn@informatik.uni-oldenburg.de
      Abteilung Systemsoftware und verteilte Systeme, Fk. II
Carl von Ossietzky Universitaet Oldenburg, 26111 Oldenburg, Germany
    http://www.svs.informatik.uni-oldenburg.de/contact/pmhahn/
      Telefon: +49 441 798-2866    Telefax: +49 441 798-2756

--------------090806020102030001040802
Content-Type: text/x-patch;
 name="sound_pci_ice1712.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sound_pci_ice1712.diff"

From: Philipp Matthias Hahn <pmhahn@pmhahn.de>

Fix small typo in comment of Prodigy 7.1 Light
Add support for AudioTrak Prodigt 7.1 HiFi

Signed-of-by: Philipp Matthias Hahn <pmhahn@pmhahn.de>
---

--- sound/pci/ice1712/aureon.c	2006-12-17 01:21:00.000000000 +0100
+++ sound/pci/ice1712/aureon.c	2007-01-19 10:50:19.000000000 +0100
@@ -2085,7 +2085,7 @@ static unsigned char prodigy71_eeprom[] 
 };
 
 static unsigned char prodigy71lt_eeprom[] __devinitdata = {
-	0x4b,	/* SYSCINF: clock 512, spdif-in/ADC, 4DACs */
+	0x4b,	/* SYSCONF: clock 384, spdif-in/ADC, 4DACs */
 	0x80,	/* ACLINK: I2S */
 	0xfc,	/* I2S: vol, 96k, 24bit, 192k */
 	0xc3,	/* SPDIF: out-en, out-int, spdif-in */
@@ -2100,6 +2100,22 @@ static unsigned char prodigy71lt_eeprom[
 	0x00,	/* GPIO_STATE2 */
 };
 	
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
+
 
 /* entry point */
 struct snd_ice1712_card_info snd_vt1724_aureon_cards[] __devinitdata = {
@@ -2153,5 +2169,15 @@ struct snd_ice1712_card_info snd_vt1724_
 		.eeprom_data = prodigy71lt_eeprom,
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
+		.driver = "Prodigy71HiFi", /* should be identical with Prodigy71 */
+	},
 	{ } /* terminator */
 };
--- sound/pci/ice1712/aureon.h	2006-12-17 01:21:00.000000000 +0100
+++ sound/pci/ice1712/aureon.h	2007-01-19 10:50:19.000000000 +0100
@@ -28,13 +28,15 @@
 				       "{Terratec,Aureon 7.1 Space},"\
 				       "{Terratec,Aureon 7.1 Universe}," \
 					"{AudioTrak,Prodigy 7.1}," \
-					"{AudioTrak,Prodigy 7.1 LT},"
+					"{AudioTrak,Prodigy 7.1 LT},"\
+					"{AudioTrak,Prodigy 7.1 HiFi},"
 
 #define VT1724_SUBDEVICE_AUREON51_SKY	0x3b154711	/* Aureon 5.1 Sky */
 #define VT1724_SUBDEVICE_AUREON71_SPACE	0x3b154511	/* Aureon 7.1 Space */
 #define VT1724_SUBDEVICE_AUREON71_UNIVERSE	0x3b155311	/* Aureon 7.1 Universe */
 #define VT1724_SUBDEVICE_PRODIGY71	0x33495345	/* PRODIGY 7.1 */
 #define VT1724_SUBDEVICE_PRODIGY71LT	0x32315441	/* PRODIGY 7.1 LT */
+#define VT1724_SUBDEVICE_PRODIGY71HIFI	0x38315441	/* PRODIGY 7.1 HiFi */
 
 extern struct snd_ice1712_card_info  snd_vt1724_aureon_cards[];
 


--------------090806020102030001040802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------090806020102030001040802
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel

--------------090806020102030001040802--
