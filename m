From: Mark Brown <broonie@kernel.org>
Subject: [PATCH] ASoC: max98357a: Fix build in !CONFIG_OF case
Date: Mon,  9 Feb 2015 14:38:58 +0800
Message-ID: <1423463938-27381-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F133C2604D4
 for <alsa-devel@alsa-project.org>; Mon,  9 Feb 2015 07:39:39 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, Kenneth Westfield <kwestfie@codeaurora.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/max98357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/max98357a.c b/sound/soc/codecs/max98357a.c
index 98b9153..1806333 100644
--- a/sound/soc/codecs/max98357a.c
+++ b/sound/soc/codecs/max98357a.c
@@ -120,6 +120,7 @@ static const struct of_device_id max98357a_device_id[] = {
 	{ .compatible = "maxim," DRV_NAME, },
 	{}
 };
+MODULE_DEVICE_TABLE(of, max98357a_device_id);
 #endif
 
 static struct platform_driver max98357a_platform_driver = {
@@ -135,4 +136,3 @@ module_platform_driver(max98357a_platform_driver);
 MODULE_DESCRIPTION("Maxim MAX98357A Codec Driver");
 MODULE_LICENSE("GPL v2");
 MODULE_ALIAS("platform:" DRV_NAME);
-MODULE_DEVICE_TABLE(of, max98357a_device_id);
-- 
2.1.4
