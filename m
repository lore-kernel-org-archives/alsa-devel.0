From: Pawel MOLL <pawel.moll@st.com>
Subject: [PATCH: alsa-kernel] ALSA: IEC958 definition for
	consumer status	channel update
Date: Fri, 01 Aug 2008 11:23:44 +0100
Message-ID: <1217586224.29863.106.camel@bri1004.bri.st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Updated IEC958 consumer status channel definitions according
to the third edition of IEC60958-3 spec.

Signed-off-by: Pawel Moll <pawel.moll@st.com>

diff --git a/include/sound/asoundef.h b/include/sound/asoundef.h
index a6e0fac..20ebf32 100644
--- a/include/sound/asoundef.h
+++ b/include/sound/asoundef.h
@@ -60,35 +60,56 @@
 #define IEC958_AES1_PRO_USERBITS_UDEF	(12<<4)	/* user defined application */
 #define IEC958_AES1_CON_CATEGORY	0x7f
 #define IEC958_AES1_CON_GENERAL		0x00
-#define IEC958_AES1_CON_EXPERIMENTAL	0x40
-#define IEC958_AES1_CON_SOLIDMEM_MASK	0x0f
-#define IEC958_AES1_CON_SOLIDMEM_ID	0x08
-#define IEC958_AES1_CON_BROADCAST1_MASK 0x07
-#define IEC958_AES1_CON_BROADCAST1_ID	0x04
-#define IEC958_AES1_CON_DIGDIGCONV_MASK 0x07
-#define IEC958_AES1_CON_DIGDIGCONV_ID	0x02
-#define IEC958_AES1_CON_ADC_COPYRIGHT_MASK 0x1f
-#define IEC958_AES1_CON_ADC_COPYRIGHT_ID 0x06
-#define IEC958_AES1_CON_ADC_MASK	0x1f
-#define IEC958_AES1_CON_ADC_ID		0x16
-#define IEC958_AES1_CON_BROADCAST2_MASK 0x0f
-#define IEC958_AES1_CON_BROADCAST2_ID	0x0e
 #define IEC958_AES1_CON_LASEROPT_MASK	0x07
 #define IEC958_AES1_CON_LASEROPT_ID	0x01
-#define IEC958_AES1_CON_MUSICAL_MASK	0x07
-#define IEC958_AES1_CON_MUSICAL_ID	0x05
-#define IEC958_AES1_CON_MAGNETIC_MASK	0x07
-#define IEC958_AES1_CON_MAGNETIC_ID	0x03
 #define IEC958_AES1_CON_IEC908_CD	(IEC958_AES1_CON_LASEROPT_ID|0x00)
 #define IEC958_AES1_CON_NON_IEC908_CD	(IEC958_AES1_CON_LASEROPT_ID|0x08)
+#define IEC958_AES1_CON_MINI_DISC	(IEC958_AES1_CON_LASEROPT_ID|0x48)
+#define IEC958_AES1_CON_DVD		(IEC958_AES1_CON_LASEROPT_ID|0x18)
+#define IEC958_AES1_CON_LASTEROPT_OTHER	(IEC958_AES1_CON_LASEROPT_ID|0x78)
+#define IEC958_AES1_CON_DIGDIGCONV_MASK 0x07
+#define IEC958_AES1_CON_DIGDIGCONV_ID	0x02
 #define IEC958_AES1_CON_PCM_CODER	(IEC958_AES1_CON_DIGDIGCONV_ID|0x00)
-#define IEC958_AES1_CON_SAMPLER		(IEC958_AES1_CON_DIGDIGCONV_ID|0x20)
 #define IEC958_AES1_CON_MIXER		(IEC958_AES1_CON_DIGDIGCONV_ID|0x10)
 #define IEC958_AES1_CON_RATE_CONVERTER	(IEC958_AES1_CON_DIGDIGCONV_ID|0x18)
