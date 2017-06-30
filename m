From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5665: calibration should be done
	before jack detection" to the asoc tree
Date: Fri, 30 Jun 2017 12:59:05 +0100
Message-ID: <E1dQuZl-0007zM-Bk@finisterre>
References: <1498738070-16624-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 51E732674F2
 for <alsa-devel@alsa-project.org>; Fri, 30 Jun 2017 13:59:29 +0200 (CEST)
In-Reply-To: <1498738070-16624-1-git-send-email-bardliao@realtek.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Bard Liao <bardliao@realtek.com>
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, xiaoxiang@pinecone.net, zhongan@pinecone.net, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt5665: calibration should be done before jack detection

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

>From b059ca720e2ac04380240500eb8d8ba931898570 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Thu, 29 Jun 2017 20:07:50 +0800
Subject: [PATCH] ASoC: rt5665: calibration should be done before jack
 detection

We will set some volatile registers in jack detection function. But
those volatile registers will be clear in rt5665_calibrate function
because we set cache bypass and reset codec in rt5665_calibrate function.
This patch add a flag to make sure that rt5665_calibrate is done
before starting jack detection.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5665.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/rt5665.c b/sound/soc/codecs/rt5665.c
index 7420010fd8e9..370ed54d1e15 100644
--- a/sound/soc/codecs/rt5665.c
+++ b/sound/soc/codecs/rt5665.c
@@ -70,6 +70,7 @@ struct rt5665_priv {
 	int jack_type;
 	int irq_work_delay_time;
 	unsigned int sar_adc_value;
+	bool calibration_done;
 };
 
 static const struct reg_default rt5665_reg[] = {
@@ -1305,6 +1306,11 @@ static void rt5665_jack_detect_handler(struct work_struct *work)
 		usleep_range(10000, 15000);
 	}
 
+	while (!rt5665->calibration_done) {
+		pr_debug("%s calibration not ready\n", __func__);
+		usleep_range(10000, 15000);
+	}
+
 	mutex_lock(&rt5665->calibrate_mutex);
 
 	val = snd_soc_read(rt5665->codec, RT5665_AJD1_CTRL) & 0x0010;
@@ -4695,6 +4701,7 @@ static void rt5665_calibrate(struct rt5665_priv *rt5665)
 	regmap_write(rt5665->regmap, RT5665_ASRC_8, 0x0120);
 
 out_unlock:
+	rt5665->calibration_done = true;
 	mutex_unlock(&rt5665->calibrate_mutex);
 }
 
-- 
2.13.2
