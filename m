From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: wm8753: Replace magic number" to the
	asoc tree
Date: Sun, 26 Jun 2016 13:02:50 +0100
Message-ID: <E1bH8m2-0002TM-Vs@debutante>
References: <1466830689-31587-1-git-send-email-shc_work@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id ACB112650DA
 for <alsa-devel@alsa-project.org>; Sun, 26 Jun 2016 14:02:56 +0200 (CEST)
In-Reply-To: <1466830689-31587-1-git-send-email-shc_work@mail.ru>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Alexander Shiyan <shc_work@mail.ru>
Cc: Liam Girdwood <lgirdwood@gmail.com>, alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, patches@opensource.wolfsonmicro.com, Takashi Iwai <tiwai@suse.com>
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: wm8753: Replace magic number

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

>From eb87f9e2b3212c84498c6972b529e207e4e95e6a Mon Sep 17 00:00:00 2001
From: Alexander Shiyan <shc_work@mail.ru>
Date: Sat, 25 Jun 2016 07:58:09 +0300
Subject: [PATCH] ASoC: wm8753: Replace magic number

Use SND_SOC_NOPM constant, instead of -1.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/wm8753.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/wm8753.c b/sound/soc/codecs/wm8753.c
index b4e6893f5e3d..cdcc91282e8a 100644
--- a/sound/soc/codecs/wm8753.c
+++ b/sound/soc/codecs/wm8753.c
@@ -485,7 +485,7 @@ SND_SOC_DAPM_DAC("Voice DAC", "Voice Playback", WM8753_PWR1, 4, 0),
 SND_SOC_DAPM_OUTPUT("MONO1"),
 SND_SOC_DAPM_MUX("Mono 2 Mux", SND_SOC_NOPM, 0, 0, &wm8753_mono2_controls),
 SND_SOC_DAPM_OUTPUT("MONO2"),
-SND_SOC_DAPM_MIXER("Out3 Left + Right", -1, 0, 0, NULL, 0),
+SND_SOC_DAPM_MIXER("Out3 Left + Right", SND_SOC_NOPM, 0, 0, NULL, 0),
 SND_SOC_DAPM_MUX("Out3 Mux", SND_SOC_NOPM, 0, 0, &wm8753_out3_controls),
 SND_SOC_DAPM_PGA("Out 3", WM8753_PWR3, 4, 0, NULL, 0),
 SND_SOC_DAPM_OUTPUT("OUT3"),
-- 
2.8.1
