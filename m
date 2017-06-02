From: guneshwor.o.singh@intel.com
Subject: [PATCH v2] topology: Add parsing for rates from conf
Date: Fri,  2 Jun 2017 08:45:58 +0530
Message-ID: <20170602031558.25893-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id B193D267094
 for <alsa-devel@alsa-project.org>; Fri,  2 Jun 2017 05:16:05 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, tiwai@suse.com
Cc: vinod.koul@intel.com, mengdong.lin@intel.com, Guneshwor Singh <guneshwor.o.singh@intel.com>, liam.r.girdwood@intel.com, patches.audio@intel.com
List-Id: alsa-devel@alsa-project.org

From: Guneshwor Singh <guneshwor.o.singh@intel.com>

rate_min and rate_max are parsed currently, some drivers
may also use rates to specify PCM stream capability. So
add support to parse it.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 include/topology.h        |  1 +
 src/topology/pcm.c        | 71 +++++++++++++++++++++++++++++++++++++++++++++++
 src/topology/tplg_local.h | 20 +++++++++++++
 3 files changed, 92 insertions(+)

diff --git a/include/topology.h b/include/topology.h
index ccb3a004..42d23762 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -534,6 +534,7 @@ extern "C" {
  * SectionPCMCapabilities."name" {
  *
  *	formats "S24_LE,S16_LE"		# Supported formats
+ *	rates "48000"			# Supported rates
  *	rate_min "48000"		# Max supported sample rate
  *	rate_max "48000"		# Min supported sample rate
  *	channels_min "2"		# Min number of channels
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index daef20e4..9a27a13a 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -20,6 +20,26 @@
 #include "list.h"
 #include "tplg_local.h"
 
+#define RATE(v) [SND_PCM_RATE_##v] = #v
+
+static const char *const snd_pcm_rate_names[] = {
+	RATE(5512),
+	RATE(8000),
+	RATE(11025),
+	RATE(16000),
+	RATE(22050),
+	RATE(32000),
+	RATE(44100),
+	RATE(48000),
+	RATE(64000),
+	RATE(88200),
+	RATE(96000),
+	RATE(176400),
+	RATE(192000),
+	RATE(CONTINUOUS),
+	RATE(KNOT),
+};
+
 struct tplg_elem *lookup_pcm_dai_stream(struct list_head *base, const char* id)
 {
 	struct list_head *pos;
@@ -309,6 +329,42 @@ static int split_format(struct snd_soc_tplg_stream_caps *caps, char *str)
 	return 0;
 }
 
+static int get_rate_value(const char* name)
+{
+	int rate;
+	for (rate = 0; rate <= SND_PCM_RATE_LAST; rate++) {
+		if (snd_pcm_rate_names[rate] &&
+		    strcasecmp(name, snd_pcm_rate_names[rate]) == 0) {
+			return rate;
+		}
+	}
+
+	return SND_PCM_RATE_UNKNOWN;
+}
+
+static int split_rate(struct snd_soc_tplg_stream_caps *caps, char *str)
+{
+	char *s = NULL;
+	snd_pcm_rates_t rate;
+	int i = 0;
+
+	s = strtok(str, ",");
+	while (s) {
+		rate = get_rate_value(s);
+
+		if (rate == SND_PCM_RATE_UNKNOWN) {
+			SNDERR("error: unsupported stream rate %s\n", s);
+			return -EINVAL;
+		}
+
+		caps->rates |= 1 << rate;
+		s = strtok(NULL, ", ");
+		i++;
+	}
+
+	return 0;
+}
+
 /* Parse pcm stream capabilities */
 int tplg_parse_stream_caps(snd_tplg_t *tplg,
 	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED)
@@ -360,6 +416,21 @@ int tplg_parse_stream_caps(snd_tplg_t *tplg,
 			continue;
 		}
 
+		if (strcmp(id, "rates") == 0) {
+			s = strdup(val);
+			if (!s)
+				return -ENOMEM;
+
+			err = split_rate(sc, s);
+			free(s);
+
+			if (err < 0)
+				return err;
+
+			tplg_dbg("\t\t%s: %s\n", id, val);
+			continue;
+		}
+
 		if (strcmp(id, "rate_min") == 0) {
 			sc->rate_min = atoi(val);
 			tplg_dbg("\t\t%s: %d\n", id, sc->rate_min);
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index 42e3201d..127842f4 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -38,6 +38,26 @@
 struct tplg_ref;
 struct tplg_elem;
 
+typedef enum _snd_pcm_rates {
+	SND_PCM_RATE_UNKNOWN = -1,
+	SND_PCM_RATE_5512 = 0,
+	SND_PCM_RATE_8000,
+	SND_PCM_RATE_11025,
+	SND_PCM_RATE_16000,
+	SND_PCM_RATE_22050,
+	SND_PCM_RATE_32000,
+	SND_PCM_RATE_44100,
+	SND_PCM_RATE_48000,
+	SND_PCM_RATE_64000,
+	SND_PCM_RATE_88200,
+	SND_PCM_RATE_96000,
+	SND_PCM_RATE_176400,
+	SND_PCM_RATE_192000,
+	SND_PCM_RATE_CONTINUOUS = 30,
+	SND_PCM_RATE_KNOT = 31,
+	SND_PCM_RATE_LAST = SND_PCM_RATE_KNOT,
+} snd_pcm_rates_t;
+
 struct snd_tplg {
 
 	/* opaque vendor data */
-- 
2.13.0
