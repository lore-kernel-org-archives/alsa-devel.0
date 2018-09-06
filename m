From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rsnd: adg: care clock-frequency size"
	to the asoc tree
Date: Thu,  6 Sep 2018 11:44:35 +0100 (BST)
Message-ID: <20180906104435.3AE651122A1F@debutante.sirena.org.uk>
References: <87zhwv9v1f.wl-kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 9E86D267828
 for <alsa-devel@alsa-project.org>; Thu,  6 Sep 2018 12:44:35 +0200 (CEST)
In-Reply-To: <87zhwv9v1f.wl-kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rsnd: adg: care clock-frequency size

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

>From 69235ccf491d2e26aefd465c0d3ccd1e3b2a9a9c Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Thu, 6 Sep 2018 03:21:33 +0000
Subject: [PATCH] ASoC: rsnd: adg: care clock-frequency size

ADG has buffer over flow bug if DT has more than 3 clock-frequency.
This patch fixup this issue, and uses first 2 values.

	clock-frequency = <x y>;	/* this is OK */
	clock-frequency = <x y z>;	/* this is NG */

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Tested-by: Hiroyuki Yokoyama <hiroyuki.yokoyama.vx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/sh/rcar/adg.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/sh/rcar/adg.c b/sound/soc/sh/rcar/adg.c
index 3a3064dda57f..051f96405346 100644
--- a/sound/soc/sh/rcar/adg.c
+++ b/sound/soc/sh/rcar/adg.c
@@ -462,6 +462,11 @@ static void rsnd_adg_get_clkout(struct rsnd_priv *priv,
 		goto rsnd_adg_get_clkout_end;
 
 	req_size = prop->length / sizeof(u32);
+	if (req_size > REQ_SIZE) {
+		dev_err(dev,
+			"too many clock-frequency, use top %d\n", REQ_SIZE);
+		req_size = REQ_SIZE;
+	}
 
 	of_property_read_u32_array(np, "clock-frequency", req_rate, req_size);
 	req_48kHz_rate = 0;
-- 
2.19.0.rc1
