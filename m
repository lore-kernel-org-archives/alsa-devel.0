From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514: Fix rt5514_spi_burst_read()
	buffer passing" to the asoc tree
Date: Thu, 01 Mar 2018 19:42:24 +0000
Message-ID: <E1erU5w-0003TE-P2@debutante>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1290607045341583908=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id 177D0267BD0
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 20:42:25 +0100 (CET)
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
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>
List-Id: alsa-devel@alsa-project.org

--===============1290607045341583908==
Content-Type: text/plain

The patch

   ASoC: rt5514: Fix rt5514_spi_burst_read() buffer passing

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

>From 29838a5c1e77ed93d41fb9837390e243b9b73518 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jan 2018 14:19:42 +0100
Subject: [PATCH] ASoC: rt5514: Fix rt5514_spi_burst_read() buffer passing
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

rt5514_dsp_voice_wake_up_put() passes "(u8 *)&buf" to
rt5514_spi_burst_read(), where the cast is needed to silence a compiler
warning:

    sound/soc/codecs/rt5514.c: In function ‘rt5514_dsp_voice_wake_up_put’:
    sound/soc/codecs/rt5514.c:357: warning: passing argument 2 of ‘rt5514_spi_burst_read’ from incompatible pointer type

However, as the variable is declared as an array ("u8 buf[8]"), the
function should just pass "buf" instead.

Fixes: fc9cab05837639ce ("ASoC: rt5514: The DSP clock can be calibrated by the other clock source")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index 2d79571098ac..b358704ee19c 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -353,8 +353,7 @@ static int rt5514_dsp_voice_wake_up_put(struct snd_kcontrol *kcontrol,
 				msleep(20);
 #if IS_ENABLED(CONFIG_SND_SOC_RT5514_SPI)
 				rt5514_spi_burst_read(RT5514_PLL3_CALIB_CTRL6 |
-					RT5514_DSP_MAPPING,
-					(u8 *)&buf, sizeof(buf));
+					RT5514_DSP_MAPPING, buf, sizeof(buf));
 #else
 				dev_err(component->dev, "There is no SPI driver for"
 					" loading the firmware\n");
-- 
2.16.2


--===============1290607045341583908==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1290607045341583908==--
