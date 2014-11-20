From: eliot@blennerhassett.gen.nz
Subject: [PATCH 02/10] ALSA: asihpi: New I/O types - AVB &
 BLUlink, DAB Rf receiver
Date: Thu, 20 Nov 2014 16:22:49 +1300
Message-ID: <1416453777-7155-3-git-send-email-eliot@blennerhassett.gen.nz>
References: <1416453777-7155-1-git-send-email-eliot@blennerhassett.gen.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp3.clear.net.nz (smtp3.clear.net.nz [203.97.33.64])
 by alsa0.perex.cz (Postfix) with ESMTP id EC572265866
 for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2014 04:25:41 +0100 (CET)
Received: from mxin1-orange.clear.net.nz
 (lb2-srcnat.clear.net.nz [203.97.32.237])
 by smtp3.clear.net.nz (CLEAR Net Mail)
 with ESMTP id <0NFB007V7IU4ZE20@smtp3.clear.net.nz> for
 alsa-devel@alsa-project.org; Thu, 20 Nov 2014 16:25:37 +1300 (NZDT)
In-reply-to: <1416453777-7155-1-git-send-email-eliot@blennerhassett.gen.nz>
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
Cc: tiwai@suse.de, Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
List-Id: alsa-devel@alsa-project.org

From: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>

Audio cards wth have AVB or BLU Link IO.
Tuner card with DAB receiver

