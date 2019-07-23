From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: qcom: apq8016_sbc: Fix oops with
	multiple DAI links" to the asoc tree
Date: Tue, 23 Jul 2019 12:29:15 +0100 (BST)
Message-ID: <20190723112915.D9D222742B59@ypsilon.sirena.org.uk>
References: <20190722130352.95874-1-stephan@gerhold.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id DA28BF80448
 for <alsa-devel@alsa-project.org>; Tue, 23 Jul 2019 13:29:17 +0200 (CEST)
In-Reply-To: <20190722130352.95874-1-stephan@gerhold.net>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Stephan Gerhold <stephan@gerhold.net>
Cc: alsa-devel@alsa-project.org, Banajit Goswami <bgoswami@codeaurora.org>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Patrick Lai <plai@codeaurora.org>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: qcom: apq8016_sbc: Fix oops with multiple DAI links

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

>From 8201f11a1f75e3aa7d5327d0b1d8cb544aeaa62f Mon Sep 17 00:00:00 2001
From: Stephan Gerhold <stephan@gerhold.net>
Date: Mon, 22 Jul 2019 15:03:52 +0200
Subject: [PATCH] ASoC: qcom: apq8016_sbc: Fix oops with multiple DAI links

apq8016_sbc_parse_of() sets up multiple DAI links, depending on the
number of nodes in the device tree. However, at the moment
CPU and platform components are only allocated for the first link.
This causes an oops when more than one link is defined:

	Internal error: Oops: 96000044 [#1] SMP
	CPU: 0 PID: 1015 Comm: kworker/0:2 Not tainted 5.3.0-rc1 #4
	Call trace:
	 apq8016_sbc_platform_probe+0x1a8/0x3f0
	 platform_drv_probe+0x50/0xa0
	...

Move the allocation inside the loop to ensure that each link is
properly initialized.

Fixes: 98b232ca9e0e ("ASoC: qcom: apq8016_sbc: use modern dai_link style")
Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
Acked-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Link: https://lore.kernel.org/r/20190722130352.95874-1-stephan@gerhold.net
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/qcom/apq8016_sbc.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/sound/soc/qcom/apq8016_sbc.c b/sound/soc/qcom/apq8016_sbc.c
index f60a71990f66..ac75838bbfab 100644
--- a/sound/soc/qcom/apq8016_sbc.c
+++ b/sound/soc/qcom/apq8016_sbc.c
@@ -150,17 +150,17 @@ static struct apq8016_sbc_data *apq8016_sbc_parse_of(struct snd_soc_card *card)
 
 	link = data->dai_link;
 
-	dlc = devm_kzalloc(dev, 2 * sizeof(*dlc), GFP_KERNEL);
-	if (!dlc)
-		return ERR_PTR(-ENOMEM);
+	for_each_child_of_node(node, np) {
+		dlc = devm_kzalloc(dev, 2 * sizeof(*dlc), GFP_KERNEL);
+		if (!dlc)
+			return ERR_PTR(-ENOMEM);
 
-	link->cpus	= &dlc[0];
-	link->platforms	= &dlc[1];
+		link->cpus	= &dlc[0];
+		link->platforms	= &dlc[1];
 
-	link->num_cpus		= 1;
-	link->num_platforms	= 1;
+		link->num_cpus		= 1;
+		link->num_platforms	= 1;
 
-	for_each_child_of_node(node, np) {
 		cpu = of_get_child_by_name(np, "cpu");
 		codec = of_get_child_by_name(np, "codec");
 
-- 
2.20.1
