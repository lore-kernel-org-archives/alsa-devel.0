From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm_adsp: Correct region base typo in
	wm_halo_setup_algs" to the asoc tree
Date: Thu,  2 May 2019 03:18:00 +0100 (BST)
Message-ID: <20190502021800.B70E7441D3C@finisterre.ee.mobilebroadband>
References: <20190501101332.31190-1-ckeepax@opensource.cirrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [IPv6:2a01:7e01::f03c:91ff:fed4:a3b6])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 511AFF8075A
 for <alsa-devel@alsa-project.org>; Thu,  2 May 2019 04:18:05 +0200 (CEST)
In-Reply-To: <20190501101332.31190-1-ckeepax@opensource.cirrus.com>
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
Cc: Stuart Henderson <stuarth@opensource.cirrus.com>, patches@opensource.cirrus.com, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, lgirdwood@gmail.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm_adsp: Correct region base typo in wm_halo_setup_algs

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-5.2

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

>From b75a9799dc371ce5f51a73536f248f60a1be74ec Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Wed, 1 May 2019 11:13:31 +0100
Subject: [PATCH] ASoC: wm_adsp: Correct region base typo in wm_halo_setup_algs

Due to a typo the wrong base is being supplied for the primary algorithm
on Halo firmwares, which will cause the controls to not function.

Fixes: 170b1e123f38 ("ASoC: wm_adsp: Add support for new Halo core DSPs")
Reported-by: Stuart Henderson <stuarth@opensource.cirrus.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm_adsp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm_adsp.c b/sound/soc/codecs/wm_adsp.c
index bb10c4aeceb4..b26e6b825a90 100644
--- a/sound/soc/codecs/wm_adsp.c
+++ b/sound/soc/codecs/wm_adsp.c
@@ -2445,7 +2445,7 @@ static int wm_halo_setup_algs(struct wm_adsp *dsp)
 	wmfw_v3_parse_id_header(dsp, &halo_id.fw, n_algs);
 
 	ret = wm_halo_create_regions(dsp, halo_id.fw.id,
-				     halo_id.ym_base, halo_id.ym_base);
+				     halo_id.xm_base, halo_id.ym_base);
 	if (ret)
 		return ret;
 
-- 
2.20.1
