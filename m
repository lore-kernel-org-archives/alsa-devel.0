From: mengdong.lin@linux.intel.com
Subject: [PATCH 03/22] topology: Parse flags for PCM
Date: Thu, 27 Oct 2016 15:11:36 +0800
Message-ID: <ed04f45a78bbef651af54d71a4b8b8790dabf05b.1477549962.git.mengdong.lin@linux.intel.com>
References: <cover.1477549962.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
 by alsa0.perex.cz (Postfix) with ESMTP id A22DF26688A
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2016 09:10:22 +0200 (CEST)
In-Reply-To: <cover.1477549962.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, vinod.koul@intel.com, broonie@kernel.org, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Users can define flags by both text conf file and C API.
Add flags and flag_mask to C API template of PCM object.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/topology.h b/include/topology.h
index ccd8401..0a07c94 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -606,6 +606,13 @@ extern "C" {
  *			"config3"
  *		]
  *	}
+ *
+ *	# Optional flags, the default value is "false".
+ *	symmetric_rates			"true or false"
+ *	symmetric_channels		"true or false"
+ *	symmetric_sample_bits		"true or false"
+ *	ignore_suspend			"true or false"
+ *	ignore_powerdown_time		"true or false"
  * }
  * </pre>
  *
@@ -863,6 +870,8 @@ struct snd_tplg_pcm_template {
 	unsigned int capture;	/*!< supports capture mode */
 	unsigned int compress;	/*!< 1 = compressed; 0 = PCM */
 	struct snd_tplg_stream_caps_template *caps[2]; /*!< playback & capture for DAI */
+	unsigned int flag_mask; /*!< bitmask of flags to configure */
+	unsigned int flags;     /*!< flag value */
 	int num_streams;	/*!< number of supported configs */
 	struct snd_tplg_stream_template stream[0]; /*!< supported configs */
 };
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 6fdf047..3d9feb0 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -364,6 +364,24 @@ static int tplg_parse_fe_dai(snd_tplg_t *tplg ATTRIBUTE_UNUSED,
 	return 0;
 }
 
+/* parse a flag bit of the given mask */
+static int parse_flag(snd_config_t *n, unsigned int mask_in,
+		      unsigned int *mask, unsigned int *flags)
+{
+	const char *val = NULL;
+
+	if (snd_config_get_string(n, &val) < 0)
+		return -EINVAL;
+
+	*mask |= mask_in;
+	if (strcmp(val, "true") == 0)
+		*flags |= mask_in;
+	else
+		*flags &= ~mask_in;
+
+	return 0;
+}
+
 /* Parse pcm (for front end DAI & DAI link) */
 int tplg_parse_pcm(snd_tplg_t *tplg,
 	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED)
@@ -430,6 +448,53 @@ int tplg_parse_pcm(snd_tplg_t *tplg,
 				return err;
 			continue;
 		}
+
+		/* flags */
+		if (strcmp(id, "symmetric_rates") == 0) {
+			err = parse_flag(n,
+				SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_RATES,
+				&pcm->flag_mask, &pcm->flags);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "symmetric_channels") == 0) {
+			err = parse_flag(n,
+				SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_CHANNELS,
+				&pcm->flag_mask, &pcm->flags);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "symmetric_sample_bits") == 0) {
+			err = parse_flag(n,
+				SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_SAMPLEBITS,
+				&pcm->flag_mask, &pcm->flags);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "ignore_suspend") == 0) {
+			err = parse_flag(n,
+				SND_SOC_TPLG_LNK_FLGBIT_IGNORE_SUSPEND,
+				&pcm->flag_mask, &pcm->flags);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "ignore_powerdown_time") == 0) {
+			err = parse_flag(n,
+				SND_SOC_TPLG_LNK_FLGBIT_IGNORE_POWERDOWN_TIME,
+				&pcm->flag_mask, &pcm->flags);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
 	}
 
 	return 0;
@@ -610,6 +675,9 @@ int tplg_add_pcm_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
 			tplg_add_stream_caps(&pcm->caps[i], pcm_tpl->caps[i]);
 	}
 
+	pcm->flag_mask = pcm_tpl->flag_mask;
+	pcm->flags = pcm_tpl->flags;
+
 	pcm->num_streams = pcm_tpl->num_streams;
 	for (i = 0; i < pcm_tpl->num_streams; i++)
 		tplg_add_stream_object(&pcm->stream[i], &pcm_tpl->stream[i]);
-- 
2.5.0
