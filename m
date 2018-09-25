From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: cs4265: Add a MIC pre. route" to the
	asoc tree
Date: Tue, 25 Sep 2018 18:27:54 +0100 (BST)
Message-ID: <20180925172754.E3AD8440078@finisterre.ee.mobilebroadband>
References: <20180925064018.5484-1-flatmax@flatmax.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id E3D58267892
 for <alsa-devel@alsa-project.org>; Tue, 25 Sep 2018 19:27:57 +0200 (CEST)
In-Reply-To: <20180925064018.5484-1-flatmax@flatmax.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Matt Flax <flatmax@flatmax.org>
Cc: alsa-devel@alsa-project.org, broonie@kernel.org, ckeepax@opensource.cirrus.com, brian.austin@cirrus.com, paul.handrigan@cirrus.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: cs4265: Add a MIC pre. route

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

>From b0ef5011b981ece1fde8063243a56d3038b87adb Mon Sep 17 00:00:00 2001
From: Matt Flax <flatmax@flatmax.org>
Date: Tue, 25 Sep 2018 16:40:18 +1000
Subject: [PATCH] ASoC: cs4265: Add a MIC pre. route

The cs4265 driver is missing a microphone preamp enable.
This patch enables/disables the microphone preamp when mic
selection is made using the kcontrol.

Signed-off-by: Matt Flax <flatmax@flatmax.org>
Reviewed-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/cs4265.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs4265.c b/sound/soc/codecs/cs4265.c
index d9eebf6af7a8..ab27d2b94d02 100644
--- a/sound/soc/codecs/cs4265.c
+++ b/sound/soc/codecs/cs4265.c
@@ -221,10 +221,11 @@ static const struct snd_soc_dapm_route cs4265_audio_map[] = {
 	{"LINEOUTR", NULL, "DAC"},
 	{"SPDIFOUT", NULL, "SPDIF"},
 
+	{"Pre-amp MIC", NULL, "MICL"},
+	{"Pre-amp MIC", NULL, "MICR"},
+	{"ADC Mux", "MIC", "Pre-amp MIC"},
 	{"ADC Mux", "LINEIN", "LINEINL"},
 	{"ADC Mux", "LINEIN", "LINEINR"},
-	{"ADC Mux", "MIC", "MICL"},
-	{"ADC Mux", "MIC", "MICR"},
 	{"ADC", NULL, "ADC Mux"},
 	{"DOUT", NULL, "ADC"},
 	{"DAI1 Capture", NULL, "DOUT"},
-- 
2.19.0
