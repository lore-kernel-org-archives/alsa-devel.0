From: guneshwor.o.singh@intel.com
Subject: [PATCH 3/3] topology: Add parsing for rates from conf
Date: Wed, 31 May 2017 19:16:46 +0530
Message-ID: <20170531134646.9081-3-guneshwor.o.singh@intel.com>
References: <20170531134646.9081-1-guneshwor.o.singh@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id DF1B3266BED
 for <alsa-devel@alsa-project.org>; Wed, 31 May 2017 15:46:52 +0200 (CEST)
In-Reply-To: <20170531134646.9081-1-guneshwor.o.singh@intel.com>
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
Cc: vinod.koul@intel.com, mengdong.lin@intel.com, Guneshwor Singh <guneshwor.o.singh@intel.com>, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Guneshwor Singh <guneshwor.o.singh@intel.com>

rate_min and rate_max are parsed currently, some drivers
may also use rates to specify PCM stream capability. So
add support to parse it.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
---
 include/topology.h |  1 +
 src/topology/pcm.c | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

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
index daef20e4..52165243 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -309,6 +309,29 @@ static int split_format(struct snd_soc_tplg_stream_caps *caps, char *str)
 	return 0;
 }
 
+static int split_rate(struct snd_soc_tplg_stream_caps *caps, char *str)
+{
+	char *s = NULL;
+	snd_pcm_rates_t rate;
+	int i = 0;
+
+	s = strtok(str, ",");
+	while ((s) && (i < SND_SOC_TPLG_MAX_RATES)) {
+		rate = snd_pcm_rate_value(s);
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
@@ -360,6 +383,21 @@ int tplg_parse_stream_caps(snd_tplg_t *tplg,
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
-- 
2.13.0
