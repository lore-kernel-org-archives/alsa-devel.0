From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH 11/24] sound/pci: coding style fixes: ice1712
Date: Tue, 9 Sep 2008 05:53:48 +0400
Message-ID: <20080909015348.GN6211@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157])
	by alsa0.perex.cz (Postfix) with ESMTP id 1ECF310380C
	for <alsa-devel@alsa-project.org>;
	Tue,  9 Sep 2008 03:53:55 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 16so1535908fgg.44
	for <alsa-devel@alsa-project.org>; Mon, 08 Sep 2008 18:53:54 -0700 (PDT)
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

 sound/pci/ice1712/ak4xxx.c       |    8 ++++----
 sound/pci/ice1712/amp.c          |    6 +++---
 sound/pci/ice1712/amp.h          |    2 +-
 sound/pci/ice1712/aureon.h       |    2 +-
 sound/pci/ice1712/delta.c        |   12 ++++++------
 sound/pci/ice1712/delta.h        |    2 +-
 sound/pci/ice1712/envy24ht.h     |   10 +++++-----
 sound/pci/ice1712/ews.c          |   34 +++++++++++++++++-----------------
 sound/pci/ice1712/ews.h          |    2 +-
 sound/pci/ice1712/hoontech.c     |   20 ++++++++++----------
 sound/pci/ice1712/hoontech.h     |    2 +-
 sound/pci/ice1712/ice1712.c      |    4 ++--
 sound/pci/ice1712/ice1724.c      |    4 ++--
 sound/pci/ice1712/juli.c         |    4 ++--
 sound/pci/ice1712/phase.c        |    2 +-
 sound/pci/ice1712/pontis.c       |   12 ++++++------
 sound/pci/ice1712/pontis.h       |    2 +-
 sound/pci/ice1712/prodigy192.c   |   14 +++++++-------
 sound/pci/ice1712/prodigy_hifi.c |   28 ++++++++++++++--------------
 sound/pci/ice1712/prodigy_hifi.h |    2 +-
 sound/pci/ice1712/revo.c         |    8 ++++----
 sound/pci/ice1712/revo.h         |    2 +-
 sound/pci/ice1712/se.c           |    6 +++---
 sound/pci/ice1712/vt1720_mobo.c  |    4 ++--
 sound/pci/ice1712/vt1720_mobo.h  |    2 +-
 25 files changed, 97 insertions(+), 97 deletions(-)

diff --git a/sound/pci/ice1712/ak4xxx.c b/sound/pci/ice1712/ak4xxx.c
index 03391da..5859af1 100644
--- a/sound/pci/ice1712/ak4xxx.c
+++ b/sound/pci/ice1712/ak4xxx.c
@@ -19,9 +19,9 @@
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
- */      
+ */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -181,11 +181,11 @@ static int __init alsa_ice1712_akm4xxx_module_init(void)
 {
 	return 0;
 }
-        
+
 static void __exit alsa_ice1712_akm4xxx_module_exit(void)
 {
 }
-        
+
 module_init(alsa_ice1712_akm4xxx_module_init)
 module_exit(alsa_ice1712_akm4xxx_module_exit)
 
diff --git a/sound/pci/ice1712/amp.c b/sound/pci/ice1712/amp.c
index 3756430..3b2aa8b 100644
--- a/sound/pci/ice1712/amp.c
+++ b/sound/pci/ice1712/amp.c
@@ -19,9 +19,9 @@
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
- */      
+ */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -45,7 +45,7 @@ static int __devinit snd_vt1724_amp_init(struct snd_ice1712 *ice)
 		WM_ATTEN_L,	0x0000,	/* 0 db */
 		WM_ATTEN_R,	0x0000,	/* 0 db */
 		WM_DAC_CTRL,	0x0008,	/* 24bit I2S */
-		WM_INT_CTRL,	0x0001, /* 24bit I2S */	
+		WM_INT_CTRL,	0x0001, /* 24bit I2S */
 	};
 
 	unsigned int i;
diff --git a/sound/pci/ice1712/amp.h b/sound/pci/ice1712/amp.h
index bf81d30..34c2463 100644
--- a/sound/pci/ice1712/amp.h
+++ b/sound/pci/ice1712/amp.h
@@ -22,7 +22,7 @@
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
- */      
+ */
 
 #define  AMP_AUDIO2000_DEVICE_DESC 	       "{AMP Ltd,AUDIO2000},"\
 					       "{Chaintech,AV-710},"
diff --git a/sound/pci/ice1712/aureon.h b/sound/pci/ice1712/aureon.h
index c253b8e..098792a 100644
--- a/sound/pci/ice1712/aureon.h
+++ b/sound/pci/ice1712/aureon.h
@@ -22,7 +22,7 @@
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
- */      
+ */
 
 #define  AUREON_DEVICE_DESC 	       "{Terratec,Aureon 5.1 Sky},"\
 				       "{Terratec,Aureon 7.1 Space},"\
