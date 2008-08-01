From: Pawel MOLL <pawel.moll@st.com>
Subject: [PATCH: alsa-utils] iecset update for new consumer
	status channel	bits
Date: Fri, 01 Aug 2008 11:23:58 +0100
Message-ID: <1217586238.29863.108.camel@bri1004.bri.st.com>
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

Added iecset support for some of consumer status channel bits,
new in the third edition od IEC60958-3 spec.

Signed-off-by: Pawel Moll <pawel.moll@st.com>

diff --git a/iecset/iecbits.c b/iecset/iecbits.c
index 8c62749..84d439b 100644
--- a/iecset/iecbits.c
+++ b/iecset/iecbits.c
@@ -26,17 +26,39 @@ struct category_str {
 };
 
 static struct category_str con_category[] = {
+	{ IEC958_AES1_CON_GENERAL, "general" },
+
+	{ IEC958_AES1_CON_IEC908_CD, "CD" },
+	{ IEC958_AES1_CON_NON_IEC908_CD, "non-IEC908 CD" },
+	{ IEC958_AES1_CON_MINI_DISC, "Mini-Disc" },
+	{ IEC958_AES1_CON_DVD, "DVD" },
+
+	{ IEC958_AES1_CON_PCM_CODER, "PCM coder" },
+	{ IEC958_AES1_CON_MIXER, "digital signal mixer" },
+	{ IEC958_AES1_CON_RATE_CONVERTER, "rate converter" },
+	{ IEC958_AES1_CON_SAMPLER, "sampler" },
+	{ IEC958_AES1_CON_DSP, "digital sound processor" },
+
 	{ IEC958_AES1_CON_DAT, "DAT" },
 	{ IEC958_AES1_CON_VCR, "VCR" },
-	{ IEC958_AES1_CON_MICROPHONE, "microphone" },
+	{ IEC958_AES1_CON_DCC, "DCC" },
+	{ IEC958_AES1_CON_MAGNETIC_DISC, "magnetic disc" },
+
+	{ IEC958_AES1_CON_DAB_JAPAN, "digital audio broadcast (Japan)" },
+	{ IEC958_AES1_CON_DAB_EUROPE, "digital audio broadcast (Europe)" },
+	{ IEC958_AES1_CON_DAB_USA, "digital audio broadcast (USA)" },
+	{ IEC958_AES1_CON_SOFTWARE, "software delivery" },
+
 	{ IEC958_AES1_CON_SYNTHESIZER, "synthesizer" },
-	{ IEC958_AES1_CON_RATE_CONVERTER, "rate converter" },
-	{ IEC958_AES1_CON_MIXER, "mixer" },
-	{ IEC958_AES1_CON_SAMPLER, "sampler" },
-	{ IEC958_AES1_CON_PCM_CODER, "PCM coder" },
-	{ IEC958_AES1_CON_IEC908_CD, "CD" },
-	{ IEC958_AES1_CON_NON_IEC908_CD, "non-IEC908 CD" },
-	{ IEC958_AES1_CON_GENERAL, "general" },
+	{ IEC958_AES1_CON_MICROPHONE, "microphone" },
+
+	{ IEC958_AES1_CON_ADC, "ADC without copyright information" },
+
+	{ IEC958_AES1_CON_ADC_COPYRIGHT, "ADC with copyright information" },
+
+	{ IEC958_AES1_CON_SOLIDMEM_DIGITAL_RECORDER_PLAYER, "flash memory recorder/player" },
+
+	{ IEC958_AES1_CON_EXPERIMENTAL, "experimental" },
 };
 
 
@@ -57,14 +79,38 @@ void dump_iec958(snd_aes_iec958_t *iec)
 		}
 		printf("Rate: ");
 		switch (iec->status[3] & IEC958_AES3_CON_FS) {
+		case IEC958_AES3_CON_FS_22050:
+			printf("22050 Hz\n");
+			break;
+		case IEC958_AES3_CON_FS_24000:
+			printf("24000 Hz\n");
+			break;
+		case IEC958_AES3_CON_FS_32000:
+			printf("32000 Hz\n");
+			break;
 		case IEC958_AES3_CON_FS_44100:
 			printf("44100 Hz\n");
 			break;
 		case IEC958_AES3_CON_FS_48000:
 			printf("48000 Hz\n");
 			break;
-		case IEC958_AES3_CON_FS_32000:
-			printf("32000 Hz\n");
+		case IEC958_AES3_CON_FS_88200:
+			printf("88200 Hz\n");
+			break;
+		case IEC958_AES3_CON_FS_96000:
+			printf("96000 Hz\n");
+			break;
+		case IEC958_AES3_CON_FS_176400:
+			printf("176400 Hz\n");
+			break;
+		case IEC958_AES3_CON_FS_192000:
+			printf("192000 Hz\n");
+			break;
+		case IEC958_AES3_CON_FS_768000:
+			printf("768000 Hz\n");
+			break;
+		case IEC958_AES3_CON_FS_NOTID:
+			printf("not indicated\n");
 			break;
 		default:
 			printf("unknown\n");
diff --git a/iecset/iecset.c b/iecset/iecset.c
index a2fe4d1..44c43ab 100644
--- a/iecset/iecset.c
+++ b/iecset/iecset.c
@@ -58,7 +58,7 @@ static struct cmdtbl cmds[] = {
 	{ "aud", IDX_NOAUDIO, CMD_BOOL_INV,
 	  "audio (common)\n\ton = audio mode, off = non-audio mode" },
 	{ "rat", IDX_RATE, CMD_INT,
-	  "rate (common)\n\tsample rate in Hz" },
+	  "rate (common)\n\tsample rate in Hz (0 = not indicated)" },
 	{ "emp", IDX_EMP, CMD_INT,
 	  "emphasis (common)\n\t0 = none, 1 = 50/15us, 2 = CCITT" },
 	{ "loc", IDX_UNLOCK, CMD_BOOL_INV,
@@ -194,14 +194,38 @@ static int update_iec958_status(snd_aes_iec958_t *iec958, int *parms)
 		} else {
 			iec958->status[3] &= ~IEC958_AES3_CON_FS;
 			switch (parms[IDX_RATE]) {
+			case 22050:
+				iec958->status[3] |= IEC958_AES3_CON_FS_22050;
+				break;
+			case 24000:
+				iec958->status[3] |= IEC958_AES3_CON_FS_24000;
+				break;
+			case 32000:
+				iec958->status[3] |= IEC958_AES3_CON_FS_32000;
+				break;
 			case 44100:
 				iec958->status[3] |= IEC958_AES3_CON_FS_44100;
 				break;
 			case 48000:
 				iec958->status[3] |= IEC958_AES3_CON_FS_48000;
 				break;
-			case 32000:
-				iec958->status[3] |= IEC958_AES3_CON_FS_32000;
+			case 88200:
+				iec958->status[3] |= IEC958_AES3_CON_FS_88200;;
+				break;
+			case 96000:
+				iec958->status[3] |= IEC958_AES3_CON_FS_96000;
+				break;
+			case 176400:
+				iec958->status[3] |= IEC958_AES3_CON_FS_176400;
+				break;
+			case 192000:
+				iec958->status[3] |= IEC958_AES3_CON_FS_192000;
+				break;
+			case 768000:
+				iec958->status[3] |= IEC958_AES3_CON_FS_768000;
+				break;
+			default:
+				iec958->status[3] |= IEC958_AES3_CON_FS_NOTID;
 				break;
 			}
 		}
-- 
1.5.5.1
