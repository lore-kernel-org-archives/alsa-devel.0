From: mengdong.lin@intel.com
Subject: [PATCH v2 6/8] ASoC: topology: ABI - Add the type for
	BE DAI link
Date: Wed, 30 Sep 2015 17:32:04 +0800
Message-ID: <68a98c1c67380b058865fa8e8cb05e2377b30f14.1443605139.git.mengdong.lin@intel.com>
References: <cover.1443605139.git.mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 99159265AF0
 for <alsa-devel@alsa-project.org>; Wed, 30 Sep 2015 11:17:39 +0200 (CEST)
In-Reply-To: <cover.1443605139.git.mengdong.lin@intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org, broonie@kernel.org, tiwai@suse.de, liam.r.girdwood@intel.com, vedang.patel@intel.com, subhransu.s.prusty@intel.com, vinod.koul@intel.com, jeeja.kp@intel.com
Cc: Mengdong Lin <mengdong.lin@intel.com>
List-Id: alsa-devel@alsa-project.org

From: Vedang Patel <vedang.patel@intel.com>

Define the topology type for BE DAI link: SND_SOC_TPLG_TYPE_BACKEND_LINK.

Signed-off-by: Vedang Patel <vedang.patel@intel.com>
Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/include/uapi/sound/asoc.h b/include/uapi/sound/asoc.h
index eeb74a9c..f75fd29 100644
--- a/include/uapi/sound/asoc.h
+++ b/include/uapi/sound/asoc.h
@@ -103,7 +103,8 @@
 #define SND_SOC_TPLG_TYPE_PCM		7
 #define SND_SOC_TPLG_TYPE_MANIFEST	8
 #define SND_SOC_TPLG_TYPE_CODEC_LINK	9
-#define SND_SOC_TPLG_TYPE_PDATA		10
+#define SND_SOC_TPLG_TYPE_BACKEND_LINK	10
+#define SND_SOC_TPLG_TYPE_PDATA		11
 #define SND_SOC_TPLG_TYPE_MAX	SND_SOC_TPLG_TYPE_PDATA
 
 /* vendor block IDs - please add new vendor types to end */
-- 
1.9.1