-#define IEC958_AES1_CON_SYNTHESIZER	(IEC958_AES1_CON_MUSICAL_ID|0x00)
-#define IEC958_AES1_CON_MICROPHONE	(IEC958_AES1_CON_MUSICAL_ID|0x08)
+#define IEC958_AES1_CON_SAMPLER		(IEC958_AES1_CON_DIGDIGCONV_ID|0x20)
+#define IEC958_AES1_CON_DSP		(IEC958_AES1_CON_DIGDIGCONV_ID|0x28)
+#define IEC958_AES1_CON_DIGDIGCONV_OTHER (IEC958_AES1_CON_DIGDIGCONV_ID|0x78)
+#define IEC958_AES1_CON_MAGNETIC_MASK	0x07
+#define IEC958_AES1_CON_MAGNETIC_ID	0x03
 #define IEC958_AES1_CON_DAT		(IEC958_AES1_CON_MAGNETIC_ID|0x00)
 #define IEC958_AES1_CON_VCR		(IEC958_AES1_CON_MAGNETIC_ID|0x08)
+#define IEC958_AES1_CON_DCC		(IEC958_AES1_CON_MAGNETIC_ID|0x40)
+#define IEC958_AES1_CON_MAGNETIC_DISC	(IEC958_AES1_CON_MAGNETIC_ID|0x18)
+#define IEC958_AES1_CON_MAGNETIC_OTHER	(IEC958_AES1_CON_MAGNETIC_ID|0x78)
+#define IEC958_AES1_CON_BROADCAST1_MASK 0x07
+#define IEC958_AES1_CON_BROADCAST1_ID	0x04
+#define IEC958_AES1_CON_DAB_JAPAN	(IEC958_AES1_CON_BROADCAST1_ID|0x00)
+#define IEC958_AES1_CON_DAB_EUROPE	(IEC958_AES1_CON_BROADCAST1_ID|0x08)
+#define IEC958_AES1_CON_DAB_USA		(IEC958_AES1_CON_BROADCAST1_ID|0x60)
+#define IEC958_AES1_CON_SOFTWARE	(IEC958_AES1_CON_BROADCAST1_ID|0x40)
+#define IEC958_AES1_CON_IEC62105	(IEC958_AES1_CON_BROADCAST1_ID|0x20)
+#define IEC958_AES1_CON_BROADCAST1_OTHER (IEC958_AES1_CON_BROADCAST1_ID|0x78)
+#define IEC958_AES1_CON_BROADCAST2_MASK 0x0f
+#define IEC958_AES1_CON_BROADCAST2_ID	0x0e
+#define IEC958_AES1_CON_MUSICAL_MASK	0x07
+#define IEC958_AES1_CON_MUSICAL_ID	0x05
+#define IEC958_AES1_CON_SYNTHESIZER	(IEC958_AES1_CON_MUSICAL_ID|0x00)
+#define IEC958_AES1_CON_MICROPHONE	(IEC958_AES1_CON_MUSICAL_ID|0x08)
+#define IEC958_AES1_CON_MUSICAL_OTHER	(IEC958_AES1_CON_MUSICAL_ID|0x78)
+#define IEC958_AES1_CON_ADC_MASK	0x1f
+#define IEC958_AES1_CON_ADC_ID		0x06
+#define IEC958_AES1_CON_ADC		(IEC958_AES1_CON_ADC_ID|0x00)
+#define IEC958_AES1_CON_ADC_OTHER	(IEC958_AES1_CON_ADC_ID|0x60)
+#define IEC958_AES1_CON_ADC_COPYRIGHT_MASK 0x1f
+#define IEC958_AES1_CON_ADC_COPYRIGHT_ID 0x16
+#define IEC958_AES1_CON_ADC_COPYRIGHT	(IEC958_AES1_CON_ADC_COPYRIGHT_ID|0x00)
+#define IEC958_AES1_CON_ADC_COPYRIGHT_OTHER (IEC958_AES1_CON_ADC_COPYRIGHT_ID|0x60)
+#define IEC958_AES1_CON_SOLIDMEM_MASK	0x0f
+#define IEC958_AES1_CON_SOLIDMEM_ID	0x08
+#define IEC958_AES1_CON_SOLIDMEM_DIGITAL_RECORDER_PLAYER (IEC958_AES1_CON_SOLIDMEM_ID|0x00)
+#define IEC958_AES1_CON_SOLIDMEM_OTHER	(IEC958_AES1_CON_SOLIDMEM_ID|0x70)
+#define IEC958_AES1_CON_EXPERIMENTAL	0x40
 #define IEC958_AES1_CON_ORIGINAL	(1<<7)	/* this bits depends on the category code */
 #define IEC958_AES2_PRO_SBITS		(7<<0)	/* mask - sample bits */
 #define IEC958_AES2_PRO_SBITS_20	(2<<0)	/* 20-bit - coordination */
