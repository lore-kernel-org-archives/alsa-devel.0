From: mengdong.lin@linux.intel.com
Subject: [PATCH 15/22] topology: Parse link flags of physical
	DAI links
Date: Thu, 27 Oct 2016 15:14:05 +0800
Message-ID: <f8085a397a6089a99d71540c7eee3ac79ce84cef.1477549962.git.mengdong.lin@linux.intel.com>
References: <cover.1477549962.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 9D4A72672C7
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2016 09:12:50 +0200 (CEST)
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

Parse physical DAI link flags in both text conf file or C API template.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/topology.h b/include/topology.h
index cf25de5..d7971b7 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -640,6 +640,13 @@ extern "C" {
  *
  *	default_hw_conf_id "1"		#default HW config ID for init
  *
+ *	# Optional flags, the default value is "false".
+ *	symmetric_rates			"true or false"
+ *	symmetric_channels		"true or false"
+ *	symmetric_sample_bits		"true or false"
+ *	ignore_suspend			"true or false"
+ *	ignore_powerdown_time		"true or false"
+ *
  *	data "name"			# optional private data
  * }
  * </pre>
@@ -959,6 +966,10 @@ struct snd_tplg_link_template {
 	struct snd_tplg_hw_config_template *hw_config; /*!< supported HW configs */
 	int num_hw_configs;		/* number of hw configs */
 	int default_hw_config_id;       /* default hw config ID for init */
+
+	unsigned int flag_mask;         /* bitmask of flags to configure */
+	unsigned int flags;             /* SND_SOC_TPLG_LNK_FLGBIT_* flag value */
+	struct snd_soc_tplg_private *priv; /*!< private data */
 };
 
 /** \struct snd_tplg_obj_template
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 9e5bb8e..daeb32e 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -682,6 +682,53 @@ int tplg_parse_link(snd_tplg_t *tplg,
 			continue;
 		}
 
+		/* flags */
+		if (strcmp(id, "symmetric_rates") == 0) {
+			err = parse_flag(n,
+				SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_RATES,
+				&link->flag_mask, &link->flags);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "symmetric_channels") == 0) {
+			err = parse_flag(n,
+				SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_CHANNELS,
+				&link->flag_mask, &link->flags);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "symmetric_sample_bits") == 0) {
+			err = parse_flag(n,
+				SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_SAMPLEBITS,
+				&link->flag_mask, &link->flags);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "ignore_suspend") == 0) {
+			err = parse_flag(n,
+				SND_SOC_TPLG_LNK_FLGBIT_IGNORE_SUSPEND,
+				&link->flag_mask, &link->flags);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "ignore_powerdown_time") == 0) {
+			err = parse_flag(n,
+				SND_SOC_TPLG_LNK_FLGBIT_IGNORE_POWERDOWN_TIME,
+				&link->flag_mask, &link->flags);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		/* private data */
 		if (strcmp(id, "data") == 0) {
 			err = tplg_parse_data_refs(n, elem);
 			if (err < 0)
@@ -1028,5 +1075,9 @@ int tplg_add_link_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
 	link->default_hw_config_id = link_tpl->default_hw_config_id;
 	for (i = 0; i < link->num_hw_configs; i++)
 		set_link_hw_config(&link->hw_config[i], &link_tpl->hw_config[i]);
+
+	/* flags */
+	link->flag_mask = link_tpl->flag_mask;
+	link->flags = link_tpl->flags;
 	return 0;
 }
-- 
2.5.0
