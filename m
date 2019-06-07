From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Remove erroneous
	soc_cleanup_card_resources() call" to the asoc tree
Date: Fri,  7 Jun 2019 17:05:30 +0100 (BST)
Message-ID: <20190607160530.94376440046@finisterre.sirena.org.uk>
References: <20190607154926.11373-1-s.nawrocki@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 96E15F896CE
 for <alsa-devel@alsa-project.org>; Fri,  7 Jun 2019 18:05:33 +0200 (CEST)
In-Reply-To: <20190607154926.11373-1-s.nawrocki@samsung.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: alsa-devel@alsa-project.org, b.zolnierkie@samsung.com, lgirdwood@gmail.com, krzk@kernel.org, tzungbi@google.com, Mark Brown <broonie@kernel.org>, festevam@gmail.com, m.szyprowski@samsung.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Remove erroneous soc_cleanup_card_resources() call

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.3

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

>From 0779935938b1b6f492f019764bc7dda77bb08ec9 Mon Sep 17 00:00:00 2001
From: Sylwester Nawrocki <s.nawrocki@samsung.com>
Date: Fri, 7 Jun 2019 17:49:26 +0200
Subject: [PATCH] ASoC: Remove erroneous soc_cleanup_card_resources() call

When soc_init_dai_link() call at the beginning of snd_soc_instantiate_card
function fails soc_cleanup_card_resources() and then snd_soc_dapm_free()
gets called with an incompletely initialized card->dapm. In particular
card->dapm.card is NULL and it gets dereferenced in dapm_free_widgets().
Also dapm->list is invalid and there is an invalid pointer dereference
from list_del().

The function call stack (deferred probing) on Chromebook Snow where this
issue has shown up in today's -next is:

 snd_soc_dapm_free
 soc_cleanup_card_resources
 snd_soc_instantiate_card
 snd_soc_register_card
 devm_snd_soc_register_card
 snow_probe

In patch 70fc53734e71 "ASoC: core: move DAI pre-links initiation to
snd_soc_instantiate_card" there is an soc_cleanup_platform() call instead
of soc_cleanup_card_resources() as in current -next.

soc_cleanup_platform got renamed to soc_cleanup_legacy, then removed
in commit adb76b5b9c47 "ASoC: soc-core: remove legacy style dai_link".

It seems in merge conflict resolution the soc_cleanup_platform() call got
renamed to soc_cleanup_card_resources(), instead of being removed.

Correct this by removing an unnecessary soc_cleanup_card_resources() call.

Fixes: a8e992342ce4 ("Merge branch 'asoc-5.2' into asoc-5.3")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Suggested-by: Tzung-Bi Shih <tzungbi@google.com>
Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 94a36ee8eb22..f0fa289c90d8 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1986,7 +1986,6 @@ static int snd_soc_instantiate_card(struct snd_soc_card *card)
 	for_each_card_prelinks(card, i, dai_link) {
 		ret = soc_init_dai_link(card, dai_link);
 		if (ret) {
-			soc_cleanup_card_resources(card);
 			dev_err(card->dev, "ASoC: failed to init link %s: %d\n",
 				dai_link->name, ret);
 			mutex_unlock(&client_mutex);
-- 
2.20.1
