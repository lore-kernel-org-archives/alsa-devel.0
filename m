From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 1/3] ASoC: Add SND_SOC_BYTES_EXT control type
Date: Fri,  6 Jun 2014 13:33:18 +0100
Message-ID: <1402058000-5357-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 89C57265172
 for <alsa-devel@alsa-project.org>; Fri,  6 Jun 2014 14:40:50 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: lee.jones@linaro.org, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.org, sameo@linux.intel.com
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 include/sound/soc.h |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index ed9e2d7..92c1b99 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -256,6 +256,13 @@
 		((unsigned long)&(struct soc_bytes)           \
 		{.base = xbase, .num_regs = xregs }) }
 
+#define SND_SOC_BYTES_EXT(xname, xbase, xregs, xhandler_get, xhandler_put) \
+{	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname,		   \
+	.info = snd_soc_bytes_info, .get = xhandler_get,		   \
+	.put = xhandler_put, .private_value =				   \
+		((unsigned long)&(struct soc_bytes)			   \
+		{.base = xbase, .num_regs = xregs }) }
+
 #define SND_SOC_BYTES_MASK(xname, xbase, xregs, xmask)	      \
 {	.iface = SNDRV_CTL_ELEM_IFACE_MIXER, .name = xname,   \
 	.info = snd_soc_bytes_info, .get = snd_soc_bytes_get, \
-- 
1.7.2.5
