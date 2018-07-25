From: Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 06/10] ALSA: asihpi: Fix PCM format notations
Date: Wed, 25 Jul 2018 23:19:41 +0200
Message-ID: <20180725211945.19222-7-tiwai@suse.de>
References: <20180725211945.19222-1-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.suse.de (mx2.suse.de [195.135.220.15])
 by alsa0.perex.cz (Postfix) with ESMTP id 5A919267762
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 23:19:55 +0200 (CEST)
Received: from relay2.suse.de (unknown [195.135.220.254])
 by mx1.suse.de (Postfix) with ESMTP id DC739B37E
 for <alsa-devel@alsa-project.org>; Wed, 25 Jul 2018 21:19:53 +0000 (UTC)
In-Reply-To: <20180725211945.19222-1-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

asihpi driver treats -1 as an own invalid PCM format, but this needs
a proper cast with __force prefix since PCM format type is __bitwise.
Define a constant with the proper type and use it allover.

This fixes sparse warnings like:
  sound/pci/asihpi/asihpi.c:315:9: warning: incorrect type in initializer (different base types)

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 sound/pci/asihpi/asihpi.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index 64e0961f93ba..a31fe1550903 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -311,27 +311,29 @@ static void print_hwparams(struct snd_pcm_substream *substream,
 		snd_pcm_format_width(params_format(p)) / 8);
 }
 
+#define INVALID_FORMAT	(__force snd_pcm_format_t)(-1)
+
 static snd_pcm_format_t hpi_to_alsa_formats[] = {
-	-1,			/* INVALID */
+	INVALID_FORMAT,		/* INVALID */
 	SNDRV_PCM_FORMAT_U8,	/* HPI_FORMAT_PCM8_UNSIGNED        1 */
 	SNDRV_PCM_FORMAT_S16,	/* HPI_FORMAT_PCM16_SIGNED         2 */
-	-1,			/* HPI_FORMAT_MPEG_L1              3 */
+	INVALID_FORMAT,		/* HPI_FORMAT_MPEG_L1              3 */
 	SNDRV_PCM_FORMAT_MPEG,	/* HPI_FORMAT_MPEG_L2              4 */
 	SNDRV_PCM_FORMAT_MPEG,	/* HPI_FORMAT_MPEG_L3              5 */
-	-1,			/* HPI_FORMAT_DOLBY_AC2            6 */
-	-1,			/* HPI_FORMAT_DOLBY_AC3            7 */
+	INVALID_FORMAT,		/* HPI_FORMAT_DOLBY_AC2            6 */
+	INVALID_FORMAT,		/* HPI_FORMAT_DOLBY_AC3            7 */
 	SNDRV_PCM_FORMAT_S16_BE,/* HPI_FORMAT_PCM16_BIGENDIAN      8 */
-	-1,			/* HPI_FORMAT_AA_TAGIT1_HITS       9 */
-	-1,			/* HPI_FORMAT_AA_TAGIT1_INSERTS   10 */
+	INVALID_FORMAT,		/* HPI_FORMAT_AA_TAGIT1_HITS       9 */
+	INVALID_FORMAT,		/* HPI_FORMAT_AA_TAGIT1_INSERTS   10 */
 	SNDRV_PCM_FORMAT_S32,	/* HPI_FORMAT_PCM32_SIGNED        11 */
-	-1,			/* HPI_FORMAT_RAW_BITSTREAM       12 */
-	-1,			/* HPI_FORMAT_AA_TAGIT1_HITS_EX1  13 */
+	INVALID_FORMAT,		/* HPI_FORMAT_RAW_BITSTREAM       12 */
+	INVALID_FORMAT,		/* HPI_FORMAT_AA_TAGIT1_HITS_EX1  13 */
 	SNDRV_PCM_FORMAT_FLOAT,	/* HPI_FORMAT_PCM32_FLOAT         14 */
 #if 1
 	/* ALSA can't handle 3 byte sample size together with power-of-2
 	 *  constraint on buffer_bytes, so disable this format
 	 */
-	-1
+	INVALID_FORMAT
 #else
 	/* SNDRV_PCM_FORMAT_S24_3LE */ /* HPI_FORMAT_PCM24_SIGNED 15 */
 #endif
@@ -1023,7 +1025,7 @@ static u64 snd_card_asihpi_playback_formats(struct snd_card_asihpi *asihpi,
 					format, sample_rate, 128000, 0);
 		if (!err)
 			err = hpi_outstream_query_format(h_stream, &hpi_format);
-		if (!err && (hpi_to_alsa_formats[format] != -1))
+		if (!err && (hpi_to_alsa_formats[format] != INVALID_FORMAT))
 			formats |= pcm_format_to_bits(hpi_to_alsa_formats[format]);
 	}
 	return formats;
@@ -1205,7 +1207,7 @@ static u64 snd_card_asihpi_capture_formats(struct snd_card_asihpi *asihpi,
 					format, sample_rate, 128000, 0);
 		if (!err)
 			err = hpi_instream_query_format(h_stream, &hpi_format);
-		if (!err && (hpi_to_alsa_formats[format] != -1))
+		if (!err && (hpi_to_alsa_formats[format] != INVALID_FORMAT))
 			formats |= pcm_format_to_bits(hpi_to_alsa_formats[format]);
 	}
 	return formats;
-- 
2.18.0
