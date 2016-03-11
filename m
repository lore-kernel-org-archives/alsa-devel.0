From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Use correct local length in
	error message" to the asoc tree
Date: Fri, 11 Mar 2016 14:24:51 +0700
Message-ID: <E1aeHRL-0002sW-2i@finisterre>
References: <1457606767-11090-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 78CBE2605D4
 for <alsa-devel@alsa-project.org>; Fri, 11 Mar 2016 08:25:02 +0100 (CET)
In-Reply-To: <1457606767-11090-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Use correct local length in error message

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

>From 5602a64318a4a6aad028141bb68e9bbd6bb5749a Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Thu, 10 Mar 2016 10:46:07 +0000
Subject: [PATCH] ASoC: wm_adsp: Use correct local length in error message

Fixes: 44029e9e1290 ("ASoC: wm_adsp: wm_coeff_{read|write}_control should use passed length")
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 36687db5da61..ba9213c0ad53 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -787,7 +787,7 @@ static int wm_coeff_read_control(struct wm_coeff_ctl *ctl,
 	ret = regmap_raw_read(dsp->regmap, reg, scratch, len);
 	if (ret) {
 		adsp_err(dsp, "Failed to read %zu bytes from %x: %d\n",
-			 ctl->len, reg, ret);
+			 len, reg, ret);
 		kfree(scratch);
 		return ret;
 	}
-- 
2.7.0
