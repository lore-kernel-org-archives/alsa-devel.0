From: mengdong.lin@intel.com
Subject: [PATCH 2/2] topology: Add API to set a vendor specific
	version number
Date: Thu, 13 Aug 2015 16:35:00 +0800
Message-ID: <1439454900-2685-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FD5E260591
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 10:21:39 +0200 (CEST)
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
Cc: tiwai@suse.de, Mengdong Lin <mengdong.lin@intel.com>, broonie@kernel.org, liam.r.girdwood@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@intel.com>

This vendor-specific version number is optional. It will be written to
the 'version' field of each block header of the binary toplogy data file.
The vendor driver can check this number for further processing in kernel.

The topology ABI version number is still stored in the 'abi' field of
block headers.

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/include/topology.h b/include/topology.h
index 6ff8c5f..9b84bd9 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -690,6 +690,14 @@ int snd_tplg_build(snd_tplg_t *tplg, const char *outfile);
  */
 int snd_tplg_set_manifest_data(snd_tplg_t *tplg, const void *data, int len);
 
+/**
+ * \brief Set an optional vendor specific version number.
+ * \param tplg Topology instance.
+ * \param version Vendor specific version number.
+ * \return Zero on success, otherwise a negative error code
+ */
+int snd_tplg_set_version(snd_tplg_t *tplg, unsigned int version);
+
 /* \} */
 
 #ifdef __cplusplus
diff --git a/src/topology/builder.c b/src/topology/builder.c
index 3bccd44..2f01137 100644
--- a/src/topology/builder.c
+++ b/src/topology/builder.c
@@ -89,7 +89,7 @@ static int write_data_block(snd_tplg_t *tplg, int size, int tplg_type,
 
 	/* write the header for this block */
 	ret = write_block_header(tplg, tplg_type, 0,
-		SND_SOC_TPLG_ABI_VERSION, 0, size, 1);
+		tplg->version, 0, size, 1);
 	if (ret < 0) {
 		SNDERR("error: failed to write %s block %d\n", obj_name, ret);
 		return ret;
@@ -125,7 +125,7 @@ static int write_elem_block(snd_tplg_t *tplg,
 	}
 
 	ret = write_block_header(tplg, tplg_type, vendor_type,
-		SND_SOC_TPLG_ABI_VERSION, 0, size, count);
+		tplg->version, 0, size, count);
 	if (ret < 0) {
 		SNDERR("error: failed to write %s block %d\n",
 			obj_name, ret);
@@ -243,7 +243,7 @@ static int write_manifest_data(snd_tplg_t *tplg)
 
 	/* write the header for this block */
 	ret = write_block_header(tplg, SND_SOC_TPLG_TYPE_MANIFEST, 0,
-		SND_SOC_TPLG_ABI_VERSION, 0,
+		tplg->version, 0,
 		sizeof(tplg->manifest) + tplg->manifest.priv.size, 1);
 	if (ret < 0) {
 		SNDERR("error: failed to write manifest block %d\n", ret);
diff --git a/src/topology/parser.c b/src/topology/parser.c
index 7ca244c..c0ab5e4 100644
--- a/src/topology/parser.c
+++ b/src/topology/parser.c
@@ -362,6 +362,13 @@ int snd_tplg_set_manifest_data(snd_tplg_t *tplg, const void *data, int len)
 	return 0;
 }
 
+int snd_tplg_set_version(snd_tplg_t *tplg, unsigned int version)
+{
+	tplg->version = version;
+
+	return 0;
+}
+
 void snd_tplg_verbose(snd_tplg_t *tplg, int verbose)
 {
 	tplg->verbose = verbose;
-- 
1.9.1
