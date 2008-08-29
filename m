From: Maximilian Rehkopf <otakon@gmx.net>
Subject: [PATCH] ice1724: enable MIDI on Terratec Aureon 7.1
	Universe
Date: Fri, 29 Aug 2008 13:01:00 +0200
Message-ID: <48B7D6EC.7010408@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060903090104040804040307"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by alsa0.perex.cz (Postfix) with SMTP id 5DB6D2437A
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Aug 2008 13:01:03 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------060903090104040804040307
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

This enables MIDI on Terratec Aureon 7.1 Universe cards specifically.
Apparently the other envy24ht-based Aureon cards do not have MIDI ports,
hence I added a Universe specific eeprom array.

The newer cards (Aureon 7.1 PCI / 5.1 PCI/Fun) have MIDI but use a CMI
DSP so this driver does not concern them at all.

I am new to git, do I have to perform any git operations regarding the
patch myself?

Signed-off-by: Maximilian Rehkopf <otakon@gmx.net>

-- 
Maximilian Rehkopf <otakon@gmx.net>


--------------060903090104040804040307
Content-Type: text/x-patch;
 name="universe-midi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="universe-midi.patch"

diff --git a/alsa-kernel.orig/sound/pci/ice1712/aureon.c b/alsa-kernel/sound/pci/ice1712/aureon.c
index 868ae29..3676b89 100644
--- a/alsa-kernel.orig/sound/pci/ice1712/aureon.c
+++ b/alsa-kernel/sound/pci/ice1712/aureon.c
@@ -2158,6 +2158,22 @@ static unsigned char aureon71_eeprom[] __devinitdata = {
 };
 #define prodigy71_eeprom aureon71_eeprom
 
+static unsigned char aureon71_universe_eeprom[] __devinitdata = {
+	[ICE_EEP2_SYSCONF]     = 0x2b,	/* clock 512, mpu401, spdif-in/ADC, 4DACs */
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
 static unsigned char prodigy71lt_eeprom[] __devinitdata = {
 	[ICE_EEP2_SYSCONF]     = 0x4b,	/* clock 384, spdif-in/ADC, 4DACs */
 	[ICE_EEP2_ACLINK]      = 0x80,	/* I2S */
@@ -2203,8 +2219,8 @@ struct snd_ice1712_card_info snd_vt1724_aureon_cards[] __devinitdata = {
 		.model = "universe",
  		.chip_init = aureon_init,
  		.build_controls = aureon_add_controls,
- 		.eeprom_size = sizeof(aureon71_eeprom),
- 		.eeprom_data = aureon71_eeprom,
+ 		.eeprom_size = sizeof(aureon71_universe_eeprom),
+ 		.eeprom_data = aureon71_universe_eeprom,
 		.driver = "Aureon71Univ", /* keep in 15 letters */
 	},
 	{


--------------060903090104040804040307
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------060903090104040804040307--
