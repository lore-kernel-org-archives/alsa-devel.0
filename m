From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v2 04/13] topology: Add text section parser.
Date: Wed,  1 Jul 2015 14:44:26 +0100
Message-ID: <1435758275-4047-4-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1435758275-4047-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id CF2EE26069D
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2015 15:45:45 +0200 (CEST)
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

Parse text lists (like enum values) and store for later attachment
to other objects.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 src/topology/text.c | 99 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 99 insertions(+)
 create mode 100644 src/topology/text.c

diff --git a/src/topology/text.c b/src/topology/text.c
new file mode 100644
index 0000000..d24d027
--- /dev/null
+++ b/src/topology/text.c
@@ -0,0 +1,99 @@
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
+
+*/
+
+#include "list.h"
+#include "tplg_local.h"
+
+#define TEXT_SIZE_MAX \
+	(SND_SOC_TPLG_NUM_TEXTS * SNDRV_CTL_ELEM_ID_NAME_MAXLEN)
+
+static int parse_text_values(snd_config_t *cfg, struct tplg_elem *elem)
+{
+	snd_config_iterator_t i, next;
+	snd_config_t *n;
+	const char *value = NULL;
+	int j = 0;
+
+	tplg_dbg(" Text Values: %s\n", elem->id);
+
+	snd_config_for_each(i, next, cfg) {
+		n = snd_config_iterator_entry(i);
+
+		if (j == SND_SOC_TPLG_NUM_TEXTS) {
+			tplg_dbg("error: text string number exceeds %d\n", j);
+			return -ENOMEM;
+		}
+
+		/* get value */
+		if (snd_config_get_string(n, &value) < 0)
+			continue;
+
+		strncpy(&elem->texts[j][0], value,
+			SNDRV_CTL_ELEM_ID_NAME_MAXLEN);
+		elem->texts[j][SNDRV_CTL_ELEM_ID_NAME_MAXLEN - 1] = 0;
+		tplg_dbg("\t%s\n", &elem->texts[j][0]);
+
+		j++;
+	}
+
+	return 0;
+}
+
+/* Parse Text data.
+ *
+ * Object text strings.
+ *
+ * SectionText."text name" {
+ *
+ *		Values [
+ *
+ *		]
+ * }
+ */
+int tplg_parse_text(snd_tplg_t *tplg, snd_config_t *cfg,
+	void *private ATTRIBUTE_UNUSED)
+{
+	snd_config_iterator_t i, next;
+	snd_config_t *n;
+	const char *id;
+	int err = 0;
+	struct tplg_elem *elem;
+
+	elem = tplg_elem_new_common(tplg, cfg, PARSER_TYPE_TEXT);
+	if (!elem)
+		return -ENOMEM;
+
+	snd_config_for_each(i, next, cfg) {
+
+		n = snd_config_iterator_entry(i);
+		if (snd_config_get_id(n, &id) < 0)
+			continue;
+
+		if (strcmp(id, "values") == 0) {
+			err = parse_text_values(n, elem);
+			if (err < 0) {
+				fprintf(stderr, "error: failed to parse text values");
+				return err;
+			}
+			continue;
+		}
+	}
+
+	return err;
+}
-- 
2.1.4
