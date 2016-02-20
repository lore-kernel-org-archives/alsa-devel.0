From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Explicitly set the control
	access flags in all cases" to the asoc tree
Date: Sun, 21 Feb 2016 03:10:49 +0900
Message-ID: <E1aXBzV-0001mG-Fs@finisterre>
References: <1455893084-4556-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id D143F2650BC
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 19:11:05 +0100 (CET)
In-Reply-To: <1455893084-4556-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

   ASoC: wm_adsp: Explicitly set the control access flags in all cases

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

>From cc815c4b86d14630a7d4ca4f4c7d2c2acb88cb52 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Fri, 19 Feb 2016 14:44:42 +0000
Subject: [PATCH] ASoC: wm_adsp: Explicitly set the control access flags in all
 cases

In the case where the firmware does not tell us the access flags for the
control, we let ALSA select a default (READWRITE). But really we should
be applying the volatile flag in this case, as we will read the control
from the DSP if it is on in this case. This patch explicitly sets the
access flags in all cases.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index cb49a63..ff0ce6ba 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -857,6 +857,9 @@ static int wmfw_add_ctl(struct wm_adsp *dsp, struct wm_coeff_ctl *ctl)
 			kcontrol->access |= SNDRV_CTL_ELEM_ACCESS_READ;
 		if (ctl->flags & WMFW_CTL_FLAG_VOLATILE)
 			kcontrol->access |= SNDRV_CTL_ELEM_ACCESS_VOLATILE;
+	} else {
+		kcontrol->access = SNDRV_CTL_ELEM_ACCESS_READWRITE;
+		kcontrol->access |= SNDRV_CTL_ELEM_ACCESS_VOLATILE;
 	}
 
 	ret = snd_soc_add_card_controls(dsp->card,
-- 
2.7.0
