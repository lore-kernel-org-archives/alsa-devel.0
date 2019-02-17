From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: fsi: fix spelling mistake "doens't" -> "doesn't"
Date: Sun, 17 Feb 2019 22:48:30 +0000
Message-ID: <20190217224830.17355-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

There is a spelling mistake in a dev_err message. Fix it.

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/sh/fsi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/fsi.c b/sound/soc/sh/fsi.c
index 285afbafa662..3447dbdba1f1 100644
--- a/sound/soc/sh/fsi.c
+++ b/sound/soc/sh/fsi.c
@@ -780,7 +780,7 @@ static int fsi_clk_init(struct device *dev,
 			return -EINVAL;
 		}
 		if (clock->div == clock->own) {
-			dev_err(dev, "cpu doens't support div clock\n");
+			dev_err(dev, "cpu doesn't support div clock\n");
 			return -EINVAL;
 		}
 	}
-- 
2.20.1
