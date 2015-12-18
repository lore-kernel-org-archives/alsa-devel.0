From: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Subject: [PATCH 11/19] ASoC: Intel: Atom: flip logic for gain
	Switch
Date: Thu, 17 Dec 2015 20:35:48 -0600
Message-ID: <1450406156-22246-12-git-send-email-pierre-louis.bossart@linux.intel.com>
References: <1450406156-22246-1-git-send-email-pierre-louis.bossart@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 1822A2615C0
 for <alsa-devel@alsa-project.org>; Fri, 18 Dec 2015 03:37:22 +0100 (CET)
In-Reply-To: <1450406156-22246-1-git-send-email-pierre-louis.bossart@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: bardliao@realtek.com, broonie@kernel.org, Sebastien Guiriec <sebastien.guiriec@intel.com>, Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>, jack.yu@realtek.com
List-Id: alsa-devel@alsa-project.org

The upstreamed code modified the control names from Mute to
Switch without changing the logic. To get audio working the Switch
needs to be off which isn't aligned with normal ALSA conventions.

Inverting the logic now so that Switch Off means mute and Switch On
means active audio using the specific volume setting.

Signed-off-by: Sebastien Guiriec <sebastien.guiriec@intel.com>
Signed-off-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
---
 sound/soc/intel/atom/sst-atom-controls.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/intel/atom/sst-atom-controls.c b/sound/soc/intel/atom/sst-atom-controls.c
index 1727cc4..b97e6ad 100644
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
1.9.1
