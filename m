From: Bhumika Goyal <bhumirks@gmail.com>
Subject: [PATCH] ASoC: kirkwood: make kirkwood_soc_platform const
Date: Wed, 27 Sep 2017 21:35:47 +0530
Message-ID: <1506528347-4370-1-git-send-email-bhumirks@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: julia.lawall@lip6.fr, lgirdwood@gmail.com, broonie@kernel.org, perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: Bhumika Goyal <bhumirks@gmail.com>
List-Id: alsa-devel@alsa-project.org

Make kirkwood_soc_platform const as it only passed to a const argument
of the function snd_soc_register_platform in the file referencing it.
Make the declaration const too.

Done using Coccinelle.

Signed-off-by: Bhumika Goyal <bhumirks@gmail.com>
---
 sound/soc/kirkwood/kirkwood-dma.c | 2 +-
 sound/soc/kirkwood/kirkwood.h     | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/kirkwood/kirkwood-dma.c b/sound/soc/kirkwood/kirkwood-dma.c
index cf23af1..505b0ff 100644
--- a/sound/soc/kirkwood/kirkwood-dma.c
+++ b/sound/soc/kirkwood/kirkwood-dma.c
@@ -318,7 +318,7 @@ static void kirkwood_dma_free_dma_buffers(struct snd_pcm *pcm)
 	}
 }
 
-struct snd_soc_platform_driver kirkwood_soc_platform = {
+const struct snd_soc_platform_driver kirkwood_soc_platform = {
 	.ops		= &kirkwood_dma_ops,
 	.pcm_new	= kirkwood_dma_new,
 	.pcm_free	= kirkwood_dma_free_dma_buffers,
diff --git a/sound/soc/kirkwood/kirkwood.h b/sound/soc/kirkwood/kirkwood.h
index 90e32a7..783cb1a4 100644
--- a/sound/soc/kirkwood/kirkwood.h
+++ b/sound/soc/kirkwood/kirkwood.h
@@ -143,6 +143,6 @@ struct kirkwood_dma_data {
 	int burst;
 };
 
-extern struct snd_soc_platform_driver kirkwood_soc_platform;
+extern const struct snd_soc_platform_driver kirkwood_soc_platform;
 
 #endif
-- 
1.9.1
