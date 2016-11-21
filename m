From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Only write shutdown controls
	for active firmwares" to the asoc tree
Date: Mon, 21 Nov 2016 19:20:26 +0000
Message-ID: <E1c8u8g-0007sS-83@debutante>
References: <1479751202-17749-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 48C89261A1A
 for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2016 20:20:33 +0100 (CET)
In-Reply-To: <1479751202-17749-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

   ASoC: wm_adsp: Only write shutdown controls for active firmwares

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

>From 87aa63746260e3e9db2fe6b6d8e97b55bdb63a2b Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Mon, 21 Nov 2016 18:00:02 +0000
Subject: [PATCH] ASoC: wm_adsp: Only write shutdown controls for active
 firmwares

The control list may contain shutdown controls for firmwares that are
not currently active, attempting to write this will at best fail. To
avoid this issue we skip any control that is not active.

Fixes: commit f4f0c4c60c39 ("ASoC: wm_adsp: Signal firmware shutdown
                             through event control")
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 4fb6e2f035e0..6ccb7313a0f6 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -1194,6 +1194,9 @@ static void wm_adsp_signal_event_controls(struct wm_adsp *dsp,
 		if (ctl->type != WMFW_CTL_TYPE_HOSTEVENT)
 			continue;
 
+		if (!ctl->enabled)
+			continue;
+
 		ret = wm_coeff_write_acked_control(ctl, event);
 		if (ret)
 			adsp_warn(dsp,
-- 
2.10.2
