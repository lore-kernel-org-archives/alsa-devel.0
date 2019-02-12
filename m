From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8741: Set OSR mode in hw_params()" to
	the asoc tree
Date: Tue, 12 Feb 2019 14:21:53 +0000 (GMT)
Message-ID: <20190212142153.D81551128113@debutante.sirena.org.uk>
References: <1549812569-17533-1-git-send-email-sergej@taudac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 74A422673F8
 for <alsa-devel@alsa-project.org>; Tue, 12 Feb 2019 15:21:56 +0100 (CET)
In-Reply-To: <1549812569-17533-1-git-send-email-sergej@taudac.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sergej Sawazki <sergej@taudac.com>
Cc: alsa-devel@alsa-project.org, ckeepax@opensource.cirrus.com, patches@opensource.cirrus.com, lgirdwood@gmail.com, broonie@kernel.org, ce3a@gmx.de
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8741: Set OSR mode in hw_params()

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

>From e9418629e2fcf7374c19750f3afa7f3a7ff0afa2 Mon Sep 17 00:00:00 2001
From: Sergej Sawazki <sergej@taudac.com>
Date: Sun, 10 Feb 2019 16:29:29 +0100
Subject: [PATCH] ASoC: wm8741: Set OSR mode in hw_params()

For correct operation of the digital filtering and other processing on the
WM8741, the user must ensure the correct value of OSR[1:0] is set at all
times.[1] Hence, depending the selected sampling rate, set the OSR (over-
sampling rate) mode in hw_params().

References:
	[1] "WM8741 Data Sheet"

Signed-off-by: Sergej Sawazki <sergej@taudac.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8741.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8741.c b/sound/soc/codecs/wm8741.c
index fdda83b7ca82..a4b8c459ea57 100644
--- a/sound/soc/codecs/wm8741.c
+++ b/sound/soc/codecs/wm8741.c
@@ -196,7 +196,7 @@ static int wm8741_hw_params(struct snd_pcm_substream *substream,
 {
 	struct snd_soc_component *component = dai->component;
 	struct wm8741_priv *wm8741 = snd_soc_component_get_drvdata(component);
-	unsigned int iface;
+	unsigned int iface, mode;
 	int i;
 
 	/* The set of sample rates that can be supported depends on the
@@ -240,11 +240,21 @@ static int wm8741_hw_params(struct snd_pcm_substream *substream,
 		return -EINVAL;
 	}
 
+	/* oversampling rate */
+	if (params_rate(params) > 96000)
+		mode = 0x40;
+	else if (params_rate(params) > 48000)
+		mode = 0x20;
+	else
+		mode = 0x00;
+
 	dev_dbg(component->dev, "wm8741_hw_params:    bit size param = %d, rate param = %d",
 		params_width(params), params_rate(params));
 
 	snd_soc_component_update_bits(component, WM8741_FORMAT_CONTROL, WM8741_IWL_MASK,
 			    iface);
+	snd_soc_component_update_bits(component, WM8741_MODE_CONTROL_1, WM8741_OSR_MASK,
+			    mode);
 
 	return 0;
 }
-- 
2.20.1
