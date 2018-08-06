From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8903: use true and false for boolean
	values" to the asoc tree
Date: Mon,  6 Aug 2018 12:40:30 +0100 (BST)
Message-ID: <20180806114030.AF9C71124240@debutante.sirena.org.uk>
References: <a5b8afe476543dc45d3049b72b5dc718fbe1a010.1533418275.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8278B2676A3
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2018 13:40:32 +0200 (CEST)
In-Reply-To: <a5b8afe476543dc45d3049b72b5dc718fbe1a010.1533418275.git.gustavo@embeddedor.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: alsa-devel@alsa-project.org, Charles Keepax <ckeepax@opensource.cirrus.com>, "Gustavo A. R. Silva" <gustavo@embeddedor.com>, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Takashi Iwai <tiwai@suse.com>, Mark Brown <broonie@kernel.org>, patches@opensource.cirrus.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8903: use true and false for boolean values

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

>From bee7d3c9f89a1bbe3d5f88ac9d6946de4705731b Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Sat, 4 Aug 2018 16:56:02 -0500
Subject: [PATCH] ASoC: wm8903: use true and false for boolean values

Return statements in functions returning bool should use true or false
instead of an integer value.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8903.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/wm8903.c b/sound/soc/codecs/wm8903.c
index 7b8b6ef2f632..6cb3c153ba19 100644
--- a/sound/soc/codecs/wm8903.c
+++ b/sound/soc/codecs/wm8903.c
@@ -251,10 +251,10 @@ static bool wm8903_volatile_register(struct device *dev, unsigned int reg)
 	case WM8903_DC_SERVO_READBACK_2:
 	case WM8903_DC_SERVO_READBACK_3:
 	case WM8903_DC_SERVO_READBACK_4:
-		return 1;
+		return true;
 
 	default:
-		return 0;
+		return false;
 	}
 }
 
-- 
2.18.0
