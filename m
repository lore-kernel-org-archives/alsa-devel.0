From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8825: drop redundant idiom when
	converting integer to boolean" to the asoc tree
Date: Fri, 15 Jul 2016 12:56:37 +0100
Message-ID: <E1bO1jR-0006pZ-77@debutante>
References: <1468548377-9269-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 8C0192668AB
 for <alsa-devel@alsa-project.org>; Fri, 15 Jul 2016 13:56:49 +0200 (CEST)
In-Reply-To: <1468548377-9269-1-git-send-email-KCHSU0@nuvoton.com>
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

   ASoC: nau8825: drop redundant idiom when converting integer to boolean

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

>From 308e3e0bfa9ec9d1dc8c415e8a68ad4efd0fddfd Mon Sep 17 00:00:00 2001
From: John Hsu <KCHSU0@nuvoton.com>
Date: Fri, 15 Jul 2016 10:06:17 +0800
Subject: [PATCH] ASoC: nau8825: drop redundant idiom when converting integer
 to boolean

Thanks Mark and Anatol for the discussion. According to the result,
the standard C will translate any non-zero value into true, or
false otherwise.
QUOTE:
"6.3.1.2 Boolean type
When any scalar value is converted to _Bool, the result is 0 if the
value compares equal to 0; otherwise, the result is 1
"
Thus, the "!!" idiom is removed.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8825.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index a97418deb034..5c9707ac4bbf 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1349,9 +1349,9 @@ static bool nau8825_is_jack_inserted(struct regmap *regmap)
 	int status, jkdet;
 
 	regmap_read(regmap, NAU8825_REG_JACK_DET_CTRL, &jkdet);
-	active_high = !!(jkdet & NAU8825_JACK_POLARITY);
+	active_high = jkdet & NAU8825_JACK_POLARITY;
 	regmap_read(regmap, NAU8825_REG_I2C_DEVICE_ID, &status);
-	is_high = !!(status & NAU8825_GPIO2JD1);
+	is_high = status & NAU8825_GPIO2JD1;
 	/* return jack connection status according to jack insertion logic
 	 * active high or active low.
 	 */
-- 
2.8.1
