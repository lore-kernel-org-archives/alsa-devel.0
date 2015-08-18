From: mengdong.lin@intel.com
Subject: [PATCH v2 1/3] ASoC: topology: Bind vendor specific
	kcontrol handlers before standard ones
Date: Tue, 18 Aug 2015 18:11:51 +0800
Message-ID: <c16322a038d8b6ccd9f5235cfea2c28b81a90c5d.1439892263.git.mengdong.lin@intel.com>
References: <cover.1439892263.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id C3FF326051B
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2015 11:58:22 +0200 (CEST)
In-Reply-To: <cover.1439892263.git.mengdong.lin@intel.com>
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
Cc: tiwai@suse.de, Mengdong Lin <mengdong.lin@intel.com>, broonie@kernel.org, mengdong.lin@linux.intel.com, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

Vendor specific handlers should override standard handlers. So we can
handle things in the order from specific to generic.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/include/sound/soc-topology.h b/include/sound/soc-topology.h
index 865a141..a6541a1 100644
--- a/include/sound/soc-topology.h
+++ b/include/sound/soc-topology.h
@@ -136,7 +136,7 @@ struct snd_soc_tplg_ops {
 	int (*manifest)(struct snd_soc_component *,
 		struct snd_soc_tplg_manifest *);
 
-	/* bespoke kcontrol handlers available for binding */
+	/* vendor specific kcontrol handlers available for binding */
 	const struct snd_soc_tplg_kcontrol_ops *io_ops;
 	int io_ops_count;
 };
diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 04764fd..707c360 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -66,7 +66,7 @@ struct soc_tplg {
 	u32 index;	/* current block index */
 	u32 req_index;	/* required index, only loaded/free matching blocks */
 
-	/* kcontrol operations */
+	/* vendor specific kcontrol operations */
 	const struct snd_soc_tplg_kcontrol_ops *io_ops;
 	int io_ops_count;
 
@@ -513,22 +513,7 @@ static int soc_tplg_kcontrol_bind_io(struct snd_soc_tplg_ctl_hdr *hdr,
 {
 	int i;
 
-	/* try and map standard kcontrols handler first */
-	for (i = 0; i < num_ops; i++) {
-
-		if (ops[i].id == hdr->ops.put)
-			k->put = ops[i].put;
-		if (ops[i].id == hdr->ops.get)
-			k->get = ops[i].get;
-		if (ops[i].id == hdr->ops.info)
-			k->info = ops[i].info;
-	}
-
-	/* standard handlers found ? */
-	if (k->put && k->get && k->info)
-		return 0;
-
-	/* none found so try bespoke handlers */
+	/* try and map vendor specific kcontrol handlers first */
 	for (i = 0; i < num_bops; i++) {
 
 		if (k->put == NULL && bops[i].id == hdr->ops.put)
@@ -539,7 +524,22 @@ static int soc_tplg_kcontrol_bind_io(struct snd_soc_tplg_ctl_hdr *hdr,
 			k->info = bops[i].info;
 	}
 
-	/* bespoke handlers found ? */
+	/* vendor specific handlers found ? */
+	if (k->put && k->get && k->info)
+		return 0;
+
+	/* none found so try standard kcontrol handlers */
+	for (i = 0; i < num_ops; i++) {
+
+		if (k->put == NULL && ops[i].id == hdr->ops.put)
+			k->put = ops[i].put;
+		if (k->get == NULL && ops[i].id == hdr->ops.get)
+			k->get = ops[i].get;
+		if (k->info == NULL && ops[i].id == hdr->ops.info)
+			k->info = ops[i].info;
+	}
+
+	/* standard handlers found ? */
 	if (k->put && k->get && k->info)
 		return 0;
 
-- 
1.9.1
