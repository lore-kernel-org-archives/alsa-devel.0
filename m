From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: [PATCH 09/10] ASoC: audio-graph-card: tidyup typo
 SND_AUDIO_GRAPH_CARD
Date: Thu, 22 Nov 2018 00:57:23 +0000
Message-ID: <87o9ailyyf.wl-kuninori.morimoto.gx@renesas.com>
References: <871s7endnu.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from JPN01-TY1-obe.outbound.protection.outlook.com
 (mail-eopbgr1400120.outbound.protection.outlook.com [40.107.140.120])
 by alsa0.perex.cz (Postfix) with ESMTP id 3189926770D
 for <alsa-devel@alsa-project.org>; Thu, 22 Nov 2018 01:57:25 +0100 (CET)
In-Reply-To: <871s7endnu.wl-kuninori.morimoto.gx@renesas.com>
Content-Language: en-US
Content-ID: <D599EDFE8A524544A9C8D19214A0BD23@jpnprd01.prod.outlook.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

1 "simple" is enough on Kconfig help

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 sound/soc/generic/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/Kconfig b/sound/soc/generic/Kconfig
index c954be0..fa5aff9 100644
--- a/sound/soc/generic/Kconfig
+++ b/sound/soc/generic/Kconfig
@@ -20,7 +20,7 @@ config SND_AUDIO_GRAPH_CARD
 	depends on OF
 	select SND_SIMPLE_CARD_UTILS
 	help
-	  This option enables generic simple simple sound card support
+	  This option enables generic simple sound card support
 	  with OF-graph DT bindings.
 
 config SND_AUDIO_GRAPH_SCU_CARD
-- 
2.7.4
