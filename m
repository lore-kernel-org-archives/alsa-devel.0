From: mengdong.lin@linux.intel.com
Subject: [PATCH 6/7] topology: ABI - Add voice wake up flag for
	DAI links
Date: Wed, 16 Nov 2016 14:42:58 +0800
Message-ID: <feebc45326e95cd8c090877b3e2e4c8f8f9ac997.1479277829.git.mengdong.lin@linux.intel.com>
References: <cover.1479277829.git.mengdong.lin@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by alsa0.perex.cz (Postfix) with ESMTP id 27B92266C3D
 for <alsa-devel@alsa-project.org>; Wed, 16 Nov 2016 07:41:11 +0100 (CET)
In-Reply-To: <cover.1479277829.git.mengdong.lin@linux.intel.com>
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

Add a new flag bit SND_SOC_TPLG_LNK_FLGBIT_VOICE_WAKEUP to link flags.
If a link is used for voice wake up, users can set this flag bit and
topology will set the link's 'ignore_suspend' to true.

This ABI update is backward compatible and applied in kernel. We may
rename this flag when we find a better name for this.

Signed-off-by: Mengdong Lin <mengdong.lin@linux.intel.com>

diff --git a/include/sound/asoc.h b/include/sound/asoc.h
index 1232f1e..082c542 100644
--- a/include/sound/asoc.h
+++ b/include/sound/asoc.h
@@ -146,6 +146,7 @@
 #define SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_RATES         (1 << 0)
 #define SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_CHANNELS      (1 << 1)
 #define SND_SOC_TPLG_LNK_FLGBIT_SYMMETRIC_SAMPLEBITS    (1 << 2)
+#define SND_SOC_TPLG_LNK_FLGBIT_VOICE_WAKEUP            (1 << 3)
 
 /*
  * Block Header.
-- 
2.5.0
