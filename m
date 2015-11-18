From: mengdong.lin@linux.intel.com
Subject: [PATCH 1/4] topology: Remove unused function
	write_data_block()
Date: Wed, 18 Nov 2015 02:22:59 -0500
Message-ID: <e846462b7889ab808f641e1d7f21a6e899442696.1447825540.git.mengdong.lin@linux.intel.com>
References: <cover.1447825540.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 717B5265375
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 08:07:14 +0100 (CET)
In-Reply-To: <cover.1447825540.git.mengdong.lin@linux.intel.com>
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
Cc: Mengdong Lin <mengdong.lin@linux.intel.com>, tiwai@suse.de, mengdong.lin@intel.com, vinod.koul@intel.com, liam.r.girdwood@intel.com, subhransu.s.prusty@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

Fix gcc warning: 'write_data_block' defined but not used
[-Wunused-function].

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/topology/builder.c b/src/topology/builder.c
index 154bd63..b0ba54e 100644
--- a/src/topology/builder.c
+++ b/src/topology/builder.c
@@ -82,30 +82,6 @@ static int write_block_header(snd_tplg_t *tplg, unsigned int type,
 	return bytes;
 }
 
-static int write_data_block(snd_tplg_t *tplg, int size, int tplg_type,
-	const char *obj_name, void *data)
-{
-	int ret;
-
-	/* write the header for this block */
-	ret = write_block_header(tplg, tplg_type, 0,
-		tplg->version, 0, size, 1);
-	if (ret < 0) {
-		SNDERR("error: failed to write %s block %d\n", obj_name, ret);
-		return ret;
-	}
-
-	verbose(tplg, " %s : write %d bytes\n", obj_name, size);
-
-	ret = write(tplg->out_fd, data, size);
-	if (ret < 0) {
-		SNDERR("error: failed to write %s %d\n", obj_name, ret);
-		return ret;
-	}
-
-	return 0;
-}
-
 static int write_elem_block(snd_tplg_t *tplg,
 	struct list_head *base, int size, int tplg_type, const char *obj_name)
 {
-- 
2.5.0
