From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: rt5514: Fix uninitialized calibration
	value" to the asoc tree
Date: Thu, 01 Mar 2018 19:42:22 +0000
Message-ID: <E1erU5u-0003SU-HN@debutante>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6372202826988666812=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from heliosphere.sirena.org.uk (heliosphere.sirena.org.uk
 [172.104.155.198])
 by alsa0.perex.cz (Postfix) with ESMTP id CF8F2267BD0
 for <alsa-devel@alsa-project.org>; Thu,  1 Mar 2018 20:42:23 +0100 (CET)
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

--===============6372202826988666812==
Content-Type: text/plain

The patch

   ASoC: rt5514: Fix uninitialized calibration value

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

>From 890861aa85043cc9d99a01e1bd26883722e95243 Mon Sep 17 00:00:00 2001
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 30 Jan 2018 14:19:43 +0100
Subject: [PATCH] ASoC: rt5514: Fix uninitialized calibration value
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

With gcc-4.1.2, if CONFIG_SND_SOC_RT5514_SPI is not set:

    sound/soc/codecs/rt5514.c: In function ‘rt5514_dsp_voice_wake_up_put’:
    sound/soc/codecs/rt5514.c:363: warning: ‘buf[0]’ is used uninitialized in this function
    sound/soc/codecs/rt5514.c:363: warning: ‘buf[1]’ is used uninitialized in this function
    sound/soc/codecs/rt5514.c:363: warning: ‘buf[2]’ is used uninitialized in this function
    sound/soc/codecs/rt5514.c:363: warning: ‘buf[3]’ is used uninitialized in this function

Fix this by initializing the buffer with zeroes, to avoid random bits
being written to the calibration register later.

Fixes: fc9cab05837639ce ("ASoC: rt5514: The DSP clock can be calibrated by the other clock source")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/rt5514.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/rt5514.c b/sound/soc/codecs/rt5514.c
index b358704ee19c..e8a66b03faab 100644
--- a/sound/soc/codecs/rt5514.c
+++ b/sound/soc/codecs/rt5514.c
@@ -357,6 +357,7 @@ static int rt5514_dsp_voice_wake_up_put(struct snd_kcontrol *kcontrol,
 #else
 				dev_err(component->dev, "There is no SPI driver for"
 					" loading the firmware\n");
+				memset(buf, 0, sizeof(buf));
 #endif
 				rt5514->pll3_cal_value = buf[0] | buf[1] << 8 |
 					buf[2] << 16 | buf[3] << 24;
-- 
2.16.2


--===============6372202826988666812==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6372202826988666812==--
