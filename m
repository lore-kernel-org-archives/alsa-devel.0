From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Return an error on write to a
	disabled volatile control" to the asoc tree
Date: Tue, 07 Mar 2017 13:27:20 +0100
Message-ID: <E1clED2-0003uw-NZ@finisterre>
References: <1488819274-9791-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D2DD2266ADA
 for <alsa-devel@alsa-project.org>; Tue,  7 Mar 2017 13:27:35 +0100 (CET)
In-Reply-To: <1488819274-9791-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

   ASoC: wm_adsp: Return an error on write to a disabled volatile control

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

>From 67430a39ca7a6af28aade5acb92d43ee257c1014 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Mon, 6 Mar 2017 16:54:33 +0000
Subject: [PATCH] ASoC: wm_adsp: Return an error on write to a disabled
 volatile control

Volatile controls should only be accessed when the firmware is active,
currently however writes to these controls will succeed, but the data
will be lost, if the firmware is powered down. Update this behaviour such
that an error is returned the same as it is for reads.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index d151224ffcca..6313b3da967b 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -899,7 +899,10 @@ static int wm_coeff_put(struct snd_kcontrol *kctl,
 
 	mutex_lock(&ctl->dsp->pwr_lock);
 
-	memcpy(ctl->cache, p, ctl->len);
+	if (ctl->flags & WMFW_CTL_FLAG_VOLATILE)
+		ret = -EPERM;
+	else
+		memcpy(ctl->cache, p, ctl->len);
 
 	ctl->set = 1;
 	if (ctl->enabled && ctl->dsp->running)
@@ -926,6 +929,8 @@ static int wm_coeff_tlv_put(struct snd_kcontrol *kctl,
 		ctl->set = 1;
 		if (ctl->enabled && ctl->dsp->running)
 			ret = wm_coeff_write_control(ctl, ctl->cache, size);
+		else if (ctl->flags & WMFW_CTL_FLAG_VOLATILE)
+			ret = -EPERM;
 	}
 
 	mutex_unlock(&ctl->dsp->pwr_lock);
-- 
2.11.0
