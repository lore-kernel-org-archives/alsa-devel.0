From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Fix a couple uninitialized ret
	variables" to the asoc tree
Date: Mon, 10 Sep 2018 12:35:18 +0100 (BST)
Message-ID: <20180910113518.430D71122D51@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D691F267847
 for <alsa-devel@alsa-project.org>; Mon, 10 Sep 2018 13:35:18 +0200 (CEST)
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
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Fix a couple uninitialized ret variables

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

>From 2e558a8127de7b2ed3302f9adcf332ba3feeadb2 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <dan.carpenter@oracle.com>
Date: Fri, 7 Sep 2018 22:40:33 +0300
Subject: [PATCH] ASoC: dapm: Fix a couple uninitialized ret variables

Smatch complains that these variables could be uninitialized.  The first
one in snd_soc_dai_link_event() is probably a false positive, because
probably we know the lists are not empty.  I would normally ignore the
warning, but GCC complains here as well so I just silenced the warning.
The "ret" in snd_soc_dapm_new_dai() does need to be initialized or it
leads to a bogus dereference in the caller.

Fixes: 3bbf5d34fd4a ("ASoC: dapm: Move error handling to snd_soc_dapm_new_control_unlocked")
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index e496bc642c99..0dcdcc23dcfd 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -3938,8 +3938,10 @@ snd_soc_dapm_new_dai(struct snd_soc_card *card, struct snd_soc_pcm_runtime *rtd,
 	dev_dbg(card->dev, "ASoC: adding %s widget\n", link_name);
 
 	w = snd_soc_dapm_new_control_unlocked(&card->dapm, &template);
-	if (IS_ERR(w))
+	if (IS_ERR(w)) {
+		ret = PTR_ERR(w);
 		goto outfree_kcontrol_news;
+	}
 
 	w->priv = rtd;
 
-- 
2.19.0.rc1
