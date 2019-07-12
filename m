From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] ASoC: audio-graph-card: fix type mismatch warning
Date: Fri, 12 Jul 2019 10:55:53 +0200
Message-ID: <20190712085605.4062896-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Wen Yang <wen.yang99@zte.com.cn>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The new temporary variable is lacks a 'const' annotation:

sound/soc/generic/audio-graph-card.c:87:7: error: assigning to 'u32 *' (aka 'unsigned int *') from 'const void *' discards qualifiers [-Werror,-Wincompatible-pointer-types-discards-qualifiers]

Fixes: c152f8491a8d ("ASoC: audio-graph-card: fix an use-after-free in graph_get_dai_id()")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 sound/soc/generic/audio-graph-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index c8abb86afefa..288df245b2f0 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -63,7 +63,7 @@ static int graph_get_dai_id(struct device_node *ep)
 	struct device_node *endpoint;
 	struct of_endpoint info;
 	int i, id;
-	u32 *reg;
+	const u32 *reg;
 	int ret;
 
 	/* use driver specified DAI ID if exist */
-- 
2.20.0
