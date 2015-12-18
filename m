From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: sgtl5000: fix VAG power up timing" to
	the asoc tree
Date: Fri, 18 Dec 2015 12:15:44 +0000
Message-ID: <E1a9twm-0006EW-Fv@debutante>
References: <1450346843-6700-1-git-send-email-jean-michel.hautbois@veo-labs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id F3D622666A9
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 13:15:50 +0100 (CET)
In-Reply-To: <1450346843-6700-1-git-send-email-jean-michel.hautbois@veo-labs.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Jean-Michel Hautbois <jean-michel.hautbois@veo-labs.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: sgtl5000: fix VAG power up timing

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

>From c803cc2dcd722e08020c1ba63bb5ceece4a19fdb Mon Sep 17 00:00:00 2001
From: Jean-Michel Hautbois <jhautbois@gmail.com>
Date: Thu, 17 Dec 2015 11:07:23 +0100
Subject: [PATCH] ASoC: sgtl5000: fix VAG power up timing

When power up, a "pop" is heard on line-in and mic-in.
An analysis of the PCM shows it lasts ~400ms
and looks like a filter response.
VAG power up should be delayed by 400ms as VAG power down is.

Signed-off-by: Jean-Michel Hautbois <jean-michel.hautbois@veo-labs.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/sgtl5000.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/sound/soc/codecs/sgtl5000.c b/sound/soc/codecs/sgtl5000.c
index f540f82b1f27..08b40460663c 100644
--- a/sound/soc/codecs/sgtl5000.c
+++ b/sound/soc/codecs/sgtl5000.c
@@ -189,6 +189,7 @@ static int power_vag_event(struct snd_soc_dapm_widget *w,
 	case SND_SOC_DAPM_POST_PMU:
 		snd_soc_update_bits(codec, SGTL5000_CHIP_ANA_POWER,
 			SGTL5000_VAG_POWERUP, SGTL5000_VAG_POWERUP);
+		msleep(400);
 		break;
 
 	case SND_SOC_DAPM_PRE_PMD:
-- 
2.6.2
