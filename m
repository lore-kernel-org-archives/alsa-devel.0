From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v2 03/13] topology: Add topology core parser.
Date: Wed,  1 Jul 2015 14:44:25 +0100
Message-ID: <1435758275-4047-3-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1435758275-4047-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 4F23026065E
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2015 15:45:44 +0200 (CEST)
In-Reply-To: <1435758275-4047-1-git-send-email-liam.r.girdwood@linux.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Vinod Koul <vinod.koul@intel.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

The topology core parses the high level topology file and calls the
individual object parsers when any new object element is detected at
the high level.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 include/topology.h        |  75 ++++++++++
 src/topology/elem.c       | 187 ++++++++++++++++++++++++
 src/topology/parser.c     | 357 ++++++++++++++++++++++++++++++++++++++++++++++
 src/topology/tplg_local.h | 223 +++++++++++++++++++++++++++++
 4 files changed, 842 insertions(+)
 create mode 100644 include/topology.h
 create mode 100644 src/topology/elem.c
 create mode 100644 src/topology/parser.c
 create mode 100644 src/topology/tplg_local.h

diff --git a/include/topology.h b/include/topology.h
new file mode 100644
index 0000000..d9b223f
--- /dev/null
+++ b/include/topology.h
@@ -0,0 +1,75 @@
+/*
+ *
+ *  This library is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU Lesser General Public License as
+ *  published by the Free Software Foundation; either version 2.1 of
+ *  the License, or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307 USA
+ *
+ *  Copyright (C) 2015 Intel Corporation
+ *
+ */
+
+#ifndef __ALSA_TOPOLOGY_H
+#define __ALSA_TOPOLOGY_H
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/**
+ *  \defgroup topology Topology Interface
+ *  The topology interface.
+ *  See \ref Topology page for more details.
+ *  \{
+ */
+
+/*! \page topology ALSA Topology Interface
+ *
+ * ALSA Topology Interface
+ *
+ */
+
+typedef struct snd_tplg snd_tplg_t;
+
+/**
+ * \brief Create a new topology parser instance.
+ * \return New topology parser instance
+ */
+snd_tplg_t *snd_tplg_new(void);
+
+/**
+ * \brief Free a topology parser instance.
+ * \param tplg Topology parser instance
+ */
+void snd_tplg_free(snd_tplg_t *tplg);
+
+/**
+ * \brief Parse and build topology text file into binary file.
+ * \param tplg Topology instance.
+ * \param infile Topology text input file to be parsed
+ * \param outfile Binary topology output file.
+ * \return Zero on sucess, otherwise a negative error code
+ */
+int snd_tplg_build(snd_tplg_t *tplg, const char *infile, const char *outfile);
+
+/**
+ * \brief Enable verbose reporting of binary file output
+ * \param tplg Topology Instance
+ * \param verbose Enable verbose output if non zero
+ */
+void snd_tplg_verbose(snd_tplg_t *tplg, int verbose);
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* __ALSA_TOPOLOGY_H */
diff --git a/src/topology/elem.c b/src/topology/elem.c
new file mode 100644
index 0000000..0ce406b
--- /dev/null
+++ b/src/topology/elem.c
@@ -0,0 +1,187 @@
+/*
+  Copyright(c) 2014-2015 Intel Corporation
+  All rights reserved.
+
+  This program is free software; you can redistribute it and/or modify
+  it under the terms of version 2 of the GNU General Public License as
+  published by the Free Software Foundation.
+
+  This program is distributed in the hope that it will be useful, but
+  WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+  General Public License for more details.
+
+  Authors: Mengdong Lin <mengdong.lin@intel.com>
+           Yao Jin <yao.jin@intel.com>
+           Liam Girdwood <liam.r.girdwood@linux.intel.com>
+*/
+
+#include "list.h"
+#include "tplg_local.h"
+
+int tplg_ref_add(struct tplg_elem *elem, int type, const char* id)
+{
+	struct tplg_ref *ref;
+
+	ref = calloc(1, sizeof(*ref));
+	if (!ref)
+		return -ENOMEM;
+
+	strncpy(ref->id, id, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+	ref->id[SNDRV_CTL_ELEM_ID_NAME_MAXLEN - 1] = 0;
+	ref->type = type;
+
+	list_add_tail(&ref->list, &elem->ref_list);
+	return 0;
+}
+
+void tplg_ref_free_list(struct list_head *base)
+{
+	struct list_head *pos, *npos;
+	struct tplg_ref *ref;
+
+	list_for_each_safe(pos, npos, base) {
+		ref = list_entry(pos, struct tplg_ref, list);
+		list_del(&ref->list);
+		free(ref);
+	}
+}
+
+struct tplg_elem *tplg_elem_new(void)
+{
+	struct tplg_elem *elem;
+
+	elem = calloc(1, sizeof(*elem));
+	if (!elem)
+		return NULL;
+
+	INIT_LIST_HEAD(&elem->ref_list);
+	return elem;
+}
+
+void tplg_elem_free(struct tplg_elem *elem)
+{
+	tplg_ref_free_list(&elem->ref_list);
+
+	/* free struct snd_tplg_ object,
+	 * the union pointers share the same address
+	 */
+	if (elem->mixer_ctrl)
+		free(elem->mixer_ctrl);
+
+	free(elem);
+}
+
+void tplg_elem_free_list(struct list_head *base)
+{
+	struct list_head *pos, *npos;
+	struct tplg_elem *elem;
+
+	list_for_each_safe(pos, npos, base) {
+		elem = list_entry(pos, struct tplg_elem, list);
+		list_del(&elem->list);
+		tplg_elem_free(elem);
+	}
+}
+
+struct tplg_elem *tplg_elem_lookup(struct list_head *base, const char* id,
+	unsigned int type)
+{
+	struct list_head *pos, *npos;
+	struct tplg_elem *elem;
+
+	list_for_each_safe(pos, npos, base) {
+
+		elem = list_entry(pos, struct tplg_elem, list);
+
+		if (!strcmp(elem->id, id) && elem->type == type)
+			return elem;
+	}
+
+	return NULL;
+}
+
+/* create a new common element and object */
+struct tplg_elem* tplg_elem_new_common(snd_tplg_t *tplg,
+	snd_config_t *cfg, enum parser_type type)
+{
+	struct tplg_elem *elem;
+	const char *id;
+	int obj_size = 0;
+	void *obj;
+
+	elem = tplg_elem_new();
+	if (!elem)
+		return NULL;
+
+	snd_config_get_id(cfg, &id);
+	strncpy(elem->id, id, SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+	elem->id[SNDRV_CTL_ELEM_ID_NAME_MAXLEN - 1] = 0;
+
+	switch (type) {
+	case PARSER_TYPE_DATA:
+		list_add_tail(&elem->list, &tplg->pdata_list);
+		break;
+	case PARSER_TYPE_TEXT:
+		list_add_tail(&elem->list, &tplg->text_list);
+		break;
+	case PARSER_TYPE_TLV:
+		list_add_tail(&elem->list, &tplg->tlv_list);
+		elem->size = sizeof(struct snd_soc_tplg_ctl_tlv);
+		break;
+	case PARSER_TYPE_BYTES:
+		list_add_tail(&elem->list, &tplg->bytes_ext_list);
+		obj_size = sizeof(struct snd_soc_tplg_bytes_control);
+		break;
+	case PARSER_TYPE_ENUM:
+		list_add_tail(&elem->list, &tplg->enum_list);
+		obj_size = sizeof(struct snd_soc_tplg_enum_control);
+		break;
+	case SND_SOC_TPLG_TYPE_MIXER:
+		list_add_tail(&elem->list, &tplg->mixer_list);
+		obj_size = sizeof(struct snd_soc_tplg_mixer_control);
+		break;
+	case PARSER_TYPE_DAPM_WIDGET:
+		list_add_tail(&elem->list, &tplg->widget_list);
+		obj_size = sizeof(struct snd_soc_tplg_dapm_widget);
+		break;
+	case PARSER_TYPE_STREAM_CONFIG:
+		list_add_tail(&elem->list, &tplg->pcm_config_list);
+		obj_size = sizeof(struct snd_soc_tplg_stream_config);
+		break;
+	case PARSER_TYPE_STREAM_CAPS:
+		list_add_tail(&elem->list, &tplg->pcm_caps_list);
+		obj_size = sizeof(struct snd_soc_tplg_stream_caps);
+		break;
+	case PARSER_TYPE_PCM:
+		list_add_tail(&elem->list, &tplg->pcm_list);
+		obj_size = sizeof(struct snd_soc_tplg_pcm_dai);
+		break;
+	case PARSER_TYPE_BE:
+		list_add_tail(&elem->list, &tplg->be_list);
+		obj_size = sizeof(struct snd_soc_tplg_pcm_dai);
+		break;
+	case PARSER_TYPE_CC:
+		list_add_tail(&elem->list, &tplg->cc_list);
+		obj_size = sizeof(struct snd_soc_tplg_pcm_dai);
+		break;
+	default:
+		free(elem);
+		return NULL;
+	}
+
+	/* create new object too if required */
+	if (obj_size > 0) {
+		obj = calloc(1, obj_size);
+		if (obj == NULL) {
+			free(elem);
+			return NULL;
+		}
+
+		elem->obj = obj;
+		elem->size = obj_size;
+	}
+
+	elem->type = type;
+	return elem;
+}
diff --git a/src/topology/parser.c b/src/topology/parser.c
new file mode 100644
index 0000000..f813deb
--- /dev/null
+++ b/src/topology/parser.c
@@ -0,0 +1,357 @@
+/*
+  Copyright(c) 2014-2015 Intel Corporation
+  All rights reserved.
+
+  This program is free software; you can redistribute it and/or modify
+  it under the terms of version 2 of the GNU General Public License as
+  published by the Free Software Foundation.
+
+  This program is distributed in the hope that it will be useful, but
+  WITHOUT ANY WARRANTY; without even the implied warranty of
+  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+  General Public License for more details.
+
+  Authors: Mengdong Lin <mengdong.lin@intel.com>
+           Yao Jin <yao.jin@intel.com>
+           Liam Girdwood <liam.r.girdwood@linux.intel.com>
+*/
+
+#include "list.h"
+#include "tplg_local.h"
+
+/*
+ * Parse compound
+ */
+int tplg_parse_compound(snd_tplg_t *tplg, snd_config_t *cfg,
+	int (*fcn)(snd_tplg_t *, snd_config_t *, void *),
+	void *private)
+{
+	const char *id;
+	snd_config_iterator_t i, next;
+	snd_config_t *n;
+	int err = -EINVAL;
+
+	if (snd_config_get_id(cfg, &id) < 0)
+		return -EINVAL;
+
+	if (snd_config_get_type(cfg) != SND_CONFIG_TYPE_COMPOUND) {
+		fprintf(stderr, "error: compound type expected for %s", id);
+		return -EINVAL;
+	}
+
+	/* parse compound */
+	snd_config_for_each(i, next, cfg) {
+		n = snd_config_iterator_entry(i);
+
+		if (snd_config_get_type(cfg) != SND_CONFIG_TYPE_COMPOUND) {
+			fprintf(stderr, "error: compound type expected for %s, is %d",
+				id, snd_config_get_type(cfg));
+			return -EINVAL;
+		}
+
+		err = fcn(tplg, n, private);
+		if (err < 0)
+			return err;
+	}
+
+	return err;
+}
+
+static int tplg_parse_config(snd_tplg_t *tplg, snd_config_t *cfg)
+{
+	snd_config_iterator_t i, next;
+	snd_config_t *n;
+	const char *id;
+	int err;
+
+	if (snd_config_get_type(cfg) != SND_CONFIG_TYPE_COMPOUND) {
+		fprintf(stderr, "error: compound type expected at top level");
+		return -EINVAL;
+	}
+
+	/* parse topology config sections */
+	snd_config_for_each(i, next, cfg) {
+
+		n = snd_config_iterator_entry(i);
+		if (snd_config_get_id(n, &id) < 0)
+			continue;
+
+		if (strcmp(id, "SectionTLV") == 0) {
+			err = tplg_parse_compound(tplg, n, tplg_parse_tlv,
+				NULL);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "SectionControlMixer") == 0) {
+			err = tplg_parse_compound(tplg, n,
+				tplg_parse_control_mixer, NULL);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "SectionControlEnum") == 0) {
+			err = tplg_parse_compound(tplg, n,
+				tplg_parse_control_enum, NULL);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "SectionControlBytes") == 0) {
+			err = tplg_parse_compound(tplg, n,
+				tplg_parse_control_bytes, NULL);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "SectionWidget") == 0) {
+			err = tplg_parse_compound(tplg, n,
+				tplg_parse_dapm_widget, NULL);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "SectionPCMConfig") == 0) {
+			err = tplg_parse_compound(tplg, n,
+				tplg_parse_pcm_config, NULL);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "SectionPCMCapabilities") == 0) {
+			err = tplg_parse_compound(tplg, n,
+				tplg_parse_pcm_caps, NULL);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "SectionPCM") == 0) {
+			err = tplg_parse_compound(tplg, n,
+				tplg_parse_pcm, NULL);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "SectionBE") == 0) {
+			err = tplg_parse_compound(tplg, n, tplg_parse_be,
+				NULL);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "SectionCC") == 0) {
+			err = tplg_parse_compound(tplg, n, tplg_parse_cc,
+				NULL);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "SectionGraph") == 0) {
+			err = tplg_parse_compound(tplg, n,
+				tplg_parse_dapm_graph, NULL);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "SectionText") == 0) {
+			err = tplg_parse_compound(tplg, n, tplg_parse_text,
+				NULL);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		if (strcmp(id, "SectionData") == 0) {
+			err = tplg_parse_compound(tplg, n, tplg_parse_data,
+				NULL);
+			if (err < 0)
+				return err;
+			continue;
+		}
+
+		fprintf(stderr, "error: unknown section %s\n", id);
+	}
+	return 0;
+}
+
+static int tplg_load_config(const char *file, snd_config_t **cfg)
+{
+	FILE *fp;
+	snd_input_t *in;
+	snd_config_t *top;
+	int ret;
+
+	fp = fopen(file, "r");
+	if (fp == NULL) {
+		fprintf(stdout, "error: could not open configuration file %s",
+			file);
+		return -errno;
+	}
+
+	ret = snd_input_stdio_attach(&in, fp, 1);
+	if (ret < 0) {
+		fprintf(stdout, "error: could not attach stdio %s", file);
+		goto err;
+	}
+	ret = snd_config_top(&top);
+	if (ret < 0)
+		goto err;
+
+	ret = snd_config_load(top, in);
+	if (ret < 0) {
+		fprintf(stdout, "error: could not load configuration file %s",
+			file);
+		goto err_load;
+	}
+
+	ret = snd_input_close(in);
+	if (ret < 0)
+		goto err_load;
+
+	*cfg = top;
+	return 0;
+
+err_load:
+	snd_config_delete(top);
+err:
+	fclose(fp);
+	return ret;
+}
+
+static int tplg_build_integ(snd_tplg_t *tplg)
+{
+	int err;
+
+	err = tplg_build_controls(tplg);
+	if (err <  0)
+		return err;
+
+	err = tplg_build_widgets(tplg);
+	if (err <  0)
+		return err;
+
+	err = tplg_build_pcm_dai(tplg, PARSER_TYPE_PCM);
+	if (err <  0)
+		return err;
+
+	err = tplg_build_pcm_dai(tplg, PARSER_TYPE_BE);
+	if (err <  0)
+		return err;
+
+	err = tplg_build_pcm_dai(tplg, PARSER_TYPE_CC);
+	if (err <  0)
+		return err;
+
+	err = tplg_build_routes(tplg);
+	if (err <  0)
+		return err;
+
+	return err;
+}
+
+int snd_tplg_build(snd_tplg_t *tplg, const char *infile, const char *outfile)
+{
+	snd_config_t *cfg = NULL;
+	int err = 0;
+
+	/* delete any old output files */
+	unlink(outfile);
+
+	tplg->out_fd =
+		open(outfile, O_RDWR | O_CREAT, S_IRWXU | S_IRWXG | S_IRWXO);
+	if (tplg->out_fd < 0) {
+		fprintf(stderr, "error: failed to open %s err %d\n",
+			outfile, -errno);
+		return -errno;
+	}
+
+	err = tplg_load_config(infile, &cfg);
+	if (err < 0) {
+		fprintf(stderr, "error: failed to load topology file %s\n",
+			infile);
+		return err;
+	}
+
+	err = tplg_parse_config(tplg, cfg);
+	if (err < 0) {
+		fprintf(stderr, "error: failed to parse topology\n");
+		goto out;
+	}
+
+	err = tplg_build_integ(tplg);
+	if (err < 0) {
+		fprintf(stderr, "error: failed to check topology integrity\n");
+		goto out;
+	}
+
+	err = tplg_write_data(tplg);
+	if (err < 0) {
+		fprintf(stderr, "error: failed to write data %d\n", err);
+		goto out;
+	}
+
+out:
+	snd_config_delete(cfg);
+	close(tplg->out_fd);
+	return err;
+}
+
+void snd_tplg_verbose(snd_tplg_t *tplg, int verbose)
+{
+	tplg->verbose = verbose;
+}
+
+snd_tplg_t *snd_tplg_new(void)
+{
+	snd_tplg_t *tplg;
+
+	tplg = calloc(1, sizeof(snd_tplg_t));
+	if (!tplg)
+		return NULL;
+
+	INIT_LIST_HEAD(&tplg->tlv_list);
+	INIT_LIST_HEAD(&tplg->widget_list);
+	INIT_LIST_HEAD(&tplg->pcm_list);
+	INIT_LIST_HEAD(&tplg->be_list);
+	INIT_LIST_HEAD(&tplg->cc_list);
+	INIT_LIST_HEAD(&tplg->route_list);
+	INIT_LIST_HEAD(&tplg->pdata_list);
+	INIT_LIST_HEAD(&tplg->text_list);
+	INIT_LIST_HEAD(&tplg->pcm_config_list);
+	INIT_LIST_HEAD(&tplg->pcm_caps_list);
+	INIT_LIST_HEAD(&tplg->mixer_list);
+	INIT_LIST_HEAD(&tplg->enum_list);
+	INIT_LIST_HEAD(&tplg->bytes_ext_list);
+
+	return tplg;
+}
+
+void snd_tplg_free(snd_tplg_t *tplg)
+{
+	tplg_elem_free_list(&tplg->tlv_list);
+	tplg_elem_free_list(&tplg->widget_list);
+	tplg_elem_free_list(&tplg->pcm_list);
+	tplg_elem_free_list(&tplg->be_list);
+	tplg_elem_free_list(&tplg->cc_list);
+	tplg_elem_free_list(&tplg->route_list);
+	tplg_elem_free_list(&tplg->pdata_list);
+	tplg_elem_free_list(&tplg->text_list);
+	tplg_elem_free_list(&tplg->pcm_config_list);
+	tplg_elem_free_list(&tplg->pcm_caps_list);
+	tplg_elem_free_list(&tplg->mixer_list);
+	tplg_elem_free_list(&tplg->enum_list);
+	tplg_elem_free_list(&tplg->bytes_ext_list);
+
+	free(tplg);
+}
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
new file mode 100644
index 0000000..ca47879
--- /dev/null
+++ b/src/topology/tplg_local.h
@@ -0,0 +1,223 @@
+/*
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ */
+
+#include <limits.h>
+#include <stdint.h>
+#include <linux/types.h>
+
+#include "local.h"
+#include "list.h"
+#include "topology.h"
+
+#include <sound/asound.h>
+#include <sound/asoc.h>
+#include <sound/tlv.h>
+
+#define TPLG_DEBUG
+#ifdef TPLG_DEBUG
+#define tplg_dbg SNDERR
+#else
+#define tplg_dbg(fmt, arg...) do { } while (0)
+#endif
+
+#define MAX_FILE		256
+#define TPLG_MAX_PRIV_SIZE	(1024 * 128)
+#define ALSA_TPLG_DIR	ALSA_CONFIG_DIR "/topology"
+#define ARRAY_SIZE(x) (sizeof(x) / sizeof(x[0]))
+
+/** The name of the environment variable containing the tplg directory */
+#define ALSA_CONFIG_TPLG_VAR "ALSA_CONFIG_TPLG"
+
+struct tplg_ref;
+struct tplg_elem;
+
+/* internal topology object type not used by kernel */
+enum parser_type {
+	PARSER_TYPE_TLV = 0,
+	PARSER_TYPE_MIXER,
+	PARSER_TYPE_ENUM,
+	PARSER_TYPE_TEXT,
+	PARSER_TYPE_DATA,
+	PARSER_TYPE_BYTES,
+	PARSER_TYPE_STREAM_CONFIG,
+	PARSER_TYPE_STREAM_CAPS,
+	PARSER_TYPE_PCM,
+	PARSER_TYPE_DAPM_WIDGET,
+	PARSER_TYPE_DAPM_GRAPH,
+	PARSER_TYPE_BE,
+	PARSER_TYPE_CC,
+};
+
+struct snd_tplg {
+
+	/* opaque vendor data */
+	int vendor_fd;
+	char *vendor_name;
+
+	/* out file */
+	int out_fd;
+
+	int verbose;
+	unsigned int version;
+
+	/* runtime state */
+	unsigned int next_hdr_pos;
+	int index;
+	int channel_idx;
+
+	/* list of each element type */
+	struct list_head tlv_list;
+	struct list_head widget_list;
+	struct list_head pcm_list;
+	struct list_head be_list;
+	struct list_head cc_list;
+	struct list_head route_list;
+	struct list_head text_list;
+	struct list_head pdata_list;
+	struct list_head pcm_config_list;
+	struct list_head pcm_caps_list;
+
+	/* type-specific control lists */
+	struct list_head mixer_list;
+	struct list_head enum_list;
+	struct list_head bytes_ext_list;
+};
+
+/* object text references */
+struct tplg_ref {
+	unsigned int type;
+	struct tplg_elem *elem;
+	char id[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+	struct list_head list;
+};
+
+/* topology element */
+struct tplg_elem {
+
+	char id[SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+
+	/* storage for texts and data if this is text or data elem*/
+	char texts[SND_SOC_TPLG_NUM_TEXTS][SNDRV_CTL_ELEM_ID_NAME_MAXLEN];
+
+	int index;
+	enum parser_type type;
+
+	int size; /* total size of this object inc pdata and ref objects */
+	int compound_elem; /* dont write this element as individual elem */
+
+	/* UAPI object for this elem */
+	union {
+		void *obj;
+		struct snd_soc_tplg_mixer_control *mixer_ctrl;
+		struct snd_soc_tplg_enum_control *enum_ctrl;
+		struct snd_soc_tplg_bytes_control *bytes_ext;
+		struct snd_soc_tplg_dapm_widget *widget;
+		struct snd_soc_tplg_pcm_dai *pcm;
+		struct snd_soc_tplg_pcm_dai *be;
+		struct snd_soc_tplg_pcm_dai *cc;
+		struct snd_soc_tplg_dapm_graph_elem *route;
+		struct snd_soc_tplg_stream_config *stream_cfg;
+		struct snd_soc_tplg_stream_caps *stream_caps;
+
+		/* these do not map to UAPI structs but are internal only */
+		struct snd_soc_tplg_ctl_tlv *tlv;
+		struct snd_soc_tplg_private *data;
+	};
+
+	/* an element may refer to other elements:
+	 * a mixer control may refer to a tlv,
+	 * a widget may refer to a mixer control array,
+	 * a graph may refer to some widgets.
+	 */
+	struct list_head ref_list;
+	struct list_head list; /* list of all elements with same type */
+};
+
+struct map_elem {
+	const char *name;
+	int id;
+};
+
+int tplg_parse_compound(snd_tplg_t *tplg, snd_config_t *cfg,
+	int (*fcn)(snd_tplg_t *, snd_config_t *, void *),
+	void *private);
+
+int tplg_write_data(snd_tplg_t *tplg);
+
+int tplg_parse_tlv(snd_tplg_t *tplg, snd_config_t *cfg,
+	void *private ATTRIBUTE_UNUSED);
+
+int tplg_parse_text(snd_tplg_t *tplg, snd_config_t *cfg,
+	void *private ATTRIBUTE_UNUSED);
+
+int tplg_parse_data(snd_tplg_t *tplg, snd_config_t *cfg,
+	void *private ATTRIBUTE_UNUSED);
+
+int tplg_parse_control_bytes(snd_tplg_t *tplg,
+	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
+
+int tplg_parse_control_enum(snd_tplg_t *tplg, snd_config_t *cfg,
+	void *private ATTRIBUTE_UNUSED);
+
+int tplg_parse_control_mixer(snd_tplg_t *tplg,
+	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
+
+int tplg_parse_dapm_graph(snd_tplg_t *tplg, snd_config_t *cfg,
+	void *private ATTRIBUTE_UNUSED);
+
+int tplg_parse_dapm_widget(snd_tplg_t *tplg,
+	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
+
+int tplg_parse_pcm_config(snd_tplg_t *tplg,
+	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
+
+int tplg_parse_pcm_caps(snd_tplg_t *tplg,
+	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
+
+int tplg_parse_pcm_cap_cfg(snd_tplg_t *tplg, snd_config_t *cfg,
+	void *private);
+
+int tplg_parse_pcm(snd_tplg_t *tplg,
+	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
+
+int tplg_parse_be(snd_tplg_t *tplg,
+	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
+
+int tplg_parse_cc(snd_tplg_t *tplg,
+	snd_config_t *cfg, void *private ATTRIBUTE_UNUSED);
+
+int tplg_build_controls(snd_tplg_t *tplg);
+int tplg_build_widgets(snd_tplg_t *tplg);
+int tplg_build_routes(snd_tplg_t *tplg);
+int tplg_build_pcm_dai(snd_tplg_t *tplg, unsigned int type);
+
+int tplg_copy_data(struct tplg_elem *elem, struct tplg_elem *ref);
+
+int tplg_ref_add(struct tplg_elem *elem, int type, const char* id);
+
+struct tplg_elem *tplg_elem_new(void);
+void tplg_elem_free(struct tplg_elem *elem);
+void tplg_elem_free_list(struct list_head *base);
+struct tplg_elem *tplg_elem_lookup(struct list_head *base,
+				const char* id,
+				unsigned int type);
+struct tplg_elem* tplg_elem_new_common(snd_tplg_t *tplg,
+	snd_config_t *cfg, enum parser_type type);
+
+int tplg_parse_channel(snd_tplg_t *tplg ATTRIBUTE_UNUSED,
+	snd_config_t *cfg, void *private);
+
+int tplg_parse_ops(snd_tplg_t *tplg ATTRIBUTE_UNUSED,
+	snd_config_t *cfg, void *private);
+
+struct tplg_elem *lookup_pcm_dai_stream(struct list_head *base,
+	const char* id);
-- 
2.1.4
