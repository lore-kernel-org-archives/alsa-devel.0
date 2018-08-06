From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8996: use true and false for boolean
	values" to the asoc tree
Date: Mon,  6 Aug 2018 12:42:03 +0100 (BST)
Message-ID: <20180806114203.B55911124240@debutante.sirena.org.uk>
References: <d6c8a37703ecad97a48f5ba080ceec38697d100e.1533418275.git.gustavo@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id D880926782A
 for <alsa-devel@alsa-project.org>; Mon,  6 Aug 2018 13:42:04 +0200 (CEST)
In-Reply-To: <d6c8a37703ecad97a48f5ba080ceec38697d100e.1533418275.git.gustavo@embeddedor.com>
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

   ASoC: wm8996: use true and false for boolean values

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

>From eb086306bc6b42dc2c538ec2350d44a82d1a835b Mon Sep 17 00:00:00 2001
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Sat, 4 Aug 2018 16:52:35 -0500
Subject: [PATCH] ASoC: wm8996: use true and false for boolean values

Return statements in functions returning bool should use true or false
instead of an integer value.

This code was detected with the help of Coccinelle.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8996.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/wm8996.c b/sound/soc/codecs/wm8996.c
index 78a408236cfb..91711f8958c5 100644
--- a/sound/soc/codecs/wm8996.c
+++ b/sound/soc/codecs/wm8996.c
@@ -1498,9 +1498,9 @@ static bool wm8996_readable_register(struct device *dev, unsigned int reg)
 	case WM8996_RIGHT_PDM_SPEAKER:
 	case WM8996_PDM_SPEAKER_MUTE_SEQUENCE:
 	case WM8996_PDM_SPEAKER_VOLUME:
-		return 1;
+		return true;
 	default:
-		return 0;
+		return false;
 	}
 }
 
@@ -1522,9 +1522,9 @@ static bool wm8996_volatile_register(struct device *dev, unsigned int reg)
 	case WM8996_MIC_DETECT_3:
 	case WM8996_HEADPHONE_DETECT_1:
 	case WM8996_HEADPHONE_DETECT_2:
-		return 1;
+		return true;
 	default:
-		return 0;
+		return false;
 	}
 }
 
-- 
2.18.0
