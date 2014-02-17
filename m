From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 01/15] Input - arizona-haptics: Fix double lock
	of dapm_mutex
Date: Mon, 17 Feb 2014 16:51:29 +0000
Message-ID: <1392655903-24537-2-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1392655903-24537-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 087F4264F07
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2014 17:59:59 +0100 (CET)
In-Reply-To: <1392655903-24537-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: broonie@kernel.org
Cc: alsa-devel@alsa-project.org, lars@metafoo.de, eric.y.miao@gmail.com, dmitry.torokhov@gmail.com, lgirdwood@gmail.com, haojian.zhuang@gmail.com, linux-kernel@vger.kernel.org, peter.ujfalusi@ti.com, cw00.choi@samsung.com, myungjoo.ham@samsung.com, patches@opensource.wolfsonmicro.com, linux@arm.linux.org.uk, jarkko.nikula@bitmer.com
List-Id: alsa-devel@alsa-project.org

snd_soc_dapm_sync takes the dapm_mutex internally, but we currently take
it externally as well. This patch fixes this.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 drivers/input/misc/arizona-haptics.c |   11 ++++-------
 1 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/input/misc/arizona-haptics.c b/drivers/input/misc/arizona-haptics.c
index 7a04f54..e7e12a5 100644
--- a/drivers/input/misc/arizona-haptics.c
+++ b/drivers/input/misc/arizona-haptics.c
@@ -77,16 +77,14 @@ static void arizona_haptics_work(struct work_struct *work)
 			return;
 		}
 
+		mutex_unlock(dapm_mutex);
+
 		ret = snd_soc_dapm_sync(arizona->dapm);
 		if (ret != 0) {
 			dev_err(arizona->dev, "Failed to sync DAPM: %d\n",
 				ret);
-			mutex_unlock(dapm_mutex);
 			return;
 		}
-
-		mutex_unlock(dapm_mutex);
-
 	} else {
 		/* This disable sequence will be a noop if already enabled */
 		mutex_lock_nested(dapm_mutex, SND_SOC_DAPM_CLASS_RUNTIME);
@@ -99,16 +97,15 @@ static void arizona_haptics_work(struct work_struct *work)
 			return;
 		}
 
+		mutex_unlock(dapm_mutex);
+
 		ret = snd_soc_dapm_sync(arizona->dapm);
 		if (ret != 0) {
 			dev_err(arizona->dev, "Failed to sync DAPM: %d\n",
 				ret);
-			mutex_unlock(dapm_mutex);
 			return;
 		}
 
-		mutex_unlock(dapm_mutex);
-
 		ret = regmap_update_bits(arizona->regmap,
 					 ARIZONA_HAPTICS_CONTROL_1,
 					 ARIZONA_HAP_CTRL_MASK,
-- 
1.7.2.5
