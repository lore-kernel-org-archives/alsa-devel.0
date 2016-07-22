From: mengdong.lin@linux.intel.com
Subject: [PATCH v3 1/2] topology: Fix inaccurate message on
	failure to find a widgets's reference
Date: Fri, 22 Jul 2016 13:12:45 +0800
Message-ID: <40f24b4224783c5734f1a1636bce087022884f01.1469163116.git.mengdong.lin@linux.intel.com>
References: <cover.1469163116.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id C0C74265713
 for <alsa-devel@alsa-project.org>; Fri, 22 Jul 2016 07:07:38 +0200 (CEST)
In-Reply-To: <cover.1469163116.git.mengdong.lin@linux.intel.com>
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
Cc: tiwai@suse.de, mengdong.lin@intel.com, Mengdong Lin <mengdong.lin@linux.intel.com>, liam.r.girdwood@intel.com, shreyas.nc@intel.com
List-Id: alsa-devel@alsa-project.org

From: Mengdong Lin <mengdong.lin@linux.intel.com>

A widget may have references to control or data elements. So the message
should not only use "control" here.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/src/topology/dapm.c b/src/topology/dapm.c
index 4d343b2..e3c90d8 100644
--- a/src/topology/dapm.c
+++ b/src/topology/dapm.c
@@ -201,7 +201,7 @@ static int tplg_build_widget(snd_tplg_t *tplg,
 		}
 
 		if (!ref->elem) {
-			SNDERR("error: cannot find control '%s'"
+			SNDERR("error: cannot find '%s'"
 				" referenced by widget '%s'\n",
 				ref->id, elem->id);
 			return -EINVAL;
-- 
2.5.0
