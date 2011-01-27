From: Adrian Knoth <adi@drcomp.erfurt.thur.de>
Subject: [PATCH - hdspm 1/1] ALSA: [hdspm] Move static mapping
	arrays to .c
Date: Thu, 27 Jan 2011 11:23:15 +0100
Message-ID: <1296123795-7634-1-git-send-email-adi@drcomp.erfurt.thur.de>
References: <alpine.LNX.2.00.1101270905430.6272@eeebox2.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <alpine.LNX.2.00.1101270905430.6272@eeebox2.perex-int.cz>
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
Cc: tiwai@suse.de, Adrian Knoth <adi@drcomp.erfurt.thur.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

As requested by Takashi and Jaroslav, these arrays should not be in the
header file.

Signed-off-by: Adrian Knoth <adi@drcomp.erfurt.thur.de>

diff --git a/include/sound/hdspm.h b/include/sound/hdspm.h
index c3f1819..1774ff5 100644
--- a/include/sound/hdspm.h
+++ b/include/sound/hdspm.h
@@ -225,175 +225,5 @@ typedef struct hdspm_version hdspm_version_t;
 typedef struct hdspm_channelfader snd_hdspm_channelfader_t;
 typedef struct hdspm_mixer hdspm_mixer_t;
 
-/* These tables map the ALSA channels 1..N to the channels that we
-   need to use in order to find the relevant channel buffer. RME
-   refers to this kind of mapping as between "the ADAT channel and
-   the DMA channel." We index it using the logical audio channel,
-   and the value is the DMA channel (i.e. channel buffer number)
-   where the data for that channel can be read/written from/to.
-*/
-
-char channel_map_unity_ss[HDSPM_MAX_CHANNELS] = {
-	0, 1, 2, 3, 4, 5, 6, 7,
-	8, 9, 10, 11, 12, 13, 14, 15,
-	16, 17, 18, 19, 20, 21, 22, 23,
-	24, 25, 26, 27, 28, 29, 30, 31,
-	32, 33, 34, 35, 36, 37, 38, 39,
-	40, 41, 42, 43, 44, 45, 46, 47,
-	48, 49, 50, 51, 52, 53, 54, 55,
-	56, 57, 58, 59, 60, 61, 62, 63
-};
-
-char channel_map_unity_ds[HDSPM_MAX_CHANNELS] = {
-	0, 2, 4, 6, 8, 10, 12, 14,
-	16, 18, 20, 22, 24, 26, 28, 30,
-	32, 34, 36, 38, 40, 42, 44, 46,
-	48, 50, 52, 54, 56, 58, 60, 62,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-};
-
-char channel_map_unity_qs[HDSPM_MAX_CHANNELS] = {
-	0, 4, 8, 12, 16, 20, 24, 28,
-	32, 36, 40, 44, 48, 52, 56, 60,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-};
-
-char channel_map_raydat_ss[HDSPM_MAX_CHANNELS] = {
-	4, 5, 6, 7, 8, 9, 10, 11,	/* ADAT 1 */
-	12, 13, 14, 15, 16, 17, 18, 19,	/* ADAT 2 */
-	20, 21, 22, 23, 24, 25, 26, 27,	/* ADAT 3 */
-	28, 29, 30, 31, 32, 33, 34, 35,	/* ADAT 4 */
-	0, 1,			/* AES */
-	2, 3,			/* SPDIF */
-	-1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-};
-
-char channel_map_raydat_ds[HDSPM_MAX_CHANNELS] = {
-	4, 5, 6, 7,		/* ADAT 1 */
-	8, 9, 10, 11,		/* ADAT 2 */
-	12, 13, 14, 15,		/* ADAT 3 */
-	16, 17, 18, 19,		/* ADAT 4 */
-	0, 1,			/* AES */
-	2, 3,			/* SPDIF */
-	-1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-};
-
-char channel_map_raydat_qs[HDSPM_MAX_CHANNELS] = {
-	4, 5,			/* ADAT 1 */
-	6, 7,			/* ADAT 2 */
-	8, 9,			/* ADAT 3 */
-	10, 11,			/* ADAT 4 */
-	0, 1,			/* AES */
-	2, 3,			/* SPDIF */
-	-1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-};
-
-char channel_map_aio_in_ss[HDSPM_MAX_CHANNELS] = {
-	0, 1,			/* line in */
-	8, 9,			/* aes in, */
-	10, 11,			/* spdif in */
-	12, 13, 14, 15, 16, 17, 18, 19,	/* ADAT in */
-	-1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-};
-
-char channel_map_aio_out_ss[HDSPM_MAX_CHANNELS] = {
-	0, 1,			/* line out */
-	8, 9,			/* aes out */
-	10, 11,			/* spdif out */
-	12, 13, 14, 15, 16, 17, 18, 19,	/* ADAT out */
-	6, 7,			/* phone out */
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-};
-
-char channel_map_aio_in_ds[HDSPM_MAX_CHANNELS] = {
-	0, 1,			/* line in */
-	8, 9,			/* aes in */
-	10, 11,			/* spdif in */
-	12, 14, 16, 18,		/* adat in */
-	-1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1
-};
-
-char channel_map_aio_out_ds[HDSPM_MAX_CHANNELS] = {
-	0, 1,			/* line out */
-	8, 9,			/* aes out */
-	10, 11,			/* spdif out */
-	12, 14, 16, 18,		/* adat out */
-	6, 7,			/* phone out */
-	-1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1
-};
-
-char channel_map_aio_in_qs[HDSPM_MAX_CHANNELS] = {
-	0, 1,			/* line in */
-	8, 9,			/* aes in */
-	10, 11,			/* spdif in */
-	12, 16,			/* adat in */
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1
-};
-
-char channel_map_aio_out_qs[HDSPM_MAX_CHANNELS] = {
-	0, 1,			/* line out */
-	8, 9,			/* aes out */
-	10, 11,			/* spdif out */
-	12, 16,			/* adat out */
-	6, 7,			/* phone out */
-	-1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1,
-	-1, -1, -1, -1, -1, -1, -1, -1
-};
 
 #endif
