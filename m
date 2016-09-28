From: Marek Vasut <marex@denx.de>
Subject: [PATCH] ASoC: trivial: system spelling fix
Date: Wed, 28 Sep 2016 12:24:10 +0200
Message-ID: <20160928102410.5369-1-marex@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 by alsa0.perex.cz (Postfix) with ESMTP id DF257266CB9
 for <alsa-devel@alsa-project.org>; Wed, 28 Sep 2016 12:24:14 +0200 (CEST)
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
Cc: Marek Vasut <marex@denx.de>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

Do s/ststem/system/ .

Signed-off-by: Marek Vasut <marex@denx.de>
Cc: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/Kconfig b/sound/soc/generic/Kconfig
index b95ae49..d023959 100644
--- a/sound/soc/generic/Kconfig
+++ b/sound/soc/generic/Kconfig
@@ -13,4 +13,4 @@ config SND_SIMPLE_SCU_CARD
 	select SND_SIMPLE_CARD_UTILS
 	help
 	  This option enables generic simple SCU sound card support.
-	  It supports DPCM of multi CPU single Codec ststem.
+	  It supports DPCM of multi CPU single Codec system.
-- 
2.9.3
