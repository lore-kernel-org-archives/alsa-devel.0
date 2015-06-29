From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH 06/13] topology: Add operations parser
Date: Mon, 29 Jun 2015 17:32:51 +0100
Message-ID: <1435595578-6899-6-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1435595578-6899-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 78A5B265487
 for <alsa-devel@alsa-project.org>; Mon, 29 Jun 2015 18:33:21 +0200 (CEST)
In-Reply-To: <1435595578-6899-1-git-send-email-liam.r.girdwood@linux.intel.com>
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
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <liam.r.girdwood@linux.intel.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Parse operations so we can bind them to kcontrols in the kernel.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 src/topology/ops.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 90 insertions(+)
 create mode 100644 src/topology/ops.c

diff --git a/src/topology/ops.c b/src/topology/ops.c
new file mode 100644
index 0000000..d3f4a28
--- /dev/null
+++ b/src/topology/ops.c
@@ -0,0 +1,90 @@
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
+/* mapping of kcontrol text names to types */
+static const struct map_elem control_map[] = {
+	{"volsw", SND_SOC_TPLG_CTL_VOLSW},
+	{"volsw_sx", SND_SOC_TPLG_CTL_VOLSW_SX},
+	{"volsw_xr_sx", SND_SOC_TPLG_CTL_VOLSW_XR_SX},
+	{"enum", SND_SOC_TPLG_CTL_ENUM},
+	{"bytes", SND_SOC_TPLG_CTL_BYTES},
+	{"enum_value", SND_SOC_TPLG_CTL_ENUM_VALUE},
+	{"range", SND_SOC_TPLG_CTL_RANGE},
+	{"strobe", SND_SOC_TPLG_CTL_STROBE},
+};
+
+static int lookup_ops(const char *c)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(control_map); i++) {
+		if (strcmp(control_map[i].name, c) == 0)
+			return control_map[i].id;
+	}
+
+	/* cant find string name in our table so we use its ID number */
+	return atoi(c);
+}
+
+/* Parse Control operations. Ops can come from standard names above or
+ * bespoke driver controls with numbers >= 256
+ *
+ * ops."name" {
+ *	info "volsw"
+ *	get "256"
+ *	put "256"
+ * }
+ */
+int tplg_parse_ops(snd_tplg_t *tplg ATTRIBUTE_UNUSED,
+	snd_config_t *cfg, void *private)
+{
+	snd_config_iterator_t i, next;
+	snd_config_t *n;
+	struct snd_soc_tplg_ctl_hdr *hdr = private;
+	const char *id, *value;
+
+	tplg_dbg("\tOps\n");
+	hdr->size = sizeof(*hdr);
+
+	snd_config_for_each(i, next, cfg) {
+
+		n = snd_config_iterator_entry(i);
+
+		/* get id */
+		if (snd_config_get_id(n, &id) < 0)
+			continue;
+
+		/* get value - try strings then ints */
+		if (snd_config_get_string(n, &value) < 0)
+			continue;
+
+		if (strcmp(id, "info") == 0)
+			hdr->ops.info = lookup_ops(value);
+		else if (strcmp(id, "put") == 0)
+			hdr->ops.put = lookup_ops(value);
+		else if (strcmp(id, "get") == 0)
+			hdr->ops.get = lookup_ops(value);
+
+		tplg_dbg("\t\t%s = %s\n", id, value);
+	}
+
+	return 0;
+}
-- 
2.1.4
