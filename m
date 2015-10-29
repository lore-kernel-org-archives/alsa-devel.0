From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Fix typo in kernel doc comment for
	snd_soc_put_volsw_sx()" to the asoc tree
Date: Thu, 29 Oct 2015 09:16:46 +0900
Message-ID: <E1Zrata-0006Rx-Tf@finisterre>
References: <1446046818-19234-1-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 0714A264F30
 for <alsa-devel@alsa-project.org>; Thu, 29 Oct 2015 01:17:02 +0100 (CET)
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
To: kbuild test robot <lkp@intel.com>, Takashi Iwai <tiwai@suse.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Fix typo in kernel doc comment for snd_soc_put_volsw_sx()

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

>From c5f01a2e2791ddbaeb95d9165c1184470a07688f Mon Sep 17 00:00:00 2001
From: Takashi Iwai <tiwai@suse.de>
Date: Wed, 28 Oct 2015 16:40:18 +0100
Subject: [PATCH] ASoC: Fix typo in kernel doc comment for
 snd_soc_put_volsw_sx()

Spotted by kbuild bot:
 sound/soc/soc-ops.c:415: warning: No description found for parameter 'ucontrol'
 sound/soc/soc-ops.c:415: warning: Excess function parameter 'uinfo' description in 'snd_soc_put_volsw_sx'

Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-ops.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-ops.c b/sound/soc/soc-ops.c
index 100d92b..f8cf781 100644
--- a/sound/soc/soc-ops.c
+++ b/sound/soc/soc-ops.c
@@ -376,7 +376,7 @@ EXPORT_SYMBOL_GPL(snd_soc_get_volsw_sx);
 /**
  * snd_soc_put_volsw_sx - double mixer set callback
  * @kcontrol: mixer control
- * @uinfo: control element information
+ * @ucontrol: control element information
  *
  * Callback to set the value of a double mixer control that spans 2 registers.
  *
-- 
2.6.1