diff --git a/sound/pci/rme9652/hdspm.c b/sound/pci/rme9652/hdspm.c
index 2db871d..28a1eb3 100644
--- a/sound/pci/rme9652/hdspm.c
+++ b/sound/pci/rme9652/hdspm.c
@@ -673,6 +673,177 @@ static char *texts_ports_aio_out_qs[] = {
 	"Phone.L", "Phone.R"
 };
 
+/* These tables map the ALSA channels 1..N to the channels that we
+   need to use in order to find the relevant channel buffer. RME
+   refers to this kind of mapping as between "the ADAT channel and
+   the DMA channel." We index it using the logical audio channel,
+   and the value is the DMA channel (i.e. channel buffer number)
+   where the data for that channel can be read/written from/to.
+*/
+
+static char channel_map_unity_ss[HDSPM_MAX_CHANNELS] = {
+	0, 1, 2, 3, 4, 5, 6, 7,
+	8, 9, 10, 11, 12, 13, 14, 15,
+	16, 17, 18, 19, 20, 21, 22, 23,
+	24, 25, 26, 27, 28, 29, 30, 31,
+	32, 33, 34, 35, 36, 37, 38, 39,
+	40, 41, 42, 43, 44, 45, 46, 47,
+	48, 49, 50, 51, 52, 53, 54, 55,
+	56, 57, 58, 59, 60, 61, 62, 63
+};
+
+static char channel_map_unity_ds[HDSPM_MAX_CHANNELS] = {
+	0, 2, 4, 6, 8, 10, 12, 14,
+	16, 18, 20, 22, 24, 26, 28, 30,
+	32, 34, 36, 38, 40, 42, 44, 46,
+	48, 50, 52, 54, 56, 58, 60, 62,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+};
+
+static char channel_map_unity_qs[HDSPM_MAX_CHANNELS] = {
+	0, 4, 8, 12, 16, 20, 24, 28,
+	32, 36, 40, 44, 48, 52, 56, 60,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+};
+
+static char channel_map_raydat_ss[HDSPM_MAX_CHANNELS] = {
+	4, 5, 6, 7, 8, 9, 10, 11,	/* ADAT 1 */
+	12, 13, 14, 15, 16, 17, 18, 19,	/* ADAT 2 */
+	20, 21, 22, 23, 24, 25, 26, 27,	/* ADAT 3 */
+	28, 29, 30, 31, 32, 33, 34, 35,	/* ADAT 4 */
+	0, 1,			/* AES */
+	2, 3,			/* SPDIF */
+	-1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+};
+
+static char channel_map_raydat_ds[HDSPM_MAX_CHANNELS] = {
+	4, 5, 6, 7,		/* ADAT 1 */
+	8, 9, 10, 11,		/* ADAT 2 */
+	12, 13, 14, 15,		/* ADAT 3 */
+	16, 17, 18, 19,		/* ADAT 4 */
+	0, 1,			/* AES */
+	2, 3,			/* SPDIF */
+	-1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+};
+
+static char channel_map_raydat_qs[HDSPM_MAX_CHANNELS] = {
+	4, 5,			/* ADAT 1 */
+	6, 7,			/* ADAT 2 */
+	8, 9,			/* ADAT 3 */
+	10, 11,			/* ADAT 4 */
+	0, 1,			/* AES */
+	2, 3,			/* SPDIF */
+	-1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+};
+
+static char channel_map_aio_in_ss[HDSPM_MAX_CHANNELS] = {
+	0, 1,			/* line in */
+	8, 9,			/* aes in, */
+	10, 11,			/* spdif in */
+	12, 13, 14, 15, 16, 17, 18, 19,	/* ADAT in */
+	-1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+};
+
+static char channel_map_aio_out_ss[HDSPM_MAX_CHANNELS] = {
+	0, 1,			/* line out */
+	8, 9,			/* aes out */
+	10, 11,			/* spdif out */
+	12, 13, 14, 15, 16, 17, 18, 19,	/* ADAT out */
+	6, 7,			/* phone out */
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+};
+
+static char channel_map_aio_in_ds[HDSPM_MAX_CHANNELS] = {
+	0, 1,			/* line in */
+	8, 9,			/* aes in */
+	10, 11,			/* spdif in */
+	12, 14, 16, 18,		/* adat in */
+	-1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1
+};
+
+static char channel_map_aio_out_ds[HDSPM_MAX_CHANNELS] = {
+	0, 1,			/* line out */
+	8, 9,			/* aes out */
+	10, 11,			/* spdif out */
+	12, 14, 16, 18,		/* adat out */
+	6, 7,			/* phone out */
+	-1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1
+};
+
+static char channel_map_aio_in_qs[HDSPM_MAX_CHANNELS] = {
+	0, 1,			/* line in */
+	8, 9,			/* aes in */
+	10, 11,			/* spdif in */
+	12, 16,			/* adat in */
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1
+};
+
+static char channel_map_aio_out_qs[HDSPM_MAX_CHANNELS] = {
+	0, 1,			/* line out */
+	8, 9,			/* aes out */
+	10, 11,			/* spdif out */
+	12, 16,			/* adat out */
+	6, 7,			/* phone out */
+	-1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1,
+	-1, -1, -1, -1, -1, -1, -1, -1
+};
+
 struct hdspm_midi {
 	struct hdspm *hdspm;
 	int id;
-- 
1.7.2.3
