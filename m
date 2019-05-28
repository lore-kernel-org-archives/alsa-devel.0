From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cx2072x: remove redundant assignment to pulse_len" to the asoc tree
Date: Tue, 28 May 2019 16:07:00 +0100 (BST)
Message-ID: <20190528150700.A5290440046@finisterre.sirena.org.uk>
References: <20190524214419.25075-1-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190524214419.25075-1-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: alsa-devel@alsa-project.org, Jaroslav Kysela <perex@perex.cz>, kernel-janitors@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>, Simon Ho <simon.ho@conexant.com>, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cx2072x: remove redundant assignment to pulse_len

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 9b33d2e526c53b0339ddba8b875bb8b8b3a11207 Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Fri, 24 May 2019 22:44:19 +0100
Subject: [PATCH] ASoC: cx2072x: remove redundant assignment to pulse_len

Variable pulse_len is being initialized to 1 however this value is
never read and pulse_len is being re-assigned later in a switch
statement.  Clean up the code by removing the redundant initialization.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Reviewed-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cx2072x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cx2072x.c b/sound/soc/codecs/cx2072x.c
index 23d2b25fe04c..c11a585bbf70 100644
--- a/sound/soc/codecs/cx2072x.c
+++ b/sound/soc/codecs/cx2072x.c
@@ -679,7 +679,7 @@ static int cx2072x_config_i2spcm(struct cx2072x_priv *cx2072x)
 	int is_right_j = 0;
 	int is_frame_inv = 0;
 	int is_bclk_inv = 0;
-	int pulse_len = 1;
+	int pulse_len;
 	int frame_len = cx2072x->frame_size;
 	int sample_size = cx2072x->sample_size;
 	int i2s_right_slot;
-- 
2.20.1
