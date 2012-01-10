From: pavel.hofman@ivitera.com
Subject: [PATCH - ice1724 3/3] ALSA: ice1724 - Support for
	ooAoo SQ210a
Date: Tue, 10 Jan 2012 20:28:48 +0100
Message-ID: <1326223728-3085-3-git-send-email-pavel.hofman@ivitera.com>
References: <1326223728-3085-1-git-send-email-pavel.hofman@ivitera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <1326223728-3085-1-git-send-email-pavel.hofman@ivitera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: Pavel Hofman <pavel.hofman@ivitera.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Pavel Hofman <pavel.hofman@ivitera.com>

This card shares PCI ids with Chaintec AV710. Therefore, it will not be
detected automatically, it can only be activated by the module parameter
model=sq210a.

Signed-off-by: Pavel Hofman <pavel.hofman@ivitera.com>

diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index 352f3ff..9236297 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -2185,6 +2185,40 @@ static struct snd_kcontrol_new snd_vt1724_mixer_pro_peak __devinitdata = {
 
 static struct snd_ice1712_card_info no_matched __devinitdata;
 
+
+/*
+  ooAoo cards with no controls
+*/
+static unsigned char ooaoo_sq210_eeprom[] __devinitdata = {
+	[ICE_EEP2_SYSCONF]     = 0x4c,	/* 49MHz crystal, no mpu401, no ADC,
+					   1xDACs */
+	[ICE_EEP2_ACLINK]      = 0x80,	/* I2S */
+	[ICE_EEP2_I2S]         = 0x78,	/* no volume, 96k, 24bit, 192k */
+	[ICE_EEP2_SPDIF]       = 0xc1,	/* out-en, out-int, out-ext */
+	[ICE_EEP2_GPIO_DIR]    = 0x00,	/* no GPIOs are used */
+	[ICE_EEP2_GPIO_DIR1]   = 0x00,
+	[ICE_EEP2_GPIO_DIR2]   = 0x00,
+	[ICE_EEP2_GPIO_MASK]   = 0xff,
+	[ICE_EEP2_GPIO_MASK1]  = 0xff,
+	[ICE_EEP2_GPIO_MASK2]  = 0xff,
+
+	[ICE_EEP2_GPIO_STATE]  = 0x00, /* inputs */
+	[ICE_EEP2_GPIO_STATE1] = 0x00, /* all 1, but GPIO_CPLD_RW
+					  and GPIO15 always zero */
+	[ICE_EEP2_GPIO_STATE2] = 0x00, /* inputs */
+};
+
+
+struct snd_ice1712_card_info snd_vt1724_ooaoo_cards[] __devinitdata = {
+	{
+		.name = "ooAoo SQ210a",
+		.model = "sq210a",
+		.eeprom_size = sizeof(ooaoo_sq210_eeprom),
+		.eeprom_data = ooaoo_sq210_eeprom,
+	},
+	{ } /* terminator */
+};
+
 static struct snd_ice1712_card_info *card_tables[] __devinitdata = {
 	snd_vt1724_revo_cards,
 	snd_vt1724_amp_cards,
@@ -2199,6 +2233,7 @@ static struct snd_ice1712_card_info *card_tables[] __devinitdata = {
 	snd_vt1724_wtm_cards,
 	snd_vt1724_se_cards,
 	snd_vt1724_qtet_cards,
+	snd_vt1724_ooaoo_cards,
 	NULL,
 };
 
-- 
1.7.0.4
