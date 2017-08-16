From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH 7/7] ASoC: sh: make snd_soc_ops const
Date: Wed, 16 Aug 2017 22:29:30 +0530
Message-ID: <1502902770-3758-8-git-send-email-bhumirks@gmail.com>
References: <1502902770-3758-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1502902770-3758-1-git-send-email-bhumirks@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, daniel@zonque.org, haojian.zhuang@gmail.com, robert.jarzmik@free.fr, heiko@sntech.de, krzk@kernel.org, sbkim73@samsung.com, s.nawrocki@samsung.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make this const as it is only stored in the ops field of a
snd_soc_dai_link structure, which is const.
Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/sh/migor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/sh/migor.c b/sound/soc/sh/migor.c
index 672bcd4..ecb057f 100644
--- a/sound/soc/sh/migor.c
+++ b/sound/soc/sh/migor.c
@@ -98,7 +98,7 @@ static int migor_hw_free(struct snd_pcm_substream *substream)
 	return 0;
 }
 
-static struct snd_soc_ops migor_dai_ops = {
+static const struct snd_soc_ops migor_dai_ops = {
 	.hw_params = migor_hw_params,
 	.hw_free = migor_hw_free,
 };
-- 
1.9.1
