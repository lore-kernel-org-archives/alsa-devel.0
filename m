From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: soc-core: remove rtd NULL check on
	soc_free_pcm_runtime()" to the asoc tree
Date: Mon, 25 Sep 2017 17:31:21 +0100 (BST)
Message-ID: <20170925163121.9C77D440055@finisterre.ee.mobilebroadband>
References: <87ing7pnt2.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 12DD2266EE4
 for <alsa-devel@alsa-project.org>; Mon, 25 Sep 2017 18:35:00 +0200 (CEST)
In-Reply-To: <87ing7pnt2.wl%kuninori.morimoto.gx@renesas.com>
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
Cc: Simon <horms@verge.net.au>, Mark Brown <broonie@kernel.org>, Fengguang Wu <fengguang.wu@intel.com>, alsa-devel@alsa-project.org, Dan Carpenter <dan.carpenter@oracle.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: soc-core: remove rtd NULL check on soc_free_pcm_runtime()

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

>From db1721f5296704d4f706a31f5d147cf7f16e3add Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Mon, 25 Sep 2017 01:38:13 +0000
Subject: [PATCH] ASoC: soc-core: remove rtd NULL check on
 soc_free_pcm_runtime()

static soc_free_pcm_runtime() is never called with rtd == NULL.
This patch removes unnecessary rtd == NULL check from
soc_free_pcm_runtime().

Furthermore, NULL check before kfree() is not needed.
This patch removes such ckeck too.

Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index fee4b0ef5566..091ebe198194 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -639,8 +639,7 @@ static struct snd_soc_pcm_runtime *soc_new_pcm_runtime(
 
 static void soc_free_pcm_runtime(struct snd_soc_pcm_runtime *rtd)
 {
-	if (rtd && rtd->codec_dais)
-		kfree(rtd->codec_dais);
+	kfree(rtd->codec_dais);
 	snd_soc_rtdcom_del_all(rtd);
 	kfree(rtd);
 }
-- 
2.14.1
