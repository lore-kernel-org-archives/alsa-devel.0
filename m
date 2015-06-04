From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: zte: Fix missing dev in devm operation
Date: Thu,  4 Jun 2015 17:23:10 +0100
Message-ID: <1433434990-4806-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D7DA326061E
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 18:23:15 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jun Nie <jun.nie@linaro.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/zte/zx296702-spdif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/zte/zx296702-spdif.c b/sound/soc/zte/zx296702-spdif.c
index 4a93bca232ff..11a0e46a1156 100644
--- a/sound/soc/zte/zx296702-spdif.c
+++ b/sound/soc/zte/zx296702-spdif.c
@@ -309,7 +309,7 @@ static int zx_spdif_probe(struct platform_device *pdev)
 	struct zx_spdif_info *zx_spdif;
 	int ret;
 
-	zx_spdif = devm_kzalloc(sizeof(*zx_spdif), GFP_KERNEL);
+	zx_spdif = devm_kzalloc(&pdev->dev, sizeof(*zx_spdif), GFP_KERNEL);
 	if (!zx_spdif)
 		return -ENOMEM;
 
-- 
2.1.4
