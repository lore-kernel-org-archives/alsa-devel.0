From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5663: Add delay for jack plug in" to
	the asoc tree
Date: Wed, 30 Aug 2017 16:22:47 +0100
Message-ID: <E1dn4pL-0003Th-7F@debutante>
References: <1504069711-6549-1-git-send-email-oder_chiou@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 3340B2671BA
 for <alsa-devel@alsa-project.org>; Wed, 30 Aug 2017 17:22:50 +0200 (CEST)
In-Reply-To: <1504069711-6549-1-git-send-email-oder_chiou@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
Cc: Oder Chiou <oder_chiou@realtek.com>, jack.yu@realtek.com, alsa-devel@alsa-project.org, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, bardliao@realtek.com, Hsinyu Chao <hychao@chromium.org>, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5663: Add delay for jack plug in

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

>From 9c324afe3b90e406b15938acafaa2636a7e85ff3 Mon Sep 17 00:00:00 2001
From: "oder_chiou@realtek.com" <oder_chiou@realtek.com>
Date: Wed, 30 Aug 2017 13:08:31 +0800
Subject: [PATCH] ASoC: rt5663: Add delay for jack plug in

Codec initialize takes some time when 3.5mm jack plugged in. Add a
delay to report jack plugged event to user space to avoid pop noise.

Signed-off-by: Hsinyu Chao <hychao@chromium.org>
Signed-off-by: Oder Chiou <oder_chiou@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5663.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/rt5663.c b/sound/soc/codecs/rt5663.c
index fdc2bbcb67c2..14716d25173b 100644
--- a/sound/soc/codecs/rt5663.c
+++ b/sound/soc/codecs/rt5663.c
@@ -1705,6 +1705,9 @@ static void rt5663_jack_detect_work(struct work_struct *work)
 			default:
 				dev_err(codec->dev, "Unknown CODEC Version\n");
 			}
+
+			/* Delay the jack insert report to avoid pop noise */
+			msleep(30);
 		} else {
 			/* jack is already in, report button event */
 			report = SND_JACK_HEADSET;
-- 
2.14.1
