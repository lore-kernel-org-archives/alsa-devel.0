From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Prevent components from being bound to
	multiple cards" to the asoc tree
Date: Wed, 08 Jul 2015 20:05:22 +0100
Message-ID: <E1ZCueo-0005E2-NE@debutante>
References: <1436381264-6924-1-git-send-email-lars@metafoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 76821265A72
 for <alsa-devel@alsa-project.org>; Wed,  8 Jul 2015 21:05:29 +0200 (CEST)
In-Reply-To: <1436381264-6924-1-git-send-email-lars@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Lars-Peter Clausen <lars@metafoo.de>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Prevent components from being bound to multiple cards

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

>From 1b7c12316982f74a5b8e7704c24cf5524d0723a3 Mon Sep 17 00:00:00 2001
From: Lars-Peter Clausen <lars@metafoo.de>
Date: Wed, 8 Jul 2015 20:47:43 +0200
Subject: [PATCH] ASoC: Prevent components from being bound to multiple cards

A component can only be bound to a single card at a time. Binding it to
card while it is already bound to another will result in undefined
behavior.

As the undefined behavior might only manifest itself later on it is not
necessarily always straight forward to find the cause. To prevent this add
a check that refuses to bind a component to multiple cards as well as
prints a error describing the problem.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 6ce621749f8d..96bb71aea529 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1102,9 +1102,19 @@ static int soc_probe_component(struct snd_soc_card *card,
 	struct snd_soc_dai *dai;
 	int ret;
 
-	if (!strcmp(component->name, "snd-soc-dummy") || component->probed)
+	if (!strcmp(component->name, "snd-soc-dummy"))
 		return 0;
 
+	if (component->probed) {
+		if (component->card != card) {
+			dev_err(component->dev,
+				"Trying to bind component to card \"%s\" but is already bound to card \"%s\"\n",
+				card->name, component->card->name);
+			return -ENODEV;
+		}
+		return 0;
+	}
+
 	component->card = card;
 	dapm->card = card;
 	soc_set_name_prefix(card, component);
-- 
2.1.4
