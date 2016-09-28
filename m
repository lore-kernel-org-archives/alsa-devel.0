From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: da7219: fix inappropriate condition
	statement" to the asoc tree
Date: Wed, 28 Sep 2016 11:27:28 -0700
Message-ID: <E1bpJZo-0003qu-Sl@finisterre>
References: <1469540517-32466-2-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A86C52667C9
 for <alsa-devel@alsa-project.org>; Wed, 28 Sep 2016 20:27:46 +0200 (CEST)
In-Reply-To: <1469540517-32466-2-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Cc: tiwai@suse.de, Adam Thomson <Adam.Thomson.Opensource@diasemi.com>, broonie@kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: da7219: fix inappropriate condition statement

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

>From a56a569818ea831ed2325dc5d1122dc0b8a229d0 Mon Sep 17 00:00:00 2001
From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Date: Tue, 27 Sep 2016 07:45:07 +0900
Subject: [PATCH] ASoC: da7219: fix inappropriate condition statement

Sparse reports a below warning.

sound/soc/codecs/da7219.c:804:57: warning: dubious: x & !y

The line includes a condition statement; '(a < b) & !c'. Practically, the
evaluated value of this statement equals to the value of '(a < b) && !c'.
Although, it's not an usual way to use bitwise operations as logical
operations to several conditions.

This commit fixes the bug.

Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/da7219.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/da7219.c b/sound/soc/codecs/da7219.c
index 65f7e9807659..32007625913d 100644
--- a/sound/soc/codecs/da7219.c
+++ b/sound/soc/codecs/da7219.c
@@ -801,7 +801,7 @@ static int da7219_dai_event(struct snd_soc_dapm_widget *w,
 				++i;
 				msleep(50);
 			}
-		} while ((i < DA7219_SRM_CHECK_RETRIES) & (!srm_lock));
+		} while ((i < DA7219_SRM_CHECK_RETRIES) && (!srm_lock));
 
 		if (!srm_lock)
 			dev_warn(codec->dev, "SRM failed to lock\n");
-- 
2.9.3
