From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7218: fix fix child-node lookup" to
	the asoc tree
Date: Thu, 16 Nov 2017 19:28:18 +0000 (GMT)
Message-ID: <20171116192818.2C39344005B@finisterre.ee.mobilebroadband>
References: <20171113111256.24140-1-johan@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 09CE1266EE4
 for <alsa-devel@alsa-project.org>; Thu, 16 Nov 2017 20:28:21 +0100 (CET)
In-Reply-To: <20171113111256.24140-1-johan@kernel.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Johan Hovold <johan@kernel.org>
Cc: alsa-devel@alsa-project.org, Support Opensource <support.opensource@diasemi.com>, Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>, stable <stable@vger.kernel.org>, linux-kernel@vger.kernel.org, Peter Ujfalusi <peter.ujfalusi@ti.com>, Mark Brown <broonie@kernel.org>, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7218: fix fix child-node lookup

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

>From bc6476d6c1edcb9b97621b5131bd169aa81f27db Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Mon, 13 Nov 2017 12:12:55 +0100
Subject: [PATCH] ASoC: da7218: fix fix child-node lookup

Fix child-node lookup during probe, which ended up searching the whole
device tree depth-first starting at the parent rather than just matching
on its children.

To make things worse, the parent codec node was also prematurely freed.

Fixes: 4d50934abd22 ("ASoC: da7218: Add da7218 codec driver")
Signed-off-by: Johan Hovold <johan@kernel.org>
Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
Cc: stable <stable@vger.kernel.org>
---
 sound/soc/codecs/da7218.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7218.c b/sound/soc/codecs/da7218.c
index b2d42ec1dcd9..56564ce90cb6 100644
--- a/sound/soc/codecs/da7218.c
+++ b/sound/soc/codecs/da7218.c
@@ -2520,7 +2520,7 @@ static struct da7218_pdata *da7218_of_to_pdata(struct snd_soc_codec *codec)
 	}
 
 	if (da7218->dev_id == DA7218_DEV_ID) {
-		hpldet_np = of_find_node_by_name(np, "da7218_hpldet");
+		hpldet_np = of_get_child_by_name(np, "da7218_hpldet");
 		if (!hpldet_np)
 			return pdata;
 
-- 
2.14.1
