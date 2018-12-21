From: Mark Brown <broonie@kernel.org>
Subject: Applied "ALSA: compress: prevent potential divide by
	zero bugs" to the asoc tree
Date: Fri, 21 Dec 2018 13:42:24 +0000 (GMT)
Message-ID: <20181221134224.1E1831121B93@debutante.sirena.org.uk>
References: <20181221090658.GD2735@kadam>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id C3DA5267A78
 for <alsa-devel@alsa-project.org>; Fri, 21 Dec 2018 14:42:26 +0100 (CET)
In-Reply-To: <20181221090658.GD2735@kadam>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Patrick Lai <plai@codeaurora.org>, kernel-janitors@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Vinod Koul <vkoul@kernel.org>, Mark Brown <broonie@kernel.org>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ALSA: compress: prevent potential divide by zero bugs

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From e9d960271d89c0cabf094123e2ddc94705de2a31 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 21 Dec 2018 12:06:58 +0300
Subject: [PATCH] ALSA: compress: prevent potential divide by zero bugs

The problem is seen in the q6asm_dai_compr_set_params() function:

	ret = q6asm_map_memory_regions(dir, prtd->audio_client, prtd->phys,
				       (prtd->pcm_size / prtd->periods),
                                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
				       prtd->periods);

In this code prtd->pcm_size is the buffer_size and prtd->periods comes
from params->buffer.fragments.  If we allow the number of fragments to
be zero then it results in a divide by zero bug.  One possible fix would
be to use prtd->pcm_count directly instead of using the division to
re-calculate it.  But I decided that it doesn't really make sense to
allow zero fragments.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/core/compress_offload.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/sound/core/compress_offload.c b/sound/core/compress_offload.c
index a5b09e75e787..f7d2b373da0a 100644
--- a/sound/core/compress_offload.c
+++ b/sound/core/compress_offload.c
@@ -541,7 +541,8 @@ static int snd_compress_check_input(struct snd_compr_params *params)
 {
 	/* first let's check the buffer parameter's */
 	if (params->buffer.fragment_size == 0 ||
-	    params->buffer.fragments > INT_MAX / params->buffer.fragment_size)
+	    params->buffer.fragments > INT_MAX / params->buffer.fragment_size ||
+	    params->buffer.fragments == 0)
 		return -EINVAL;
 
 	/* now codec parameters */
-- 
2.20.1
