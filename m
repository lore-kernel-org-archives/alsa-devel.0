From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: remove codec hw_write/control_data" to
	the asoc tree
Date: Wed,  9 May 2018 10:45:39 +0100 (BST)
Message-ID: <20180509094539.E8ECD44007A@finisterre.ee.mobilebroadband>
References: <877exjm0ww.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3265C267706
 for <alsa-devel@alsa-project.org>; Wed,  9 May 2018 18:28:54 +0200 (CEST)
In-Reply-To: <877exjm0ww.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Lars-Peter <lars@metafoo.de>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: remove codec hw_write/control_data

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

>From 81da8a0b7975c51db482acee750a2dbcb320b97d Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 8 May 2018 03:18:11 +0000
Subject: [PATCH] ASoC: remove codec hw_write/control_data

No one is using codec hw_write/control_data any more.
Let's remove these.

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Reviewed-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 include/sound/soc.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/include/sound/soc.h b/include/sound/soc.h
index 9ea99e5d3c8e..0e1cb847f8f8 100644
--- a/include/sound/soc.h
+++ b/include/sound/soc.h
@@ -932,8 +932,6 @@ struct snd_soc_codec {
 	unsigned int cache_init:1; /* codec cache has been initialized */
 
 	/* codec IO */
-	void *control_data; /* codec control (i2c/3wire) data */
-	hw_write_t hw_write;
 	void *reg_cache;
 
 	/* component */
-- 
2.17.0
