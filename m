From: Brian Bloniarz <brian.bloniarz@gmail.com>
Subject: [PATCH] [ALSA] ice1712 - working M-Audio Delta 66E
	support
Date: Wed, 08 Dec 2010 12:45:20 -0800
Message-ID: <4CFFEE60.5080304@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
	[209.85.160.51]) by alsa0.perex.cz (Postfix) with ESMTP id C507C2443D
	for <alsa-devel@alsa-project.org>; Wed,  8 Dec 2010 21:45:24 +0100 (CET)
Received: by pwj4 with SMTP id 4so480578pwj.38
	for <alsa-devel@alsa-project.org>; Wed, 08 Dec 2010 12:45:23 -0800 (PST)
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

Rev. E of the M-Audio Delta 66 is partially supported (commit
ef2cd2ccad66b4aba518eca7514eface267ee0f3), but the layout of the GPIO
pins was still unclear. This patch adds the GPIO definitions so that
communication to the CS8247 & 2x AK4524 works correctly.

ALSA bug#3327 has more details; users cap & jhunt report there that the
GPIO wiring is similar to the Digigram VX442 (chip select: pin 4 =
CS8427, pin 5 = AK4524 #0, pin 6 = AK4524 #1).  There has been a lot of
conflicting information in the bug, but given these definitions, my
Delta 66E works; I tested analog in&out at 44.1kHz & 96kHz, analog gain
settings, S/PDIF clock sync, and S/PDIF in&out at 44.1kHz.

Signed-off-by: Brian Bloniarz <brian.bloniarz@gmail.com>
---
 sound/pci/ice1712/delta.c |   49 ++++++++++++++++++++++++++++++++++++++++++++-
 sound/pci/ice1712/delta.h |   11 ++++++++++
 2 files changed, 59 insertions(+), 1 deletions(-)

diff --git a/sound/pci/ice1712/delta.c b/sound/pci/ice1712/delta.c
index 712c171..7b62de0 100644
--- a/sound/pci/ice1712/delta.c
+++ b/sound/pci/ice1712/delta.c
@@ -96,6 +96,11 @@ static unsigned char ap_cs8427_codec_select(struct snd_ice1712 *ice)
 		tmp |= ICE1712_DELTA_AP_CCLK | ICE1712_DELTA_AP_CS_CODEC;
 		tmp &= ~ICE1712_DELTA_AP_CS_DIGITAL;
 		break;
+	case ICE1712_SUBDEVICE_DELTA66E:
+		tmp |= ICE1712_DELTA_66E_CCLK | ICE1712_DELTA_66E_CS_CHIP_A |
+		       ICE1712_DELTA_66E_CS_CHIP_B;
+		tmp &= ~ICE1712_DELTA_66E_CS_CS8427;
+		break;
 	case ICE1712_SUBDEVICE_VX442:
 		tmp |= ICE1712_VX442_CCLK | ICE1712_VX442_CODEC_CHIP_A | ICE1712_VX442_CODEC_CHIP_B;
 		tmp &= ~ICE1712_VX442_CS_DIGITAL;
@@ -119,6 +124,9 @@ static void ap_cs8427_codec_deassert(struct snd_ice1712 *ice, unsigned char tmp)
 	case ICE1712_SUBDEVICE_DELTA410:
 		tmp |= ICE1712_DELTA_AP_CS_DIGITAL;
 		break;
+	case ICE1712_SUBDEVICE_DELTA66E:
+		tmp |= ICE1712_DELTA_66E_CS_CS8427;
+		break;
 	case ICE1712_SUBDEVICE_VX442:
 		tmp |= ICE1712_VX442_CS_DIGITAL;
 		break;
@@ -276,6 +284,20 @@ static void delta1010lt_ak4524_lock(struct snd_akm4xxx *ak, int chip)
 }
 
 /*
+ * AK4524 on Delta66 rev E to choose the chip address
+ */
+static void delta66e_ak4524_lock(struct snd_akm4xxx *ak, int chip)
+{
+	struct snd_ak4xxx_private *priv = (void *)ak->private_value[0];
+	struct snd_ice1712 *ice = ak->private_data[0];
+
+	snd_ice1712_save_gpio_status(ice);
+	priv->cs_mask =
+	priv->cs_addr = chip == 0 ? ICE1712_DELTA_66E_CS_CHIP_A :
+				    ICE1712_DELTA_66E_CS_CHIP_B;
+}
+
+/*
  * AK4528 on VX442 to choose the chip mask
  */
 static void vx442_ak4524_lock(struct snd_akm4xxx *ak, int chip)
