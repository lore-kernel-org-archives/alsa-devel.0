From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: zx-tdm: remove redundant assignment to ts_width on
 error return path" to the asoc tree
Date: Thu,  1 Aug 2019 14:10:39 +0100 (BST)
Message-ID: <20190801131039.3CC712742C48@ypsilon.sirena.org.uk>
References: <20190731223234.16153-1-colin.king@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190731223234.16153-1-colin.king@canonical.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Colin Ian King <colin.king@canonical.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>, Jun Nie <jun.nie@linaro.org>, Shawn Guo <shawnguo@kernel.org>, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: zx-tdm: remove redundant assignment to ts_width on error return path

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.4

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

>From f24e41d3d04f326613d8a7ebecf72c3019826f71 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Wed, 31 Jul 2019 23:32:34 +0100
Subject: [PATCH] ASoC: zx-tdm: remove redundant assignment to ts_width on
 error return path

The value assigned to ts_width is never read on the error return path
so the assignment is redundant and can be removed.  Remove it.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Link: https://lore.kernel.org/r/20190731223234.16153-1-colin.king@canonical.com
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/zte/zx-tdm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/zte/zx-tdm.c b/sound/soc/zte/zx-tdm.c
index 5e877fe9ba7b..0e5a05b25a77 100644
--- a/sound/soc/zte/zx-tdm.c
+++ b/sound/soc/zte/zx-tdm.c
@@ -211,7 +211,6 @@ static int zx_tdm_hw_params(struct snd_pcm_substream *substream,
 		ts_width = 1;
 		break;
 	default:
-		ts_width = 0;
 		dev_err(socdai->dev, "Unknown data format\n");
 		return -EINVAL;
 	}
-- 
2.20.1
