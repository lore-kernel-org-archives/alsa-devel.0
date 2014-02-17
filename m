From: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
Subject: [PATCH 03/15] ASoC: adav80x: Update locking around use
	of DAPM pin API
Date: Mon, 17 Feb 2014 16:51:31 +0000
Message-ID: <1392655903-24537-4-git-send-email-ckeepax@opensource.wolfsonmicro.com>
References: <1392655903-24537-1-git-send-email-ckeepax@opensource.wolfsonmicro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
 [80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 092EE264F0A
 for <alsa-devel@alsa-project.org>; Mon, 17 Feb 2014 18:00:02 +0100 (CET)
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

The pin updates in this driver look like they are intended to be done
atomically, update to do so.

Signed-off-by: Charles Keepax <ckeepax@opensource.wolfsonmicro.com>
---
 sound/soc/codecs/adav80x.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/sound/soc/codecs/adav80x.c b/sound/soc/codecs/adav80x.c
index f78b27a..aacb2c03 100644
--- a/sound/soc/codecs/adav80x.c
+++ b/sound/soc/codecs/adav80x.c
@@ -600,15 +600,21 @@ static int adav80x_set_sysclk(struct snd_soc_codec *codec,
 			adav80x->sysclk_pd[clk_id] = false;
 		}
 
+		mutex_lock(&codec->dapm.card->dapm_mutex);
+
 		if (adav80x->sysclk_pd[0])
-			snd_soc_dapm_disable_pin(&codec->dapm, "PLL1");
+			snd_soc_dapm_disable_pin_locked(&codec->dapm, "PLL1");
 		else
-			snd_soc_dapm_force_enable_pin(&codec->dapm, "PLL1");
+			snd_soc_dapm_force_enable_pin_locked(&codec->dapm,
+							     "PLL1");
 
 		if (adav80x->sysclk_pd[1] || adav80x->sysclk_pd[2])
-			snd_soc_dapm_disable_pin(&codec->dapm, "PLL2");
+			snd_soc_dapm_disable_pin_locked(&codec->dapm, "PLL2");
 		else
-			snd_soc_dapm_force_enable_pin(&codec->dapm, "PLL2");
+			snd_soc_dapm_force_enable_pin_locked(&codec->dapm,
+							     "PLL2");
+
+		mutex_unlock(&codec->dapm.card->dapm_mutex);
 
 		snd_soc_dapm_sync(&codec->dapm);
 	}
-- 
1.7.2.5
