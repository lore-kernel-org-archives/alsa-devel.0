From: Ben Dooks <ben-alsa@fluff.org>
Subject: [PATCH] TI TLV320AIC23 register definitions
Date: Tue, 15 Mar 2005 15:30:46 +0000
Message-ID: <20050315153046.GA25402@home.fluff.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="6TrnltStXW4iwmi0"
Content-Disposition: inline
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Patch for TI TLV320AIC23 register definitions for
include/sound

Signed-off-by: Ben Dooks <ben-linux@fluff.org>

--6TrnltStXW4iwmi0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="s3c2410-audio9-tlvhdr.patch"

diff -urN -X ../dontdiff linux-2.6.11-rc5/include/sound/tlv320aic23.h linux-2.6.11-rc5-audio9/include/sound/tlv320aic23.h
--- linux-2.6.11-rc5/include/sound/tlv320aic23.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.11-rc5-audio9/include/sound/tlv320aic23.h	2005-03-11 14:12:09.000000000 +0000
@@ -0,0 +1,100 @@
+/* linux/include/sound/tlv320aic23.h
+ *
+ * Copyright (c) 2005 Simtec Electronics
+ *	http://www.simtec.co.uk/products/SWLINUX/
+ *	Ben Dooks <ben@simtec.co.uk>
+ *
+ * Register definitions for TI TLV320AIC23 audio codec
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+*/
+
+#ifndef __SOUND_TLV320AIC23_H
+#define __SOUND_TLV320AIC23_H "include/sound/tlv320aic23.h"
+
+/* TLV320AIC23 registers */
+
+#define TLV320AIC23_LINPVOL		(0x00)
+#define TLV320AIC23_RINPVOL		(0x01)
+#define TLV320AIC23_LHPVOL		(0x02)
+#define TLV320AIC23_RHPVOL		(0x03)
+#define TLV320AIC23_ANALOGPATH		(0x04)
+#define TLV320AIC23_DIGITALPATH		(0x05)
+#define TLV320AIC23_POWERCTRL		(0x06)
+#define TLV320AIC23_DIGITALFMT		(0x07)
+#define TLV320AIC23_SAMPLERATE		(0x08)
+#define TLV320AIC23_DIGITALACT		(0x09)
+#define TLV320AIC23_RESET		(0x0f)
+
+/* for the L/R line input */
+#define TLV320AIC23_INP_SIMULTUPD	(1<<8)
+#define TLV320AIC23_INP_MUTE		(1<<7)
+#define TLV320AIC23_INP_0dB		(0x17)
+
+/* L/R Headphone volume */
+#define TLV320AIC23_HPVOL_SIMULTUPD	(1<<8)
+#define TLV320AIC23_HPVOL_ZEROCROSS	(1<<7)
+#define TLV320AIC23_HPVOL_0dB		(0x79)
+#define TLV320AIC23_HPVOL_6dB		(127)
+
+/* Analog path control */
+#define TLV320AIC23_APATH_SIDETONE6dB	(0<<6)
+#define TLV320AIC23_APATH_SIDETONE9dB	(1<<6)
+#define TLV320AIC23_APATH_SIDETONE12dB	(2<<6)
+#define TLV320AIC23_APATH_SIDETONE15dB	(3<<6)
+#define TLV320AIC23_APATH_SIDETONE_EN	(1<<5)
+#define TLV320AIC23_APATH_DACEN		(1<<4)
+#define TLV320AIC23_APATH_BYPASSEN	(1<<3)
+#define TLV320AIC23_APATH_MICADC	(1<<2)
+#define TLV320AIC23_APATH_MICMUTE	(1<<1)
+#define TLV320AIC23_APATH_MICBOOST	(1<<0)
+
+/* Digital path control */
+#define TLV320AIC23_DPATH_SOFTMUTE	(1<<3)
+#define TLV320AIC23_DPATH_DEEMP_OFF	(0<<1)
+#define TLV320AIC23_DPATH_DEEMP_32K	(1<<1)
+#define TLV320AIC23_DPATH_DEEMP_44K1	(2<<1)
+#define TLV320AIC23_DPATH_DEEMP_48K	(3<<1)
+#define TLV320AIC23_DPATH_ADC_HIGHPASS	(1<<1)
+
+/* power down control (set bit to power down)  */
+#define TLV320AIC23_PDC_DEVICE		(1<<7)
+#define TLV320AIC23_PDC_CLOCK		(1<<6)
+#define TLV320AIC23_PDC_OSC		(1<<5)
+#define TLV320AIC23_PDC_OUTPUT		(1<<4)
+#define TLV320AIC23_PDC_DAC		(1<<3)
+#define TLV320AIC23_PDC_ADC		(1<<2)
+#define TLV320AIC23_PDC_MIC		(1<<1)
+#define TLV320AIC23_PDC_LINE		(1<<0)
+
+#define TLV320AIC23_PDC_DEFAULT	\
+	TLV320AIC23_PDC_CLOCK	| \
+	TLV320AIC23_PDC_OSC	| \
+	TLV320AIC23_PDC_OUTPUT	| \
+	TLV320AIC23_PDC_DAC	| \
+	TLV320AIC23_PDC_ADC	| \
+	TLV320AIC23_PDC_MIC	| \
+	TLV320AIC23_PDC_LINE
+
+/* digital data format control */
+#define TLV320AIC23_DIGITALFMT_MASTER	(1<<6)
+#define TLV320AIC23_DIGITALFMT_LRSWAP	(1<<5)
+#define TLV320AIC23_DIGITALFMT_LRPHASE	(1<<4)
+#define TLV320AIC23_DIGITALFMT_16BIT	(0<<2)
+#define TLV320AIC23_DIGITALFMT_20BIT	(1<<2)
+#define TLV320AIC23_DIGITALFMT_24BIT	(2<<2)
+#define TLV320AIC23_DIGITALFMT_32BIT	(3<<2)
+#define TLV320AIC23_DIGITALFMT_BITMASK	(3<<2)
+#define TLV320AIC23_DIGITALFMT_DSP	(3<<0)
+#define TLV320AIC23_DIGITALFMT_I2S	(2<<0)
+#define TLV320AIC23_DIGITALFMT_LEFT	(1<<0)
+#define TLV320AIC23_DIGITALFMT_RIGHT	(0<<0)
+
+/* sample rate control */
+#define TLV320AIC23_SAMPLERATE_USB	(1<<0)
+#define TLV320AIC23_SAMPLERATE_BOSR	(1<<1)
+#define TLV320AIC23_SAMPLERATE_MASK	(0xf << 2)
+
+#endif /* __SOUND_TLV320AIC23_H */

--6TrnltStXW4iwmi0--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
