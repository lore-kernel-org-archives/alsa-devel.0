From: Mark Brown <broonie@kernel.org>
Subject: Applied "MAINTAINERS: add entry for STI audio drivers"
	to the asoc tree
Date: Fri, 20 Jul 2018 13:19:59 +0100
Message-ID: <E1fgUO7-0006Dw-L6@debutante>
References: <1532073771-8600-1-git-send-email-arnaud.pouliquen@st.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 438E0267762
 for <alsa-devel@alsa-project.org>; Fri, 20 Jul 2018 14:20:04 +0200 (CEST)
In-Reply-To: <1532073771-8600-1-git-send-email-arnaud.pouliquen@st.com>
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

   MAINTAINERS: add entry for STI audio drivers

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

>From e1548b1ba1643d4b5015f7168c64f240ebe114c8 Mon Sep 17 00:00:00 2001
From: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Date: Fri, 20 Jul 2018 10:02:50 +0200
Subject: [PATCH] MAINTAINERS: add entry for STI audio drivers

Add sound/soc/sti drivers entry for STI audio drivers from
ST Microelectronics.

Signed-off-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9d5eeff51b5f..b44d7167a9e9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13557,6 +13557,13 @@ L:	linux-block@vger.kernel.org
 S:	Maintained
 F:	drivers/block/skd*[ch]
 
+STI AUDIO (ASoC) DRIVERS
+M:	Arnaud Pouliquen <arnaud.pouliquen@st.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Maintained
+F:	Documentation/devicetree/bindings/sound/st,sti-asoc-card.txt
+F:	sound/soc/sti/
+
 STI CEC DRIVER
 M:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
 S:	Maintained
-- 
2.18.0
