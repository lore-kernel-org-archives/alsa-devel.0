From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dmic: introduce module_param
	wakeup_delay" to the asoc tree
Date: Wed, 28 Nov 2018 16:05:19 +0000 (GMT)
Message-ID: <20181128160519.689DB112521B@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 411F5267B01
 for <alsa-devel@alsa-project.org>; Wed, 28 Nov 2018 17:05:22 +0100 (CET)
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
To: Jenny TC <jenny.tc@intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dmic: introduce module_param wakeup_delay

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

>From f6f30a609c526dbf6d59490a8c85adaf6ac9b0fa Mon Sep 17 00:00:00 2001
From: Jenny TC <jenny.tc@intel.com>
Date: Wed, 28 Nov 2018 12:22:46 +0530
Subject: [PATCH] ASoC: dmic: introduce module_param wakeup_delay

Introducing a module param for wakeup_delay in order to
align with modeswitch_delay parameter. With this change, both
wakeup_delay and modeswitch_delay parameters can be passed
as module parameters.

Signed-off-by: Jenny TC <jenny.tc@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/dmic.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/sound/soc/codecs/dmic.c b/sound/soc/codecs/dmic.c
index f4eb0a438a3a..da921da50ef0 100644
--- a/sound/soc/codecs/dmic.c
+++ b/sound/soc/codecs/dmic.c
@@ -34,6 +34,9 @@
 static int modeswitch_delay;
 module_param(modeswitch_delay, uint, 0644);
 
+static int wakeup_delay;
+module_param(wakeup_delay, uint, 0644);
+
 struct dmic {
 	struct gpio_desc *gpio_en;
 	int wakeup_delay;
@@ -115,6 +118,8 @@ static int dmic_component_probe(struct snd_soc_component *component)
 				 &dmic->wakeup_delay);
 	device_property_read_u32(component->dev, "modeswitch-delay-ms",
 				 &dmic->modeswitch_delay);
+	if (wakeup_delay)
+		dmic->wakeup_delay  = wakeup_delay;
 	if (modeswitch_delay)
 		dmic->modeswitch_delay  = modeswitch_delay;
 
-- 
2.19.0.rc2
