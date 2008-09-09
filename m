From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH 23/24] sound/pci: coding style fixes: vx222
Date: Tue, 9 Sep 2008 06:02:59 +0400
Message-ID: <20080909020259.GZ6211@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.188])
	by alsa0.perex.cz (Postfix) with ESMTP id 6A222103844
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 04:03:05 +0200 (CEST)
Received: by fk-out-0910.google.com with SMTP id b27so1407398fka.0
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 19:03:05 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



- <asm/io.h> -> <linux/io.h>
- remove trailing whitespaces
- convert comments

Only compile tested.

Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---

 sound/pci/vx222/vx222.c     |    2 +-
 sound/pci/vx222/vx222_ops.c |  330 +++++++++++++++++++++---------------------
 2 files changed, 166 insertions(+), 166 deletions(-)

diff --git a/sound/pci/vx222/vx222.c b/sound/pci/vx222/vx222.c
index acc352f..ec7c743 100644
--- a/sound/pci/vx222/vx222.c
+++ b/sound/pci/vx222/vx222.c
@@ -154,7 +154,7 @@ static int __devinit snd_vx222_create(struct snd_card *card, struct pci_dev *pci
 	vx_ops = hw->type == VX_TYPE_BOARD ? &vx222_old_ops : &vx222_ops;
 	chip = snd_vx_create(card, hw, vx_ops,
 			     sizeof(struct snd_vx222) - sizeof(struct vx_core));
-	if (! chip) {
+	if (!chip) {
 		pci_disable_device(pci);
 		return -ENOMEM;
 	}
diff --git a/sound/pci/vx222/vx222_ops.c b/sound/pci/vx222/vx222_ops.c
index 7e87f39..7d1350a 100644
--- a/sound/pci/vx222/vx222_ops.c
+++ b/sound/pci/vx222/vx222_ops.c
@@ -28,7 +28,7 @@
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/tlv.h>
-#include <asm/io.h>
+#include <linux/io.h>
 #include "vx222.h"
 
 
@@ -50,12 +50,12 @@ static int vx2_reg_offset[VX_REG_MAX] = {
 	[VX_HIFREQ] = 0x38,
 	[VX_CSUER]  = 0x3c,
 	[VX_SELMIC] = 0x40,
-	[VX_COMPOT] = 0x44, // Write: POTENTIOMETER ; Read: COMPRESSION LEVEL activate
-	[VX_SCOMPR] = 0x48, // Read: COMPRESSION THRESHOLD activate
-	[VX_GLIMIT] = 0x4c, // Read: LEVEL LIMITATION activate
-	[VX_INTCSR] = 0x4c, // VX_INTCSR_REGISTER_OFFSET
-	[VX_CNTRL]  = 0x50,		// VX_CNTRL_REGISTER_OFFSET
-	[VX_GPIOC]  = 0x54,		// VX_GPIOC (new with PLX9030)
+	[VX_COMPOT] = 0x44, /* Write: POTENTIOMETER; Read: COMPRESSION LEVEL activate */
+	[VX_SCOMPR] = 0x48, /* Read: COMPRESSION THRESHOLD activate */
+	[VX_GLIMIT] = 0x4c, /* Read: LEVEL LIMITATION activate */
+	[VX_INTCSR] = 0x4c, /* VX_INTCSR_REGISTER_OFFSET */
+	[VX_CNTRL]  = 0x50,		/* VX_CNTRL_REGISTER_OFFSET */
+	[VX_GPIOC]  = 0x54,		/* VX_GPIOC (new with PLX9030) */
 };
 
 static int vx2_reg_index[VX_REG_MAX] = {
@@ -107,7 +107,7 @@ static unsigned char vx2_inb(struct vx_core *chip, int offset)
 static void vx2_outb(struct vx_core *chip, int offset, unsigned char val)
 {
 	outb(val, vx2_reg_addr(chip, offset));
-	//printk("outb: %x -> %x\n", val, vx2_reg_addr(chip, offset));
+	/* printk("outb: %x -> %x\n", val, vx2_reg_addr(chip, offset)); */
 }
 
 /**
@@ -126,7 +126,7 @@ static unsigned int vx2_inl(struct vx_core *chip, int offset)
  */
 static void vx2_outl(struct vx_core *chip, int offset, unsigned int val)
 {
-	// printk("outl: %x -> %x\n", val, vx2_reg_addr(chip, offset));
+	/* printk("outl: %x -> %x\n", val, vx2_reg_addr(chip, offset)); */
 	outl(val, vx2_reg_addr(chip, offset));
 }
 
@@ -187,7 +187,7 @@ static int vx2_test_xilinx(struct vx_core *_chip)
 	vx_outl(chip, CDSP, chip->regCDSP & ~VX_CDSP_TEST0_MASK);
 	vx_inl(chip, ISR);
 	data = vx_inl(chip, STATUS);
-	if (! (data & VX_STATUS_VAL_TEST0_MASK)) {
+	if (!(data & VX_STATUS_VAL_TEST0_MASK)) {
 		snd_printdd("bad! #2\n");
 		return -ENODEV;
 	}
@@ -207,7 +207,7 @@ static int vx2_test_xilinx(struct vx_core *_chip)
 		vx_outl(chip, CDSP, chip->regCDSP & ~VX_CDSP_TEST1_MASK);
 		vx_inl(chip, ISR);
 		data = vx_inl(chip, STATUS);
-		if (! (data & VX_STATUS_VAL_TEST1_MASK)) {
+		if (!(data & VX_STATUS_VAL_TEST1_MASK)) {
 			snd_printdd("bad! #4\n");
 			return -ENODEV;
 		}
@@ -400,7 +400,7 @@ static int vx2_load_xilinx_binary(struct vx_core *chip, const struct firmware *x
 	return 0;
 }
 
-	
+
 /*
  * load the boot/dsp images
  */
@@ -439,12 +439,12 @@ static int vx2_load_dsp(struct vx_core *vx, int index, const struct firmware *ds
 static int vx2_test_and_ack(struct vx_core *chip)
 {
 	/* not booted yet? */
-	if (! (chip->chip_status & VX_STAT_XILINX_LOADED))
+	if (!(chip->chip_status & VX_STAT_XILINX_LOADED))
 		return -ENXIO;
 
-	if (! (vx_inl(chip, STATUS) & VX_STATUS_MEMIRQ_MASK))
+	if (!(vx_inl(chip, STATUS) & VX_STATUS_MEMIRQ_MASK))
 		return -EIO;
-	
+
 	/* ok, interrupts generated, now ack it */
 	/* set ACQUIT bit up and down */
 	vx_outl(chip, STATUS, 0);
@@ -512,154 +512,154 @@ static void vx2_write_codec_reg(struct vx_core *chip, unsigned int data)
 #define AKM_CODEC_RIGHT_LEVEL_CMD   0xA500
 
 static const u8 vx2_akm_gains_lut[VX2_AKM_LEVEL_MAX+1] = {
-    0x7f,       // [000] =  +0.000 dB  ->  AKM(0x7f) =  +0.000 dB  error(+0.000 dB)
-    0x7d,       // [001] =  -0.500 dB  ->  AKM(0x7d) =  -0.572 dB  error(-0.072 dB)
-    0x7c,       // [002] =  -1.000 dB  ->  AKM(0x7c) =  -0.873 dB  error(+0.127 dB)
-    0x7a,       // [003] =  -1.500 dB  ->  AKM(0x7a) =  -1.508 dB  error(-0.008 dB)
-    0x79,       // [004] =  -2.000 dB  ->  AKM(0x79) =  -1.844 dB  error(+0.156 dB)
-    0x77,       // [005] =  -2.500 dB  ->  AKM(0x77) =  -2.557 dB  error(-0.057 dB)
-    0x76,       // [006] =  -3.000 dB  ->  AKM(0x76) =  -2.937 dB  error(+0.063 dB)
-    0x75,       // [007] =  -3.500 dB  ->  AKM(0x75) =  -3.334 dB  error(+0.166 dB)
-    0x73,       // [008] =  -4.000 dB  ->  AKM(0x73) =  -4.188 dB  error(-0.188 dB)
-    0x72,       // [009] =  -4.500 dB  ->  AKM(0x72) =  -4.648 dB  error(-0.148 dB)
-    0x71,       // [010] =  -5.000 dB  ->  AKM(0x71) =  -5.134 dB  error(-0.134 dB)
-    0x70,       // [011] =  -5.500 dB  ->  AKM(0x70) =  -5.649 dB  error(-0.149 dB)
-    0x6f,       // [012] =  -6.000 dB  ->  AKM(0x6f) =  -6.056 dB  error(-0.056 dB)
-    0x6d,       // [013] =  -6.500 dB  ->  AKM(0x6d) =  -6.631 dB  error(-0.131 dB)
-    0x6c,       // [014] =  -7.000 dB  ->  AKM(0x6c) =  -6.933 dB  error(+0.067 dB)
-    0x6a,       // [015] =  -7.500 dB  ->  AKM(0x6a) =  -7.571 dB  error(-0.071 dB)
-    0x69,       // [016] =  -8.000 dB  ->  AKM(0x69) =  -7.909 dB  error(+0.091 dB)
-    0x67,       // [017] =  -8.500 dB  ->  AKM(0x67) =  -8.626 dB  error(-0.126 dB)
-    0x66,       // [018] =  -9.000 dB  ->  AKM(0x66) =  -9.008 dB  error(-0.008 dB)
-    0x65,       // [019] =  -9.500 dB  ->  AKM(0x65) =  -9.407 dB  error(+0.093 dB)
-    0x64,       // [020] = -10.000 dB  ->  AKM(0x64) =  -9.826 dB  error(+0.174 dB)
-    0x62,       // [021] = -10.500 dB  ->  AKM(0x62) = -10.730 dB  error(-0.230 dB)
-    0x61,       // [022] = -11.000 dB  ->  AKM(0x61) = -11.219 dB  error(-0.219 dB)
-    0x60,       // [023] = -11.500 dB  ->  AKM(0x60) = -11.738 dB  error(-0.238 dB)
-    0x5f,       // [024] = -12.000 dB  ->  AKM(0x5f) = -12.149 dB  error(-0.149 dB)
-    0x5e,       // [025] = -12.500 dB  ->  AKM(0x5e) = -12.434 dB  error(+0.066 dB)
-    0x5c,       // [026] = -13.000 dB  ->  AKM(0x5c) = -13.033 dB  error(-0.033 dB)
-    0x5b,       // [027] = -13.500 dB  ->  AKM(0x5b) = -13.350 dB  error(+0.150 dB)
-    0x59,       // [028] = -14.000 dB  ->  AKM(0x59) = -14.018 dB  error(-0.018 dB)
-    0x58,       // [029] = -14.500 dB  ->  AKM(0x58) = -14.373 dB  error(+0.127 dB)
-    0x56,       // [030] = -15.000 dB  ->  AKM(0x56) = -15.130 dB  error(-0.130 dB)
-    0x55,       // [031] = -15.500 dB  ->  AKM(0x55) = -15.534 dB  error(-0.034 dB)
-    0x54,       // [032] = -16.000 dB  ->  AKM(0x54) = -15.958 dB  error(+0.042 dB)
-    0x53,       // [033] = -16.500 dB  ->  AKM(0x53) = -16.404 dB  error(+0.096 dB)
-    0x52,       // [034] = -17.000 dB  ->  AKM(0x52) = -16.874 dB  error(+0.126 dB)
-    0x51,       // [035] = -17.500 dB  ->  AKM(0x51) = -17.371 dB  error(+0.129 dB)
-    0x50,       // [036] = -18.000 dB  ->  AKM(0x50) = -17.898 dB  error(+0.102 dB)
-    0x4e,       // [037] = -18.500 dB  ->  AKM(0x4e) = -18.605 dB  error(-0.105 dB)
-    0x4d,       // [038] = -19.000 dB  ->  AKM(0x4d) = -18.905 dB  error(+0.095 dB)
-    0x4b,       // [039] = -19.500 dB  ->  AKM(0x4b) = -19.538 dB  error(-0.038 dB)
-    0x4a,       // [040] = -20.000 dB  ->  AKM(0x4a) = -19.872 dB  error(+0.128 dB)
-    0x48,       // [041] = -20.500 dB  ->  AKM(0x48) = -20.583 dB  error(-0.083 dB)
-    0x47,       // [042] = -21.000 dB  ->  AKM(0x47) = -20.961 dB  error(+0.039 dB)
-    0x46,       // [043] = -21.500 dB  ->  AKM(0x46) = -21.356 dB  error(+0.144 dB)
-    0x44,       // [044] = -22.000 dB  ->  AKM(0x44) = -22.206 dB  error(-0.206 dB)
-    0x43,       // [045] = -22.500 dB  ->  AKM(0x43) = -22.664 dB  error(-0.164 dB)
-    0x42,       // [046] = -23.000 dB  ->  AKM(0x42) = -23.147 dB  error(-0.147 dB)
-    0x41,       // [047] = -23.500 dB  ->  AKM(0x41) = -23.659 dB  error(-0.159 dB)
-    0x40,       // [048] = -24.000 dB  ->  AKM(0x40) = -24.203 dB  error(-0.203 dB)
-    0x3f,       // [049] = -24.500 dB  ->  AKM(0x3f) = -24.635 dB  error(-0.135 dB)
-    0x3e,       // [050] = -25.000 dB  ->  AKM(0x3e) = -24.935 dB  error(+0.065 dB)
-    0x3c,       // [051] = -25.500 dB  ->  AKM(0x3c) = -25.569 dB  error(-0.069 dB)
-    0x3b,       // [052] = -26.000 dB  ->  AKM(0x3b) = -25.904 dB  error(+0.096 dB)
-    0x39,       // [053] = -26.500 dB  ->  AKM(0x39) = -26.615 dB  error(-0.115 dB)
-    0x38,       // [054] = -27.000 dB  ->  AKM(0x38) = -26.994 dB  error(+0.006 dB)
-    0x37,       // [055] = -27.500 dB  ->  AKM(0x37) = -27.390 dB  error(+0.110 dB)
-    0x36,       // [056] = -28.000 dB  ->  AKM(0x36) = -27.804 dB  error(+0.196 dB)
-    0x34,       // [057] = -28.500 dB  ->  AKM(0x34) = -28.699 dB  error(-0.199 dB)
-    0x33,       // [058] = -29.000 dB  ->  AKM(0x33) = -29.183 dB  error(-0.183 dB)
-    0x32,       // [059] = -29.500 dB  ->  AKM(0x32) = -29.696 dB  error(-0.196 dB)
-    0x31,       // [060] = -30.000 dB  ->  AKM(0x31) = -30.241 dB  error(-0.241 dB)
-    0x31,       // [061] = -30.500 dB  ->  AKM(0x31) = -30.241 dB  error(+0.259 dB)
-    0x30,       // [062] = -31.000 dB  ->  AKM(0x30) = -30.823 dB  error(+0.177 dB)
-    0x2e,       // [063] = -31.500 dB  ->  AKM(0x2e) = -31.610 dB  error(-0.110 dB)
-    0x2d,       // [064] = -32.000 dB  ->  AKM(0x2d) = -31.945 dB  error(+0.055 dB)
-    0x2b,       // [065] = -32.500 dB  ->  AKM(0x2b) = -32.659 dB  error(-0.159 dB)
-    0x2a,       // [066] = -33.000 dB  ->  AKM(0x2a) = -33.038 dB  error(-0.038 dB)
-    0x29,       // [067] = -33.500 dB  ->  AKM(0x29) = -33.435 dB  error(+0.065 dB)
-    0x28,       // [068] = -34.000 dB  ->  AKM(0x28) = -33.852 dB  error(+0.148 dB)
-    0x27,       // [069] = -34.500 dB  ->  AKM(0x27) = -34.289 dB  error(+0.211 dB)
-    0x25,       // [070] = -35.000 dB  ->  AKM(0x25) = -35.235 dB  error(-0.235 dB)
-    0x24,       // [071] = -35.500 dB  ->  AKM(0x24) = -35.750 dB  error(-0.250 dB)
-    0x24,       // [072] = -36.000 dB  ->  AKM(0x24) = -35.750 dB  error(+0.250 dB)
-    0x23,       // [073] = -36.500 dB  ->  AKM(0x23) = -36.297 dB  error(+0.203 dB)
-    0x22,       // [074] = -37.000 dB  ->  AKM(0x22) = -36.881 dB  error(+0.119 dB)
-    0x21,       // [075] = -37.500 dB  ->  AKM(0x21) = -37.508 dB  error(-0.008 dB)
-    0x20,       // [076] = -38.000 dB  ->  AKM(0x20) = -38.183 dB  error(-0.183 dB)
-    0x1f,       // [077] = -38.500 dB  ->  AKM(0x1f) = -38.726 dB  error(-0.226 dB)
-    0x1e,       // [078] = -39.000 dB  ->  AKM(0x1e) = -39.108 dB  error(-0.108 dB)
-    0x1d,       // [079] = -39.500 dB  ->  AKM(0x1d) = -39.507 dB  error(-0.007 dB)
-    0x1c,       // [080] = -40.000 dB  ->  AKM(0x1c) = -39.926 dB  error(+0.074 dB)
-    0x1b,       // [081] = -40.500 dB  ->  AKM(0x1b) = -40.366 dB  error(+0.134 dB)
-    0x1a,       // [082] = -41.000 dB  ->  AKM(0x1a) = -40.829 dB  error(+0.171 dB)
-    0x19,       // [083] = -41.500 dB  ->  AKM(0x19) = -41.318 dB  error(+0.182 dB)
-    0x18,       // [084] = -42.000 dB  ->  AKM(0x18) = -41.837 dB  error(+0.163 dB)
-    0x17,       // [085] = -42.500 dB  ->  AKM(0x17) = -42.389 dB  error(+0.111 dB)
-    0x16,       // [086] = -43.000 dB  ->  AKM(0x16) = -42.978 dB  error(+0.022 dB)
-    0x15,       // [087] = -43.500 dB  ->  AKM(0x15) = -43.610 dB  error(-0.110 dB)
-    0x14,       // [088] = -44.000 dB  ->  AKM(0x14) = -44.291 dB  error(-0.291 dB)
-    0x14,       // [089] = -44.500 dB  ->  AKM(0x14) = -44.291 dB  error(+0.209 dB)
-    0x13,       // [090] = -45.000 dB  ->  AKM(0x13) = -45.031 dB  error(-0.031 dB)
-    0x12,       // [091] = -45.500 dB  ->  AKM(0x12) = -45.840 dB  error(-0.340 dB)
-    0x12,       // [092] = -46.000 dB  ->  AKM(0x12) = -45.840 dB  error(+0.160 dB)
-    0x11,       // [093] = -46.500 dB  ->  AKM(0x11) = -46.731 dB  error(-0.231 dB)
-    0x11,       // [094] = -47.000 dB  ->  AKM(0x11) = -46.731 dB  error(+0.269 dB)
-    0x10,       // [095] = -47.500 dB  ->  AKM(0x10) = -47.725 dB  error(-0.225 dB)
-    0x10,       // [096] = -48.000 dB  ->  AKM(0x10) = -47.725 dB  error(+0.275 dB)
-    0x0f,       // [097] = -48.500 dB  ->  AKM(0x0f) = -48.553 dB  error(-0.053 dB)
-    0x0e,       // [098] = -49.000 dB  ->  AKM(0x0e) = -49.152 dB  error(-0.152 dB)
-    0x0d,       // [099] = -49.500 dB  ->  AKM(0x0d) = -49.796 dB  error(-0.296 dB)
-    0x0d,       // [100] = -50.000 dB  ->  AKM(0x0d) = -49.796 dB  error(+0.204 dB)
-    0x0c,       // [101] = -50.500 dB  ->  AKM(0x0c) = -50.491 dB  error(+0.009 dB)
-    0x0b,       // [102] = -51.000 dB  ->  AKM(0x0b) = -51.247 dB  error(-0.247 dB)
-    0x0b,       // [103] = -51.500 dB  ->  AKM(0x0b) = -51.247 dB  error(+0.253 dB)
-    0x0a,       // [104] = -52.000 dB  ->  AKM(0x0a) = -52.075 dB  error(-0.075 dB)
-    0x0a,       // [105] = -52.500 dB  ->  AKM(0x0a) = -52.075 dB  error(+0.425 dB)
-    0x09,       // [106] = -53.000 dB  ->  AKM(0x09) = -52.990 dB  error(+0.010 dB)
-    0x09,       // [107] = -53.500 dB  ->  AKM(0x09) = -52.990 dB  error(+0.510 dB)
-    0x08,       // [108] = -54.000 dB  ->  AKM(0x08) = -54.013 dB  error(-0.013 dB)
-    0x08,       // [109] = -54.500 dB  ->  AKM(0x08) = -54.013 dB  error(+0.487 dB)
-    0x07,       // [110] = -55.000 dB  ->  AKM(0x07) = -55.173 dB  error(-0.173 dB)
-    0x07,       // [111] = -55.500 dB  ->  AKM(0x07) = -55.173 dB  error(+0.327 dB)
-    0x06,       // [112] = -56.000 dB  ->  AKM(0x06) = -56.512 dB  error(-0.512 dB)
-    0x06,       // [113] = -56.500 dB  ->  AKM(0x06) = -56.512 dB  error(-0.012 dB)
-    0x06,       // [114] = -57.000 dB  ->  AKM(0x06) = -56.512 dB  error(+0.488 dB)
-    0x05,       // [115] = -57.500 dB  ->  AKM(0x05) = -58.095 dB  error(-0.595 dB)
-    0x05,       // [116] = -58.000 dB  ->  AKM(0x05) = -58.095 dB  error(-0.095 dB)
-    0x05,       // [117] = -58.500 dB  ->  AKM(0x05) = -58.095 dB  error(+0.405 dB)
-    0x05,       // [118] = -59.000 dB  ->  AKM(0x05) = -58.095 dB  error(+0.905 dB)
-    0x04,       // [119] = -59.500 dB  ->  AKM(0x04) = -60.034 dB  error(-0.534 dB)
-    0x04,       // [120] = -60.000 dB  ->  AKM(0x04) = -60.034 dB  error(-0.034 dB)
-    0x04,       // [121] = -60.500 dB  ->  AKM(0x04) = -60.034 dB  error(+0.466 dB)
-    0x04,       // [122] = -61.000 dB  ->  AKM(0x04) = -60.034 dB  error(+0.966 dB)
-    0x03,       // [123] = -61.500 dB  ->  AKM(0x03) = -62.532 dB  error(-1.032 dB)
-    0x03,       // [124] = -62.000 dB  ->  AKM(0x03) = -62.532 dB  error(-0.532 dB)
-    0x03,       // [125] = -62.500 dB  ->  AKM(0x03) = -62.532 dB  error(-0.032 dB)
-    0x03,       // [126] = -63.000 dB  ->  AKM(0x03) = -62.532 dB  error(+0.468 dB)
-    0x03,       // [127] = -63.500 dB  ->  AKM(0x03) = -62.532 dB  error(+0.968 dB)
-    0x03,       // [128] = -64.000 dB  ->  AKM(0x03) = -62.532 dB  error(+1.468 dB)
-    0x02,       // [129] = -64.500 dB  ->  AKM(0x02) = -66.054 dB  error(-1.554 dB)
-    0x02,       // [130] = -65.000 dB  ->  AKM(0x02) = -66.054 dB  error(-1.054 dB)
-    0x02,       // [131] = -65.500 dB  ->  AKM(0x02) = -66.054 dB  error(-0.554 dB)
-    0x02,       // [132] = -66.000 dB  ->  AKM(0x02) = -66.054 dB  error(-0.054 dB)
-    0x02,       // [133] = -66.500 dB  ->  AKM(0x02) = -66.054 dB  error(+0.446 dB)
-    0x02,       // [134] = -67.000 dB  ->  AKM(0x02) = -66.054 dB  error(+0.946 dB)
-    0x02,       // [135] = -67.500 dB  ->  AKM(0x02) = -66.054 dB  error(+1.446 dB)
-    0x02,       // [136] = -68.000 dB  ->  AKM(0x02) = -66.054 dB  error(+1.946 dB)
-    0x02,       // [137] = -68.500 dB  ->  AKM(0x02) = -66.054 dB  error(+2.446 dB)
-    0x02,       // [138] = -69.000 dB  ->  AKM(0x02) = -66.054 dB  error(+2.946 dB)
-    0x01,       // [139] = -69.500 dB  ->  AKM(0x01) = -72.075 dB  error(-2.575 dB)
-    0x01,       // [140] = -70.000 dB  ->  AKM(0x01) = -72.075 dB  error(-2.075 dB)
-    0x01,       // [141] = -70.500 dB  ->  AKM(0x01) = -72.075 dB  error(-1.575 dB)
-    0x01,       // [142] = -71.000 dB  ->  AKM(0x01) = -72.075 dB  error(-1.075 dB)
-    0x01,       // [143] = -71.500 dB  ->  AKM(0x01) = -72.075 dB  error(-0.575 dB)
-    0x01,       // [144] = -72.000 dB  ->  AKM(0x01) = -72.075 dB  error(-0.075 dB)
-    0x01,       // [145] = -72.500 dB  ->  AKM(0x01) = -72.075 dB  error(+0.425 dB)
-    0x01,       // [146] = -73.000 dB  ->  AKM(0x01) = -72.075 dB  error(+0.925 dB)
-    0x00};      // [147] = -73.500 dB  ->  AKM(0x00) =  mute       error(+infini)
+    0x7f,       /* [000] =  +0.000 dB  ->  AKM(0x7f) =  +0.000 dB  error(+0.000 dB) */
+    0x7d,       /* [001] =  -0.500 dB  ->  AKM(0x7d) =  -0.572 dB  error(-0.072 dB) */
+    0x7c,       /* [002] =  -1.000 dB  ->  AKM(0x7c) =  -0.873 dB  error(+0.127 dB) */
+    0x7a,       /* [003] =  -1.500 dB  ->  AKM(0x7a) =  -1.508 dB  error(-0.008 dB) */
+    0x79,       /* [004] =  -2.000 dB  ->  AKM(0x79) =  -1.844 dB  error(+0.156 dB) */
+    0x77,       /* [005] =  -2.500 dB  ->  AKM(0x77) =  -2.557 dB  error(-0.057 dB) */
+    0x76,       /* [006] =  -3.000 dB  ->  AKM(0x76) =  -2.937 dB  error(+0.063 dB) */
+    0x75,       /* [007] =  -3.500 dB  ->  AKM(0x75) =  -3.334 dB  error(+0.166 dB) */
+    0x73,       /* [008] =  -4.000 dB  ->  AKM(0x73) =  -4.188 dB  error(-0.188 dB) */
+    0x72,       /* [009] =  -4.500 dB  ->  AKM(0x72) =  -4.648 dB  error(-0.148 dB) */
+    0x71,       /* [010] =  -5.000 dB  ->  AKM(0x71) =  -5.134 dB  error(-0.134 dB) */
+    0x70,       /* [011] =  -5.500 dB  ->  AKM(0x70) =  -5.649 dB  error(-0.149 dB) */
+    0x6f,       /* [012] =  -6.000 dB  ->  AKM(0x6f) =  -6.056 dB  error(-0.056 dB) */
+    0x6d,       /* [013] =  -6.500 dB  ->  AKM(0x6d) =  -6.631 dB  error(-0.131 dB) */
+    0x6c,       /* [014] =  -7.000 dB  ->  AKM(0x6c) =  -6.933 dB  error(+0.067 dB) */
+    0x6a,       /* [015] =  -7.500 dB  ->  AKM(0x6a) =  -7.571 dB  error(-0.071 dB) */
+    0x69,       /* [016] =  -8.000 dB  ->  AKM(0x69) =  -7.909 dB  error(+0.091 dB) */
+    0x67,       /* [017] =  -8.500 dB  ->  AKM(0x67) =  -8.626 dB  error(-0.126 dB) */
+    0x66,       /* [018] =  -9.000 dB  ->  AKM(0x66) =  -9.008 dB  error(-0.008 dB) */
+    0x65,       /* [019] =  -9.500 dB  ->  AKM(0x65) =  -9.407 dB  error(+0.093 dB) */
+    0x64,       /* [020] = -10.000 dB  ->  AKM(0x64) =  -9.826 dB  error(+0.174 dB) */
+    0x62,       /* [021] = -10.500 dB  ->  AKM(0x62) = -10.730 dB  error(-0.230 dB) */
+    0x61,       /* [022] = -11.000 dB  ->  AKM(0x61) = -11.219 dB  error(-0.219 dB) */
+    0x60,       /* [023] = -11.500 dB  ->  AKM(0x60) = -11.738 dB  error(-0.238 dB) */
+    0x5f,       /* [024] = -12.000 dB  ->  AKM(0x5f) = -12.149 dB  error(-0.149 dB) */
+    0x5e,       /* [025] = -12.500 dB  ->  AKM(0x5e) = -12.434 dB  error(+0.066 dB) */
+    0x5c,       /* [026] = -13.000 dB  ->  AKM(0x5c) = -13.033 dB  error(-0.033 dB) */
+    0x5b,       /* [027] = -13.500 dB  ->  AKM(0x5b) = -13.350 dB  error(+0.150 dB) */
+    0x59,       /* [028] = -14.000 dB  ->  AKM(0x59) = -14.018 dB  error(-0.018 dB) */
+    0x58,       /* [029] = -14.500 dB  ->  AKM(0x58) = -14.373 dB  error(+0.127 dB) */
+    0x56,       /* [030] = -15.000 dB  ->  AKM(0x56) = -15.130 dB  error(-0.130 dB) */
+    0x55,       /* [031] = -15.500 dB  ->  AKM(0x55) = -15.534 dB  error(-0.034 dB) */
+    0x54,       /* [032] = -16.000 dB  ->  AKM(0x54) = -15.958 dB  error(+0.042 dB) */
+    0x53,       /* [033] = -16.500 dB  ->  AKM(0x53) = -16.404 dB  error(+0.096 dB) */
+    0x52,       /* [034] = -17.000 dB  ->  AKM(0x52) = -16.874 dB  error(+0.126 dB) */
+    0x51,       /* [035] = -17.500 dB  ->  AKM(0x51) = -17.371 dB  error(+0.129 dB) */
+    0x50,       /* [036] = -18.000 dB  ->  AKM(0x50) = -17.898 dB  error(+0.102 dB) */
+    0x4e,       /* [037] = -18.500 dB  ->  AKM(0x4e) = -18.605 dB  error(-0.105 dB) */
+    0x4d,       /* [038] = -19.000 dB  ->  AKM(0x4d) = -18.905 dB  error(+0.095 dB) */
+    0x4b,       /* [039] = -19.500 dB  ->  AKM(0x4b) = -19.538 dB  error(-0.038 dB) */
+    0x4a,       /* [040] = -20.000 dB  ->  AKM(0x4a) = -19.872 dB  error(+0.128 dB) */
+    0x48,       /* [041] = -20.500 dB  ->  AKM(0x48) = -20.583 dB  error(-0.083 dB) */
+    0x47,       /* [042] = -21.000 dB  ->  AKM(0x47) = -20.961 dB  error(+0.039 dB) */
+    0x46,       /* [043] = -21.500 dB  ->  AKM(0x46) = -21.356 dB  error(+0.144 dB) */
+    0x44,       /* [044] = -22.000 dB  ->  AKM(0x44) = -22.206 dB  error(-0.206 dB) */
+    0x43,       /* [045] = -22.500 dB  ->  AKM(0x43) = -22.664 dB  error(-0.164 dB) */
+    0x42,       /* [046] = -23.000 dB  ->  AKM(0x42) = -23.147 dB  error(-0.147 dB) */
+    0x41,       /* [047] = -23.500 dB  ->  AKM(0x41) = -23.659 dB  error(-0.159 dB) */
+    0x40,       /* [048] = -24.000 dB  ->  AKM(0x40) = -24.203 dB  error(-0.203 dB) */
+    0x3f,       /* [049] = -24.500 dB  ->  AKM(0x3f) = -24.635 dB  error(-0.135 dB) */
+    0x3e,       /* [050] = -25.000 dB  ->  AKM(0x3e) = -24.935 dB  error(+0.065 dB) */
+    0x3c,       /* [051] = -25.500 dB  ->  AKM(0x3c) = -25.569 dB  error(-0.069 dB) */
+    0x3b,       /* [052] = -26.000 dB  ->  AKM(0x3b) = -25.904 dB  error(+0.096 dB) */
+    0x39,       /* [053] = -26.500 dB  ->  AKM(0x39) = -26.615 dB  error(-0.115 dB) */
+    0x38,       /* [054] = -27.000 dB  ->  AKM(0x38) = -26.994 dB  error(+0.006 dB) */
+    0x37,       /* [055] = -27.500 dB  ->  AKM(0x37) = -27.390 dB  error(+0.110 dB) */
+    0x36,       /* [056] = -28.000 dB  ->  AKM(0x36) = -27.804 dB  error(+0.196 dB) */
+    0x34,       /* [057] = -28.500 dB  ->  AKM(0x34) = -28.699 dB  error(-0.199 dB) */
+    0x33,       /* [058] = -29.000 dB  ->  AKM(0x33) = -29.183 dB  error(-0.183 dB) */
+    0x32,       /* [059] = -29.500 dB  ->  AKM(0x32) = -29.696 dB  error(-0.196 dB) */
+    0x31,       /* [060] = -30.000 dB  ->  AKM(0x31) = -30.241 dB  error(-0.241 dB) */
+    0x31,       /* [061] = -30.500 dB  ->  AKM(0x31) = -30.241 dB  error(+0.259 dB) */
+    0x30,       /* [062] = -31.000 dB  ->  AKM(0x30) = -30.823 dB  error(+0.177 dB) */
+    0x2e,       /* [063] = -31.500 dB  ->  AKM(0x2e) = -31.610 dB  error(-0.110 dB) */
+    0x2d,       /* [064] = -32.000 dB  ->  AKM(0x2d) = -31.945 dB  error(+0.055 dB) */
+    0x2b,       /* [065] = -32.500 dB  ->  AKM(0x2b) = -32.659 dB  error(-0.159 dB) */
+    0x2a,       /* [066] = -33.000 dB  ->  AKM(0x2a) = -33.038 dB  error(-0.038 dB) */
+    0x29,       /* [067] = -33.500 dB  ->  AKM(0x29) = -33.435 dB  error(+0.065 dB) */
+    0x28,       /* [068] = -34.000 dB  ->  AKM(0x28) = -33.852 dB  error(+0.148 dB) */
+    0x27,       /* [069] = -34.500 dB  ->  AKM(0x27) = -34.289 dB  error(+0.211 dB) */
+    0x25,       /* [070] = -35.000 dB  ->  AKM(0x25) = -35.235 dB  error(-0.235 dB) */
+    0x24,       /* [071] = -35.500 dB  ->  AKM(0x24) = -35.750 dB  error(-0.250 dB) */
+    0x24,       /* [072] = -36.000 dB  ->  AKM(0x24) = -35.750 dB  error(+0.250 dB) */
+    0x23,       /* [073] = -36.500 dB  ->  AKM(0x23) = -36.297 dB  error(+0.203 dB) */
+    0x22,       /* [074] = -37.000 dB  ->  AKM(0x22) = -36.881 dB  error(+0.119 dB) */
+    0x21,       /* [075] = -37.500 dB  ->  AKM(0x21) = -37.508 dB  error(-0.008 dB) */
+    0x20,       /* [076] = -38.000 dB  ->  AKM(0x20) = -38.183 dB  error(-0.183 dB) */
+    0x1f,       /* [077] = -38.500 dB  ->  AKM(0x1f) = -38.726 dB  error(-0.226 dB) */
+    0x1e,       /* [078] = -39.000 dB  ->  AKM(0x1e) = -39.108 dB  error(-0.108 dB) */
+    0x1d,       /* [079] = -39.500 dB  ->  AKM(0x1d) = -39.507 dB  error(-0.007 dB) */
+    0x1c,       /* [080] = -40.000 dB  ->  AKM(0x1c) = -39.926 dB  error(+0.074 dB) */
+    0x1b,       /* [081] = -40.500 dB  ->  AKM(0x1b) = -40.366 dB  error(+0.134 dB) */
+    0x1a,       /* [082] = -41.000 dB  ->  AKM(0x1a) = -40.829 dB  error(+0.171 dB) */
+    0x19,       /* [083] = -41.500 dB  ->  AKM(0x19) = -41.318 dB  error(+0.182 dB) */
+    0x18,       /* [084] = -42.000 dB  ->  AKM(0x18) = -41.837 dB  error(+0.163 dB) */
+    0x17,       /* [085] = -42.500 dB  ->  AKM(0x17) = -42.389 dB  error(+0.111 dB) */
+    0x16,       /* [086] = -43.000 dB  ->  AKM(0x16) = -42.978 dB  error(+0.022 dB) */
+    0x15,       /* [087] = -43.500 dB  ->  AKM(0x15) = -43.610 dB  error(-0.110 dB) */
+    0x14,       /* [088] = -44.000 dB  ->  AKM(0x14) = -44.291 dB  error(-0.291 dB) */
+    0x14,       /* [089] = -44.500 dB  ->  AKM(0x14) = -44.291 dB  error(+0.209 dB) */
+    0x13,       /* [090] = -45.000 dB  ->  AKM(0x13) = -45.031 dB  error(-0.031 dB) */
+    0x12,       /* [091] = -45.500 dB  ->  AKM(0x12) = -45.840 dB  error(-0.340 dB) */
+    0x12,       /* [092] = -46.000 dB  ->  AKM(0x12) = -45.840 dB  error(+0.160 dB) */
+    0x11,       /* [093] = -46.500 dB  ->  AKM(0x11) = -46.731 dB  error(-0.231 dB) */
+    0x11,       /* [094] = -47.000 dB  ->  AKM(0x11) = -46.731 dB  error(+0.269 dB) */
+    0x10,       /* [095] = -47.500 dB  ->  AKM(0x10) = -47.725 dB  error(-0.225 dB) */
+    0x10,       /* [096] = -48.000 dB  ->  AKM(0x10) = -47.725 dB  error(+0.275 dB) */
+    0x0f,       /* [097] = -48.500 dB  ->  AKM(0x0f) = -48.553 dB  error(-0.053 dB) */
+    0x0e,       /* [098] = -49.000 dB  ->  AKM(0x0e) = -49.152 dB  error(-0.152 dB) */
+    0x0d,       /* [099] = -49.500 dB  ->  AKM(0x0d) = -49.796 dB  error(-0.296 dB) */
+    0x0d,       /* [100] = -50.000 dB  ->  AKM(0x0d) = -49.796 dB  error(+0.204 dB) */
+    0x0c,       /* [101] = -50.500 dB  ->  AKM(0x0c) = -50.491 dB  error(+0.009 dB) */
+    0x0b,       /* [102] = -51.000 dB  ->  AKM(0x0b) = -51.247 dB  error(-0.247 dB) */
+    0x0b,       /* [103] = -51.500 dB  ->  AKM(0x0b) = -51.247 dB  error(+0.253 dB) */
+    0x0a,       /* [104] = -52.000 dB  ->  AKM(0x0a) = -52.075 dB  error(-0.075 dB) */
+    0x0a,       /* [105] = -52.500 dB  ->  AKM(0x0a) = -52.075 dB  error(+0.425 dB) */
+    0x09,       /* [106] = -53.000 dB  ->  AKM(0x09) = -52.990 dB  error(+0.010 dB) */
+    0x09,       /* [107] = -53.500 dB  ->  AKM(0x09) = -52.990 dB  error(+0.510 dB) */
+    0x08,       /* [108] = -54.000 dB  ->  AKM(0x08) = -54.013 dB  error(-0.013 dB) */
+    0x08,       /* [109] = -54.500 dB  ->  AKM(0x08) = -54.013 dB  error(+0.487 dB) */
+    0x07,       /* [110] = -55.000 dB  ->  AKM(0x07) = -55.173 dB  error(-0.173 dB) */
+    0x07,       /* [111] = -55.500 dB  ->  AKM(0x07) = -55.173 dB  error(+0.327 dB) */
+    0x06,       /* [112] = -56.000 dB  ->  AKM(0x06) = -56.512 dB  error(-0.512 dB) */
+    0x06,       /* [113] = -56.500 dB  ->  AKM(0x06) = -56.512 dB  error(-0.012 dB) */
+    0x06,       /* [114] = -57.000 dB  ->  AKM(0x06) = -56.512 dB  error(+0.488 dB) */
+    0x05,       /* [115] = -57.500 dB  ->  AKM(0x05) = -58.095 dB  error(-0.595 dB) */
+    0x05,       /* [116] = -58.000 dB  ->  AKM(0x05) = -58.095 dB  error(-0.095 dB) */
+    0x05,       /* [117] = -58.500 dB  ->  AKM(0x05) = -58.095 dB  error(+0.405 dB) */
+    0x05,       /* [118] = -59.000 dB  ->  AKM(0x05) = -58.095 dB  error(+0.905 dB) */
+    0x04,       /* [119] = -59.500 dB  ->  AKM(0x04) = -60.034 dB  error(-0.534 dB) */
+    0x04,       /* [120] = -60.000 dB  ->  AKM(0x04) = -60.034 dB  error(-0.034 dB) */
+    0x04,       /* [121] = -60.500 dB  ->  AKM(0x04) = -60.034 dB  error(+0.466 dB) */
+    0x04,       /* [122] = -61.000 dB  ->  AKM(0x04) = -60.034 dB  error(+0.966 dB) */
+    0x03,       /* [123] = -61.500 dB  ->  AKM(0x03) = -62.532 dB  error(-1.032 dB) */
+    0x03,       /* [124] = -62.000 dB  ->  AKM(0x03) = -62.532 dB  error(-0.532 dB) */
+    0x03,       /* [125] = -62.500 dB  ->  AKM(0x03) = -62.532 dB  error(-0.032 dB) */
+    0x03,       /* [126] = -63.000 dB  ->  AKM(0x03) = -62.532 dB  error(+0.468 dB) */
+    0x03,       /* [127] = -63.500 dB  ->  AKM(0x03) = -62.532 dB  error(+0.968 dB) */
+    0x03,       /* [128] = -64.000 dB  ->  AKM(0x03) = -62.532 dB  error(+1.468 dB) */
+    0x02,       /* [129] = -64.500 dB  ->  AKM(0x02) = -66.054 dB  error(-1.554 dB) */
+    0x02,       /* [130] = -65.000 dB  ->  AKM(0x02) = -66.054 dB  error(-1.054 dB) */
+    0x02,       /* [131] = -65.500 dB  ->  AKM(0x02) = -66.054 dB  error(-0.554 dB) */
+    0x02,       /* [132] = -66.000 dB  ->  AKM(0x02) = -66.054 dB  error(-0.054 dB) */
+    0x02,       /* [133] = -66.500 dB  ->  AKM(0x02) = -66.054 dB  error(+0.446 dB) */
+    0x02,       /* [134] = -67.000 dB  ->  AKM(0x02) = -66.054 dB  error(+0.946 dB) */
+    0x02,       /* [135] = -67.500 dB  ->  AKM(0x02) = -66.054 dB  error(+1.446 dB) */
+    0x02,       /* [136] = -68.000 dB  ->  AKM(0x02) = -66.054 dB  error(+1.946 dB) */
+    0x02,       /* [137] = -68.500 dB  ->  AKM(0x02) = -66.054 dB  error(+2.446 dB) */
+    0x02,       /* [138] = -69.000 dB  ->  AKM(0x02) = -66.054 dB  error(+2.946 dB) */
+    0x01,       /* [139] = -69.500 dB  ->  AKM(0x01) = -72.075 dB  error(-2.575 dB) */
+    0x01,       /* [140] = -70.000 dB  ->  AKM(0x01) = -72.075 dB  error(-2.075 dB) */
+    0x01,       /* [141] = -70.500 dB  ->  AKM(0x01) = -72.075 dB  error(-1.575 dB) */
+    0x01,       /* [142] = -71.000 dB  ->  AKM(0x01) = -72.075 dB  error(-1.075 dB) */
+    0x01,       /* [143] = -71.500 dB  ->  AKM(0x01) = -72.075 dB  error(-0.575 dB) */
+    0x01,       /* [144] = -72.000 dB  ->  AKM(0x01) = -72.075 dB  error(-0.075 dB) */
+    0x01,       /* [145] = -72.500 dB  ->  AKM(0x01) = -72.075 dB  error(+0.425 dB) */
+    0x01,       /* [146] = -73.000 dB  ->  AKM(0x01) = -72.075 dB  error(+0.925 dB) */
+    0x00};      /* [147] = -73.500 dB  ->  AKM(0x00) =  mute       error(+infini) */
 
 /*
  * pseudo-codec write entry
@@ -738,7 +738,7 @@ static void vx2_reset_codec(struct vx_core *_chip)
 	msleep(5);  /* additionnel wait time for AKM's */
 
 	vx2_write_codec_reg(_chip, AKM_CODEC_POWER_CONTROL_CMD); /* DAC power up, ADC power up, Vref power down */
-	
+
 	vx2_write_codec_reg(_chip, AKM_CODEC_CLOCK_FORMAT_CMD); /* default */
 	vx2_write_codec_reg(_chip, AKM_CODEC_MUTE_CMD); /* Mute = ON ,Deemphasis = OFF */
 	vx2_write_codec_reg(_chip, AKM_CODEC_RESET_OFF_CMD); /* DAC and ADC normal operation */
@@ -798,7 +798,7 @@ static void vx2_reset_board(struct vx_core *_chip, int cold_reset)
 	struct snd_vx222 *chip = (struct snd_vx222 *)_chip;
 
 	/* initialize the register values */
-	chip->regCDSP = VX_CDSP_CODEC_RESET_MASK | VX_CDSP_DSP_RESET_MASK ;
+	chip->regCDSP = VX_CDSP_CODEC_RESET_MASK | VX_CDSP_DSP_RESET_MASK;
 	chip->regCFG = 0;
 }
