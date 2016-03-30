From: mengdong.lin@linux.intel.com
Subject: [PATCH v2 5/7] topology: Add support for vendor tokens
Date: Wed, 30 Mar 2016 15:11:08 +0800
Message-ID: <328bb6886e03ea3a34ec3afd2cb06c6e13f5fbbe.1459321387.git.mengdong.lin@linux.intel.com>
References: <cover.1459321387.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 6B4A62605D4
 for <alsa-devel@alsa-project.org>; Wed, 30 Mar 2016 09:09:14 +0200 (CEST)
In-Reply-To: <cover.1459321387.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, vinod.koul@intel.com, rakesh.a.ughreja@intel.com, liam.r.girdwood@intel.com, hardik.t.shah@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Vendor can define a token list in SectionVendorTokens. Each token element
is a pair of string ID and integer value. And both the ID and value are
vendor-specific.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/topology.h b/include/topology.h
index 51d282f..0df112c 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -578,6 +578,7 @@ enum snd_tplg_type {
 	SND_TPLG_TYPE_BE,		/*!< BE DAI link */
 	SND_TPLG_TYPE_CC,		/*!< Hostless codec <-> codec link */
 	SND_TPLG_TYPE_MANIFEST,		/*!< Topology manifest */
+	SND_TPLG_TYPE_TOKEN,		/*!< Vendor tokens */
 };
 
 /**
diff --git a/src/topology/data.c b/src/topology/data.c
index 370c0fa..8455c15 100644
--- a/src/topology/data.c
+++ b/src/topology/data.c
@@ -253,6 +253,56 @@ static int tplg_parse_data_hex(snd_config_t *cfg, struct tplg_elem *elem,
 	return ret;
 }
 
+/* Parse vendor tokens
+ */
+int tplg_parse_tokens(snd_tplg_t *tplg, snd_config_t *cfg,
+	void *private ATTRIBUTE_UNUSED)
+{
+	snd_config_iterator_t i, next;
+	snd_config_t *n;
+	const char *id, *value;
+	struct tplg_elem *elem;
+	struct tplg_vendor_tokens *tokens;
+	int num_tokens = 0;
+
+	elem = tplg_elem_new_common(tplg, cfg, NULL, SND_TPLG_TYPE_TOKEN);
+	if (!elem)
+		return -ENOMEM;
+
+	snd_config_for_each(i, next, cfg) {
+		num_tokens++;
+	}
+
+	if (!num_tokens)
+		return 0;
+
+	tplg_dbg(" Vendor tokens: %s, %d tokens\n", elem->id, num_tokens);
+
+	tokens = calloc(1, sizeof(*tokens)
+			+ num_tokens * sizeof(struct tplg_token));
+	if (!tokens)
+		return -ENOMEM;
+	elem->tokens = tokens;
+
+	snd_config_for_each(i, next, cfg) {
+
+		n = snd_config_iterator_entry(i);
+		if (snd_config_get_id(n, &id) < 0)
+			continue;
+
+		if (snd_config_get_string(n, &value) < 0)
+			continue;
+
+		elem_copy_text(tokens->token[tokens->num_tokens].id, id,
+				SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+		tokens->token[tokens->num_tokens].value = atoi(value);
+		tplg_dbg("\t\t %s : %d\n", tokens->token[tokens->num_tokens].id,
+			tokens->token[tokens->num_tokens].value);
+		tokens->num_tokens++;
+	}
+
+	return 0;
+}
 
 /* Parse Private data.
  *
diff --git a/src/topology/elem.c b/src/topology/elem.c
index f2afaaf..95e3fd4 100644
--- a/src/topology/elem.c
+++ b/src/topology/elem.c
@@ -193,6 +193,9 @@ struct tplg_elem* tplg_elem_new_common(snd_tplg_t *tplg,
 		list_add_tail(&elem->list, &tplg->cc_list);
 		obj_size = sizeof(struct snd_soc_tplg_link_config);
 		break;
+	case SND_TPLG_TYPE_TOKEN:
+		list_add_tail(&elem->list, &tplg->token_list);
+		break;
 	default:
 		free(elem);
 		return NULL;
diff --git a/src/topology/parser.c b/src/topology/parser.c
index 4546257..264abc8 100644
--- a/src/topology/parser.c
+++ b/src/topology/parser.c
@@ -173,6 +173,14 @@ static int tplg_parse_config(snd_tplg_t *tplg, snd_config_t *cfg)
 			continue;
 		}
 
+		if (strcmp(id, "SectionVendorTokens") == 0) {
+			err = tplg_parse_compound(tplg, n, tplg_parse_tokens,
+				NULL);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
 		SNDERR("error: unknown section %s\n", id);
 	}
 	return 0;
@@ -407,6 +415,7 @@ snd_tplg_t *snd_tplg_new(void)
 	INIT_LIST_HEAD(&tplg->mixer_list);
 	INIT_LIST_HEAD(&tplg->enum_list);
 	INIT_LIST_HEAD(&tplg->bytes_ext_list);
+	INIT_LIST_HEAD(&tplg->token_list);
 
 	return tplg;
 }
@@ -426,6 +435,7 @@ void snd_tplg_free(snd_tplg_t *tplg)
 	tplg_elem_free_list(&tplg->mixer_list);
 	tplg_elem_free_list(&tplg->enum_list);
 	tplg_elem_free_list(&tplg->bytes_ext_list);
+	tplg_elem_free_list(&tplg->token_list);
 
 	free(tplg);
 }
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index 7368a86..679bfff 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -69,6 +69,7 @@ struct snd_tplg {
 	struct list_head route_list;
 	struct list_head text_list;
 	struct list_head pdata_list;
+	struct list_head token_list;
 	struct list_head pcm_config_list;
 	struct list_head pcm_caps_list;
 
@@ -86,6 +87,16 @@ struct tplg_ref {
 	struct list_head list;
 };
 
+/* element for vendor tokens */
+struct tplg_token {
+	char id[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+	unsigned int value;
+};
+
+struct tplg_vendor_tokens {
+	unsigned int num_tokens;
+	struct tplg_token token[0];
+};
 /* topology element */
 struct tplg_elem {
 
@@ -118,6 +129,7 @@ struct tplg_elem {
 		/* these do not map to UAPI structs but are internal only */
 		struct snd_soc_tplg_ctl_tlv *tlv;
 		struct snd_soc_tplg_private *data;
+		struct tplg_vendor_tokens *tokens;
 	};
 
 	/* an element may refer to other elements:
@@ -151,6 +163,9 @@ int tplg_parse_text(snd_tplg_t *tplg, snd_config_t *cfg,
 int tplg_parse_data(snd_tplg_t *tplg, snd_config_t *cfg,
 	void *private ATTRIBUTE_UNUSED);
 
+int tplg_parse_tokens(snd_tplg_t *tplg, snd_config_t *cfg,
+	void *private ATTRIBUTE_UNUSED);
+
 int tplg_parse_control_bytes(snd_tplg_t *tplg,
 	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
 
-- 
2.5.0
