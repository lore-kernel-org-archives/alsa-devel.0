From: Colin King <colin.king@canonical.com>
Subject: [PATCH] ASoC: rsnd: don't double free kctrl
Date: Thu,  8 Dec 2016 13:05:43 +0000
Message-ID: <20161208130543.11560-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, alsa-devel@alsa-project.org
Cc: linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

From: Colin Ian King <colin.king@canonical.com>

On an error, snd_ctl_add already free's kctrl, so calling snd_ctl_free_one
to free it again leads to a double free error.  Fix this by removing
the extraneous snd_ctl_free_one call.

Issue found using static analysis with CoverityScan, CID 1372908

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 sound/soc/sh/rcar/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/sh/rcar/core.c b/sound/soc/sh/rcar/core.c
index 4bd68de..99b5b08 100644
--- a/sound/soc/sh/rcar/core.c
+++ b/sound/soc/sh/rcar/core.c
@@ -1030,10 +1030,8 @@ static int __rsnd_kctrl_new(struct rsnd_mod *mod,
 		return -ENOMEM;
 
 	ret = snd_ctl_add(card, kctrl);
-	if (ret < 0) {
-		snd_ctl_free_one(kctrl);
+	if (ret < 0)
 		return ret;
-	}
 
 	cfg->update = update;
 	cfg->card = card;
-- 
2.10.2
