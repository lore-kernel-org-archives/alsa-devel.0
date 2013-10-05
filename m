From: klem.dev@gmail.com
Subject: [PATCH 1/4] ESI W192M: Update ESI W192M driver.
Date: Sat,  5 Oct 2013 15:41:02 +0200
Message-ID: <525016e8.a556b40a.02db.ffff9b6a@mx.google.com>
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
Cc: Clement Guedez <klem.dev@gmail.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Clement Guedez <klem.dev@gmail.com>

Update Waveterminal 192M driver to support alsa changes that happened since last driver commit.

Signed-off-by: Clement Guedez <klem.dev@gmail.com>
---
 sound/pci/ice1712/wtm.c | 37 ++++++++++++++++++++++---------------
 1 file changed, 22 insertions(+), 15 deletions(-)

diff --git a/sound/pci/ice1712/wtm.c b/sound/pci/ice1712/wtm.c
index bcf30a3..b6b650c 100644
--- a/sound/pci/ice1712/wtm.c
+++ b/sound/pci/ice1712/wtm.c
@@ -463,7 +463,7 @@ static int wtm_add_controls(struct snd_ice1712 *ice)
 
 static int wtm_init(struct snd_ice1712 *ice)
 {
-	static unsigned short stac_inits_prodigy[] = {
+	static unsigned short stac_inits_wtm[] = {
 		STAC946X_RESET, 0,
 		(unsigned short)-1
 	};
@@ -473,9 +473,10 @@ static int wtm_init(struct snd_ice1712 *ice)
 	ice->num_total_dacs = 8;
 	ice->num_total_adcs = 4;
 	ice->force_rdma1 = 1;
+	ice->vt1720 = 0;  /* ice1724, e.g. 23 GPIOs */
 
 	/*initialize codec*/
-	p = stac_inits_prodigy;
+	p = stac_inits_wtm;
 	for (; *p != (unsigned short)-1; p += 2) {
 		stac9460_put(ice, p[0], p[1]);
 		stac9460_2_put(ice, p[0], p[1]);
@@ -485,19 +486,25 @@ static int wtm_init(struct snd_ice1712 *ice)
 
 
 static unsigned char wtm_eeprom[] = {
-	0x47,	/*SYSCONF: clock 192KHz, 4ADC, 8DAC */
-	0x80,	/* ACLINK : I2S */
-	0xf8,	/* I2S: vol; 96k, 24bit, 192k */
-	0xc1	/*SPDIF: out-en, spidf ext out*/,
-	0x9f,	/* GPIO_DIR */
-	0xff,	/* GPIO_DIR1 */
-	0x7f,	/* GPIO_DIR2 */
-	0x9f,	/* GPIO_MASK */
-	0xff,	/* GPIO_MASK1 */
-	0x7f,	/* GPIO_MASK2 */
-	0x16,	/* GPIO_STATE */
-	0x80,	/* GPIO_STATE1 */
-	0x00,	/* GPIO_STATE2 */
+	[ICE_EEP2_SYSCONF]     = 0x67, /* 49MHz crystal, mpu401,
+					* spdif-in+ 1 stereo ADC,
+					* 4 stereo DACs
+					*/
+	[ICE_EEP2_ACLINK]      = 0x80,  /* I2S */
+	[ICE_EEP2_I2S]         = 0xf8,  /* vol, 96k, 24bit, 192k */
+	[ICE_EEP2_SPDIF]       = 0xc1,  /* out-en, out-int, spdif-in */
+	[ICE_EEP2_GPIO_DIR]    = 0x9f,
+	[ICE_EEP2_GPIO_DIR1]   = 0xff,
+	[ICE_EEP2_GPIO_DIR2]   = 0x7f,
+	[ICE_EEP2_GPIO_MASK]   = 0x9f,
+	[ICE_EEP2_GPIO_MASK1]  = 0xff,
+	[ICE_EEP2_GPIO_MASK2]  = 0x7f,
+	[ICE_EEP2_GPIO_STATE]  = 0x16,
+	[ICE_EEP2_GPIO_STATE1] = 0x80,
+	[ICE_EEP2_GPIO_STATE2] = 0x00, /* GPIO20: 0 = CD drive dig. input
+					* passthrough,
+					* 1 = SPDIF-OUT from ice1724
+					*/
 };
 
 
-- 
1.8.4.rc3