diff --git a/sound/pci/ice1712/delta.c b/sound/pci/ice1712/delta.c
index d216362..c696671 100644
--- a/sound/pci/ice1712/delta.c
+++ b/sound/pci/ice1712/delta.c
@@ -20,9 +20,9 @@
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
- */      
+ */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -66,7 +66,7 @@ static unsigned char ap_cs8427_read_byte(struct snd_ice1712 *ice, unsigned char
 {
 	unsigned char data = 0;
 	int idx;
-	
+
 	for (idx = 7; idx >= 0; idx--) {
 		tmp &= ~ICE1712_DELTA_AP_CCLK;
 		snd_ice1712_write(ice, ICE1712_IREG_GPIO_DATA, tmp);
@@ -149,7 +149,7 @@ static int ap_cs8427_readbytes(struct snd_i2c_device *device, unsigned char *byt
 	struct snd_ice1712 *ice = device->bus->private_data;
 	int res = count;
 	unsigned char tmp;
-	
+
 	mutex_lock(&ice->gpio_mutex);
 	tmp = ap_cs8427_codec_select(ice);
 	ap_cs8427_write_byte(ice, (device->addr << 1) | 1, tmp); /* address + read mode */
@@ -324,7 +324,7 @@ static void delta_ak4524_set_rate_val(struct snd_akm4xxx *ak, unsigned int rate)
 	mutex_lock(&ice->gpio_mutex);
 	tmp = snd_ice1712_read(ice, ICE1712_IREG_GPIO_DATA);
 	mutex_unlock(&ice->gpio_mutex);
-	tmp2 = tmp & ~ICE1712_DELTA_DFS; 
+	tmp2 = tmp & ~ICE1712_DELTA_DFS;
 	if (rate > 48000)
 		tmp2 |= ICE1712_DELTA_DFS;
 	if (tmp == tmp2)
@@ -623,7 +623,7 @@ static int __devinit snd_ice1712_delta_init(struct snd_ice1712 *ice)
 
 	/* second stage of initialization, analog parts and others */
 	ak = ice->akm = kmalloc(sizeof(struct snd_akm4xxx), GFP_KERNEL);
-	if (! ak)
+	if (!ak)
 		return -ENOMEM;
 	ice->akm_codecs = 1;
 
diff --git a/sound/pci/ice1712/delta.h b/sound/pci/ice1712/delta.h
index f7f14df..5bff36a 100644
--- a/sound/pci/ice1712/delta.h
+++ b/sound/pci/ice1712/delta.h
@@ -23,7 +23,7 @@
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
- */      
+ */
 
 #define DELTA_DEVICE_DESC \
 		"{MidiMan M Audio,Delta 1010},"\
diff --git a/sound/pci/ice1712/envy24ht.h b/sound/pci/ice1712/envy24ht.h
index a0c5e00..66680a5 100644
--- a/sound/pci/ice1712/envy24ht.h
+++ b/sound/pci/ice1712/envy24ht.h
@@ -20,7 +20,7 @@
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
- */      
+ */
 
 #include <sound/control.h>
 #include <sound/ac97_codec.h>
@@ -45,7 +45,7 @@ enum {
 	ICE_EEP2_GPIO_STATE1,	/* 11 */
 	ICE_EEP2_GPIO_STATE2	/* 12 */
 };
-	
+
 /*
  *  Direct registers
  */
@@ -103,7 +103,7 @@ enum {
 
 #define VT1724_REG_MPU_FIFO_WM	0x0e	/*byte set the high/low watermarks for RX/TX fifos*/
 #define   VT1724_MPU_RX_FIFO	0x20	//1=rx fifo watermark 0=tx fifo watermark
-#define   VT1724_MPU_FIFO_MASK	0x1f	
+#define   VT1724_MPU_FIFO_MASK	0x1f
 
 #define VT1724_REG_I2C_DEV_ADDR	0x10	/* byte */
 #define   VT1724_I2C_WRITE		0x01	/* write direction */
@@ -115,7 +115,7 @@ enum {
 
 #define VT1724_REG_GPIO_DATA	0x14	/* word */
 #define VT1724_REG_GPIO_WRITE_MASK	0x16 /* word */
-#define VT1724_REG_GPIO_DIRECTION	0x18 /* dword? (3 bytes) 0=input 1=output. 
+#define VT1724_REG_GPIO_DIRECTION	0x18 /* dword? (3 bytes) 0=input 1=output.
 						bit3 - during reset used for Eeprom power-on strapping
 						if TESTEN# pin active, bit 2 always input*/
 #define VT1724_REG_POWERDOWN	0x1c
@@ -123,7 +123,7 @@ enum {
 #define VT1724_REG_GPIO_WRITE_MASK_22	0x1f /* byte write mask for GPIO 16:22 */
 
 
-/* 
+/*
  *  Professional multi-track direct control registers
  */
 
diff --git a/sound/pci/ice1712/ews.c b/sound/pci/ice1712/ews.c
index 6fe35b8..73accca 100644
--- a/sound/pci/ice1712/ews.c
+++ b/sound/pci/ice1712/ews.c
@@ -20,9 +20,9 @@
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
- */      
+ */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -42,7 +42,7 @@ enum {
 	EWS_I2C_88D = 0,
 	EWS_I2C_6FIRE = 0
 };
-	
+
 
 /* additional i2c devices for EWS boards */
 struct ews_spec {
@@ -162,7 +162,7 @@ static int snd_ice1712_ews88mt_chip_select(struct snd_ice1712 *ice, int chip_mas
 	snd_i2c_unlock(ice->i2c);
 	return 0;
 
-     __error:
+__error:
 	snd_i2c_unlock(ice->i2c);
 	snd_printk(KERN_ERR "AK4524 chip select failed, check cable to the front module\n");
 	return -EIO;
@@ -256,7 +256,7 @@ static void snd_ice1712_ews_cs8404_spdif_write(struct snd_ice1712 *ice, unsigned
 		}
 		break;
 	}
- _error:
+_error:
 	snd_i2c_unlock(ice->i2c);
 }
 
@@ -431,7 +431,7 @@ static int __devinit snd_ice1712_ews_init(struct snd_ice1712 *ice)
 	case ICE1712_SUBDEVICE_EWX2496:
 		ice->num_total_dacs = 2;
 		ice->num_total_adcs = 2;
-		break;	
+		break;
 	case ICE1712_SUBDEVICE_EWS88MT:
 	case ICE1712_SUBDEVICE_EWS88MT_NEW:
 	case ICE1712_SUBDEVICE_PHASE88:
@@ -545,7 +545,7 @@ static int __devinit snd_ice1712_ews_init(struct snd_ice1712 *ice)
 
 	/* analog section */
 	ak = ice->akm = kzalloc(sizeof(struct snd_akm4xxx), GFP_KERNEL);
-	if (! ak)
+	if (!ak)
 		return -ENOMEM;
 	ice->akm_codecs = 1;
 
@@ -592,7 +592,7 @@ static int snd_ice1712_ewx_io_sense_get(struct snd_kcontrol *kcontrol, struct sn
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	unsigned char mask = kcontrol->private_value & 0xff;
-	
+
 	snd_ice1712_save_gpio_status(ice);
 	ucontrol->value.enumerated.item[0] = snd_ice1712_read(ice, ICE1712_IREG_GPIO_DATA) & mask ? 1 : 0;
 	snd_ice1712_restore_gpio_status(ice);
@@ -755,7 +755,7 @@ static int snd_ice1712_ews88d_control_get(struct snd_kcontrol *kcontrol, struct
 	int shift = kcontrol->private_value & 0xff;
 	int invert = (kcontrol->private_value >> 8) & 1;
 	unsigned char data[2];
-	
+
 	snd_i2c_lock(ice->i2c);
 	if (snd_i2c_readbytes(spec->i2cdevs[EWS_I2C_88D], data, 2) != 2) {
 		snd_i2c_unlock(ice->i2c);
@@ -785,7 +785,7 @@ static int snd_ice1712_ews88d_control_put(struct snd_kcontrol *kcontrol, struct
 	}
 	ndata[shift >> 3] = data[shift >> 3] & ~(1 << (shift & 7));
 	if (invert) {
-		if (! ucontrol->value.integer.value[0])
+		if (!ucontrol->value.integer.value[0])
 			ndata[shift >> 3] |= (1 << (shift & 7));
 	} else {
 		if (ucontrol->value.integer.value[0])
@@ -866,7 +866,7 @@ static int snd_ice1712_6fire_control_get(struct snd_kcontrol *kcontrol, struct s
 	int shift = kcontrol->private_value & 0xff;
 	int invert = (kcontrol->private_value >> 8) & 1;
 	int data;
-	
+
 	if ((data = snd_ice1712_6fire_read_pca(ice, PCF9554_REG_OUTPUT)) < 0)
 		return data;
 	data = (data >> shift) & 1;
@@ -882,7 +882,7 @@ static int snd_ice1712_6fire_control_put(struct snd_kcontrol *kcontrol, struct s
 	int shift = kcontrol->private_value & 0xff;
 	int invert = (kcontrol->private_value >> 8) & 1;
 	int data, ndata;
-	
+
 	if ((data = snd_ice1712_6fire_read_pca(ice, PCF9554_REG_OUTPUT)) < 0)
 		return data;
 	ndata = data & ~(1 << shift);
@@ -910,12 +910,12 @@ static int snd_ice1712_6fire_select_input_info(struct snd_kcontrol *kcontrol, st
 	strcpy(uinfo->value.enumerated.name, texts[uinfo->value.enumerated.item]);
 	return 0;
 }
-     
+
 static int snd_ice1712_6fire_select_input_get(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	int data;
-	
+
 	if ((data = snd_ice1712_6fire_read_pca(ice, PCF9554_REG_OUTPUT)) < 0)
 		return data;
 	ucontrol->value.integer.value[0] = data & 3;
@@ -926,7 +926,7 @@ static int snd_ice1712_6fire_select_input_put(struct snd_kcontrol *kcontrol, str
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	int data, ndata;
-	
+
 	if ((data = snd_ice1712_6fire_read_pca(ice, PCF9554_REG_OUTPUT)) < 0)
 		return data;
 	ndata = data & ~3;
@@ -957,7 +957,7 @@ static struct snd_kcontrol_new snd_ice1712_6fire_controls[] __devinitdata = {
 		.put = snd_ice1712_6fire_select_input_put,
 	},
 	DMX6FIRE_CONTROL("Front Digital Input Switch", 2, 1),
-	// DMX6FIRE_CONTROL("Master Clock Select", 3, 0),
+	/* DMX6FIRE_CONTROL("Master Clock Select", 3, 0), */
 	DMX6FIRE_CONTROL("Optical Digital Input Switch", 4, 0),
 	DMX6FIRE_CONTROL("Phono Analog Input Switch", 5, 0),
 	DMX6FIRE_CONTROL("Breakbox LED", 6, 0),
@@ -968,7 +968,7 @@ static int __devinit snd_ice1712_ews_add_controls(struct snd_ice1712 *ice)
 {
 	unsigned int idx;
 	int err;
-	
+
 	/* all terratec cards have spdif, but cs8427 module builds it's own controls */
 	if (ice->cs8427 == NULL) {
 		err = snd_ice1712_spdif_build_controls(ice);
diff --git a/sound/pci/ice1712/ews.h b/sound/pci/ice1712/ews.h
index 1c44371..1b478cf 100644
--- a/sound/pci/ice1712/ews.h
+++ b/sound/pci/ice1712/ews.h
@@ -23,7 +23,7 @@
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
- */      
+ */
 
 #define EWS_DEVICE_DESC \
 		"{TerraTec,EWX 24/96},"\
diff --git a/sound/pci/ice1712/hoontech.c b/sound/pci/ice1712/hoontech.c
index 6914189..e46367c 100644
--- a/sound/pci/ice1712/hoontech.c
+++ b/sound/pci/ice1712/hoontech.c
@@ -19,9 +19,9 @@
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
- */      
+ */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -146,12 +146,12 @@ static void __devinit snd_ice1712_stdsp24_box_midi(struct snd_ice1712 *ice, int
 	snd_ice1712_stdsp24_gpio_write(ice, spec->boxbits[3]);
 
 	udelay(100);
-	
+
 	ICE1712_STDSP24_2_MIDIIN(spec->boxbits, 0);
 	snd_ice1712_stdsp24_gpio_write(ice, spec->boxbits[2]);
-	
+
 	mdelay(10);
-	
+
 	ICE1712_STDSP24_2_MIDIIN(spec->boxbits, 1);
 	snd_ice1712_stdsp24_gpio_write(ice, spec->boxbits[2]);
 
@@ -190,7 +190,7 @@ static int __devinit snd_ice1712_hoontech_init(struct snd_ice1712 *ice)
 	ICE1712_STDSP24_1_CHN1(spec->boxbits, 1);
 	ICE1712_STDSP24_1_CHN2(spec->boxbits, 1);
 	ICE1712_STDSP24_1_CHN3(spec->boxbits, 1);
-	
+
 	ICE1712_STDSP24_SET_ADDR(spec->boxbits, 2);
 	ICE1712_STDSP24_CLOCK(spec->boxbits, 2, 1);
 	ICE1712_STDSP24_2_CHN4(spec->boxbits, 1);
@@ -227,8 +227,8 @@ static int __devinit snd_ice1712_hoontech_init(struct snd_ice1712 *ice)
 				     ICE1712_STDSP24_BOX_CHN4 |
 				     ICE1712_STDSP24_BOX_MIDI1 |
 				     ICE1712_STDSP24_BOX_MIDI2;
-	spec->boxconfig[1] = 
-	spec->boxconfig[2] = 
+	spec->boxconfig[1] =
+	spec->boxconfig[2] =
 	spec->boxconfig[3] = 0;
 	snd_ice1712_stdsp24_darear(ice,
 		(spec->config & ICE1712_STDSP24_DAREAR) ? 1 : 0);
@@ -298,10 +298,10 @@ static int __devinit snd_ice1712_value_init(struct snd_ice1712 *ice)
 
 	/* set the analog ADCs */
 	ice->num_total_adcs = 2;
-	
+
 	/* analog section */
 	ak = ice->akm = kmalloc(sizeof(struct snd_akm4xxx), GFP_KERNEL);
-	if (! ak)
+	if (!ak)
 		return -ENOMEM;
 	ice->akm_codecs = 1;
 
diff --git a/sound/pci/ice1712/hoontech.h b/sound/pci/ice1712/hoontech.h
index cc1da1e..a37a087 100644
--- a/sound/pci/ice1712/hoontech.h
+++ b/sound/pci/ice1712/hoontech.h
@@ -22,7 +22,7 @@
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
- */      
+ */
 
 #define  HOONTECH_DEVICE_DESC \
 	"{Hoontech,SoundTrack DSP 24}," \
diff --git a/sound/pci/ice1712/ice1712.c b/sound/pci/ice1712/ice1712.c
index 5b44238..2559b2a 100644
--- a/sound/pci/ice1712/ice1712.c
+++ b/sound/pci/ice1712/ice1712.c
@@ -2288,7 +2288,7 @@ static unsigned char __devinit snd_ice1712_read_i2c(struct snd_ice1712 *ice,
 
 	outb(addr, ICEREG(ice, I2C_BYTE_ADDR));
 	outb(dev & ~ICE1712_I2C_WRITE, ICEREG(ice, I2C_DEV_ADDR));
-	while (t-- > 0 && (inb(ICEREG(ice, I2C_CTRL)) & ICE1712_I2C_BUSY)) ;
+	while (t-- > 0 && (inb(ICEREG(ice, I2C_CTRL)) & ICE1712_I2C_BUSY));
 	return inb(ICEREG(ice, I2C_DATA));
 }
 
@@ -2680,7 +2680,7 @@ static int __devinit snd_ice1712_probe(struct pci_dev *pci,
 		}
 	}
 	c = &no_matched;
- __found:
+__found:
 
 	err = snd_ice1712_pcm_profi(ice, pcm_dev++, NULL);
 	if (err < 0) {
diff --git a/sound/pci/ice1712/ice1724.c b/sound/pci/ice1712/ice1724.c
index 1b3f117..7173bfe 100644
--- a/sound/pci/ice1712/ice1724.c
+++ b/sound/pci/ice1712/ice1724.c
@@ -1459,10 +1459,10 @@ static void snd_vt1724_proc_read(struct snd_info_entry *entry,
 
 	snd_iprintf(buffer, "  PSDOUT03 : 0x%08x\n",
 		    (unsigned)inl(ICEMT1724(ice, ROUTE_PLAYBACK)));
-	for (idx = 0x0; idx < 0x20 ; idx++)
+	for (idx = 0x0; idx < 0x20; idx++)
 		snd_iprintf(buffer, "  CCS%02x    : 0x%02x\n",
 			    idx, inb(ice->port+idx));
-	for (idx = 0x0; idx < 0x30 ; idx++)
+	for (idx = 0x0; idx < 0x30; idx++)
 		snd_iprintf(buffer, "  MT%02x     : 0x%02x\n",
 			    idx, inb(ice->profi_port+idx));
 }
diff --git a/sound/pci/ice1712/juli.c b/sound/pci/ice1712/juli.c
index c51659b..42369ff 100644
--- a/sound/pci/ice1712/juli.c
+++ b/sound/pci/ice1712/juli.c
@@ -23,7 +23,7 @@
  *
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -211,7 +211,7 @@ static void juli_akm_write(struct snd_akm4xxx *ak, int chip,
 			   unsigned char addr, unsigned char data)
 {
 	struct snd_ice1712 *ice = ak->private_data[0];
-	 
+
 	if (snd_BUG_ON(chip))
 		return;
 	snd_vt1724_write_i2c(ice, AK4358_ADDR, addr, data);
diff --git a/sound/pci/ice1712/phase.c b/sound/pci/ice1712/phase.c
index de29be8..5c36393 100644
--- a/sound/pci/ice1712/phase.c
+++ b/sound/pci/ice1712/phase.c
@@ -42,7 +42,7 @@
  *   Digital receiver: CS8414-CS (supported in this release)
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
diff --git a/sound/pci/ice1712/pontis.c b/sound/pci/ice1712/pontis.c
index 6bc3f91..14390a6 100644
--- a/sound/pci/ice1712/pontis.c
+++ b/sound/pci/ice1712/pontis.c
@@ -21,7 +21,7 @@
  *
  */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -476,7 +476,7 @@ static int pontis_gpio_mask_get(struct snd_kcontrol *kcontrol, struct snd_ctl_el
 	mutex_unlock(&ice->gpio_mutex);
 	return 0;
 }
-	
+
 static int pontis_gpio_mask_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
@@ -500,7 +500,7 @@ static int pontis_gpio_dir_get(struct snd_kcontrol *kcontrol, struct snd_ctl_ele
 	mutex_unlock(&ice->gpio_mutex);
 	return 0;
 }
-	
+
 static int pontis_gpio_dir_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem_value *ucontrol)
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
@@ -667,7 +667,7 @@ static void wm_proc_regs_read(struct snd_info_entry *entry, struct snd_info_buff
 static void wm_proc_init(struct snd_ice1712 *ice)
 {
 	struct snd_info_entry *entry;
-	if (! snd_card_proc_new(ice->card, "wm_codec", &entry)) {
+	if (!snd_card_proc_new(ice->card, "wm_codec", &entry)) {
 		snd_info_set_text_ops(entry, ice, wm_proc_regs_read);
 		entry->mode |= S_IWUSR;
 		entry->c.text.write = wm_proc_regs_write;
@@ -692,7 +692,7 @@ static void cs_proc_regs_read(struct snd_info_entry *entry, struct snd_info_buff
 static void cs_proc_init(struct snd_ice1712 *ice)
 {
 	struct snd_info_entry *entry;
-	if (! snd_card_proc_new(ice->card, "cs_codec", &entry))
+	if (!snd_card_proc_new(ice->card, "cs_codec", &entry))
 		snd_info_set_text_ops(entry, ice, cs_proc_regs_read);
 }
 
@@ -770,7 +770,7 @@ static int __devinit pontis_init(struct snd_ice1712 *ice)
 
 	/* to remeber the register values */
 	ice->akm = kzalloc(sizeof(struct snd_akm4xxx), GFP_KERNEL);
-	if (! ice->akm)
+	if (!ice->akm)
 		return -ENOMEM;
 	ice->akm_codecs = 1;
 
diff --git a/sound/pci/ice1712/pontis.h b/sound/pci/ice1712/pontis.h
index d0d1378..84bc863 100644
--- a/sound/pci/ice1712/pontis.h
+++ b/sound/pci/ice1712/pontis.h
@@ -22,7 +22,7 @@
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
- */      
+ */
 
 #define PONTIS_DEVICE_DESC 	       "{Pontis,MS300},"
 
diff --git a/sound/pci/ice1712/prodigy192.c b/sound/pci/ice1712/prodigy192.c
index 48d3679..ddfaa28 100644
--- a/sound/pci/ice1712/prodigy192.c
+++ b/sound/pci/ice1712/prodigy192.c
@@ -52,9 +52,9 @@
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
- */      
+ */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -297,7 +297,7 @@ static int stac9460_mic_sw_get(struct snd_kcontrol *kcontrol,
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	unsigned char val;
-		
+
 	val = stac9460_get(ice, STAC946X_GENERAL_PURPOSE);
 	ucontrol->value.enumerated.item[0] = (val >> 7) & 0x1;
 	return 0;
@@ -341,7 +341,7 @@ static void stac9460_set_rate_val(struct snd_ice1712 *ice, unsigned int rate)
 	/* due to possible conflicts with mute controls - mutexing */
 	mutex_lock(&spec->mute_mutex);
 	/* we have to remember current mute status for each DAC */
-	for (idx = 0; idx < 7 ; ++idx)
+	for (idx = 0; idx < 7; ++idx)
 		changed[idx] = stac9460_dac_mute(ice,
 				STAC946X_MASTER_VOLUME + idx, 0);
 	/*printk("Rate change: %d, new MC: 0x%02x\n", rate, new);*/
@@ -349,7 +349,7 @@ static void stac9460_set_rate_val(struct snd_ice1712 *ice, unsigned int rate)
 	udelay(10);
 	/* unmuting - only originally unmuted dacs -
 	 * i.e. those changed when muting */
-	for (idx = 0; idx < 7 ; ++idx) {
+	for (idx = 0; idx < 7; ++idx) {
 		if (changed[idx])
 			stac9460_dac_mute(ice, STAC946X_MASTER_VOLUME + idx, 1);
 	}
@@ -574,7 +574,7 @@ static int ak4114_input_sw_get(struct snd_kcontrol *kcontrol,
 {
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	unsigned char val;
-		
+
 	val = prodigy192_ak4114_read(ice, AK4114_REG_IO1);
 	/* AK4114_IPS0 bit = 0 -> RX0 = Toslink
 	 * AK4114_IPS0 bit = 1 -> RX1 = Coax
@@ -745,7 +745,7 @@ static int __devinit prodigy192_init(struct snd_ice1712 *ice)
 	ice->num_total_dacs = 6;
 	ice->num_total_adcs = 2;
 	ice->vt1720 = 0;  /* ice1724, e.g. 23 GPIOs */
-	
+
 	spec = kzalloc(sizeof(*spec), GFP_KERNEL);
 	if (!spec)
 		return -ENOMEM;
diff --git a/sound/pci/ice1712/prodigy_hifi.c b/sound/pci/ice1712/prodigy_hifi.c
index 043a938..f30aa55 100644
--- a/sound/pci/ice1712/prodigy_hifi.c
+++ b/sound/pci/ice1712/prodigy_hifi.c
@@ -25,7 +25,7 @@
  */
 
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -230,7 +230,7 @@ static void ak4396_write(struct snd_ice1712 *ice, unsigned int reg,
 	snd_ice1712_gpio_set_dir(ice, AK4396_CSN|AK4396_CCLK|AK4396_CDTI);
 	snd_ice1712_gpio_set_mask(ice, ~(AK4396_CSN|AK4396_CCLK|AK4396_CDTI));
 	/* latch must be low when writing */
-	set_gpio_bit(ice, AK4396_CSN, 0); 
+	set_gpio_bit(ice, AK4396_CSN, 0);
 	block =  ((AK4396_ADDR & 0x03) << 14) | (1 << 13) |
 			((reg & 0x1f) << 8) | (data & 0xff);
 	ak4396_send_word(ice, block); /* REGISTER ADDRESS */
@@ -269,7 +269,7 @@ static int ak4396_dac_vol_get(struct snd_kcontrol *kcontrol,
 	struct snd_ice1712 *ice = snd_kcontrol_chip(kcontrol);
 	struct prodigy_hifi_spec *spec = ice->spec;
 	int i;
-	
+
 	for (i = 0; i < 2; i++)
 		ucontrol->value.integer.value[i] = spec->vol[i];
 
@@ -282,7 +282,7 @@ static int ak4396_dac_vol_put(struct snd_kcontrol *kcontrol, struct snd_ctl_elem
 	struct prodigy_hifi_spec *spec = ice->spec;
 	int i;
 	int change = 0;
-	
+
 	mutex_lock(&ice->gpio_mutex);
 	for (i = 0; i < 2; i++) {
 		if (ucontrol->value.integer.value[i] != spec->vol[i]) {
@@ -346,7 +346,7 @@ static void wm_set_vol(struct snd_ice1712 *ice, unsigned int index,
 		       unsigned short vol, unsigned short master)
 {
 	unsigned char nvol;
-	
+
 	if ((master & WM_VOL_MUTE) || (vol & WM_VOL_MUTE))
 		nvol = 0;
 	else {
@@ -354,7 +354,7 @@ static void wm_set_vol(struct snd_ice1712 *ice, unsigned int index,
 				& WM_VOL_MAX;
 		nvol = (nvol ? (nvol + DAC_MIN) : 0) & 0xff;
 	}
-	
+
 	wm_put(ice, index, nvol);
 	wm_put_nocache(ice, index, 0x100 | nvol);
 }
@@ -363,7 +363,7 @@ static void wm8766_set_vol(struct snd_ice1712 *ice, unsigned int index,
 			   unsigned short vol, unsigned short master)
 {
 	unsigned char nvol;
-	
+
 	if ((master & WM_VOL_MUTE) || (vol & WM_VOL_MUTE))
 		nvol = 0;
 	else {
@@ -527,7 +527,7 @@ static int wm_master_vol_put(struct snd_kcontrol *kcontrol,
 			change = 1;
 		}
 	}
-	mutex_unlock(&ice->gpio_mutex);	
+	mutex_unlock(&ice->gpio_mutex);
 	return change;
 }
 
@@ -982,7 +982,7 @@ static int __devinit prodigy_hifi_init(struct snd_ice1712 *ice)
 		/* These come first to reduce init pop noise */
 		WM_ADC_MUX,	0x0003,	/* ADC mute */
 		/* 0x00c0 replaced by 0x0003 */
-		
+
 		WM_DAC_MUTE,	0x0001,	/* DAC softmute */
 		WM_DAC_CTRL1,	0x0000,	/* DAC mute */
 
@@ -1049,7 +1049,7 @@ static int __devinit prodigy_hifi_init(struct snd_ice1712 *ice)
 	/* to remeber the register values */
 
 	ice->akm = kzalloc(sizeof(struct snd_akm4xxx), GFP_KERNEL);
-	if (! ice->akm)
+	if (!ice->akm)
 		return -ENOMEM;
 	ice->akm_codecs = 1;
 
@@ -1082,7 +1082,7 @@ static int __devinit prodigy_hd2_init(struct snd_ice1712 *ice)
 	static unsigned short ak4396_inits[] = {
 		AK4396_CTRL1,	   0x87,   /* I2S Normal Mode, 24 bit */
 		AK4396_CTRL2,	   0x02,
-		AK4396_CTRL3,	   0x00, 
+		AK4396_CTRL3,	   0x00,
 		AK4396_LCH_ATT,	 0x00,
 		AK4396_RCH_ATT,	 0x00,
 	};
@@ -1103,7 +1103,7 @@ static int __devinit prodigy_hd2_init(struct snd_ice1712 *ice)
 	/* to remeber the register values */
 
 	ice->akm = kzalloc(sizeof(struct snd_akm4xxx), GFP_KERNEL);
-	if (! ice->akm)
+	if (!ice->akm)
 		return -ENOMEM;
 	ice->akm_codecs = 1;
 
@@ -1117,7 +1117,7 @@ static int __devinit prodigy_hd2_init(struct snd_ice1712 *ice)
 	ak4396_write(ice, AK4396_CTRL1, 0x86);
 	msleep(100);
 	ak4396_write(ice, AK4396_CTRL1, 0x87);
-			
+
 	for (i = 0; i < ARRAY_SIZE(ak4396_inits); i += 2)
 		ak4396_write(ice, ak4396_inits[i], ak4396_inits[i+1]);
 
@@ -1158,7 +1158,7 @@ static unsigned char prodigyhd2_eeprom[] __devinitdata = {
 };
 
 static unsigned char fortissimo4_eeprom[] __devinitdata = {
-	0x43,   /* SYSCONF: clock 512, ADC, 4DACs */	
+	0x43,   /* SYSCONF: clock 512, ADC, 4DACs */
 	0x80,   /* ACLINK: I2S */
 	0xfc,   /* I2S: vol, 96k, 24bit, 192k */
 	0xc1,   /* SPDIF: out-en, out-int */
diff --git a/sound/pci/ice1712/prodigy_hifi.h b/sound/pci/ice1712/prodigy_hifi.h
index a4415d4..5667d51 100644
--- a/sound/pci/ice1712/prodigy_hifi.h
+++ b/sound/pci/ice1712/prodigy_hifi.h
@@ -22,7 +22,7 @@
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
- */      
+ */
 
 #define PRODIGY_HIFI_DEVICE_DESC 	       "{Audiotrak,Prodigy 7.1 HIFI},"\
                                            "{Audiotrak Prodigy HD2},"\
diff --git a/sound/pci/ice1712/revo.c b/sound/pci/ice1712/revo.c
index b508bb3..0cdeb85 100644
--- a/sound/pci/ice1712/revo.c
+++ b/sound/pci/ice1712/revo.c
@@ -19,9 +19,9 @@
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
- */      
+ */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -523,7 +523,7 @@ static int __devinit revo_init(struct snd_ice1712 *ice)
 
 	/* second stage of initialization, analog parts and others */
 	ak = ice->akm = kcalloc(2, sizeof(struct snd_akm4xxx), GFP_KERNEL);
-	if (! ak)
+	if (!ak)
 		return -ENOMEM;
 	switch (ice->eeprom.subvendor) {
 	case VT1724_SUBDEVICE_REVOLUTION71:
@@ -563,7 +563,7 @@ static int __devinit revo_init(struct snd_ice1712 *ice)
 					       ice);
 		if (err < 0)
 			return err;
-		
+
 		/* unmute all codecs */
 		snd_ice1712_gpio_write_bits(ice, VT1724_REVO_MUTE,
 					    VT1724_REVO_MUTE);
diff --git a/sound/pci/ice1712/revo.h b/sound/pci/ice1712/revo.h
index a3ba425..8685ac5 100644
--- a/sound/pci/ice1712/revo.h
+++ b/sound/pci/ice1712/revo.h
@@ -22,7 +22,7 @@
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
- */      
+ */
 
 #define REVO_DEVICE_DESC \
 		"{MidiMan M Audio,Revolution 7.1},"\
diff --git a/sound/pci/ice1712/se.c b/sound/pci/ice1712/se.c
index 69673b9..0af3289 100644
--- a/sound/pci/ice1712/se.c
+++ b/sound/pci/ice1712/se.c
@@ -20,9 +20,9 @@
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
- */      
+ */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
@@ -70,7 +70,7 @@ struct se_spec {
  *  WM8740
  *      A 2ch-DAC of main outputs.
  *      It setuped as I2S mode by wire, so no way to setup from software.
- *      The sample-rate are automatically changed. 
+ *      The sample-rate are automatically changed.
  *          ML/I2S (28pin) --------+
  *          MC/DM1 (27pin) -- 5V   |
  *          MD/DM0 (26pin) -- GND  |
diff --git a/sound/pci/ice1712/vt1720_mobo.c b/sound/pci/ice1712/vt1720_mobo.c
index 7f9674b..0f7ba24 100644
--- a/sound/pci/ice1712/vt1720_mobo.c
+++ b/sound/pci/ice1712/vt1720_mobo.c
@@ -19,9 +19,9 @@
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
- */      
+ */
 
-#include <asm/io.h>
+#include <linux/io.h>
 #include <linux/delay.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
diff --git a/sound/pci/ice1712/vt1720_mobo.h b/sound/pci/ice1712/vt1720_mobo.h
index 0b1b0ee..60c90d5 100644
--- a/sound/pci/ice1712/vt1720_mobo.h
+++ b/sound/pci/ice1712/vt1720_mobo.h
@@ -22,7 +22,7 @@
  *   along with this program; if not, write to the Free Software
  *   Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
  *
- */      
+ */
 
 #define VT1720_MOBO_DEVICE_DESC        "{Albatron,K8X800 Pro II},"\
 				       "{Chaintech,ZNF3-150},"\
