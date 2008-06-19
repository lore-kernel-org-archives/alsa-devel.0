From: linux@audioscience.com
Subject: [PATCH - asihpi 2/2] Disable S24_3LE incompatible with
	2^N buffer size.
Date: Thu, 19 Jun 2008 14:15:13 +1200
Message-ID: <1213841713-20114-1-git-send-email-linux@audioscience.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5.clear.net.nz (smtp5.clear.net.nz [203.97.33.68])
	by alsa0.perex.cz (Postfix) with ESMTP id 0F5DF24537
	for <alsa-devel@alsa-project.org>;
	Thu, 19 Jun 2008 04:15:21 +0200 (CEST)
Received: from localhost.localdomain
	(121-72-250-62.cable.telstraclear.net [121.72.250.62])
	by smtp5.clear.net.nz (CLEAR Net Mail)
	with ESMTP id <0K2O00IA6U9DOK00@smtp5.clear.net.nz> for
	alsa-devel@alsa-project.org; Thu, 19 Jun 2008 14:15:15 +1200 (NZST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: Eliot Blennerhassett <eblennerhassett@audioscience.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eblennerhassett@audioscience.com>


Signed-off-by: Eliot Blennerhassett <eblennerhassett@audioscience.com>

diff --git a/pci/asihpi/asihpi.c b/pci/asihpi/asihpi.c
index ab90b08..c715ad2 100644
--- a/pci/asihpi/asihpi.c
+++ b/pci/asihpi/asihpi.c
@@ -328,21 +328,28 @@ static void print_hwparams(struct snd_pcm_hw_params *p)
 
 static snd_pcm_format_t hpi_to_alsa_formats[] = {
 	-1,			/* INVALID */
-	SNDRV_PCM_FORMAT_U8,	/* { HPI_FORMAT_PCM8_UNSIGNED        1 */
-	SNDRV_PCM_FORMAT_S16,	/* { HPI_FORMAT_PCM16_SIGNED         2 */
-	-1,			/* { HPI_FORMAT_MPEG_L1              3 */
-	SNDRV_PCM_FORMAT_MPEG,	/* { HPI_FORMAT_MPEG_L2              4 */
-	SNDRV_PCM_FORMAT_MPEG,	/* { HPI_FORMAT_MPEG_L3              5 */
-	-1,			/* { HPI_FORMAT_DOLBY_AC2            6 */
-	-1,			/* { HPI_FORMAT_DOLBY_AC3            7 */
-	SNDRV_PCM_FORMAT_S16_BE,/* { HPI_FORMAT_PCM16_BIGENDIAN      8 */
-	-1,			/* { HPI_FORMAT_AA_TAGIT1_HITS       9 */
-	-1,			/* { HPI_FORMAT_AA_TAGIT1_INSERTS   10 */
-	SNDRV_PCM_FORMAT_S32,	/* { HPI_FORMAT_PCM32_SIGNED        11 */
-	-1,			/* { HPI_FORMAT_RAW_BITSTREAM       12 */
-	-1,			/* { HPI_FORMAT_AA_TAGIT1_HITS_EX1  13 */
-	SNDRV_PCM_FORMAT_FLOAT,	/* { HPI_FORMAT_PCM32_FLOAT         14 */
-	SNDRV_PCM_FORMAT_S24	/* { HPI_FORMAT_PCM24_SIGNED        15 */
+	SNDRV_PCM_FORMAT_U8,	/* HPI_FORMAT_PCM8_UNSIGNED        1 */
+	SNDRV_PCM_FORMAT_S16,	/* HPI_FORMAT_PCM16_SIGNED         2 */
+	-1,			/* HPI_FORMAT_MPEG_L1              3 */
+	SNDRV_PCM_FORMAT_MPEG,	/* HPI_FORMAT_MPEG_L2              4 */
+	SNDRV_PCM_FORMAT_MPEG,	/* HPI_FORMAT_MPEG_L3              5 */
+	-1,			/* HPI_FORMAT_DOLBY_AC2            6 */
+	-1,			/* HPI_FORMAT_DOLBY_AC3            7 */
+	SNDRV_PCM_FORMAT_S16_BE,/* HPI_FORMAT_PCM16_BIGENDIAN      8 */
+	-1,			/* HPI_FORMAT_AA_TAGIT1_HITS       9 */
+	-1,			/* HPI_FORMAT_AA_TAGIT1_INSERTS   10 */
+	SNDRV_PCM_FORMAT_S32,	/* HPI_FORMAT_PCM32_SIGNED        11 */
+	-1,			/* HPI_FORMAT_RAW_BITSTREAM       12 */
+	-1,			/* HPI_FORMAT_AA_TAGIT1_HITS_EX1  13 */
+	SNDRV_PCM_FORMAT_FLOAT,	/* HPI_FORMAT_PCM32_FLOAT         14 */
+#if 1
+	/* ALSA can't handle 3 byte sample size together with power-of-2
+	 *  constraint on buffer_bytes, so disable this format
+	 */
+	-1
+#else
+	/* SNDRV_PCM_FORMAT_S24_3LE */	/* { HPI_FORMAT_PCM24_SIGNED        15 */
+#endif
 };
 
 
@@ -978,7 +985,7 @@ static int snd_card_asihpi_playback_open(struct snd_pcm_substream *substream)
 	runtime->hw = snd_card_asihpi_playback;
 	/* Strictly only necessary for HPI6205 adapters */
 	err = snd_pcm_hw_constraint_pow2(runtime, 0,
-					SNDRV_PCM_HW_PARAM_BUFFER_SIZE);
+					SNDRV_PCM_HW_PARAM_BUFFER_BYTES);
 	if (err < 0)
 		return err;
 
@@ -1195,7 +1202,7 @@ static int snd_card_asihpi_capture_open(struct snd_pcm_substream *substream)
 
 	/* Strictly only necessary for HPI6205 adapters */
 	err = snd_pcm_hw_constraint_pow2(runtime, 0,
-					SNDRV_PCM_HW_PARAM_BUFFER_SIZE);
+					SNDRV_PCM_HW_PARAM_BUFFER_BYTES);
 	if (err < 0)
 		return err;
 
@@ -2025,6 +2032,7 @@ static int snd_asihpi_meter_get(struct snd_kcontrol *kcontrol,
 	short anGain0_01dB[HPI_MAX_CHANNELS], i;
 	u16 err;
 
+	//err = HPI_MeterGetRms(phSubSys, hControl, anGain0_01dB);
 	err = HPI_MeterGetPeak(phSubSys, hControl, anGain0_01dB);
 
 	for (i = 0; i < HPI_MAX_CHANNELS; i++) {
-- 
1.5.4.3
