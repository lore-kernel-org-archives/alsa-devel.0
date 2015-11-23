From: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 1/3] ASoC: core: mark SND_SOC_BYTES_EXT as
	deprecated
Date: Mon, 23 Nov 2015 21:22:29 +0530
Message-ID: <1448293951-32071-2-git-send-email-vinod.koul@intel.com>
References: <1448293951-32071-1-git-send-email-vinod.koul@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by alsa0.perex.cz (Postfix) with ESMTP id 4DF4B265823
 for <alsa-devel@alsa-project.org>; Mon, 23 Nov 2015 16:48:46 +0100 (CET)
In-Reply-To: <1448293951-32071-1-git-send-email-vinod.koul@intel.com>
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

Since we have SND_SOC_BYTES_TLV control to lets devices have
larger size data sent, we do not need SND_SOC_BYTES_EXT with 512
byte limitation so mark it deprecated

Signed-off-by: Vinod Koul <vinod.koul@intel.com>
---
 include/sound/soc.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index d2a80508a048..03431e76c932 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -293,6 +293,9 @@
 		{.base = xbase, .num_regs = xregs,	      \
 		 .mask = xmask }) }
 
+/*
+ * SND_SOC_BYTES_EXT is deprecated, please USE SND_SOC_BYTES_TLV instead
+ */
 #define SND_SOC_BYTES_EXT(xname, xcount, xhandler_get, xhandler_put) \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname, \
 	.info = snd_soc_bytes_info_ext, \
-- 
1.9.1
