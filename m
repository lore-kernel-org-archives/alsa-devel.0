From: mengdong.lin@linux.intel.com
Subject: [PATCH 03/13] topology: Define a function to build a
	single physical DAI link
Date: Sun,  6 Nov 2016 13:12:40 +0800
Message-ID: <77d0a244bb49a6fc94814d23d0ac3466a8785d53.1478407716.git.mengdong.lin@linux.intel.com>
References: <cover.1478407716.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 by alsa0.perex.cz (Postfix) with ESMTP id D7EEC2665B0
 for <alsa-devel@alsa-project.org>; Sun,  6 Nov 2016 06:11:11 +0100 (CET)
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

Code refactoring. Rename the function to build all physical links from
tplg_build_link_config() to tplg_build_links(). And define a new function
build_link() to build a single physical DAI link element.

The function build_link() will be extended to handle more properties
of a physical DAI link (e.g. backend or codec-codec link).

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/topology/parser.c b/src/topology/parser.c
index 7b2c879..ded2eb7 100644
--- a/src/topology/parser.c
+++ b/src/topology/parser.c
@@ -271,11 +271,11 @@ static int tplg_build_integ(snd_tplg_t *tplg)
 	if (err <  0)
 		return err;
 
-	err = tplg_build_link_cfg(tplg, SND_TPLG_TYPE_BE);
+	err = tplg_build_links(tplg, SND_TPLG_TYPE_BE);
 	if (err <  0)
 		return err;
 
-	err = tplg_build_link_cfg(tplg, SND_TPLG_TYPE_CC);
+	err = tplg_build_links(tplg, SND_TPLG_TYPE_CC);
 	if (err <  0)
 		return err;
 
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 64fd78f..d8dd96a 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -148,12 +148,31 @@ static int tplg_build_stream_cfg(snd_tplg_t *tplg,
 	return 0;
 }
 
+static int build_link(snd_tplg_t *tplg, struct tplg_elem *elem)
+{
+	struct snd_soc_tplg_link_config *link = elem->link;
+	struct tplg_elem *ref_elem = NULL;
+	struct snd_soc_tplg_link_cmpnt  *codec, *cmpnt;
+	struct tplg_ref *ref;
+	struct list_head *base, *pos;
+	int i, num_hw_configs = 0, err = 0;
+
+	err = tplg_build_stream_cfg(tplg, link->stream,
+				    link->num_streams);
+	if (err < 0)
+		return err;
+
+	/* add link to manifest */
+	tplg->manifest.dai_link_elems++;
+
+	return 0;
+}
+
 /* build BE/CC DAI link configurations */
-int tplg_build_link_cfg(snd_tplg_t *tplg, unsigned int type)
+int tplg_build_links(snd_tplg_t *tplg, unsigned int type)
 {
 	struct list_head *base, *pos;
 	struct tplg_elem *elem;
-	struct snd_soc_tplg_link_config *link;
 	int err = 0;
 
 	switch (type) {
@@ -175,9 +194,7 @@ int tplg_build_link_cfg(snd_tplg_t *tplg, unsigned int type)
 			return -EINVAL;
 		}
 
-		link = elem->link;
-		err = tplg_build_stream_cfg(tplg, link->stream,
-			link->num_streams);
+		err =  build_link(tplg, elem);
 		if (err < 0)
 			return err;
 	}
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index 3aa51ee..548f42d 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -284,6 +284,6 @@ int tplg_add_bytes(snd_tplg_t *tplg, struct snd_tplg_bytes_template *bytes_ctl,
 		   struct tplg_elem **e);
 
 int tplg_build_pcms(snd_tplg_t *tplg, unsigned int type);
-int tplg_build_link_cfg(snd_tplg_t *tplg, unsigned int type);
+int tplg_build_links(snd_tplg_t *tplg, unsigned int type);
 int tplg_add_link_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t);
 int tplg_add_pcm_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t);
-- 
2.7.4
