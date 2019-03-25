From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: AMD: Fix incorrect extern" to the asoc
	tree
Date: Mon, 25 Mar 2019 12:22:08 +0000 (GMT)
Message-ID: <20190325122208.8E35A11288F1@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id ABF08F808F6
 for <alsa-devel@alsa-project.org>; Mon, 25 Mar 2019 13:22:10 +0100 (CET)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Andi Kleen <ak@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: AMD: Fix incorrect extern

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

>From eddb6084305e5418ce28b8379a6c3d0058a61463 Mon Sep 17 00:00:00 2001
From: Andi Kleen <ak@linux.intel.com>
Date: Thu, 21 Mar 2019 15:00:05 -0700
Subject: [PATCH] ASoC: AMD: Fix incorrect extern

When using bare externs outside include files that types should
at least match. This fixes a type confusion between bool
and int.

Cc: broonie@kernel.org
Signed-off-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/amd/acp-da7219-max98357a.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp-da7219-max98357a.c b/sound/soc/amd/acp-da7219-max98357a.c
index f37a588ba345..8a619a75b3a9 100644
--- a/sound/soc/amd/acp-da7219-max98357a.c
+++ b/sound/soc/amd/acp-da7219-max98357a.c
@@ -47,7 +47,7 @@
 
 static struct snd_soc_jack cz_jack;
 static struct clk *da7219_dai_clk;
-extern int bt_uart_enable;
+extern bool bt_uart_enable;
 
 static int cz_da7219_init(struct snd_soc_pcm_runtime *rtd)
 {
-- 
2.20.1
