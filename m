From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: fix kernel-doc warnings in
	sound/soc/soc-ops.c" to the asoc tree
Date: Wed, 25 Nov 2015 13:00:01 +0000
Message-ID: <E1a1Zg1-0002oU-6j@debutante>
References: <1446046818-19234-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9EC05261583
 for <alsa-devel@alsa-project.org>; Wed, 25 Nov 2015 14:00:19 +0100 (CET)
In-Reply-To: <1446046818-19234-1-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Randy Dunlap <rdunlap@infradead.org>, Cc@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>Cc@alsa-project.org, Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: fix kernel-doc warnings in sound/soc/soc-ops.c

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

>From 9a11ef7ff00e08825ac970a6bda56a3ea8ab0321 Mon Sep 17 00:00:00 2001
From: Randy Dunlap <rdunlap@infradead.org>
Date: Mon, 23 Nov 2015 17:37:54 -0800
Subject: [PATCH] ASoC: fix kernel-doc warnings in sound/soc/soc-ops.c

Fix kernel-doc warnings in soc-ops.c:

..//sound/soc/soc-ops.c:415: warning: No description found for parameter 'ucontrol'
..//sound/soc/soc-ops.c:415: warning: Excess function parameter 'uinfo' description in 'snd_soc_put_volsw_sx'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc:	Liam Girdwood <lgirdwood@gmail.com>
Cc:	Mark Brown <broonie@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index ecd38e52285a..2f67ba6d7a8f 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -404,7 +404,7 @@ EXPORT_SYMBOL_GPL(snd_soc_get_volsw_sx);
 /**
  * snd_soc_put_volsw_sx - double mixer set callback
  * @kcontrol: mixer control
- * @uinfo: control element information
+ * @ucontrol: control element information
  *
  * Callback to set the value of a double mixer control that spans 2 registers.
  *
-- 
2.6.2
