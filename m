From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: Use IS_ERR_OR_NULL()" to the
	asoc tree
Date: Mon, 07 Aug 2017 16:53:08 +0100
Message-ID: <E1dekL6-0005Tn-Vl@debutante>
References: <1502107733-29628-2-git-send-email-festevam@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 4B700267459
 for <alsa-devel@alsa-project.org>; Mon,  7 Aug 2017 17:53:16 +0200 (CEST)
In-Reply-To: <1502107733-29628-2-git-send-email-festevam@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Fabio Estevam <festevam@gmail.com>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: Use IS_ERR_OR_NULL()

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

>From d9a02c552cd69c466998e3afdf420cb4c0b9d9d9 Mon Sep 17 00:00:00 2001
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 7 Aug 2017 09:08:53 -0300
Subject: [PATCH] ASoC: soc-core: Use IS_ERR_OR_NULL()

The check of IS_ERR or NULL pointer can be replaced by IS_ERR_OR_NULL(),
which helps readability.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 558efdfd717d..07d708498500 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -495,7 +495,7 @@ static void soc_cleanup_card_debugfs(struct snd_soc_card *card)
 static void snd_soc_debugfs_init(void)
 {
 	snd_soc_debugfs_root = debugfs_create_dir("asoc", NULL);
-	if (IS_ERR(snd_soc_debugfs_root) || !snd_soc_debugfs_root) {
+	if (IS_ERR_OR_NULL(snd_soc_debugfs_root)) {
 		pr_warn("ASoC: Failed to create debugfs directory\n");
 		snd_soc_debugfs_root = NULL;
 		return;
-- 
2.13.3
