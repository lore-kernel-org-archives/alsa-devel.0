From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: Fix refcount underflow" to
	the asoc tree
Date: Mon, 18 Feb 2019 18:49:13 +0000 (GMT)
Message-ID: <20190218184913.737051128008@debutante.sirena.org.uk>
References: <20190216100927.10017-1-daniel.baluta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E3598265532
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2019 19:49:15 +0100 (CET)
In-Reply-To: <20190216100927.10017-1-daniel.baluta@nxp.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Baluta <daniel.baluta@nxp.com>
Cc: alsa-devel@alsa-project.org, "kuninori.morimoto.gx@renesas.com" <kuninori.morimoto.gx@renesas.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "S.j. Wang" <shengjiu.wang@nxp.com>, "lgirdwood@gmail.com" <lgirdwood@gmail.com>, "vicencb@gmail.com" <vicencb@gmail.com>, "tiwai@suse.com" <tiwai@suse.com>, "broonie@kernel.org" <broonie@kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: Fix refcount underflow

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

>From 461d854c0dba3cdf63cce37ffb9423eca0793a47 Mon Sep 17 00:00:00 2001
From: Daniel Baluta <daniel.baluta@nxp.com>
Date: Sat, 16 Feb 2019 10:09:42 +0000
Subject: [PATCH] ASoC: simple-card: Fix refcount underflow

of_get_child_by_name() takes a reference we'll need to drop
later so when we substitute in top we need to take a reference
as well as just assigning.

Without this patch we hit the following error:

[    1.246852] OF: ERROR: Bad of_node_put() on /sound-wm8524
[    1.262261] Hardware name: NXP i.MX8MQ EVK (DT)
[    1.266807] Workqueue: events deferred_probe_work_func
[    1.271950] Call trace:
[    1.274406]  dump_backtrace+0x0/0x158
[    1.278074]  show_stack+0x14/0x20
[    1.281396]  dump_stack+0xa8/0xcc
[    1.284717]  of_node_release+0xb0/0xc8
[    1.288474]  kobject_put+0x74/0xf0
[    1.291879]  of_node_put+0x14/0x28
[    1.295286]  __of_get_next_child+0x44/0x70
[    1.299387]  of_get_next_child+0x3c/0x60
[    1.303315]  simple_for_each_link+0x1dc/0x230
[    1.307676]  simple_probe+0x80/0x540
[    1.311256]  platform_drv_probe+0x50/0xa0

This patch is based on an earlier version posted by Kuninori Morimoto
and commit message includes explanations from Mark Brown.

https://patchwork.kernel.org/patch/10814255/

Reported-by: Vicente Bergas <vicencb@gmail.com>
Signed-off-by: Daniel Baluta <daniel.baluta@nxp.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 08df261024cf..dc18c4492955 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -445,7 +445,7 @@ static int simple_for_each_link(struct simple_priv *priv,
 	/* Check if it has dai-link */
 	node = of_get_child_by_name(top, PREFIX "dai-link");
 	if (!node) {
-		node = top;
+		node = of_node_get(top);
 		is_top = 1;
 	}
 
-- 
2.20.1
