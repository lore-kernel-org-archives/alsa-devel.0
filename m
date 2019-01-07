From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: eliminate left-over from Raumfeld
	machine driver removal" to the asoc tree
Date: Mon,  7 Jan 2019 18:57:54 +0000 (GMT)
Message-ID: <20190107185754.97C541127491@debutante.sirena.org.uk>
References: <20190104185530.30920-1-daniel@zonque.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 578A2266B63
 for <alsa-devel@alsa-project.org>; Mon,  7 Jan 2019 19:57:55 +0100 (CET)
In-Reply-To: <20190104185530.30920-1-daniel@zonque.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: eliminate left-over from Raumfeld machine driver removal

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

>From e147c189c10911def4c3d98aa1111a474a64111c Mon Sep 17 00:00:00 2001
From: Daniel Mack <daniel@zonque.org>
Date: Fri, 4 Jan 2019 19:55:30 +0100
Subject: [PATCH] ASoC: eliminate left-over from Raumfeld machine driver
 removal

Commit f84a6273dd9107c ("ASoC: pxa: remove raumfeld machine driver")
removed the Raumfeld ASoC machine driver but forgot to kill one line
in the Makefile.

Signed-off-by: Daniel Mack <daniel@zonque.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/pxa/Makefile | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/pxa/Makefile b/sound/soc/pxa/Makefile
index 0ab2a9dcb720..ea4929d73318 100644
--- a/sound/soc/pxa/Makefile
+++ b/sound/soc/pxa/Makefile
@@ -30,7 +30,6 @@ snd-soc-magician-objs := magician.o
 snd-soc-mioa701-objs := mioa701_wm9713.o
 snd-soc-z2-objs := z2.o
 snd-soc-imote2-objs := imote2.o
-snd-soc-raumfeld-objs := raumfeld.o
 snd-soc-brownstone-objs := brownstone.o
 snd-soc-ttc-dkb-objs := ttc-dkb.o
 
-- 
2.20.1