@@ -106,8 +127,16 @@
 #define IEC958_AES2_CON_CHANNEL_UNSPEC	(0<<4)	/* unspecified */
 #define IEC958_AES3_CON_FS		(15<<0)	/* mask - sample frequency */
 #define IEC958_AES3_CON_FS_44100	(0<<0)	/* 44.1kHz */
+#define IEC958_AES3_CON_FS_NOTID	(1<<0)	/* non indicated */
 #define IEC958_AES3_CON_FS_48000	(2<<0)	/* 48kHz */
 #define IEC958_AES3_CON_FS_32000	(3<<0)	/* 32kHz */
+#define IEC958_AES3_CON_FS_22050	(4<<0)	/* 22.05kHz */
+#define IEC958_AES3_CON_FS_24000	(6<<0)	/* 24kHz */
+#define IEC958_AES3_CON_FS_88200	(8<<0)	/* 88.2kHz */
+#define IEC958_AES3_CON_FS_768000	(9<<0)	/* 768kHz */
+#define IEC958_AES3_CON_FS_96000	(10<<0)	/* 96kHz */
+#define IEC958_AES3_CON_FS_176400	(12<<0)	/* 176.4kHz */
+#define IEC958_AES3_CON_FS_192000	(14<<0)	/* 192kHz */
 #define IEC958_AES3_CON_CLOCK		(3<<4)	/* mask - clock accuracy */
 #define IEC958_AES3_CON_CLOCK_1000PPM	(0<<4)	/* 1000 ppm */
 #define IEC958_AES3_CON_CLOCK_50PPM	(1<<4)	/* 50 ppm */
@@ -120,6 +149,26 @@
 #define IEC958_AES4_CON_WORDLEN_23_19	(4<<1)	/* 23-bit or 19-bit */
 #define IEC958_AES4_CON_WORDLEN_24_20	(5<<1)	/* 24-bit or 20-bit */
 #define IEC958_AES4_CON_WORDLEN_21_17	(6<<1)	/* 21-bit or 17-bit */
+#define IEC958_AES4_CON_ORIGFS		(15<<4)	/* mask - original sample frequency */
+#define IEC958_AES4_CON_ORIGFS_NOTID	(0<<4)	/* not indicated */
+#define IEC958_AES4_CON_ORIGFS_192000	(1<<4)	/* 192kHz */
+#define IEC958_AES4_CON_ORIGFS_12000	(2<<4)	/* 12kHz */
+#define IEC958_AES4_CON_ORIGFS_176400	(3<<4)	/* 176.4kHz */
+#define IEC958_AES4_CON_ORIGFS_96000	(5<<4)	/* 96kHz */
+#define IEC958_AES4_CON_ORIGFS_8000	(6<<4)	/* 8kHz */
+#define IEC958_AES4_CON_ORIGFS_88200	(7<<4)	/* 88.2kHz */
+#define IEC958_AES4_CON_ORIGFS_16000	(8<<4)	/* 16kHz */
+#define IEC958_AES4_CON_ORIGFS_24000	(9<<4)	/* 24kHz */
+#define IEC958_AES4_CON_ORIGFS_11025	(10<<4)	/* 11.025kHz */
+#define IEC958_AES4_CON_ORIGFS_22050	(11<<4)	/* 22.05kHz */
+#define IEC958_AES4_CON_ORIGFS_32000	(12<<4)	/* 32kHz */
+#define IEC958_AES4_CON_ORIGFS_48000	(13<<4)	/* 48kHz */
+#define IEC958_AES4_CON_ORIGFS_44100	(15<<4)	/* 44.1kHz */
+#define IEC958_AES5_CON_CGMSA		(3<<0)	/* mask - CGMS-A */
+#define IEC958_AES5_CON_CGMSA_COPYFREELY (0<<0)	/* copying is permitted without restriction */
+#define IEC958_AES5_CON_CGMSA_COPYONCE	(1<<0)	/* one generation of copies may be made */
+#define IEC958_AES5_CON_CGMSA_COPYNOMORE (2<<0)	/* condition not be used */
+#define IEC958_AES5_CON_CGMSA_COPYNEVER	(3<<0)	/* no copying is permitted */
 
 /*****************************************************************************
  *                                                                           *
-- 
1.5.5.1
