From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt286: don't turn off HV and VREF if
	headset is detected" to the asoc tree
Date: Tue, 20 Mar 2018 01:06:12 +0000 (GMT)
Message-ID: <20180320010612.59E8E44007A@finisterre.ee.mobilebroadband>
References: <1521454032-32387-1-git-send-email-bardliao@realtek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 205862672C1
 for <alsa-devel@alsa-project.org>; Tue, 20 Mar 2018 02:06:16 +0100 (CET)
In-Reply-To: <1521454032-32387-1-git-send-email-bardliao@realtek.com>
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
Cc: oder_chiou@realtek.com, jack.yu@realtek.com, alsa-devel@alsa-project.org, lars@metafoo.de, lgirdwood@gmail.com, puneethx.prabhu@intel.com, broonie@kernel.org, shumingf@realtek.com, flove@realtek.com
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: rt286: don't turn off HV and VREF if headset is detected

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

>From 8153362e757a7b971aa73e7747bdc2ca2acbe84b Mon Sep 17 00:00:00 2001
From: Bard Liao <bardliao@realtek.com>
Date: Mon, 19 Mar 2018 18:07:12 +0800
Subject: [PATCH] ASoC: rt286: don't turn off HV and VREF if headset is
 detected

"HV" and "VREF" will be powered up when jack type detection process is
started and will be powered off when jack type detection process is finished.
It will generate an unexpected interrupt signal when they are powered
up during the capture process. Codec driver will do the jack type detection
process and we can't capture properly before the jack detection process is
finished. This patch will not power off the "HV" and "VREF" widgets if
headset is detected and it will solve the unexpected interrupt issue. As a
result, it will also solve the silence data captured at the beginning in
headset mic recording issue.

Signed-off-by: Bard Liao <bardliao@realtek.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt286.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/rt286.c b/sound/soc/codecs/rt286.c
index af6325c78292..e5c9d59c3967 100644
--- a/sound/soc/codecs/rt286.c
+++ b/sound/soc/codecs/rt286.c
@@ -275,9 +275,10 @@ static int rt286_jack_detect(struct rt286_priv *rt286, bool *hp, bool *mic)
 		regmap_read(rt286->regmap, RT286_GET_MIC1_SENSE, &buf);
 		*mic = buf & 0x80000000;
 	}
-
-	snd_soc_dapm_disable_pin(dapm, "HV");
-	snd_soc_dapm_disable_pin(dapm, "VREF");
+	if (!*mic) {
+		snd_soc_dapm_disable_pin(dapm, "HV");
+		snd_soc_dapm_disable_pin(dapm, "VREF");
+	}
 	if (!*hp)
 		snd_soc_dapm_disable_pin(dapm, "LDO1");
 	snd_soc_dapm_sync(dapm);
-- 
2.16.2
