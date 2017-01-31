From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8741: Remove unused WM8741_NUM_RATES
	macro" to the asoc tree
Date: Tue, 31 Jan 2017 21:17:23 +0000
Message-ID: <E1cYfnn-0000rY-Hz@debutante>
References: <1485555653-11326-1-git-send-email-ce3a@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 51FDA2673ED
 for <alsa-devel@alsa-project.org>; Tue, 31 Jan 2017 22:17:35 +0100 (CET)
In-Reply-To: <1485555653-11326-1-git-send-email-ce3a@gmx.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <ce3a@gmx.de>
Cc: ckeepax@opensource.wolfsonmicro.com, broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org, patches@opensource.wolfsonmicro.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8741: Remove unused WM8741_NUM_RATES macro

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

>From c9b0bdc74735a5173cdce67f8a85f85c2e8bccee Mon Sep 17 00:00:00 2001
From: Sergej Sawazki <ce3a@gmx.de>
Date: Fri, 27 Jan 2017 23:20:53 +0100
Subject: [PATCH] ASoC: wm8741: Remove unused WM8741_NUM_RATES macro

This macro is unused since commit e369bd006fd6 ("ASoC: wm8741: Allow master
clock switching").

Signed-off-by: Sergej Sawazki <ce3a@gmx.de>
Acked-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8741.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index 565d477cd790..b8c1940f2243 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -37,8 +37,6 @@ static const char *wm8741_supply_names[WM8741_NUM_SUPPLIES] = {
 	"DVDD",
 };
 
-#define WM8741_NUM_RATES 6
-
 /* codec private data */
 struct wm8741_priv {
 	struct wm8741_platform_data pdata;
-- 
2.11.0
