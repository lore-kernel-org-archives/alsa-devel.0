From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5645: Check if codec is initialized
	in workqueue handler" to the asoc tree
Date: Thu, 16 Jul 2015 13:12:27 +0100
Message-ID: <E1ZFi1b-0001kI-Dl@finisterre>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 2B041260563
 for <alsa-devel@alsa-project.org>; Thu, 16 Jul 2015 14:12:41 +0200 (CEST)
In-Reply-To: 
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Nicolas Boichat <drinkcat@chromium.org>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5645: Check if codec is initialized in workqueue handler

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

>From 3c2234569cfff83718792f810a9bb855b78c2473 Mon Sep 17 00:00:00 2001
From: Nicolas Boichat <drinkcat@chromium.org>
Date: Thu, 16 Jul 2015 11:30:58 +0800
Subject: [PATCH] ASoC: rt5645: Check if codec is initialized in workqueue
 handler

rt5645_jack_detect_work needs rt5645->codec to be initialized to
setup dapm pins. Also, reporting jack events is useless, as the
jacks cannot be set before the codec is ready.

Since we manually call the interrupt handler in
rt5645_set_jack_detect, the initial jack state will be reported
correctly, and dapm pins will be setup at that time.

Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5645.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/codecs/rt5645.c b/sound/soc/codecs/rt5645.c
index 9ce311e..d1d49e8 100644
--- a/sound/soc/codecs/rt5645.c
+++ b/sound/soc/codecs/rt5645.c
@@ -2943,6 +2943,9 @@ static int rt5645_irq_detection(struct rt5645_priv *rt5645)
 {
 	int val, btn_type, gpio_state = 0, report = 0;
 
+	if (!rt5645->codec)
+		return;
+
 	switch (rt5645->pdata.jd_mode) {
 	case 0: /* Not using rt5645 JD */
 		if (rt5645->gpiod_hp_det) {
-- 
2.1.4
