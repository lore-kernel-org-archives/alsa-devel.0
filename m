From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: dapm: Check for NULL widget in
	dapm_update_dai_unlocked" to the asoc tree
Date: Wed,  6 Feb 2019 16:58:20 +0000 (GMT)
Message-ID: <20190206165820.9A4E71127EA3@debutante.sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8E754267980
 for <alsa-devel@alsa-project.org>; Wed,  6 Feb 2019 17:58:22 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.cirrus.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: dapm: Check for NULL widget in dapm_update_dai_unlocked

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

>From cf17a5ffd27234371d10748bf1c716ef172877f3 Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.cirrus.com>
Date: Wed, 6 Feb 2019 11:13:59 +0000
Subject: [PATCH] ASoC: dapm: Check for NULL widget in dapm_update_dai_unlocked

DAIs linked to the dummy will not have an associated playback/capture
widget, so we need to skip the update in that case.

Fixes: 078a85f2806f ("ASoC: dapm: Only power up active channels from a DAI")
Reported-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Tested-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
Tested-by: Krzysztof Kozlowski <krzk@kernel.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/soc-dapm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/sound/soc/soc-dapm.c b/sound/soc/soc-dapm.c
index 5b74dffc9c11..111a23a9708a 100644
--- a/sound/soc/soc-dapm.c
+++ b/sound/soc/soc-dapm.c
@@ -2580,6 +2580,9 @@ static int dapm_update_dai_unlocked(struct snd_pcm_substream *substream,
 	else
 		w = dai->capture_widget;
 
+	if (!w)
+		return 0;
+
 	dev_dbg(dai->dev, "Update DAI routes for %s %s\n", dai->name,
 		dir == SNDRV_PCM_STREAM_PLAYBACK ? "playback" : "capture");
 
-- 
2.20.1
