From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: Fix misleading error
	message" to the asoc tree
Date: Wed, 24 May 2017 18:03:01 +0100
Message-ID: <E1dDZgb-0008TD-St@debutante>
References: <20170524102823.8253-1-julian@jusst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 36CF226736B
 for <alsa-devel@alsa-project.org>; Wed, 24 May 2017 19:03:25 +0200 (CEST)
In-Reply-To: <20170524102823.8253-1-julian@jusst.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Julian Scheel <julian@jusst.de>
Cc: Nikita Yushchenko <nikita.yoush@cogentembedded.com>, alsa-devel@alsa-project.org, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, linux-kernel@vger.kernel.org, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: Fix misleading error message

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

>From 7ac45d1635a4cd2e99a4b11903d4a2815ca1b27b Mon Sep 17 00:00:00 2001
From: Julian Scheel <julian@jusst.de>
Date: Wed, 24 May 2017 12:28:23 +0200
Subject: [PATCH] ASoC: simple-card: Fix misleading error message

In case cpu could not be found the error message would always refer to
/codec/ not being found in DT. Fix this by catching the cpu node not found
case explicitly.

Signed-off-by: Julian Scheel <julian@jusst.de>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 2c9dedab5184..565d057f0d14 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -233,13 +233,19 @@ static int asoc_simple_card_dai_link_of(struct device_node *node,
 	snprintf(prop, sizeof(prop), "%scpu", prefix);
 	cpu = of_get_child_by_name(node, prop);
 
+	if (!cpu) {
+		ret = -EINVAL;
+		dev_err(dev, "%s: Can't find %s DT node\n", __func__, prop);
+		goto dai_link_of_err;
+	}
+
 	snprintf(prop, sizeof(prop), "%splat", prefix);
 	plat = of_get_child_by_name(node, prop);
 
 	snprintf(prop, sizeof(prop), "%scodec", prefix);
 	codec = of_get_child_by_name(node, prop);
 
-	if (!cpu || !codec) {
+	if (!codec) {
 		ret = -EINVAL;
 		dev_err(dev, "%s: Can't find %s DT node\n", __func__, prop);
 		goto dai_link_of_err;
-- 
2.11.0
