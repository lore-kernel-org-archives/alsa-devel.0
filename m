From: Chuansheng Liu <chuansheng.liu@intel.com>
Subject: [PATCH] ASoC: core: giving WARN when device starting from non-off
 bias with idle_bias_off
Date: Fri, 21 Dec 2012 18:17:12 +0800
Message-ID: <1356085032.1839.14.camel@cliu38-desktop-build>
References: <1355913397.17896.10.camel@cliu38-desktop-build>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1355913397.17896.10.camel@cliu38-desktop-build>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@opensource.wolfsonmicro.com
Cc: lrg@ti.com, perex@perex.cz, tiwai@suse.de, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com
List-Id: alsa-devel@alsa-project.org


Just found some cases that some codec drivers set the bias to _STANDBY and
set idle_bias_off to 1 during probing.
It will cause unpaired runtime_get_sync/put() issue. Also as Mark suggested,
there is no reason to start from _STANDBY bias with idle_bias_off == 1.

So here giving one warning when detected (dapm.idle_bias_off == 1) and
(dapm.bias_level != SND_SOC_BIAS_OFF) just after driver->probe().

Signed-off-by: liu chuansheng <chuansheng.liu@intel.com>
---
 sound/soc/soc-core.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index 9c768bc..d7ec007 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1107,6 +1107,10 @@ static int soc_probe_codec(struct snd_soc_card *card,
 				"ASoC: failed to probe CODEC %d\n", ret);
 			goto err_probe;
 		}
+		WARN(codec->dapm.idle_bias_off &&
+			codec->dapm.bias_level != SND_SOC_BIAS_OFF,
+			"codec %s can not start from non-off bias"
+			" with idle_bias_off==1\n", codec->name);
 	}
 
 	/* If the driver didn't set I/O up try regmap */
-- 
1.7.0.4
