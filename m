From: YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH -next] ASoC: simple-card-utils: remove set but not used variable ''
Date: Sat, 23 Mar 2019 02:08:38 +0000
Message-ID: <20190323020838.107533-1-yuehaibing@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Katsuhiro Suzuki <suzuki.katsuhiro@socionext.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: YueHaibing <yuehaibing@huawei.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

Fixes gcc '-Wunused-but-set-variable' warning:

sound/soc/generic/simple-card-utils.c: In function 'asoc_simple_parse_clk':
sound/soc/generic/simple-card-utils.c:164:18: warning:
 parameter 'dai_name' set but not used [-Wunused-but-set-parameter]

It's not used since commit 0580dde59438 ("ASoC: simple-card-utils: add
asoc_simple_debug_info()"), so can be removed.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 sound/soc/generic/simple-card-utils.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 4ed68348f939..db1458a19985 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -173,10 +173,8 @@ int asoc_simple_parse_clk(struct device *dev,
 	 * see
 	 *	soc-core.c :: snd_soc_init_multicodec()
 	 */
-	if (dlc) {
+	if (dlc)
 		dai_of_node	= dlc->of_node;
-		dai_name	= dlc->dai_name;
-	}
 
 	/*
 	 * Parse dai->sysclk come from "clocks = <&xxx>"
