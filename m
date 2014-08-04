From: Nicolin Chen <nicoleotsuka@gmail.com>
Subject: [PATCH 1/2] ASoC: fsl_sarc_dma: Check pair before using it
Date: Mon, 4 Aug 2014 12:19:48 +0800
Message-ID: <5a5ffb6219ec5ade81511be9dfbdbeef311f1a16.1407125653.git.nicoleotsuka@gmail.com>
References: <cover.1407125653.git.nicoleotsuka@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1407125653.git.nicoleotsuka@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@kernel.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, alsa-devel@alsa-project.org, timur@tabi.org
List-Id: alsa-devel@alsa-project.org

The patch 3117bb3109dc: "ASoC: fsl_asrc: Add ASRC ASoC CPU DAI and
platform drivers" from Jul 29, 2014, leads to the following Smatch
complaint:

sound/soc/fsl/fsl_asrc_dma.c:304 fsl_asrc_dma_shutdown()
warn: variable dereferenced before check 'pair' (see line 302)

sound/soc/fsl/fsl_asrc_dma.c
301          struct fsl_asrc_pair *pair = runtime->private_data;
302          struct fsl_asrc *asrc_priv = pair->asrc_priv;
                                          ^^^^^^^^^^^^^^^
                                            Dereference.

303
304          if (pair && asrc_priv->pair[pair->index] == pair)
                 ^^^^
                Check.

305                  asrc_priv->pair[pair->index] = NULL;
306

So we just let the driver check pair before using it.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>
---
 sound/soc/fsl/fsl_asrc_dma.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/sound/soc/fsl/fsl_asrc_dma.c b/sound/soc/fsl/fsl_asrc_dma.c
index 5b1e73e..ffc000b 100644
--- a/sound/soc/fsl/fsl_asrc_dma.c
+++ b/sound/soc/fsl/fsl_asrc_dma.c
@@ -299,9 +299,14 @@ static int fsl_asrc_dma_shutdown(struct snd_pcm_substream *substream)
 {
 	struct snd_pcm_runtime *runtime = substream->runtime;
 	struct fsl_asrc_pair *pair = runtime->private_data;
-	struct fsl_asrc *asrc_priv = pair->asrc_priv;
+	struct fsl_asrc *asrc_priv;
+
+	if (!pair)
+		return 0;
+
+	asrc_priv = pair->asrc_priv;
 
-	if (pair && asrc_priv->pair[pair->index] == pair)
+	if (asrc_priv->pair[pair->index] == pair)
 		asrc_priv->pair[pair->index] = NULL;
 
 	kfree(pair);
-- 
1.8.4
