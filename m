From: mengdong.lin@linux.intel.com
Subject: [PATCH 13/13] topology: Remove BE or CC in comments of
	physical links C API template
Date: Sun,  6 Nov 2016 13:14:43 +0800
Message-ID: <fdbdaafa8fd1f7cce5184a13428cb05f9a43a26c.1478407716.git.mengdong.lin@linux.intel.com>
References: <cover.1478407716.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 31CC92665B0
 for <alsa-devel@alsa-project.org>; Sun,  6 Nov 2016 06:13:13 +0100 (CET)
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

No longer use BE or CC in comments of C API template for physical links.
This template can be used by Backend or Codec-to-Codec DAI links but not
only for them.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/topology.h b/include/topology.h
index 66dd084..c52c580 100644
--- a/include/topology.h
+++ b/include/topology.h
@@ -988,7 +988,7 @@ struct snd_tplg_hw_config_template {
  */
 struct snd_tplg_link_template {
 	const char *name;	/*!< link name, used to match */
-	int id;	/*!< unique ID - used to match with existing BE and CC links */
+	int id;	/*!< unique ID - used to match with existing physical links */
 	const char *stream_name;        /*!< link stream name, used to match */
 
 	int num_streams;	/*!< number of configs */
-- 
2.7.4
