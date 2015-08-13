From: mengdong.lin@intel.com
Subject: [PATCH 1/2] topology: Fix missing return value for
	snd_tplg_set_manifest_data()
Date: Thu, 13 Aug 2015 16:34:54 +0800
Message-ID: <1439454894-2644-1-git-send-email-mengdong.lin@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 9513A2604A1
 for <alsa-devel@alsa-project.org>; Thu, 13 Aug 2015 10:21:34 +0200 (CEST)
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

Signed-off-by: Mengdong Lin <mengdong.lin@intel.com>

diff --git a/src/topology/parser.c b/src/topology/parser.c
index ca7de06..7ca244c 100644
--- a/src/topology/parser.c
+++ b/src/topology/parser.c
@@ -358,6 +358,8 @@ int snd_tplg_set_manifest_data(snd_tplg_t *tplg, const void *data, int len)
 {
 	tplg->manifest.priv.size = len;
 	tplg->manifest_pdata = data;
+
+	return 0;
 }
 
 void snd_tplg_verbose(snd_tplg_t *tplg, int verbose)
-- 
1.9.1
