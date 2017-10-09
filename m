From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cygnus: Remove unnecessary active_slots
	check" to the asoc tree
Date: Mon, 09 Oct 2017 09:50:09 +0100
Message-ID: <E1e1TlJ-0006TB-QE@debutante>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E505426716A
 for <alsa-devel@alsa-project.org>; Mon,  9 Oct 2017 10:50:10 +0200 (CEST)
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
To: Christos Gkekas <chris.gekas@gmail.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cygnus: Remove unnecessary active_slots check

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

>From 4c75968a1bbfb3f190e2e624c83929451e4730ac Mon Sep 17 00:00:00 2001
From: Christos Gkekas <chris.gekas@gmail.com>
Date: Sun, 8 Oct 2017 19:20:30 +0100
Subject: [PATCH] ASoC: cygnus: Remove unnecessary active_slots check

Variable active_slots is unsigned so checking whether it is less than
zero is not necessary.

Signed-off-by: Christos Gkekas <chris.gekas@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/bcm/cygnus-ssp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/bcm/cygnus-ssp.c b/sound/soc/bcm/cygnus-ssp.c
index cd8aef8ed8a5..abafadc0b534 100644
--- a/sound/soc/bcm/cygnus-ssp.c
+++ b/sound/soc/bcm/cygnus-ssp.c
@@ -986,7 +986,7 @@ static int cygnus_set_dai_tdm_slot(struct snd_soc_dai *cpu_dai,
 
 	active_slots = hweight32(tx_mask);
 
-	if ((active_slots < 0) || (active_slots > 16))
+	if (active_slots > 16)
 		return -EINVAL;
 
 	/* Slot value must be even */
-- 
2.14.1
