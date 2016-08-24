From: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
Subject: [PATCH v2 2/2] MAINTAINERS: document ASoC header files
Date: Wed, 24 Aug 2016 17:23:48 +0200
Message-ID: <20160824152348.2048-2-nicolas.iooss_linux@m4x.org>
References: <20160824152348.2048-1-nicolas.iooss_linux@m4x.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160824152348.2048-1-nicolas.iooss_linux@m4x.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

include/sound/simple_card_utils.h is handled by ASoC maintainers, as
stated in https://lkml.org/lkml/2016/8/22/307, and
include/sound/simple_card.h seems to be an ASoC file too. In the future
there will be more files named like these ones so introduce a pattern to
match them.

Signed-off-by: Nicolas Iooss <nicolas.iooss_linux@m4x.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0bbe4b105c34..3f4e8bf042b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11012,6 +11012,7 @@ S:	Supported
 F:	Documentation/devicetree/bindings/sound/
 F:	Documentation/sound/alsa/soc/
 F:	sound/soc/
+F:	include/sound/simple*card*
 F:	include/sound/soc*
 
 SOUND - DMAENGINE HELPERS
-- 
2.9.3
