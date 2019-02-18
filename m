From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card: fixup refcount_t
	underflow" to the asoc tree
Date: Mon, 18 Feb 2019 18:52:18 +0000 (GMT)
Message-ID: <20190218185218.CBA0F1128008@debutante.sirena.org.uk>
References: <878syh8svy.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9505226552B
 for <alsa-devel@alsa-project.org>; Mon, 18 Feb 2019 19:52:20 +0100 (CET)
In-Reply-To: <878syh8svy.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai <tiwai@suse.com>, Vicente Bergas <vicencb@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card: fixup refcount_t underflow

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

>From 19dd0777773ab17b4d97f7105e836867c0cdecb4 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Fri, 15 Feb 2019 15:31:29 +0900
Subject: [PATCH] ASoC: simple-card: fixup refcount_t underflow

commit da215354eb55c ("ASoC: simple-card: merge simple-scu-card")
merged simple-card and simple-scu-card. Then it had refcount
underflow bug. This patch fixup it.
We will get below error without this patch.

	OF: ERROR: Bad of_node_put() on /sound
	CPU: 3 PID: 237 Comm: kworker/3:1 Not tainted 5.0.0-rc6+ #1514
	Hardware name: Renesas H3ULCB Kingfisher board based on r8a7795 ES2.0+ (DT)
	Workqueue: events deferred_probe_work_func
	Call trace:
	 dump_backtrace+0x0/0x150
	 show_stack+0x24/0x30
	 dump_stack+0xb0/0xec
	 of_node_release+0xd0/0xd8
	 kobject_put+0x74/0xe8
	 of_node_put+0x24/0x30
	 __of_get_next_child+0x50/0x70
	 of_get_next_child+0x40/0x68
	 asoc_simple_card_probe+0x604/0x730
	 platform_drv_probe+0x58/0xa8
	 ...
Reported-by: Vicente Bergas <vicencb@gmail.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/generic/simple-card.c b/sound/soc/generic/simple-card.c
index 37e001cf9cd1..3fe34417ec89 100644
--- a/sound/soc/generic/simple-card.c
+++ b/sound/soc/generic/simple-card.c
@@ -462,7 +462,7 @@ static int asoc_simple_card_parse_of(struct simple_card_data *priv)
 	conf_idx	= 0;
 	node = of_get_child_by_name(top, PREFIX "dai-link");
 	if (!node) {
-		node = dev->of_node;
+		node = of_node_get(top);
 		loop = 0;
 	}
 
-- 
2.20.1
