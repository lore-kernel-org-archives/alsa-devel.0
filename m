From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: fsl_ssi: Provide register I/O functions
	by default
Date: Fri, 19 Jul 2013 11:55:34 +0100
Message-ID: <1374231334-8400-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 7924B26566A
 for <alsa-devel@alsa-project.org>; Fri, 19 Jul 2013 12:55:40 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Timur Tabi <timur@tabi.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, linaro-kernel@lists.linaro.org, Mark Brown <broonie@linaro.org>
List-Id: alsa-devel@alsa-project.org

From: Mark Brown <broonie@linaro.org>

Use the ARM version by default as that's the more generally portable
one, it doesn't matter if they work well on random platforms when the
goal is only build coverage.

Signed-off-by: Mark Brown <broonie@linaro.org>
---
 sound/soc/fsl/fsl_ssi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
index c9974a4..e12a997 100644
--- a/sound/soc/fsl/fsl_ssi.c
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -36,7 +36,7 @@
 #define read_ssi(addr)			 in_be32(addr)
 #define write_ssi(val, addr)		 out_be32(addr, val)
 #define write_ssi_mask(addr, clear, set) clrsetbits_be32(addr, clear, set)
-#elif defined ARM
+#else
 #define read_ssi(addr)			 readl(addr)
 #define write_ssi(val, addr)		 writel(val, addr)
 /*
-- 
1.8.3.2
