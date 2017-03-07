From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Acknowledge controls should
	also check the DSP is running" to the asoc tree
Date: Tue, 07 Mar 2017 13:27:15 +0100
Message-ID: <E1clECx-0003u6-A0@finisterre>
References: <1488819274-9791-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 00A44266AD7
 for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2017 13:27:34 +0100 (CET)
In-Reply-To: <1488819274-9791-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Acknowledge controls should also check the DSP is running

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

>From 7b4af793a7a4f8e04175eb6600ba9c8ba855ad20 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Mon, 6 Mar 2017 16:54:34 +0000
Subject: [PATCH] ASoC: wm_adsp: Acknowledge controls should also check the DSP
 is running

We should not be writing acknowledge controls until the firmware is
running, as in the case of preloaded firmwares the DSP memory may be
unaccessible to whilst in the preloaded state. This means a write to the
control during this time could be lost.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 6313b3da967b..bbdb72f73df1 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -952,7 +952,7 @@ static int wm_coeff_put_acked(struct snd_kcontrol *kctl,
 
 	mutex_lock(&ctl->dsp->pwr_lock);
 
-	if (ctl->enabled)
+	if (ctl->enabled && ctl->dsp->running)
 		ret = wm_coeff_write_acked_control(ctl, val);
 	else
 		ret = -EPERM;
-- 
2.11.0
