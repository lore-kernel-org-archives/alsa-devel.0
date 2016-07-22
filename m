From: mengdong.lin@linux.intel.com
Subject: [PATCH 4/4] topology: Export BE DAIs to the binary for
	kernel
Date: Fri, 22 Jul 2016 14:11:16 +0800
Message-ID: <d10246e500147183113d75216915b26c139857f2.1469165324.git.mengdong.lin@linux.intel.com>
References: <cover.1469165324.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 321732667AD
 for <alsa-devel@alsa-project.org>; Fri, 22 Jul 2016 08:06:16 +0200 (CEST)
In-Reply-To: <cover.1469165324.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, hardik.t.shah@intel.com, guneshwor.o.singh@intel.com, liam.r.girdwood@linux.intel.com, broonie@kernel.org, mengdong.lin@intel.com
List-Id: alsa-devel@alsa-project.org

From: Guneshwor Singh <guneshwor.o.singh@intel.com>

Export the BE (back-end) DAI objects to the binary output file for kernel.
For BE DAIs defined by the text conf file, find and merge their stream
capablities before exporting.

Signed-off-by: Guneshwor Singh <guneshwor.o.singh@intel.com>
Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/topology/builder.c b/src/topology/builder.c
index b0ba54e..c1ba6a4 100644
--- a/src/topology/builder.c
+++ b/src/topology/builder.c
@@ -204,6 +204,9 @@ static int write_block(snd_tplg_t *tplg, struct list_head *base,
 	case SND_TPLG_TYPE_DATA:
 		return write_elem_block(tplg, base, size,
 			SND_SOC_TPLG_TYPE_PDATA, "data");
+	case SND_TPLG_TYPE_BE_DAI:
+		return write_elem_block(tplg, base, size,
+			SND_SOC_TPLG_TYPE_BE_DAI, "be_dai");
 	default:
 		return -EINVAL;
 	}
@@ -293,6 +296,14 @@ int tplg_write_data(snd_tplg_t *tplg)
 		return ret;
 	}
 
+	/* write be dai elems */
+	ret = write_block(tplg, &tplg->be_dai_list,
+		SND_TPLG_TYPE_BE_DAI);
+	if (ret < 0) {
+		SNDERR("failed to write be dai elems %d\n", ret);
+		return ret;
+	}
+
 	/* write be elems */
 	ret = write_block(tplg, &tplg->be_list,
 		SND_TPLG_TYPE_BE);
diff --git a/src/topology/parser.c b/src/topology/parser.c
index 02c19dd..ff1c3cf 100644
--- a/src/topology/parser.c
+++ b/src/topology/parser.c
@@ -279,6 +279,10 @@ static int tplg_build_integ(snd_tplg_t *tplg)
 	if (err <  0)
 		return err;
 
+	err = tplg_build_be_dais(tplg, SND_TPLG_TYPE_BE_DAI);
+	if (err <  0)
+		return err;
+
 	err = tplg_build_link_cfg(tplg, SND_TPLG_TYPE_BE);
 	if (err <  0)
 		return err;
diff --git a/src/topology/pcm.c b/src/topology/pcm.c
index 42efe4a..65f7102 100644
--- a/src/topology/pcm.c
+++ b/src/topology/pcm.c
@@ -97,6 +97,62 @@ int tplg_build_pcm(snd_tplg_t *tplg, unsigned int type)
 	return 0;
 }
 
+static int tplg_build_be_dai(snd_tplg_t *tplg, struct tplg_elem *elem)
+{
+	struct tplg_ref *ref;
+	struct list_head *base, *pos;
+	int err = 0;
+
+	/* get playback & capture stream caps */
+	err = tplg_build_stream_caps(tplg, elem->id, elem->be_dai->caps);
+	if (err < 0)
+		return err;
+
+	/* get private data */
+	base = &elem->ref_list;
+	list_for_each(pos, base) {
+
+		ref = list_entry(pos, struct tplg_ref, list);
+
+		if (ref->type == SND_TPLG_TYPE_DATA) {
+			err = tplg_copy_data(tplg, elem, ref);
+			if (err < 0)
+				return err;
+		}
+	}
+
+	/* add BE DAI to manifest */
+	tplg->manifest.be_dai_elems++;
+
+	return 0;
+}
+
+
+
+/* build BE DAIs*/
+int tplg_build_be_dais(snd_tplg_t *tplg, unsigned int type)
+{
+	struct list_head *base, *pos;
+	struct tplg_elem *elem;
+	int err = 0;
+
+	base = &tplg->be_dai_list;
+	list_for_each(pos, base) {
+
+		elem = list_entry(pos, struct tplg_elem, list);
+		if (elem->type != type) {
+			SNDERR("error: invalid elem '%s'\n", elem->id);
+			return -EINVAL;
+		}
+
+		err = tplg_build_be_dai(tplg, elem);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+
 static int tplg_build_stream_cfg(snd_tplg_t *tplg,
 	struct snd_soc_tplg_stream *stream, int num_streams)
 {
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index dab0162..d90f313 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -290,6 +290,7 @@ int tplg_add_bytes(snd_tplg_t *tplg, struct snd_tplg_bytes_template *bytes_ctl,
 		   struct tplg_elem **e);
 
 int tplg_build_pcm(snd_tplg_t *tplg, unsigned int type);
+int tplg_build_be_dais(snd_tplg_t *tplg, unsigned int type);
 int tplg_build_link_cfg(snd_tplg_t *tplg, unsigned int type);
 int tplg_add_link_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t);
 int tplg_add_pcm_object(snd_tplg_t *tplg, snd_tplg_obj_template_t *t);
-- 
2.5.0
