From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: arizona: Add default cases for event
	switches" to the asoc tree
Date: Wed, 16 Sep 2015 21:01:41 +0100
Message-ID: <E1ZcIth-0007q2-70@finisterre>
References: <1442408383-31682-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 07567261AAB
 for <alsa-devel@alsa-project.org>; Wed, 16 Sep 2015 22:01:51 +0200 (CEST)
In-Reply-To: <1442408383-31682-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: arizona: Add default cases for event switches

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

>From bee261b8964d7751fdd63d7f636c42741294a30c Mon Sep 17 00:00:00 2001
From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Date: Wed, 16 Sep 2015 13:59:40 +0100
Subject: [PATCH] ASoC: arizona: Add default cases for event switches

Since the addition of the WILL_PMU / WILL_PMD several of the switches in
arizona.c no longer cover all cases or have a default case. Whilst this
isn't causing any problems in the interests of robustness add default
cases.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/codecs/arizona.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sound/soc/codecs/arizona.c b/sound/soc/codecs/arizona.c
index 8a2221a..1bc19f1 100644
--- a/sound/soc/codecs/arizona.c
+++ b/sound/soc/codecs/arizona.c
@@ -147,6 +147,8 @@ static int arizona_spk_ev(struct snd_soc_dapm_widget *w,
 						   0x4f5, 0x0da);
 		}
 		break;
+	default:
+		break;
 	}
 
 	return 0;
@@ -725,6 +727,9 @@ int arizona_in_ev(struct snd_soc_dapm_widget *w, struct snd_kcontrol *kcontrol,
 		reg = snd_soc_read(codec, ARIZONA_INPUT_ENABLES);
 		if (reg == 0)
 			arizona_in_set_vu(codec, 0);
+		break;
+	default:
+		break;
 	}
 
 	return 0;
@@ -806,6 +811,8 @@ int arizona_out_ev(struct snd_soc_dapm_widget *w,
 			break;
 		}
 		break;
+	default:
+		break;
 	}
 
 	return 0;
-- 
2.5.0
