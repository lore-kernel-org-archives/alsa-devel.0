From: mengdong.lin@linux.intel.com
Subject: [PATCH 10/13] topology: Parse link flags of physical
	DAI links
Date: Sun,  6 Nov 2016 13:14:15 +0800
Message-ID: <21b71a222fe1c7afb073012dd43fc9169999b4c2.1478407716.git.mengdong.lin@linux.intel.com>
References: <cover.1478407716.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 047792665B0
 for <alsa-devel@alsa-project.org>; Sun,  6 Nov 2016 06:12:45 +0100 (CET)
In-Reply-To: <cover.1478407716.git.mengdong.lin@linux.intel.com>
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

Parse physical DAI link flags defined by text conf file or C API.
The flag mask and flags are added to C API template for physical DAI
links.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/topology.h b/include/topology.h
index 85818ac..3692da4 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -639,6 +639,11 @@ extern "C" {
  *
  *	default_hw_conf_id "1"		#default HW config ID for init
  *
+ *	# Optional boolean flags
+ *	symmetric_rates			"true"
+ *	symmetric_channels		"false"
+ *	symmetric_sample_bits		"true"
+ *
  *	data "name"			# optional private data
  * }
  * </pre>
@@ -988,6 +993,9 @@ struct snd_tplg_link_template {
 	struct snd_tplg_hw_config_template *hw_config; /*!< supported HW configs */
 	int num_hw_configs;		/* number of hw configs */
 	int default_hw_config_id;       /* default hw config ID for init */
+
+	unsigned int flag_mask;         /* bitmask of flags to configure */
+	unsigned int flags;             /* SND_SOC_TPLG_LNK_FLGBIT_* flag value */
 };
 
 /** \struct snd_tplg_obj_template
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index e92d2b9..a751851 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -664,6 +664,35 @@ int tplg_parse_link(snd_tplg_t *tplg,
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
+		/* private data */
 		if (strcmp(id, "data") == 0) {
 			err = tplg_parse_data_refs(n, elem);
 			if (err < 0)
@@ -1010,5 +1039,9 @@ int tplg_add_link_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t)
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
2.7.4
