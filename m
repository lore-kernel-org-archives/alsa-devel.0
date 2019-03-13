From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: davinci-mcasp: Fix clang warning without CONFIG_PM" to the asoc tree
Date: Wed, 13 Mar 2019 15:38:55 +0000 (GMT)
Message-ID: <20190313153855.143DC1128B97@debutante.sirena.org.uk>
References: <20190307101145.636705-1-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190307101145.636705-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>Peter Ujfalusi <peter.ujfalusi@ti.com>Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Kees Cook <keescook@chromium.org>, Tony Lindgren <tony@atomide.com>, linux-kernel@vger.kernel.org, Nick Desaulniers <ndesaulniers@google.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Vishal Thanki <vishalthanki@gmail.com>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: davinci-mcasp: Fix clang warning without CONFIG_PM

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

>From 8ca5104715cfd14254ea5aecc390ae583b707607 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 7 Mar 2019 11:11:30 +0100
Subject: [PATCH] ASoC: davinci-mcasp: Fix clang warning without CONFIG_PM

Building with clang shows a variable that is only used by the
suspend/resume functions but defined outside of their #ifdef block:

sound/soc/ti/davinci-mcasp.c:48:12: error: variable 'context_regs' is not needed and will not be emitted

We commonly fix these by marking the PM functions as __maybe_unused,
but here that would grow the davinci_mcasp structure, so instead
add another #ifdef here.

Fixes: 1cc0c054f380 ("ASoC: davinci-mcasp: Convert the context save/restore to use array")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/ti/davinci-mcasp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/ti/davinci-mcasp.c b/sound/soc/ti/davinci-mcasp.c
index a3a67a8f0f54..9fbc759fdefe 100644
--- a/sound/soc/ti/davinci-mcasp.c
+++ b/sound/soc/ti/davinci-mcasp.c
@@ -45,6 +45,7 @@
 
 #define MCASP_MAX_AFIFO_DEPTH	64
 
+#ifdef CONFIG_PM
 static u32 context_regs[] = {
 	DAVINCI_MCASP_TXFMCTL_REG,
 	DAVINCI_MCASP_RXFMCTL_REG,
@@ -68,6 +69,7 @@ struct davinci_mcasp_context {
 	u32	*xrsr_regs; /* for serializer configuration */
 	bool	pm_state;
 };
+#endif
 
 struct davinci_mcasp_ruledata {
 	struct davinci_mcasp *mcasp;
-- 
2.20.1
