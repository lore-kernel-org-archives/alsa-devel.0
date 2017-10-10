From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: remove unnecessary message
	from snd_soc_register_component()" to the asoc tree
Date: Tue, 10 Oct 2017 10:23:30 +0100
Message-ID: <E1e1ql8-0004CF-PO@debutante>
References: <87h8vim9ai.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 14A2226727C
 for <alsa-devel@alsa-project.org>; Tue, 10 Oct 2017 11:23:35 +0200 (CEST)
In-Reply-To: <87h8vim9ai.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Daniel Baluta <daniel.baluta@gmail.com>, Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org, Simon <horms@verge.net.au>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: remove unnecessary message from snd_soc_register_component()

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

>From 08e61d03b08c99f611227c6e94c70cf0029fdeb6 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 2 Oct 2017 05:10:33 +0000
Subject: [PATCH] ASoC: soc-core: remove unnecessary message from
 snd_soc_register_component()

No need to print an error message if kzalloc fails.
The core will print it.

Reported-by: Daniel Baluta <daniel.baluta@gmail.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 166b6d218fe5..a3dcf14befd8 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3445,10 +3445,8 @@ int snd_soc_register_component(struct device *dev,
 	struct snd_soc_component *component;
 
 	component = kzalloc(sizeof(*component), GFP_KERNEL);
-	if (!component) {
-		dev_err(dev, "ASoC: Failed to allocate memory\n");
+	if (!component)
 		return -ENOMEM;
-	}
 
 	return snd_soc_add_component(dev, component, component_driver,
 				     dai_drv, num_dai);
-- 
2.14.1