Signed-off-by: Eliot Blennerhassett <eliot@blennerhassett.gen.nz>
---
 sound/pci/asihpi/asihpi.c | 25 ++++++++++++++++++-------
 sound/pci/asihpi/hpi.h    | 16 ++++++++++++----
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/sound/pci/asihpi/asihpi.c b/sound/pci/asihpi/asihpi.c
index 023d816..dc49bea 100644
--- a/sound/pci/asihpi/asihpi.c
+++ b/sound/pci/asihpi/asihpi.c
@@ -109,7 +109,7 @@ static int adapter_fs = DEFAULT_SAMPLERATE;
 struct clk_source {
 	int source;
 	int index;
-	char *name;
+	const char *name;
 };
 
 struct clk_cache {
@@ -1295,8 +1295,9 @@ static const char * const asihpi_tuner_band_names[] = {
 	"TV PAL I",
 	"TV PAL DK",
 	"TV SECAM",
+	"TV DAB",
 };
-
+/* Number of strings must match the enumerations for HPI_TUNER_BAND in hpi.h */
 compile_time_assert(
 	(ARRAY_SIZE(asihpi_tuner_band_names) ==
 		(HPI_TUNER_BAND_LAST+1)),
@@ -1316,9 +1317,11 @@ static const char * const asihpi_src_names[] = {
 	"Analog",
 	"Adapter",
 	"RTP",
-	"Internal"
+	"Internal",
+	"AVB",
+	"BLU-Link"
 };
-
+/* Number of strings must match the enumerations for HPI_SOURCENODES in hpi.h */
 compile_time_assert(
 	(ARRAY_SIZE(asihpi_src_names) ==
 		(HPI_SOURCENODE_LAST_INDEX-HPI_SOURCENODE_NONE+1)),
@@ -1334,8 +1337,11 @@ static const char * const asihpi_dst_names[] = {
 	"Net",
 	"Analog",
 	"RTP",
+	"AVB",
+	"Internal",
+	"BLU-Link"
 };
-
+/* Number of strings must match the enumerations for HPI_DESTNODES in hpi.h */
 compile_time_assert(
 	(ARRAY_SIZE(asihpi_dst_names) ==
 		(HPI_DESTNODE_LAST_INDEX-HPI_DESTNODE_NONE+1)),
@@ -2291,13 +2297,18 @@ static int snd_asihpi_cmode_add(struct snd_card_asihpi *asihpi,
 /*------------------------------------------------------------
    Sampleclock source  controls
  ------------------------------------------------------------*/
-static char *sampleclock_sources[MAX_CLOCKSOURCES] = {
+static const char const *sampleclock_sources[] = {
 	"N/A", "Local PLL", "Digital Sync", "Word External", "Word Header",
 	"SMPTE", "Digital1", "Auto", "Network", "Invalid",
-	"Prev Module",
+	"Prev Module", "BLU-Link",
 	"Digital2", "Digital3", "Digital4", "Digital5",
 	"Digital6", "Digital7", "Digital8"};
 
+	/* Number of strings must match expected enumerated values */
+	compile_time_assert(
+		(ARRAY_SIZE(sampleclock_sources) == MAX_CLOCKSOURCES),
+		assert_sampleclock_sources_size);
+
 static int snd_asihpi_clksrc_info(struct snd_kcontrol *kcontrol,
 				  struct snd_ctl_elem_info *uinfo)
 {
diff --git a/sound/pci/asihpi/hpi.h b/sound/pci/asihpi/hpi.h
index 2088724..4466bd2 100644
--- a/sound/pci/asihpi/hpi.h
+++ b/sound/pci/asihpi/hpi.h
@@ -196,8 +196,10 @@ enum HPI_SOURCENODES {
 	    packets of RTP audio samples from other devices. */
 	HPI_SOURCENODE_RTP_DESTINATION = 112,
 	HPI_SOURCENODE_INTERNAL = 113,	     /**< node internal to the device. */
+	HPI_SOURCENODE_AVB = 114,	     /**< AVB input stream */
+	HPI_SOURCENODE_BLULINK = 115,	     /**< BLU-link input channel */
 	/* !!!Update this  AND hpidebug.h if you add a new sourcenode type!!! */
-	HPI_SOURCENODE_LAST_INDEX = 113	     /**< largest ID */
+	HPI_SOURCENODE_LAST_INDEX = 115	     /**< largest ID */
 		/* AX6 max sourcenode types = 15 */
 };
 
@@ -224,8 +226,11 @@ enum HPI_DESTNODES {
 	/** RTP stream output node - This node is a source for
 	    packets of RTP audio samples that are sent to other devices. */
 	HPI_DESTNODE_RTP_SOURCE = 208,
+	HPI_DESTNODE_AVB = 209,		     /**< AVB output stream */
+	HPI_DESTNODE_INTERNAL = 210,	     /**< node internal to the device. */
+	HPI_DESTNODE_BLULINK = 211,	     /**< BLU-link output channel. */
 	/* !!!Update this AND hpidebug.h if you add a new destnode type!!! */
-	HPI_DESTNODE_LAST_INDEX = 208	     /**< largest ID */
+	HPI_DESTNODE_LAST_INDEX = 211	     /**< largest ID */
 		/* AX6 max destnode types = 15 */
 };
 
@@ -752,7 +757,8 @@ enum HPI_TUNER_BAND {
 	HPI_TUNER_BAND_TV_PAL_I = 7,	 /**< PAL-I TV band*/
 	HPI_TUNER_BAND_TV_PAL_DK = 8,	 /**< PAL-D/K TV band*/
 	HPI_TUNER_BAND_TV_SECAM_L = 9,	 /**< SECAM-L TV band*/
-	HPI_TUNER_BAND_LAST = 9	/**< the index of the last tuner band. */
+	HPI_TUNER_BAND_DAB = 10,
+	HPI_TUNER_BAND_LAST = 10 /**< the index of the last tuner band. */
 };
 
 /** Tuner mode attributes
@@ -842,8 +848,10 @@ enum HPI_SAMPLECLOCK_SOURCES {
 	HPI_SAMPLECLOCK_SOURCE_NETWORK = 8,
 /** From previous adjacent module (ASI2416 only)*/
 	HPI_SAMPLECLOCK_SOURCE_PREV_MODULE = 10,
+/** Blu link sample clock*/
+	HPI_SAMPLECLOCK_SOURCE_BLULINK = 11,
 /*! Update this if you add a new clock source.*/
-	HPI_SAMPLECLOCK_SOURCE_LAST = 10
+	HPI_SAMPLECLOCK_SOURCE_LAST = 11
 };
 
 /** Equalizer filter types. Used by HPI_ParametricEq_SetBand()
-- 
1.9.1
