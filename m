From: Mark Brown <broonie@kernel.org>
Subject: Applied "SoC: dwc: trivial fix of spelling mistake "unsuppted" -> "unsupported"" to the asoc tree
Date: Sun, 26 Jun 2016 13:02:48 +0100
Message-ID: <E1bH8m0-0002SP-1k@debutante>
References: <1466788493-17392-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466788493-17392-1-git-send-email-colin.king@canonical.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Colin Ian King <colin.king@canonical.com>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>Mark Brown <broonie@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Jiri Kosina <trivial@kernel.org>, Alex Deucher <alexander.deucher@amd.com>, Maruthi Srinivas Bayyavarapu <Maruthi.Bayyavarapu@amd.com>, Yitian Bu <buyitian@gmail.com>, Jose Abreu <Jose.Abreu@synopsys.com>, Jon Medhurst <tixy@linaro.org>, yitian <yitian.bu@tangramtek.com>, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   SoC: dwc: trivial fix of spelling mistake "unsuppted" -> "unsupported"

has been applied to the asoc tree at

   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

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

>From 57072ae122178416f84304fa54c4d0204c6cec1a Mon Sep 17 00:00:00 2001
From: Colin Ian King <colin.king@canonical.com>
Date: Fri, 24 Jun 2016 18:14:53 +0100
Subject: [PATCH] SoC: dwc: trivial fix of spelling mistake "unsuppted" ->
 "unsupported"

trivial fix to spelling mistake in dev_err message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/dwc/designware_i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/dwc/designware_i2s.c b/sound/soc/dwc/designware_i2s.c
index 591854e97190..dc97f4349e66 100644
--- a/sound/soc/dwc/designware_i2s.c
+++ b/sound/soc/dwc/designware_i2s.c
@@ -255,7 +255,7 @@ static int dw_i2s_hw_params(struct snd_pcm_substream *substream,
 		break;
 
 	default:
-		dev_err(dev->dev, "designware-i2s: unsuppted PCM fmt");
+		dev_err(dev->dev, "designware-i2s: unsupported PCM fmt");
 		return -EINVAL;
 	}
 
-- 
2.8.1
