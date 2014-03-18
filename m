From: Arun Shamanna Lakshmi <aruns@nvidia.com>
Subject: [PATCH] ASoC: Add support for multi register mux
Date: Tue, 18 Mar 2014 16:51:32 -0700
Message-ID: <1395186692-11735-1-git-send-email-aruns@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: lgirdwood@gmail.com, broonie@kernel.org
Cc: perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Arun Shamanna Lakshmi <aruns@nvidia.com>, Songhee Baek <sbaek@nvidia.com>
List-Id: alsa-devel@alsa-project.org

Currently soc_enum structure supports only 2 registers (reg, reg2)
for kcontrol. However, it is possible to have multiple registers
per mux. This change allows us to control these multiple registers.

Signed-off-by: Arun Shamanna Lakshmi <aruns@nvidia.com>
Signed-off-by: Songhee Baek <sbaek@nvidia.com>
---
 include/sound/soc.h |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 9a00147..ddedfb4 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -1093,6 +1093,9 @@ struct soc_enum {
 	unsigned int mask;
 	const char * const *texts;
 	const unsigned int *values;
+	unsigned int *regs;
+	unsigned int *masks;
+	unsigned int num_regs;
 };
 
 /* codec IO */
-- 
1.7.9.5
