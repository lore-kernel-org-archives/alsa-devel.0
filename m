From: Mark Brown <broonie@kernel.org>
Subject: [PATCH 1/5] mfd: davinci_voicecodec: Remove unused
	read and write functions
Date: Sat, 31 Aug 2013 14:08:55 +0100
Message-ID: <1377954539-7532-1-git-send-email-broonie@kernel.org>
References: <20130831130741.GG18608@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 108C1261ACD
 for <alsa-devel@alsa-project.org>; Sat, 31 Aug 2013 15:09:10 +0200 (CEST)
In-Reply-To: <20130831130741.GG18608@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Samuel Ortiz <sameo@linux.intel.com>, Lee Jones <lee.jones@linaro.org>, Miguel Aguilar <miguel.aguilar@ridgerun.com>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, davinci-linux-open-source@linux.davincidsp.com, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

These functions are not referenced anywhere, nor prototyped, so just
remove them.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 drivers/mfd/davinci_voicecodec.c | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/drivers/mfd/davinci_voicecodec.c b/drivers/mfd/davinci_voicecodec.c
index fb643985..a292d71 100644
--- a/drivers/mfd/davinci_voicecodec.c
+++ b/drivers/mfd/davinci_voicecodec.c
@@ -32,17 +32,6 @@
 
 #include <linux/mfd/davinci_voicecodec.h>
 
-u32 davinci_vc_read(struct davinci_vc *davinci_vc, int reg)
-{
-	return __raw_readl(davinci_vc->base + reg);
-}
-
-void davinci_vc_write(struct davinci_vc *davinci_vc,
-					   int reg, u32 val)
-{
-	__raw_writel(val, davinci_vc->base + reg);
-}
-
 static int __init davinci_vc_probe(struct platform_device *pdev)
 {
 	struct davinci_vc *davinci_vc;
-- 
1.8.4.rc3
