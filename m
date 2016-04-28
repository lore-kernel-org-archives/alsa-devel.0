From: mengdong.lin@linux.intel.com
Subject: [PATCH 3/6] topology: Use generic pointer to realloc
	buffer for private data
Date: Thu, 28 Apr 2016 16:41:49 +0800
Message-ID: <1dd0f08c152af476e3a5af48ce7de97cd759616a.1461831763.git.mengdong.lin@linux.intel.com>
References: <cover.1461831763.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 436B326656B
 for <alsa-devel@alsa-project.org>; Thu, 28 Apr 2016 10:38:52 +0200 (CEST)
In-Reply-To: <cover.1461831763.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@intel.com, hardik.t.shah@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Many element types have private data. So use the generic obj pointer
instead of the type-specific pointer when reallocating the object to
accommodate the private data.

Empty private data will be overlooked.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/topology/data.c b/src/topology/data.c
index 19c31bf..6606ca9 100644
--- a/src/topology/data.c
+++ b/src/topology/data.c
@@ -827,39 +827,29 @@ int tplg_copy_data(struct tplg_elem *elem, struct tplg_elem *ref)
 		return -EINVAL;
 
 	tplg_dbg("Data '%s' used by '%s'\n", ref->id, elem->id);
+	if (!ref->data || !ref->data->size) /* overlook empty private data */
+		return 0;
+
 	priv_data_size = ref->data->size;
+	elem->obj = realloc(elem->obj,
+			elem->size + priv_data_size);
+	if (!elem->obj)
+		return -ENOMEM;
 
 	switch (elem->type) {
 	case SND_TPLG_TYPE_MIXER:
-		elem->mixer_ctrl = realloc(elem->mixer_ctrl,
-			elem->size + priv_data_size);
-		if (!elem->mixer_ctrl)
-			return -ENOMEM;
 		priv = &elem->mixer_ctrl->priv;
 		break;
 
 	case SND_TPLG_TYPE_ENUM:
-		elem->enum_ctrl = realloc(elem->enum_ctrl,
-			elem->size + priv_data_size);
-		if (!elem->enum_ctrl)
-			return -ENOMEM;
 		priv = &elem->enum_ctrl->priv;
 		break;
 
 	case SND_TPLG_TYPE_BYTES:
-		elem->bytes_ext = realloc(elem->bytes_ext,
-			elem->size + priv_data_size);
-		if (!elem->bytes_ext)
-			return -ENOMEM;
 		priv = &elem->bytes_ext->priv;
 		break;
 
-
 	case SND_TPLG_TYPE_DAPM_WIDGET:
-		elem->widget = realloc(elem->widget,
-			elem->size + priv_data_size);
-		if (!elem->widget)
-			return -ENOMEM;
 		priv = &elem->widget->priv;
 		break;
 
-- 
2.5.0
