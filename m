From: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Subject: [PATCH] topology: Add support for writing manifest
	private data.
Date: Tue,  4 Aug 2015 18:09:46 +0100
Message-ID: <1438708186-16263-1-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 100E72659DD
 for <alsa-devel@alsa-project.org>; Tue,  4 Aug 2015 19:09:53 +0200 (CEST)
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
Cc: Takashi Iwai <tiwai@suse.de>, Mengdong Lin <mengdong.lin@intel.com>, Mark Brown <broonie@kernel.org>, Liam Girdwood <liam.r.girdwood@linux.intel.com>
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

Allow manifest to contain private data and write this data to file.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>
Signed-off-by: Liam Girdwood <liam.r.girdwood@linux.intel.com>
---
 src/topology/builder.c    | 37 ++++++++++++++++++++++++++++++++-----
 src/topology/tplg_local.h |  1 +
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/src/topology/builder.c b/src/topology/builder.c
index 0066b22..a944866 100644
--- a/src/topology/builder.c
+++ b/src/topology/builder.c
@@ -226,9 +226,6 @@ static int write_block(snd_tplg_t *tplg, struct list_head *base,
 	case OBJECT_TYPE_CC:
 		return write_elem_block(tplg, base, size,
 			SND_SOC_TPLG_TYPE_DAI_LINK, "cc");
-	case OBJECT_TYPE_MANIFEST:
-		return write_data_block(tplg, size, SND_SOC_TPLG_TYPE_MANIFEST,
-			"manifest", &tplg->manifest);
 	case OBJECT_TYPE_DATA:
 		return write_elem_block(tplg, base, size,
 			SND_SOC_TPLG_TYPE_PDATA, "data");
@@ -239,13 +236,43 @@ static int write_block(snd_tplg_t *tplg, struct list_head *base,
 	return 0;
 }
 
+/* write the manifest including its private data */
+static int write_manifest_data(snd_tplg_t *tplg)
+{
+	int ret;
+
+	/* write the header for this block */
+	ret = write_block_header(tplg, SND_SOC_TPLG_TYPE_MANIFEST, 0,
+		SND_SOC_TPLG_ABI_VERSION, 0,
+		sizeof(tplg->manifest) + tplg->manifest.priv.size, 1);
+	if (ret < 0) {
+		SNDERR("error: failed to write manifest block %d\n", ret);
+		return ret;
+	}
+
+	verbose(tplg, "manifest : write %d bytes\n", sizeof(tplg->manifest));
+	ret = write(tplg->out_fd, &tplg->manifest, sizeof(tplg->manifest));
+	if (ret < 0) {
+		SNDERR("error: failed to write manifest %d\n", ret);
+		return ret;
+	}
+
+	verbose(tplg, "manifest : write %d priv bytes\n", tplg->manifest.priv.size);
+	ret = write(tplg->out_fd, tplg->manifest_pdata, tplg->manifest.priv.size);
+	if (ret < 0) {
+		SNDERR("error: failed to write manifest priv data %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 int tplg_write_data(snd_tplg_t *tplg)
 {
 	int ret;
 
 	/* write manifest */
-	ret = write_data_block(tplg, sizeof(tplg->manifest),
-		OBJECT_TYPE_MANIFEST, "manifest", &tplg->manifest);
+	ret = write_manifest_data(tplg);
 	if (ret < 0) {
 		SNDERR("failed to write manifest %d\n", ret);
 		return ret;
diff --git a/src/topology/tplg_local.h b/src/topology/tplg_local.h
index 62788e4..ad38945 100644
--- a/src/topology/tplg_local.h
+++ b/src/topology/tplg_local.h
@@ -77,6 +77,7 @@ struct snd_tplg {
 
 	/* manifest */
 	struct snd_soc_tplg_manifest manifest;
+	const void *manifest_pdata;	/* copied by builder at file write */
 
 	/* list of each element type */
 	struct list_head tlv_list;
-- 
2.1.4
