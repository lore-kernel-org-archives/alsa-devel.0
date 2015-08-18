From: mengdong.lin@intel.com
Subject: [PATCH v2 2/3] ASoC: topology: Reduce arguments of
	soc_tplg_kcontrol_bind_io()
Date: Tue, 18 Aug 2015 18:12:01 +0800
Message-ID: <50ef2cb41e76b1582b71910b4dfea144388dcc5f.1439892263.git.mengdong.lin@intel.com>
References: <cover.1439892263.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 2E0D1260A5B
 for <alsa-devel@alsa-project.org>; Tue, 18 Aug 2015 11:58:32 +0200 (CEST)
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

Add the pointer of struct soc_tplg as one argument, so no need to
pass standard/vendor specific kcontrol handlers and their count.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/sound/soc/soc-topology.c b/sound/soc/soc-topology.c
index 707c360..9ec97f4 100644
--- a/sound/soc/soc-topology.c
+++ b/sound/soc/soc-topology.c
@@ -508,20 +508,22 @@ static void remove_pcm_dai(struct snd_soc_component *comp,
 /* bind a kcontrol to it's IO handlers */
 static int soc_tplg_kcontrol_bind_io(struct snd_soc_tplg_ctl_hdr *hdr,
 	struct snd_kcontrol_new *k,
-	const struct snd_soc_tplg_kcontrol_ops *ops, int num_ops,
-	const struct snd_soc_tplg_kcontrol_ops *bops, int num_bops)
+	const struct soc_tplg *tplg)
 {
-	int i;
+	const struct snd_soc_tplg_kcontrol_ops *ops;
+	int num_ops, i;
 
 	/* try and map vendor specific kcontrol handlers first */
-	for (i = 0; i < num_bops; i++) {
-
-		if (k->put == NULL && bops[i].id == hdr->ops.put)
-			k->put = bops[i].put;
-		if (k->get == NULL && bops[i].id == hdr->ops.get)
-			k->get = bops[i].get;
-		if (k->info == NULL && bops[i].id == hdr->ops.info)
-			k->info = bops[i].info;
+	ops = tplg->io_ops;
+	num_ops = tplg->io_ops_count;
+	for (i = 0; i < num_ops; i++) {
+
+		if (k->put == NULL && ops[i].id == hdr->ops.put)
+			k->put = ops[i].put;
+		if (k->get == NULL && ops[i].id == hdr->ops.get)
+			k->get = ops[i].get;
+		if (k->info == NULL && ops[i].id == hdr->ops.info)
+			k->info = ops[i].info;
 	}
 
 	/* vendor specific handlers found ? */
@@ -529,6 +531,8 @@ static int soc_tplg_kcontrol_bind_io(struct snd_soc_tplg_ctl_hdr *hdr,
 		return 0;
 
 	/* none found so try standard kcontrol handlers */
+	ops = io_ops;
+	num_ops = ARRAY_SIZE(io_ops);
 	for (i = 0; i < num_ops; i++) {
 
 		if (k->put == NULL && ops[i].id == hdr->ops.put)
@@ -682,8 +686,7 @@ static int soc_tplg_dbytes_create(struct soc_tplg *tplg, unsigned int count,
 		INIT_LIST_HEAD(&sbe->dobj.list);
 
 		/* map io handlers */
-		err = soc_tplg_kcontrol_bind_io(&be->hdr, &kc, io_ops,
-			ARRAY_SIZE(io_ops), tplg->io_ops, tplg->io_ops_count);
+		err = soc_tplg_kcontrol_bind_io(&be->hdr, &kc, tplg);
 		if (err) {
 			soc_control_err(tplg, &be->hdr, be->hdr.name);
 			kfree(sbe);
@@ -777,8 +780,7 @@ static int soc_tplg_dmixer_create(struct soc_tplg *tplg, unsigned int count,
 		INIT_LIST_HEAD(&sm->dobj.list);
 
 		/* map io handlers */
-		err = soc_tplg_kcontrol_bind_io(&mc->hdr, &kc, io_ops,
-			ARRAY_SIZE(io_ops), tplg->io_ops, tplg->io_ops_count);
+		err = soc_tplg_kcontrol_bind_io(&mc->hdr, &kc, tplg);
 		if (err) {
 			soc_control_err(tplg, &mc->hdr, mc->hdr.name);
 			kfree(sm);
@@ -950,8 +952,7 @@ static int soc_tplg_denum_create(struct soc_tplg *tplg, unsigned int count,
 		}
 
 		/* map io handlers */
-		err = soc_tplg_kcontrol_bind_io(&ec->hdr, &kc, io_ops,
-			ARRAY_SIZE(io_ops), tplg->io_ops, tplg->io_ops_count);
+		err = soc_tplg_kcontrol_bind_io(&ec->hdr, &kc, tplg);
 		if (err) {
 			soc_control_err(tplg, &ec->hdr, ec->hdr.name);
 			kfree(se);
@@ -1137,8 +1138,7 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dmixer_create(
 		INIT_LIST_HEAD(&sm->dobj.list);
 
 		/* map io handlers */
-		err = soc_tplg_kcontrol_bind_io(&mc->hdr, &kc[i], io_ops,
-			ARRAY_SIZE(io_ops), tplg->io_ops, tplg->io_ops_count);
+		err = soc_tplg_kcontrol_bind_io(&mc->hdr, &kc[i], tplg);
 		if (err) {
 			soc_control_err(tplg, &mc->hdr, mc->hdr.name);
 			kfree(sm);
@@ -1235,8 +1235,7 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_denum_create(
 	}
 
 	/* map io handlers */
-	err = soc_tplg_kcontrol_bind_io(&ec->hdr, kc, io_ops,
-		ARRAY_SIZE(io_ops), tplg->io_ops, tplg->io_ops_count);
+	err = soc_tplg_kcontrol_bind_io(&ec->hdr, kc, tplg);
 	if (err) {
 		soc_control_err(tplg, &ec->hdr, ec->hdr.name);
 		goto err_se;
@@ -1306,9 +1305,7 @@ static struct snd_kcontrol_new *soc_tplg_dapm_widget_dbytes_create(
 		INIT_LIST_HEAD(&sbe->dobj.list);
 
 		/* map standard io handlers and check for external handlers */
-		err = soc_tplg_kcontrol_bind_io(&be->hdr, &kc[i], io_ops,
-				ARRAY_SIZE(io_ops), tplg->io_ops,
-				tplg->io_ops_count);
+		err = soc_tplg_kcontrol_bind_io(&be->hdr, &kc[i], tplg);
 		if (err) {
 			soc_control_err(tplg, &be->hdr, be->hdr.name);
 			kfree(sbe);
-- 
1.9.1
