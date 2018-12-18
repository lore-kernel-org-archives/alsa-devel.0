From: Mark Brown <broonie@kernel.org>
Subject: Applied "MAINTAINERS: Add entry for sound/soc/ti and
	update the OMAP audio support" to the asoc tree
Date: Tue, 18 Dec 2018 12:23:47 +0000 (GMT)
Message-ID: <20181218122347.1DB5811254FF@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id AF0B8267AC5
 for <alsa-devel@alsa-project.org>; Tue, 18 Dec 2018 13:23:47 +0100 (CET)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Peter Ujfalusi <peter.ujfalusi@ti.com>
Cc: Tony Lindgren <tony@atomide.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   MAINTAINERS: Add entry for sound/soc/ti and update the OMAP audio support

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

>From ca1c4d6535249ad43068834687f78d0db82d9e2e Mon Sep 17 00:00:00 2001
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Date: Mon, 17 Dec 2018 14:21:35 +0200
Subject: [PATCH] MAINTAINERS: Add entry for sound/soc/ti and update the OMAP
 audio support

The sound/soc/davinci and omap directories are merged under sound/soc/ti.

Add myself as maintainer and update the OMAP audio support section with the
new path and file names.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
Acked-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 MAINTAINERS | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index ef17863af710..a6068f1f4b81 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10710,7 +10710,10 @@ M:	Jarkko Nikula <jarkko.nikula@bitmer.com>
 L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
 L:	linux-omap@vger.kernel.org
 S:	Maintained
-F:	sound/soc/omap/
+F:	sound/soc/ti/omap*
+F:	sound/soc/ti/rx51.c
+F:	sound/soc/ti/n810.c
+F:	sound/soc/ti/sdma-pcm.*
 
 OMAP CLOCK FRAMEWORK SUPPORT
 M:	Paul Walmsley <paul@pwsan.com>
@@ -14737,6 +14740,12 @@ F:	Documentation/devicetree/bindings/clock/ti,sci-clk.txt
 F:	drivers/clk/keystone/sci-clk.c
 F:	drivers/reset/reset-ti-sci.c
 
+Texas Instruments ASoC drivers
+M:	Peter Ujfalusi <peter.ujfalusi@ti.com>
+L:	alsa-devel@alsa-project.org (moderated for non-subscribers)
+S:	Maintained
+F:	sound/soc/ti/
+
 THANKO'S RAREMONO AM/FM/SW RADIO RECEIVER USB DRIVER
 M:	Hans Verkuil <hverkuil@xs4all.nl>
 L:	linux-media@vger.kernel.org
-- 
2.19.0.rc2
