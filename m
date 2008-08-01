From: Pawel MOLL <pawel.moll@st.com>
Subject: [PATCH: alsa-lib] IEC958 definition for consumer
	status channel	update
Date: Fri, 01 Aug 2008 11:23:50 +0100
Message-ID: <1217586230.29863.107.camel@bri1004.bri.st.com>
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

diff --git a/include/asoundef.h b/include/asoundef.h
index e780c65..c6c4eec 100644
--- a/include/asoundef.h
+++ b/include/asoundef.h
@@ -69,35 +69,56 @@ extern "C" {
 #define IEC958_AES1_PRO_USERBITS_UDEF	(12<<4)	/**< user defined application */
 #define IEC958_AES1_CON_CATEGORY	0x7f	/**< consumer category */
 #define IEC958_AES1_CON_GENERAL		0x00	/**< general category */
-#define IEC958_AES1_CON_EXPERIMENTAL	0x40	/**< experimental category */
-#define IEC958_AES1_CON_SOLIDMEM_MASK	0x0f	/**< ??? */
-#define IEC958_AES1_CON_SOLIDMEM_ID	0x08	/**< ??? */
-#define IEC958_AES1_CON_BROADCAST1_MASK 0x07	/**< ??? */
-#define IEC958_AES1_CON_BROADCAST1_ID	0x04	/**< ??? */
-#define IEC958_AES1_CON_DIGDIGCONV_MASK 0x07	/**< digital<->digital converter mask */
-#define IEC958_AES1_CON_DIGDIGCONV_ID	0x02	/**< digital<->digital converter id */
-#define IEC958_AES1_CON_ADC_COPYRIGHT_MASK 0x1f	/**< ADC Copyright mask */
-#define IEC958_AES1_CON_ADC_COPYRIGHT_ID 0x06	/**< ADC Copyright ID */
-#define IEC958_AES1_CON_ADC_MASK	0x1f	/**< ADC Mask */
-#define IEC958_AES1_CON_ADC_ID		0x16	/**< ADC ID */
-#define IEC958_AES1_CON_BROADCAST2_MASK 0x0f	/**< Broadcast mask */
-#define IEC958_AES1_CON_BROADCAST2_ID	0x0e	/**< Broadcast ID */
 #define IEC958_AES1_CON_LASEROPT_MASK	0x07	/**< Laser-optical mask */
 #define IEC958_AES1_CON_LASEROPT_ID	0x01	/**< Laser-optical ID */
-#define IEC958_AES1_CON_MUSICAL_MASK	0x07	/**< Musical device mask */
-#define IEC958_AES1_CON_MUSICAL_ID	0x05	/**< Musical device ID */
-#define IEC958_AES1_CON_MAGNETIC_MASK	0x07	/**< Magnetic device mask */
-#define IEC958_AES1_CON_MAGNETIC_ID	0x03	/**< Magnetic device ID */
 #define IEC958_AES1_CON_IEC908_CD	(IEC958_AES1_CON_LASEROPT_ID|0x00)	/**< IEC958 CD compatible device */
 #define IEC958_AES1_CON_NON_IEC908_CD	(IEC958_AES1_CON_LASEROPT_ID|0x08)	/**< non-IEC958 CD compatible device */
+#define IEC958_AES1_CON_MINI_DISC	(IEC958_AES1_CON_LASEROPT_ID|0x48)	/**< Mini-Disc device */
+#define IEC958_AES1_CON_DVD		(IEC958_AES1_CON_LASEROPT_ID|0x18)	/**< DVD device */
+#define IEC958_AES1_CON_LASTEROPT_OTHER	(IEC958_AES1_CON_LASEROPT_ID|0x78)	/**< Other laser-optical product */
+#define IEC958_AES1_CON_DIGDIGCONV_MASK 0x07	/**< digital<->digital converter mask */
+#define IEC958_AES1_CON_DIGDIGCONV_ID	0x02	/**< digital<->digital converter id */
 #define IEC958_AES1_CON_PCM_CODER	(IEC958_AES1_CON_DIGDIGCONV_ID|0x00)	/**< PCM coder */
-#define IEC958_AES1_CON_SAMPLER		(IEC958_AES1_CON_DIGDIGCONV_ID|0x20)	/**< PCM sampler */
-#define IEC958_AES1_CON_MIXER		(IEC958_AES1_CON_DIGDIGCONV_ID|0x10)	/**< Mixer */
+#define IEC958_AES1_CON_MIXER		(IEC958_AES1_CON_DIGDIGCONV_ID|0x10)	/**< Digital signal mixer */
 #define IEC958_AES1_CON_RATE_CONVERTER	(IEC958_AES1_CON_DIGDIGCONV_ID|0x18)	/**< Rate converter */
-#define IEC958_AES1_CON_SYNTHESIZER	(IEC958_AES1_CON_MUSICAL_ID|0x00)	/**< Synthesizer */
-#define IEC958_AES1_CON_MICROPHONE	(IEC958_AES1_CON_MUSICAL_ID|0x08)	/**< Microphone */
+#define IEC958_AES1_CON_SAMPLER		(IEC958_AES1_CON_DIGDIGCONV_ID|0x20)	/**< PCM sampler */
+#define IEC958_AES1_CON_DSP		(IEC958_AES1_CON_DIGDIGCONV_ID|0x28)	/**< Digital sound processor */
+#define IEC958_AES1_CON_DIGDIGCONV_OTHER (IEC958_AES1_CON_DIGDIGCONV_ID|0x78)	/**< Other digital<->digital product */
+#define IEC958_AES1_CON_MAGNETIC_MASK	0x07	/**< Magnetic device mask */
+#define IEC958_AES1_CON_MAGNETIC_ID	0x03	/**< Magnetic device ID */
 #define IEC958_AES1_CON_DAT		(IEC958_AES1_CON_MAGNETIC_ID|0x00)	/**< Digital Audio Tape */
 #define IEC958_AES1_CON_VCR		(IEC958_AES1_CON_MAGNETIC_ID|0x08)	/**< Video recorder */
+#define IEC958_AES1_CON_DCC		(IEC958_AES1_CON_MAGNETIC_ID|0x40)	/**< Digital compact cassette */
+#define IEC958_AES1_CON_MAGNETIC_DISC	(IEC958_AES1_CON_MAGNETIC_ID|0x18)	/**< Magnetic disc digital audio device */
+#define IEC958_AES1_CON_MAGNETIC_OTHER	(IEC958_AES1_CON_MAGNETIC_ID|0x78)	/**< Other magnetic device */
+#define IEC958_AES1_CON_BROADCAST1_MASK 0x07	/**< Broadcast mask */
+#define IEC958_AES1_CON_BROADCAST1_ID	0x04	/**< Broadcast ID */
+#define IEC958_AES1_CON_DAB_JAPAN	(IEC958_AES1_CON_BROADCAST1_ID|0x00)	/**< Digital audio broadcast (Japan) */
+#define IEC958_AES1_CON_DAB_EUROPE	(IEC958_AES1_CON_BROADCAST1_ID|0x08)	/**< Digital audio broadcast (Europe) */
+#define IEC958_AES1_CON_DAB_USA		(IEC958_AES1_CON_BROADCAST1_ID|0x60)	/**< Digital audio broadcast (USA) */
+#define IEC958_AES1_CON_SOFTWARE	(IEC958_AES1_CON_BROADCAST1_ID|0x40)	/**< Electronic software delivery */
+#define IEC958_AES1_CON_IEC62105	(IEC958_AES1_CON_BROADCAST1_ID|0x20)	/**< Used by another standard (IEC 62105) */
+#define IEC958_AES1_CON_BROADCAST1_OTHER (IEC958_AES1_CON_BROADCAST1_ID|0x78)	/**< Other broadcast product */
+#define IEC958_AES1_CON_BROADCAST2_MASK 0x0f	/**< Broadcast alternative mask */
+#define IEC958_AES1_CON_BROADCAST2_ID	0x0e	/**< Broadcast alternative ID */
+#define IEC958_AES1_CON_MUSICAL_MASK	0x07	/**< Musical device mask */
+#define IEC958_AES1_CON_MUSICAL_ID	0x05	/**< Musical device ID */
+#define IEC958_AES1_CON_SYNTHESIZER	(IEC958_AES1_CON_MUSICAL_ID|0x00)	/**< Synthesizer */
+#define IEC958_AES1_CON_MICROPHONE	(IEC958_AES1_CON_MUSICAL_ID|0x08)	/**< Microphone */
+#define IEC958_AES1_CON_MUSICAL_OTHER	(IEC958_AES1_CON_MUSICAL_ID|0x78)	/**< Other musical device */
+#define IEC958_AES1_CON_ADC_MASK	0x1f	/**< ADC Mask */
+#define IEC958_AES1_CON_ADC_ID		0x06	/**< ADC ID */
+#define IEC958_AES1_CON_ADC		(IEC958_AES1_CON_ADC_ID|0x00)	/**< ADC without copyright information */
+#define IEC958_AES1_CON_ADC_OTHER	(IEC958_AES1_CON_ADC_ID|0x60)	/**< Other ADC product (with no copyright information) */
+#define IEC958_AES1_CON_ADC_COPYRIGHT_MASK 0x1f	/**< ADC Copyright mask */
+#define IEC958_AES1_CON_ADC_COPYRIGHT_ID 0x16	/**< ADC Copyright ID */
+#define IEC958_AES1_CON_ADC_COPYRIGHT	(IEC958_AES1_CON_ADC_COPYRIGHT_ID|0x00)	/**< ADC with copyright information */
+#define IEC958_AES1_CON_ADC_COPYRIGHT_OTHER (IEC958_AES1_CON_ADC_COPYRIGHT_ID|0x60)	/**< Other ADC with copyright information product */
+#define IEC958_AES1_CON_SOLIDMEM_MASK	0x0f	/**< Solid memory based products mask */
+#define IEC958_AES1_CON_SOLIDMEM_ID	0x08	/**< Solid memory based products ID */
+#define IEC958_AES1_CON_SOLIDMEM_DIGITAL_RECORDER_PLAYER (IEC958_AES1_CON_SOLIDMEM_ID|0x00)	/**< Digital audio recorder and player using solid state memory */
+#define IEC958_AES1_CON_SOLIDMEM_OTHER	(IEC958_AES1_CON_SOLIDMEM_ID|0x70)	/**< Other solid state memory based product */
+#define IEC958_AES1_CON_EXPERIMENTAL	0x40	/**< experimental category */
 #define IEC958_AES1_CON_ORIGINAL	(1<<7)	/**< this bits depends on the category code */
 #define IEC958_AES2_PRO_SBITS		(7<<0)	/**< mask - sample bits */
 #define IEC958_AES2_PRO_SBITS_20	(2<<0)	/**< 20-bit - coordination */
@@ -115,8 +136,16 @@ extern "C" {
 #define IEC958_AES2_CON_CHANNEL_UNSPEC	(0<<4)	/**< channel number unspecified */
 #define IEC958_AES3_CON_FS		(15<<0)	/**< mask - sample frequency */
 #define IEC958_AES3_CON_FS_44100	(0<<0)	/**< 44.1kHz */
+#define IEC958_AES3_CON_FS_NOTID	(1<<0)	/**< sample frequency non indicated */
 #define IEC958_AES3_CON_FS_48000	(2<<0)	/**< 48kHz */
 #define IEC958_AES3_CON_FS_32000	(3<<0)	/**< 32kHz */
+#define IEC958_AES3_CON_FS_22050	(4<<0)	/**< 22.05kHz */
+#define IEC958_AES3_CON_FS_24000	(6<<0)	/**< 24kHz */
+#define IEC958_AES3_CON_FS_88200	(8<<0)	/**< 88.2kHz */
+#define IEC958_AES3_CON_FS_768000	(9<<0)	/**< 768kHz */
+#define IEC958_AES3_CON_FS_96000	(10<<0)	/**< 96kHz */
+#define IEC958_AES3_CON_FS_176400	(12<<0)	/**< 176.4kHz */
+#define IEC958_AES3_CON_FS_192000	(14<<0)	/**< 192kHz */
 #define IEC958_AES3_CON_CLOCK		(3<<4)	/**< mask - clock accuracy */
 #define IEC958_AES3_CON_CLOCK_1000PPM	(0<<4)	/**< 1000 ppm */
 #define IEC958_AES3_CON_CLOCK_50PPM	(1<<4)	/**< 50 ppm */
@@ -129,6 +158,26 @@ extern "C" {
 #define IEC958_AES4_CON_WORDLEN_23_19	(4<<1)	/**< 23-bit or 19-bit */
 #define IEC958_AES4_CON_WORDLEN_24_20	(5<<1)	/**< 24-bit or 20-bit */
 #define IEC958_AES4_CON_WORDLEN_21_17	(6<<1)	/**< 21-bit or 17-bit */
+#define IEC958_AES4_CON_ORIGFS		(15<<4)	/**< mask - original sample frequency */
+#define IEC958_AES4_CON_ORIGFS_NOTID	(0<<4)	/**< original sample frequency not indicated */
+#define IEC958_AES4_CON_ORIGFS_192000	(1<<4)	/**< 192kHz */
+#define IEC958_AES4_CON_ORIGFS_12000	(2<<4)	/**< 12kHz */
+#define IEC958_AES4_CON_ORIGFS_176400	(3<<4)	/**< 176.4kHz */
+#define IEC958_AES4_CON_ORIGFS_96000	(5<<4)	/**< 96kHz */
+#define IEC958_AES4_CON_ORIGFS_8000	(6<<4)	/**< 8kHz */
+#define IEC958_AES4_CON_ORIGFS_88200	(7<<4)	/**< 88.2kHz */
+#define IEC958_AES4_CON_ORIGFS_16000	(8<<4)	/**< 16kHz */
+#define IEC958_AES4_CON_ORIGFS_24000	(9<<4)	/**< 24kHz */
+#define IEC958_AES4_CON_ORIGFS_11025	(10<<4)	/**< 11.025kHz */
+#define IEC958_AES4_CON_ORIGFS_22050	(11<<4)	/**< 22.05kHz */
+#define IEC958_AES4_CON_ORIGFS_32000	(12<<4)	/**< 32kHz */
+#define IEC958_AES4_CON_ORIGFS_48000	(13<<4)	/**< 48kHz */
+#define IEC958_AES4_CON_ORIGFS_44100	(15<<4)	/**< 44.1kHz */
+#define IEC958_AES5_CON_CGMSA		(3<<0)	/**< mask - CGMS-A */
+#define IEC958_AES5_CON_CGMSA_COPYFREELY (0<<0)	/**< copying is permitted without restriction */
+#define IEC958_AES5_CON_CGMSA_COPYONCE	(1<<0)	/**< one generation of copies may be made */
+#define IEC958_AES5_CON_CGMSA_COPYNOMORE (2<<0)	/**< condition not be used */
+#define IEC958_AES5_CON_CGMSA_COPYNEVER	(3<<0)	/**< no copying is permitted */
 
 /** \} */
 
-- 
1.5.5.1
