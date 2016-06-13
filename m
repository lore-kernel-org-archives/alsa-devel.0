From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm5110: Add missing route from OUT3R to
	SYSCLK" to the asoc tree
Date: Mon, 13 Jun 2016 16:47:47 +0100
Message-ID: <E1bCU5b-00030G-Jt@finisterre>
References: <1465821317-28449-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 6EEFA26651C
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 17:47:57 +0200 (CEST)
In-Reply-To: <1465821317-28449-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com, lgirdwood@gmail.com, broonie@kernel.org, Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, ajit.pandey@soctronics.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm5110: Add missing route from OUT3R to SYSCLK

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

>From d72fea6214f3fee2355d8cb6c51348059d98768b Mon Sep 17 00:00:00 2001
From: Ajit Pandey <ajit.pandey@soctronics.com>
Date: Mon, 13 Jun 2016 13:35:15 +0100
Subject: [PATCH] ASoC: wm5110: Add missing route from OUT3R to SYSCLK

Output 3 is stereo on wm5110 and all inputs/outputs should have a
connection to SYSCLK. This patch adds the missing DAPM route.

Signed-off-by: Ajit Pandey <ajit.pandey@soctronics.com>
Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm5110.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/wm5110.c b/sound/soc/codecs/wm5110.c
index b5820e4d5471..d54f1b46c9ec 100644
--- a/sound/soc/codecs/wm5110.c
+++ b/sound/soc/codecs/wm5110.c
@@ -1723,6 +1723,7 @@ static const struct snd_soc_dapm_route wm5110_dapm_routes[] = {
 	{ "OUT2L", NULL, "SYSCLK" },
 	{ "OUT2R", NULL, "SYSCLK" },
 	{ "OUT3L", NULL, "SYSCLK" },
+	{ "OUT3R", NULL, "SYSCLK" },
 	{ "OUT4L", NULL, "SYSCLK" },
 	{ "OUT4R", NULL, "SYSCLK" },
 	{ "OUT5L", NULL, "SYSCLK" },
-- 
2.8.1
