From: mengdong.lin@linux.intel.com
Subject: [PATCH 04/22] topology: Define a function to build a
	single PCM element
Date: Thu, 27 Oct 2016 15:11:44 +0800
Message-ID: <673326614f862544308b68b06feec96eaf9ee4c2.1477549962.git.mengdong.lin@linux.intel.com>
References: <cover.1477549962.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
 by alsa0.perex.cz (Postfix) with ESMTP id 3A32326688A
 for <alsa-devel@alsa-project.org>; Thu, 27 Oct 2016 09:10:30 +0200 (CEST)
In-Reply-To: <cover.1477549962.git.mengdong.lin@linux.intel.com>
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

Code refactoring. Rename tplg_build_pcm() to tplg_build_pcms() to build
all PCM (FE DAI & DAI link) elements. It will call a new function
build_pcm() to build a single PCM elemement.

build_pcm() will be extended to handle more properties of a PCM.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/topology/parser.c b/src/topology/parser.c
index 3ab64f4..7b2c879 100644
--- a/src/topology/parser.c
+++ b/src/topology/parser.c
@@ -267,7 +267,7 @@ static int tplg_build_integ(snd_tplg_t *tplg)
 	if (err <  0)
 		return err;
 
-	err = tplg_build_pcm(tplg, SND_TPLG_TYPE_PCM);
+	err = tplg_build_pcms(tplg, SND_TPLG_TYPE_PCM);
 	if (err <  0)
 		return err;
 
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 3d9feb0..72bab94 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -70,8 +70,20 @@ static int tplg_build_stream_caps(snd_tplg_t *tplg,
 	return 0;
 }
 
-/* build FE DAI/PCM configurations */
-int tplg_build_pcm(snd_tplg_t *tplg, unsigned int type)
+/* build a PCM (FE DAI & DAI link) element */
+static int build_pcm(snd_tplg_t *tplg, struct tplg_elem *elem)
+{
+	int err;
+
+	err = tplg_build_stream_caps(tplg, elem->id, elem->pcm->caps);
+		if (err < 0)
+			return err;
+
+	return 0;
+}
+
+/* build all PCM (FE DAI & DAI link) elements */
+int tplg_build_pcms(snd_tplg_t *tplg, unsigned int type)
 {
 	struct list_head *base, *pos;
 	struct tplg_elem *elem;
@@ -86,7 +98,7 @@ int tplg_build_pcm(snd_tplg_t *tplg, unsigned int type)
 			return -EINVAL;
 		}
 
-		err = tplg_build_stream_caps(tplg, elem->id, elem->pcm->caps);
+		err = build_pcm(tplg, elem);
 		if (err < 0)
 			return err;
 
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index cfde4cc..7b30b84 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -284,7 +284,7 @@ int tplg_add_enum(snd_tplg_t *tplg, struct snd_tplg_enum_template *enum_ctl,
 int tplg_add_bytes(snd_tplg_t *tplg, struct snd_tplg_bytes_template *bytes_ctl,
 		   struct tplg_elem **e);
 
-int tplg_build_pcm(snd_tplg_t *tplg, unsigned int type);
+int tplg_build_pcms(snd_tplg_t *tplg, unsigned int type);
 int tplg_build_link_cfg(snd_tplg_t *tplg, unsigned int type);
 int tplg_add_link_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t);
 int tplg_add_pcm_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t);
-- 
2.5.0
