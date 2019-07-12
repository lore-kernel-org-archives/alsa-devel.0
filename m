From: Nathan Chancellor <natechancellor@gmail.com>
Subject: [PATCH] ASoC: audio-graph-card: Constify reg in graph_get_dai_id
Date: Thu, 11 Jul 2019 18:43:57 -0700
Message-ID: <20190712014357.84245-1-natechancellor@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
Cc: Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Wen Yang <wen.yang99@zte.com.cn>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, Nathan Chancellor <natechancellor@gmail.com>
List-Id: alsa-devel@alsa-project.org

clang errors:

sound/soc/generic/audio-graph-card.c:87:7: error: assigning to 'u32 *'
(aka 'unsigned int *') from 'const void *' discards qualifiers
[-Werror,-Wincompatible-pointer-types-discards-qualifiers]
                reg = of_get_property(node, "reg", NULL);
                    ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
1 error generated.

Move the declaration up a bit to keep the reverse christmas tree look.

Fixes: c152f8491a8d ("ASoC: audio-graph-card: fix an use-after-free in graph_get_dai_id()")
Link: https://github.com/ClangBuiltLinux/linux/issues/599
Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>
---
 sound/soc/generic/audio-graph-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/audio-graph-card.c b/sound/soc/generic/audio-graph-card.c
index c8abb86afefa..c0d262a2ce2c 100644
--- a/sound/soc/generic/audio-graph-card.c
+++ b/sound/soc/generic/audio-graph-card.c
@@ -62,8 +62,8 @@ static int graph_get_dai_id(struct device_node *ep)
 	struct device_node *node;
 	struct device_node *endpoint;
 	struct of_endpoint info;
+	const u32 *reg;
 	int i, id;
-	u32 *reg;
 	int ret;
 
 	/* use driver specified DAI ID if exist */
-- 
2.22.0
