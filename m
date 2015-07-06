From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Constify dmi_system_id table"
	to the asoc tree
Date: Mon, 06 Jul 2015 21:43:11 +0100
Message-ID: <E1ZCDEN-0002lD-9p@debutante>
References: <1435462879.15772.5.camel@ingics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 023EA260836
 for <alsa-devel@alsa-project.org>; Mon,  6 Jul 2015 22:43:23 +0200 (CEST)
In-Reply-To: <1435462879.15772.5.camel@ingics.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Axel Lin <axel.lin@ingics.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: Constify dmi_system_id table

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

>From 0bc7d10c4abb7cec52d4d88f761476ed04225c83 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@ingics.com>
Date: Sun, 28 Jun 2015 11:41:19 +0800
Subject: [PATCH] ASoC: rt5645: Constify dmi_system_id table

dmi_check_system() takes "const struct dmi_system_id *", so make the
dmi_system_id table const.

Signed-off-by: Axel Lin <axel.lin@ingics.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index a5bc96a0e77c..a07966bebfef 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -3221,7 +3221,7 @@ static int strago_quirk_cb(const struct dmi_system_id *id)
 	return 1;
 }
 
-static struct dmi_system_id dmi_platform_intel_braswell[] = {
+static const struct dmi_system_id dmi_platform_intel_braswell[] = {
 	{
 		.ident = "Intel Strago",
 		.callback = strago_quirk_cb,
-- 
2.1.4
