From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm9081: fixup wm9081_digital_mute() reg
	read" to the asoc tree
Date: Tue, 13 Feb 2018 12:15:49 +0000
Message-ID: <E1elZUz-0005VE-8x@debutante>
References: <871shplhwp.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 8058B26795E
 for <alsa-devel@alsa-project.org>; Tue, 13 Feb 2018 13:16:11 +0100 (CET)
In-Reply-To: <871shplhwp.wl%kuninori.morimoto.gx@renesas.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Mark Brown <broonie@kernel.org>, kbuild test robot <fengguang.wu@intel.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm9081: fixup wm9081_digital_mute() reg read

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

>From 1417c5fa3962d768bb8f18f4725a5fc039dbbb0e Mon Sep 17 00:00:00 2001
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Date: Tue, 13 Feb 2018 02:54:58 +0000
Subject: [PATCH] ASoC: wm9081: fixup wm9081_digital_mute() reg read

commit 48c338764296 ("ASoC: wm9081: replace codec to component")
replaced codec to component, but it didn't keep WM9081_DAC_DIGITAL_2
value to reg. This patch fixup it.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm9081.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm9081.c b/sound/soc/codecs/wm9081.c
index 52dd610cd8dc..5a0ea7b3c149 100644
--- a/sound/soc/codecs/wm9081.c
+++ b/sound/soc/codecs/wm9081.c
@@ -1155,7 +1155,7 @@ static int wm9081_digital_mute(struct snd_soc_dai *codec_dai, int mute)
 	struct snd_soc_component *component = codec_dai->component;
 	unsigned int reg;
 
-	snd_soc_component_read32(component, WM9081_DAC_DIGITAL_2);
+	reg = snd_soc_component_read32(component, WM9081_DAC_DIGITAL_2);
 
 	if (mute)
 		reg |= WM9081_DAC_MUTE;
-- 
2.16.1
