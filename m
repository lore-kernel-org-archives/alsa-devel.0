From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt298: disable IRQ when jack is NULL"
	to the asoc tree
Date: Tue, 29 Nov 2016 11:44:59 +0000
Message-ID: <E1cBgqJ-0004LM-Rt@debutante>
References: <1477305139-10513-2-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 1F10326707F
 for <alsa-devel@alsa-project.org>; Tue, 29 Nov 2016 12:45:14 +0100 (CET)
In-Reply-To: <1477305139-10513-2-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, vinod.koul@intel.com, lgirdwood@gmail.com, broonie@kernel.org, shumingf@realtek.com, senthilnathanx.veppur@intel.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt298: disable IRQ when jack is NULL

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

>From e3d62cb8c70ff5ff946051484b1cdb38523d8b95 Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Mon, 28 Nov 2016 13:24:06 +0800
Subject: [PATCH] ASoC: rt298: disable IRQ when jack is NULL

Disable IRQ when jack is NULL in rt298_mic_detect. So machine driver
can use it in suspend/resume.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Reviewed-by: Vinod Koul <vinod.koul@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt298.c | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt298.c b/sound/soc/codecs/rt298.c
index 55558643166f..6c4ac5b04665 100644
--- a/sound/soc/codecs/rt298.c
+++ b/sound/soc/codecs/rt298.c
@@ -321,11 +321,31 @@ static void rt298_jack_detect_work(struct work_struct *work)
 int rt298_mic_detect(struct snd_soc_codec *codec, struct snd_soc_jack *jack)
 {
 	struct rt298_priv *rt298 = snd_soc_codec_get_drvdata(codec);
+	struct snd_soc_dapm_context *dapm;
+	bool hp = false;
+	bool mic = false;
+	int status = 0;
+
+	/* If jack in NULL, disable HS jack */
+	if (!jack) {
+		regmap_update_bits(rt298->regmap, RT298_IRQ_CTRL, 0x2, 0x0);
+		dapm = snd_soc_codec_get_dapm(codec);
+		snd_soc_dapm_disable_pin(dapm, "LDO1");
+		snd_soc_dapm_sync(dapm);
+		return 0;
+	}
 
 	rt298->jack = jack;
+	regmap_update_bits(rt298->regmap, RT298_IRQ_CTRL, 0x2, 0x2);
 
-	/* Send an initial empty report */
-	snd_soc_jack_report(rt298->jack, 0,
+	rt298_jack_detect(rt298, &hp, &mic);
+	if (hp == true)
+		status |= SND_JACK_HEADPHONE;
+
+	if (mic == true)
+		status |= SND_JACK_MICROPHONE;
+
+	snd_soc_jack_report(rt298->jack, status,
 		SND_JACK_MICROPHONE | SND_JACK_HEADPHONE);
 
 	return 0;
-- 
2.10.2
