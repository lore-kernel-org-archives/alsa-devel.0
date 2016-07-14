From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8825: jack connection decision with
	different insertion logic" to the asoc tree
Date: Thu, 14 Jul 2016 17:33:33 +0100
Message-ID: <E1bNjZt-00021I-KX@debutante>
References: <1467770975-11351-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1212B266849
 for <alsa-devel@alsa-project.org>; Thu, 14 Jul 2016 18:33:38 +0200 (CEST)
In-Reply-To: <1467770975-11351-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <KCHSU0@nuvoton.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, benzh@chromium.org, lgirdwood@gmail.com, YHCHuang@nuvoton.com, broonie@kernel.org, CTLIN0@nuvoton.com, yong.zhi@intel.com, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8825: jack connection decision with different insertion logic

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

>From bff03e81502cb9ac99daeeb47b4d0e779cc48fde Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Wed, 6 Jul 2016 10:09:35 +0800
Subject: [PATCH] ASoC: nau8825: jack connection decision with different
 insertion logic

The original design only covers the jack insertion logic is active low.
Add more condition to cover no matter the logic is active low and high.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8825.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 3f30e6ed210c..a97418deb034 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1345,10 +1345,17 @@ EXPORT_SYMBOL_GPL(nau8825_enable_jack_detect);
 
 static bool nau8825_is_jack_inserted(struct regmap *regmap)
 {
-	int status;
+	bool active_high, is_high;
+	int status, jkdet;
 
+	regmap_read(regmap, NAU8825_REG_JACK_DET_CTRL, &jkdet);
+	active_high = !!(jkdet & NAU8825_JACK_POLARITY);
 	regmap_read(regmap, NAU8825_REG_I2C_DEVICE_ID, &status);
-	return !(status & NAU8825_GPIO2JD1);
+	is_high = !!(status & NAU8825_GPIO2JD1);
+	/* return jack connection status according to jack insertion logic
+	 * active high or active low.
+	 */
+	return active_high == is_high;
 }
 
 static void nau8825_restart_jack_detection(struct regmap *regmap)
-- 
2.8.1
