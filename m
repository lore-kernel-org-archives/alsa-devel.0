From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Remove redundant NULL check in
	wm_adsp_buffer_free" to the asoc tree
Date: Wed,  3 Apr 2019 05:41:30 +0100 (BST)
Message-ID: <20190403044130.7F9AC440082@finisterre.ee.mobilebroadband>
References: <20190402124916.28736-2-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 963C1F8971E
 for <alsa-devel@alsa-project.org>; Wed,  3 Apr 2019 06:41:34 +0200 (CEST)
In-Reply-To: <20190402124916.28736-2-ckeepax@opensource.cirrus.com>
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: patches@opensource.cirrus.com, alsa-devel@alsa-project.org, broonie@kernel.org, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Remove redundant NULL check in wm_adsp_buffer_free

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

>From 26ffa016a3c1b34fbfcc8368edb315f2829504ae Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Tue, 2 Apr 2019 13:49:15 +0100
Subject: [PATCH] ASoC: wm_adsp: Remove redundant NULL check in
 wm_adsp_buffer_free

wm_adsp_compr_detach is NULL aware so there is no need to check for NULL
before calling it, remove the redundant check.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index 0aa62b26f61c..6145260d89bf 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -3887,8 +3887,7 @@ static int wm_adsp_buffer_free(struct wm_adsp *dsp)
 	struct wm_adsp_compr_buf *buf, *tmp;
 
 	list_for_each_entry_safe(buf, tmp, &dsp->buffer_list, list) {
-		if (buf->compr)
-			wm_adsp_compr_detach(buf->compr);
+		wm_adsp_compr_detach(buf->compr);
 
 		kfree(buf->name);
 		kfree(buf->regions);
-- 
2.20.1