@@ -487,6 +509,29 @@ static struct snd_ak4xxx_private akm_delta1010lt_priv __devinitdata = {
 	.mask_flags = 0,
 };
 
+static struct snd_akm4xxx akm_delta66e __devinitdata = {
+	.type = SND_AK4524,
+	.num_adcs = 4,
+	.num_dacs = 4,
+	.ops = {
+		.lock = delta66e_ak4524_lock,
+		.set_rate_val = delta_ak4524_set_rate_val
+	}
+};
+
+static struct snd_ak4xxx_private akm_delta66e_priv __devinitdata = {
+	.caddr = 2,
+	.cif = 0, /* the default level of the CIF pin from AK4524 */
+	.data_mask = ICE1712_DELTA_66E_DOUT,
+	.clk_mask = ICE1712_DELTA_66E_CCLK,
+	.cs_mask = 0,
+	.cs_addr = 0, /* set later */
+	.cs_none = 0,
+	.add_flags = 0,
+	.mask_flags = 0,
+};
+
+
 static struct snd_akm4xxx akm_delta44 __devinitdata = {
 	.type = SND_AK4524,
 	.num_adcs = 4,
@@ -644,9 +689,11 @@ static int __devinit snd_ice1712_delta_init(struct snd_ice1712 *ice)
 		err = snd_ice1712_akm4xxx_init(ak, &akm_delta44, &akm_delta44_priv, ice);
 		break;
 	case ICE1712_SUBDEVICE_VX442:
-	case ICE1712_SUBDEVICE_DELTA66E:
 		err = snd_ice1712_akm4xxx_init(ak, &akm_vx442, &akm_vx442_priv, ice);
 		break;
+	case ICE1712_SUBDEVICE_DELTA66E:
+		err = snd_ice1712_akm4xxx_init(ak, &akm_delta66e, &akm_delta66e_priv, ice);
+		break;
 	default:
 		snd_BUG();
 		return -EINVAL;
diff --git a/sound/pci/ice1712/delta.h b/sound/pci/ice1712/delta.h
index 1a0ac6c..11a9c3a 100644
--- a/sound/pci/ice1712/delta.h
+++ b/sound/pci/ice1712/delta.h
@@ -144,6 +144,17 @@ extern struct snd_ice1712_card_info snd_ice1712_delta_cards[];
 #define ICE1712_DELTA_1010LT_CS_NONE	0x50	/* nothing */
 #define ICE1712_DELTA_1010LT_WORDCLOCK 0x80	/* sample clock source: 0 = Word Clock Input, 1 = S/PDIF Input ??? */
 
+/* M-Audio Delta 66 rev. E definitions.
+ * Newer revisions of Delta 66 have CS8427 over SPI for
+ * S/PDIF transceiver instead of CS8404/CS8414. */
+/* 0x01 = DFS */
+#define ICE1712_DELTA_66E_CCLK		0x02	/* SPI clock */
+#define ICE1712_DELTA_66E_DIN		0x04	/* data input */
+#define ICE1712_DELTA_66E_DOUT		0x08	/* data output */
+#define ICE1712_DELTA_66E_CS_CS8427	0x10	/* chip select, low = CS8427 */
+#define ICE1712_DELTA_66E_CS_CHIP_A	0x20	/* AK4524 #0 */
+#define ICE1712_DELTA_66E_CS_CHIP_B	0x40	/* AK4524 #1 */
+
 /* Digigram VX442 definitions */
 #define ICE1712_VX442_CCLK		0x02	/* SPI clock */
 #define ICE1712_VX442_DIN		0x04	/* data input */
-- 
1.7.1
