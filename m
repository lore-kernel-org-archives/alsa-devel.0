From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 5/6] topology: Parse front-end DAI name and
	ID for the PCM
Date: Fri, 29 Apr 2016 11:03:37 +0800
Message-ID: <8258fa6bb9d5009dc9f2bb73194defc7251907cd.1461898635.git.mengdong.lin@linux.intel.com>
References: <cover.1461898635.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id B9A932666E8
 for <alsa-devel@alsa-project.org>; Fri, 29 Apr 2016 05:00:39 +0200 (CEST)
In-Reply-To: <cover.1461898635.git.mengdong.lin@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@intel.com, hardik.t.shah@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

These two fields are necessary to create the front-end DAIs
in kernel but the support is missing in text conf previously.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/topology.h b/include/topology.h
index b47f422..9d57ce3 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -533,6 +533,10 @@ extern "C" {
  *
  *	id "0"				# used for binding to the PCM
  *
+ *	dai."name of front-end DAI" {
+ *		id "0"		# used for binding to the front-end DAI
+ *	}
+ *
  *	pcm."playback" {
  *		capabilities "capabilities1"	# capabilities for playback
  *
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 1661821..efee58b 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -320,6 +320,51 @@ static int tplg_parse_streams(snd_tplg_t *tplg, snd_config_t *cfg,
 	return 0;
 }
 
+/* Parse name and id of a front-end DAI (ie. cpu dai of a FE DAI link) */
+static int tplg_parse_fe_dai(snd_tplg_t *tplg, snd_config_t *cfg,
+	void *private)
+{
+	struct tplg_elem *elem = private;
+	struct snd_soc_tplg_pcm *pcm = elem->pcm;
+	snd_config_iterator_t i, next;
+	snd_config_t *n;
+	const char *id, *value = NULL;
+	unsigned long int id_val;
+	int err;
+
+	snd_config_get_id(cfg, &id);
+	tplg_dbg("\t\tFE DAI %s:\n", id);
+	elem_copy_text(pcm->dai_name, id, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+
+	snd_config_for_each(i, next, cfg) {
+
+		n = snd_config_iterator_entry(i);
+
+		/* get id */
+		if (snd_config_get_id(n, &id) < 0)
+			continue;
+
+		if (strcmp(id, "id") == 0) {
+			if (snd_config_get_string(n, &value) < 0)
+				continue;
+			errno = 0;
+			/* no support for negative value */
+			id_val = strtoul(value, NULL, 0);
+			if ((errno == ERANGE && id_val == ULONG_MAX)
+				|| (errno != 0 && id_val == 0)
+				|| id_val > UINT_MAX) {
+				SNDERR("error: invalid fe dai ID\n");
+				return -EINVAL;
+			}
+
+			pcm->dai_id = (int) id_val;
+			tplg_dbg("\t\t\tindex: %d\n", pcm->dai_id);
+		}
+	}
+
+	return 0;
+}
+
 /* Parse pcm (for front end DAI & DAI link) */
 int tplg_parse_pcm(snd_tplg_t *tplg,
 	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED)
@@ -378,6 +423,14 @@ int tplg_parse_pcm(snd_tplg_t *tplg,
 				return err;
 			continue;
 		}
+
+		if (strcmp(id, "dai") == 0) {
+			err = tplg_parse_compound(tplg, n,
+				tplg_parse_fe_dai, elem);
+			if (err < 0)
+				return err;
+			continue;
+		}
 	}
 
 	return 0;
-- 
2.5.0
