From: Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] ASoC: dmic: Add to SND_SOC_ALL_CODECS
Date: Sun, 17 Aug 2014 12:03:05 +0200
Message-ID: <1408269785-3074-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-157.synserver.de (smtp-out-157.synserver.de
 [212.40.185.157])
 by alsa0.perex.cz (Postfix) with ESMTP id CF9DB2650D7
 for <alsa-devel@alsa-project.org>; Sun, 17 Aug 2014 12:03:11 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
Cc: alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

Improve build coverage of the dmic driver.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 sound/soc/codecs/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 8838838e..e514e98 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -56,6 +56,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_DA7213 if I2C
 	select SND_SOC_DA732X if I2C
 	select SND_SOC_DA9055 if I2C
+	select SND_SOC_DMIC
 	select SND_SOC_BT_SCO
 	select SND_SOC_ISABELLE if I2C
 	select SND_SOC_JZ4740_CODEC
-- 
1.8.0
