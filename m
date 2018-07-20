From: Mark Brown <broonie@kernel.org>
Subject: Applied "MAINTAINERS: add entry for STM32 audio
	drivers" to the asoc tree
Date: Fri, 20 Jul 2018 13:19:39 +0100
Message-ID: <E1fgUNn-0006BQ-6I@debutante>
References: <1532073771-8600-2-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 57EA8267774
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2018 14:19:44 +0200 (CEST)
In-Reply-To: <1532073771-8600-2-git-send-email-arnaud.pouliquen@st.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, olivier.moysan@st.com, Alexandre TORGUE <alexandre.torgue@st.com>, Takashi Iwai <tiwai@suse.de>, arnaud.pouliquen@st.com, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   MAINTAINERS: add entry for STM32 audio drivers

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

>From faa80b66c767ef4995e33835e9844a5df142c6cc Mon Sep 17 00:00:00 2001
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Date: Fri, 20 Jul 2018 10:02:51 +0200
Subject: [PATCH] MAINTAINERS: add entry for STM32 audio drivers

Add sound/soc/stm drivers entry for STM32 audio drivers from
ST Microelectronics.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index b44d7167a9e9..fc711d23dc83 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13577,6 +13577,14 @@ T:	git git://linuxtv.org/media_tree.git
 S:	Maintained
 F:	drivers/media/usb/stk1160/
 
+STM32 AUDIO (ASoC) DRIVERS
+M:	Olivier Moysan <olivier.moysan@st.com>
+M:	Arnaud Pouliquen <arnaud.pouliquen@st.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/sound/st,stm32-*.txt
+F:	sound/soc/stm/
+
 STM32 TIMER/LPTIMER DRIVERS
 M:	Fabrice Gasnier <fabrice.gasnier@st.com>
 S:	Maintained
-- 
2.18.0
