From: Mark Brown <broonie@kernel.org>
Subject: Applied "ASoC: Intel: Atom: flip logic for gain
	Switch" to the asoc tree
Date: Sat, 19 Dec 2015 11:51:27 +0000
Message-ID: <E1aAG2p-0004cc-C3@debutante>
References: <1450406156-22246-12-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 257262606BB
 for <alsa-devel@alsa-project.org>; Sat, 19 Dec 2015 12:51:36 +0100 (CET)
In-Reply-To: <1450406156-22246-12-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Sebastien Guiriec <sebastien.guiriec@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

The patch

   ASoC: Intel: Atom: flip logic for gain Switch

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

>From 940a5a014d50e15269b5d197ab571d1ca9971c43 Mon Sep 17 00:00:00 2001
From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Date: Thu, 17 Dec 2015 20:35:48 -0600
Subject: [PATCH] ASoC: Intel: Atom: flip logic for gain Switch

The upstreamed code modified the control names from Mute to
Switch without changing the logic. To get audio working the Switch
needs to be off which isn't aligned with normal ALSA conventions.

Inverting the logic now so that Switch Off means mute and Switch On
means active audio using the specific volume setting.

Signed-off-by: Sebastien Guiriec <sebastien.guiriec@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 sound/soc/intel/atom/sst-atom-controls.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
index 1727cc4c7f8a..b97e6adcf1b2 100644
--- a/sound/soc/intel/atom/sst-atom-controls.c
+++ b/sound/soc/intel/atom/sst-atom-controls.c
@@ -443,7 +443,7 @@ static int sst_gain_get(struct snd_kcontrol *kcontrol,
 		break;
 
 	case SST_GAIN_MUTE:
-		ucontrol->value.integer.value[0] = gv->mute ? 1 : 0;
+		ucontrol->value.integer.value[0] = gv->mute ? 0 : 1;
 		break;
 
 	case SST_GAIN_RAMP_DURATION:
@@ -479,7 +479,7 @@ static int sst_gain_put(struct snd_kcontrol *kcontrol,
 		break;
 
 	case SST_GAIN_MUTE:
-		gv->mute = !!ucontrol->value.integer.value[0];
+		gv->mute = !ucontrol->value.integer.value[0];
 		dev_dbg(cmpnt->dev, "%s: Mute %d\n", mc->pname, gv->mute);
 		break;
 
-- 
2.6.2
