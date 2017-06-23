From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: nau8825: make crosstalk function
	optional" to the asoc tree
Date: Fri, 23 Jun 2017 13:03:57 +0100
Message-ID: <E1dONJd-0006Ni-Cs@debutante>
References: <1498028154-10888-1-git-send-email-KCHSU0@nuvoton.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 9C76E2674A2
 for <alsa-devel@alsa-project.org>; Fri, 23 Jun 2017 14:04:13 +0200 (CEST)
In-Reply-To: <1498028154-10888-1-git-send-email-KCHSU0@nuvoton.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: John Hsu <supercraig0719@gmail.com>
Cc: alsa-devel@alsa-project.org, anatol.pomozov@gmail.com, benzh@chromium.org, John Hsu <KCHSU0@nuvoton.com>, lgirdwood@gmail.com, YHCHuang@nuvoton.com, mac.chiang@intel.com, broonie@kernel.org, CTLIN0@nuvoton.com, yong.zhi@intel.com, mhkuo@nuvoton.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: nau8825: make crosstalk function optional

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

>From 2bda4288e771e51946e70329c9b79605e4612f10 Mon Sep 17 00:00:00 2001
From: John Hsu <supercraig0719@gmail.com>
Date: Thu, 22 Jun 2017 11:57:55 +0800
Subject: [PATCH] ASoC: nau8825: make crosstalk function optional

Make crosstalk functoin optional.
The jack detection can speed up without crosstalk detection.
Let the decision of function usage to platform design.

The patch helps the issue concern as follows:
Google issue 35574278: Chell_headphone pop back from S3

There is a concern as follows:
cras getting blocked for 2 seconds (worst-case 3 seconds)
As I understand, ChromeOS expects resume finishes in 1 seconds.
Video/Audio playing after 3 seconds of resume seems against the spec.
If we really have to make the choice I would choose pop noise instead
of waiting for 3 seconds.

Signed-off-by: John Hsu <KCHSU0@nuvoton.com>
Signed-off-by: John Hsu <supercraig0719@gmail.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/nau8825.c | 6 +++++-
 sound/soc/codecs/nau8825.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/nau8825.c b/sound/soc/codecs/nau8825.c
index 503a6d8130b7..a8c7a556a6a8 100644
--- a/sound/soc/codecs/nau8825.c
+++ b/sound/soc/codecs/nau8825.c
@@ -1686,7 +1686,7 @@ static irqreturn_t nau8825_interrupt(int irq, void *data)
 	} else if (active_irq & NAU8825_HEADSET_COMPLETION_IRQ) {
 		if (nau8825_is_jack_inserted(regmap)) {
 			event |= nau8825_jack_insert(nau8825);
-			if (!nau8825->high_imped) {
+			if (!nau8825->xtalk_bypass && !nau8825->high_imped) {
 				/* Apply the cross talk suppression in the
 				 * headset without high impedance.
 				 */
@@ -2504,6 +2504,10 @@ static int nau8825_read_device_properties(struct device *dev,
 		&nau8825->jack_eject_debounce);
 	if (ret)
 		nau8825->jack_eject_debounce = 0;
+	ret = device_property_read_u32(dev, "nuvoton,crosstalk-bypass",
+		&nau8825->xtalk_bypass);
+	if (ret)
+		nau8825->xtalk_bypass = 1;
 
 	nau8825->mclk = devm_clk_get(dev, "mclk");
 	if (PTR_ERR(nau8825->mclk) == -EPROBE_DEFER) {
diff --git a/sound/soc/codecs/nau8825.h b/sound/soc/codecs/nau8825.h
index 514fd13c2f46..8aee5c8647ae 100644
--- a/sound/soc/codecs/nau8825.h
+++ b/sound/soc/codecs/nau8825.h
@@ -476,6 +476,7 @@ struct nau8825 {
 	int xtalk_event_mask;
 	bool xtalk_protect;
 	int imp_rms[NAU8825_XTALK_IMM];
+	int xtalk_bypass;
 };
 
 int nau8825_enable_jack_detect(struct snd_soc_codec *codec,
-- 
2.13.1
