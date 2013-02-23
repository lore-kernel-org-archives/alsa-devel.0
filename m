From: Jonas Petersen <jnsptrsn1@gmail.com>
Subject: [PATCH 1/1] M-Audio Audiophile192: Fix SPDIF input
Date: Sat, 23 Feb 2013 23:38:43 +0100
Message-ID: <1361659123-2872-1-git-send-email-jnsptrsn1@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: patch@alsa-project.org
Cc: alsa-devel@alsa-project.org, Jonas Petersen <jnsptrsn1@gmail.com>
List-Id: alsa-devel@alsa-project.org


This patch fixes initialization of the AK4114 chip so spdif capture is working properly.
Worked out together with Pavel Hofman.

Signed-off-by: Jonas Petersen <jnsptrsn1@gmail.com>

diff --git a/sound/pci/ice1712/revo.c b/sound/pci/ice1712/revo.c
index 7641080..1112ec1 100644
--- a/sound/pci/ice1712/revo.c
+++ b/sound/pci/ice1712/revo.c
@@ -35,6 +35,7 @@
 struct revo51_spec {
 	struct snd_i2c_device *dev;
 	struct snd_pt2258 *pt2258;
+	struct ak4114 *ak4114;
 };
 
 static void revo_i2s_mclk_changed(struct snd_ice1712 *ice)
@@ -359,9 +360,9 @@ static struct snd_ak4xxx_private akm_ap192_priv = {
 	.cif = 0,
 	.data_mask = VT1724_REVO_CDOUT,
 	.clk_mask = VT1724_REVO_CCLK,
-	.cs_mask = VT1724_REVO_CS0 | VT1724_REVO_CS1,
-	.cs_addr = VT1724_REVO_CS1,
-	.cs_none = VT1724_REVO_CS0 | VT1724_REVO_CS1,
+	.cs_mask = VT1724_REVO_CS0 | VT1724_REVO_CS3,
+	.cs_addr = VT1724_REVO_CS3,
+	.cs_none = VT1724_REVO_CS0 | VT1724_REVO_CS3,
 	.add_flags = VT1724_REVO_CCLK, /* high at init */
 	.mask_flags = 0,
 };
@@ -372,7 +373,7 @@ static struct snd_ak4xxx_private akm_ap192_priv = {
  * CCLK (pin 34) -- GPIO1 pin 51 (shared with AK4358)
  * CSN  (pin 35) -- GPIO7 pin 59
  */
-#define AK4114_ADDR	0x02
+#define AK4114_ADDR	0x00
 
 static void write_data(struct snd_ice1712 *ice, unsigned int gpio,
 		       unsigned int data, int idx)
@@ -426,7 +427,7 @@ static unsigned int ap192_4wire_start(struct snd_ice1712 *ice)
 	tmp = snd_ice1712_gpio_read(ice);
 	tmp |= VT1724_REVO_CCLK; /* high at init */
 	tmp |= VT1724_REVO_CS0;
-	tmp &= ~VT1724_REVO_CS1;
+	tmp &= ~VT1724_REVO_CS3;
 	snd_ice1712_gpio_write(ice, tmp);
 	udelay(1);
 	return tmp;
@@ -434,7 +435,7 @@ static unsigned int ap192_4wire_start(struct snd_ice1712 *ice)
 
 static void ap192_4wire_finish(struct snd_ice1712 *ice, unsigned int tmp)
 {
-	tmp |= VT1724_REVO_CS1;
+	tmp |= VT1724_REVO_CS3;
 	tmp |= VT1724_REVO_CS0;
 	snd_ice1712_gpio_write(ice, tmp);
 	udelay(1);
@@ -470,27 +471,32 @@ static unsigned char ap192_ak4114_read(void *private_data, unsigned char addr)
 static int ap192_ak4114_init(struct snd_ice1712 *ice)
 {
 	static const unsigned char ak4114_init_vals[] = {
-		AK4114_RST | AK4114_PWN | AK4114_OCKS0 | AK4114_OCKS1,
+		AK4114_RST | AK4114_PWN | AK4114_OCKS0,
 		AK4114_DIF_I24I2S,
 		AK4114_TX1E,
-		AK4114_EFH_1024 | AK4114_DIT | AK4114_IPS(1),
+		AK4114_EFH_1024 | AK4114_DIT | AK4114_IPS(0),
 		0,
 		0
 	};
 	static const unsigned char ak4114_init_txcsb[] = {
 		0x41, 0x02, 0x2c, 0x00, 0x00
 	};
-	struct ak4114 *ak;
 	int err;
 
+	struct revo51_spec *spec;
+	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
+	if (!spec)
+		return -ENOMEM;
+	ice->spec = spec;
+
 	err = snd_ak4114_create(ice->card,
 				 ap192_ak4114_read,
 				 ap192_ak4114_write,
 				 ak4114_init_vals, ak4114_init_txcsb,
-				 ice, &ak);
+				 ice, &spec->ak4114);
 	/* AK4114 in Revo cannot detect external rate correctly.
 	 * No reason to stop capture stream due to incorrect checks */
-	ak->check_flags = AK4114_CHECK_NO_RATE;
+	spec->ak4114->check_flags = AK4114_CHECK_NO_RATE;
 
 	return 0; /* error ignored; it's no fatal error */
 }
@@ -562,6 +568,9 @@ static int revo_init(struct snd_ice1712 *ice)
 					       ice);
 		if (err < 0)
 			return err;
+		err = ap192_ak4114_init(ice);
+		if (err < 0)
+			return err;
 		
 		/* unmute all codecs */
 		snd_ice1712_gpio_write_bits(ice, VT1724_REVO_MUTE,
@@ -575,7 +584,7 @@ static int revo_init(struct snd_ice1712 *ice)
 
 static int revo_add_controls(struct snd_ice1712 *ice)
 {
-	struct revo51_spec *spec;
+	struct revo51_spec *spec = ice->spec;
 	int err;
 
 	switch (ice->eeprom.subvendor) {
@@ -597,7 +606,9 @@ static int revo_add_controls(struct snd_ice1712 *ice)
 		err = snd_ice1712_akm4xxx_build_controls(ice);
 		if (err < 0)
 			return err;
-		err = ap192_ak4114_init(ice);
+		/* only capture SPDIF over AK4114 */
+		err = snd_ak4114_build(spec->ak4114, NULL,
+		   ice->pcm->streams[SNDRV_PCM_STREAM_CAPTURE].substream);
 		if (err < 0)
 			return err;
 		break;
-- 
1.7.10.4
