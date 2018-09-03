From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fix soc-core.c kernel-doc warning" to
	the asoc tree
Date: Mon,  3 Sep 2018 14:47:08 +0100 (BST)
Message-ID: <20180903134708.724C411227AE@debutante.sirena.org.uk>
References: <a75f4b8b-4e1c-bc73-1033-c49f4b30e4e5@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id A400A26789B
 for <alsa-devel@alsa-project.org>; Mon,  3 Sep 2018 15:47:09 +0200 (CEST)
In-Reply-To: <a75f4b8b-4e1c-bc73-1033-c49f4b30e4e5@infradead.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fix soc-core.c kernel-doc warning

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

>From 63a886f38dd96868e33488eccee8ed427144d397 Mon Sep 17 00:00:00 2001
From: Randy Dunlap <rdunlap@infradead.org>
Date: Sun, 2 Sep 2018 19:38:10 -0700
Subject: [PATCH] ASoC: fix soc-core.c kernel-doc warning

Fix kernel-doc warning:

../sound/soc/soc-core.c:2918: warning: Excess function parameter 'legacy_dai_naming' description in 'snd_soc_register_dais'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 2a73630d0680..e9c2304afaf1 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -2944,8 +2944,6 @@ static struct snd_soc_dai *soc_add_dai(struct snd_soc_component *component,
  * @component: The component the DAIs are registered for
  * @dai_drv: DAI driver to use for the DAIs
  * @count: Number of DAIs
- * @legacy_dai_naming: Use the legacy naming scheme and let the DAI inherit the
- *                     parent's name.
  */
 static int snd_soc_register_dais(struct snd_soc_component *component,
 				 struct snd_soc_dai_driver *dai_drv, size_t count)
-- 
2.19.0.rc1
