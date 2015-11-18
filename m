From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 3/3] ASoC: core: remove SND_SOC_BYTES_EXT
Date: Wed, 18 Nov 2015 19:09:12 +0530
Message-ID: <1447853952-6414-4-git-send-email-vinod.koul@intel.com>
References: <1447853952-6414-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by alsa0.perex.cz (Postfix) with ESMTP id 59BC12654BD
 for <alsa-devel@alsa-project.org>; Wed, 18 Nov 2015 14:36:02 +0100 (CET)
In-Reply-To: <1447853952-6414-1-git-send-email-vinod.koul@intel.com>
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
Cc: liam.r.girdwood@linux.intel.com, patches.audio@intel.com, broonie@kernel.org, Vinod Koul <vinod.koul@intel.com>
List-Id: alsa-devel@alsa-project.org

Now all users are converted, remove the SND_SOC_BYTES_EXT
New users should use SND_SOC_BYTES_TLV

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/soc.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index e09673dbae1b..10607aa29b48 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -293,12 +293,6 @@
 		{.base = xbase, .num_regs = xregs,	      \
 		 .mask = xmask }) }
 
-#define SND_SOC_BYTES_EXT(xname, xcount, xhandler_get, xhandler_put) \
-{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
-	.info = snd_soc_bytes_info_ext, \
-	.get = xhandler_get, .put = xhandler_put, \
-	.private_value = (unsigned long)&(struct soc_bytes_ext) \
-		{.max = xcount} }
 #define SND_SOC_BYTES_TLV(xname, xcount, xhandler_get, xhandler_put) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.access = SNDRV_CTL_ELEM_ACCESS_TLV_READWRITE | \
-- 
1.9.1
