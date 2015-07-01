From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH v2 10/13] topology: Add Channel map parser.
Date: Wed,  1 Jul 2015 14:44:32 +0100
Message-ID: <1435758275-4047-10-git-send-email-liam.r.girdwood@linux.intel.com>
References: <1435758275-4047-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 0504A2606F6
 for <alsa-devel@alsa-project.org>; Wed,  1 Jul 2015 15:45:56 +0200 (CEST)
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

Add support for parsing channel map to control registers.

Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 src/topology/channel.c | 128 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 128 insertions(+)
 create mode 100644 src/topology/channel.c

diff --git a/src/topology/channel.c b/src/topology/channel.c
new file mode 100644
index 0000000..e33c70d
--- /dev/null
+++ b/src/topology/channel.c
@@ -0,0 +1,128 @@
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
+/* mapping of channel text names to types */
+static const struct map_elem channel_map[] = {
+	{"mono", SNDRV_CHMAP_MONO},	/* mono stream */
+	{"fl", SNDRV_CHMAP_FL},		/* front left */
+	{"fr", SNDRV_CHMAP_FR},		/* front right */
+	{"rl", SNDRV_CHMAP_RL},		/* rear left */
+	{"rr", SNDRV_CHMAP_RR},		/* rear right */
+	{"fc", SNDRV_CHMAP_FC},		/* front center */
+	{"lfe", SNDRV_CHMAP_LFE},	/* LFE */
+	{"sl", SNDRV_CHMAP_SL},		/* side left */
+	{"sr", SNDRV_CHMAP_SR},		/* side right */
+	{"rc", SNDRV_CHMAP_RC},		/* rear center */
+	{"flc", SNDRV_CHMAP_FLC},	/* front left center */
+	{"frc", SNDRV_CHMAP_FRC},	/* front right center */
+	{"rlc", SNDRV_CHMAP_RLC},	/* rear left center */
+	{"rrc", SNDRV_CHMAP_RRC},	/* rear right center */
+	{"flw", SNDRV_CHMAP_FLW},	/* front left wide */
+	{"frw", SNDRV_CHMAP_FRW},	/* front right wide */
+	{"flh", SNDRV_CHMAP_FLH},	/* front left high */
+	{"fch", SNDRV_CHMAP_FCH},	/* front center high */
+	{"frh", SNDRV_CHMAP_FRH},	/* front right high */
+	{"tc", SNDRV_CHMAP_TC},		/* top center */
+	{"tfl", SNDRV_CHMAP_TFL},	/* top front left */
+	{"tfr", SNDRV_CHMAP_TFR},	/* top front right */
+	{"tfc", SNDRV_CHMAP_TFC},	/* top front center */
+	{"trl", SNDRV_CHMAP_TRL},	/* top rear left */
+	{"trr", SNDRV_CHMAP_TRR},	/* top rear right */
+	{"trc", SNDRV_CHMAP_TRC},	/* top rear center */
+	{"tflc", SNDRV_CHMAP_TFLC},	/* top front left center */
+	{"tfrc", SNDRV_CHMAP_TFRC},	/* top front right center */
+	{"tsl", SNDRV_CHMAP_TSL},	/* top side left */
+	{"tsr", SNDRV_CHMAP_TSR},	/* top side right */
+	{"llfe", SNDRV_CHMAP_LLFE},	/* left LFE */
+	{"rlfe", SNDRV_CHMAP_RLFE},	/* right LFE */
+	{"bc", SNDRV_CHMAP_BC},		/* bottom center */
+	{"blc", SNDRV_CHMAP_BLC},	/* bottom left center */
+	{"brc", SNDRV_CHMAP_BRC},	/* bottom right center */
+};
+
+
+static int lookup_channel(const char *c)
+{
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(channel_map); i++) {
+		if (strcasecmp(channel_map[i].name, c) == 0) {
+			return channel_map[i].id;
+		}
+	}
+
+	return -EINVAL;
+}
+
+/* Parse a channel.
+ *
+ * channel."channel_map.name" {
+ *		reg "0"	(register)
+ *		shift "0" (shift)
+ * }
+ */
+int tplg_parse_channel(snd_tplg_t *tplg,
+	snd_config_t *cfg, void *private)
+{
+	snd_config_iterator_t i, next;
+	snd_config_t *n;
+	struct snd_soc_tplg_channel *channel = private;
+	const char *id, *value;
+
+	if (tplg->channel_idx >= SND_SOC_TPLG_MAX_CHAN)
+		return -EINVAL;
+
+	channel += tplg->channel_idx;
+	snd_config_get_id(cfg, &id);
+	tplg_dbg("\tChannel %s at index %d\n", id, tplg->channel_idx);
+
+	channel->id = lookup_channel(id);
+	if (channel->id < 0) {
+		fprintf(stderr, "error: invalid channel %s\n", id);
+		return -EINVAL;
+	}
+
+	channel->size = sizeof(*channel);
+	tplg_dbg("\tChan %s = %d\n", id, channel->id);
+
+	snd_config_for_each(i, next, cfg) {
+
+		n = snd_config_iterator_entry(i);
+
+		/* get id */
+		if (snd_config_get_id(n, &id) < 0)
+			continue;
+
+		/* get value */
+		if (snd_config_get_string(n, &value) < 0)
+			continue;
+
+		if (strcmp(id, "reg") == 0)
+			channel->reg = atoi(value);
+		else if (strcmp(id, "shift") == 0)
+			channel->shift = atoi(value);
+
+		tplg_dbg("\t\t%s = %s\n", id, value);
+	}
+
+	tplg->channel_idx++;
+	return 0;
+}
-- 
2.1.4
