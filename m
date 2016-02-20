From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Avoid narrow race condition on
	compr pointer" to the asoc tree
Date: Sun, 21 Feb 2016 03:10:50 +0900
Message-ID: <E1aXBzW-0001mi-RB@finisterre>
References: <1455893084-4556-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1FFF8264F0A
 for <alsa-devel@alsa-project.org>; Sat, 20 Feb 2016 19:10:56 +0100 (CET)
In-Reply-To: <1455893084-4556-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
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

   ASoC: wm_adsp: Avoid narrow race condition on compr pointer

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

>From c7dae7c4c60693286298e300b3d140c8cff46daa Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Fri, 19 Feb 2016 14:44:41 +0000
Subject: [PATCH] ASoC: wm_adsp: Avoid narrow race condition on compr pointer

There is a very small window between then wm_adsp_compr_free gets call
and when the DSP is actually powered down. If we get an IRQ from the DSP
in this window then the wm_adsp_compr pointer will be NULL. This patch
adds a check for this into the IRQ handler to avoid any issues when this
happens.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 68b85ee..cb49a63 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2845,7 +2845,7 @@ int wm_adsp_compr_handle_irq(struct wm_adsp *dsp)
 		goto out;
 	}
 
-	if (compr->stream)
+	if (compr && compr->stream)
 		snd_compr_fragment_elapsed(compr->stream);
 
 out:
-- 
2.7.0
