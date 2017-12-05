From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: don't use rtd->codec on
	soc_dev_attr_is_visible()" to the asoc tree
Date: Tue,  5 Dec 2017 12:47:53 +0000 (GMT)
Message-ID: <20171205124753.0C4F644006B@finisterre.ee.mobilebroadband>
References: <878thzkkmx.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 573A92674EF
 for <alsa-devel@alsa-project.org>; Tue,  5 Dec 2017 13:47:55 +0100 (CET)
In-Reply-To: <878thzkkmx.wl%kuninori.morimoto.gx@renesas.com>
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

   ASoC: don't use rtd->codec on soc_dev_attr_is_visible()

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

>From 3b6eed8deb37c349bffc7b3b4d722ce4023f8b11 Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 5 Dec 2017 04:20:42 +0000
Subject: [PATCH] ASoC: don't use rtd->codec on soc_dev_attr_is_visible()

rtd->codec will be removed soon.
checking rtd->num_codecs is enough

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index c0edac80df34..90f1122d91c4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -213,7 +213,7 @@ static umode_t soc_dev_attr_is_visible(struct kobject *kobj,
 
 	if (attr == &dev_attr_pmdown_time.attr)
 		return attr->mode; /* always visible */
-	return rtd->codec ? attr->mode : 0; /* enabled only with codec */
+	return rtd->num_codecs ? attr->mode : 0; /* enabled only with codec */
 }
 
 static const struct attribute_group soc_dapm_dev_group = {
-- 
2.15.0
