From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: simple-card-utils: support snd_soc_get_dai_id()" to the asoc tree
Date: Wed, 24 May 2017 18:44:51 +0100
Message-ID: <E1dDaL5-0003Gl-Uq@debutante>
References: <87bmqrosla.wl%kuninori.morimoto.gx@renesas.com>
Return-path: <linux-renesas-soc-owner@vger.kernel.org>
In-Reply-To: <87bmqrosla.wl%kuninori.morimoto.gx@renesas.com>
Sender: linux-renesas-soc-owner@vger.kernel.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Mark Brown <broonie@kernel.org>Mark Brown <broonie@kernel.org>, Archit Taneja <architt@codeaurora.org>, Jose Abreu <joabreu@synopsys.com>, Linux-ALSA <alsa-devel@alsa-project.org>, Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>, Simon <horms@verge.net.au>alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: simple-card-utils: support snd_soc_get_dai_id()

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

>From 73b17f1a65c881fcf97109d77056006da2d40152 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 18 May 2017 01:39:44 +0000
Subject: [PATCH] ASoC: simple-card-utils: support snd_soc_get_dai_id()

ALSA SoC needs to know connected DAI ID for detecting.
It is not a big problem if device/driver was only for sound,
but getting DAI ID will be difficult if device includes both
Video/Sound, like HDMI.
To solve this issue, this patch adds new snd_soc_get_dai_id() and
its related .of_xlate_dai_id callback on component driver.
In below case, we can handle Sound port (= port@2) as ID = 0
if .of_xlate_dai_id has its support.

	hdmi {
		port@0 { /* VIDEO */ };
		port@1 { /* VIDEO */ };
		port@2 { /* SOUND */ };
	};

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/generic/simple-card-utils.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/sound/soc/generic/simple-card-utils.c b/sound/soc/generic/simple-card-utils.c
index 5a3d51e45938..fe726e83d0bd 100644
--- a/sound/soc/generic/simple-card-utils.c
+++ b/sound/soc/generic/simple-card-utils.c
@@ -177,9 +177,18 @@ static int asoc_simple_card_get_dai_id(struct device_node *ep)
 	struct device_node *node;
 	struct device_node *endpoint;
 	int i, id;
+	int ret;
+
+	ret = snd_soc_get_dai_id(ep);
+	if (ret != -ENOTSUPP)
+		return ret;
 
 	node = of_graph_get_port_parent(ep);
 
+	/*
+	 * Non HDMI sound case, counting port/endpoint on its DT
+	 * is enough. Let's count it.
+	 */
 	i = 0;
 	id = -1;
 	for_each_endpoint_of_node(node, endpoint) {
-- 
2.11.0
