From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: core: Set dapm->idle_bias_off for DAIs
	not mapped with a codec
Date: Tue,  7 Aug 2012 10:24:13 +0300
Message-ID: <1344324253-30327-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog113.obsmtp.com (na3sys009aog113.obsmtp.com
 [74.125.149.209])
 by alsa0.perex.cz (Postfix) with ESMTP id AB56B265D83
 for <alsa-devel@alsa-project.org>; Tue,  7 Aug 2012 08:54:40 +0200 (CEST)
Received: by obbeh20 with SMTP id eh20so6197133obb.10
 for <alsa-devel@alsa-project.org>; Tue, 07 Aug 2012 00:24:24 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org, Stephen Warren <swarren@nvidia.com>
List-Id: alsa-devel@alsa-project.org

The idle_bias_off flag is not configured for DAIs not mapped with a codec.
This causes the pm counter to be increased at probe time for the CPU dai
which unbalances the pm counter handling.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---

Hello Mark,

I'm not sure if this is the correct way to fix the problem but this patch works
for me.

The issue in short:
Since commit: '18d7564 ASoC: when removing a CPU DAI, clean up its DAPM context'
After booting up the kernel on BeagleBoard for example I see that the clocks are
enabled for the McBSP CPU dai. This alone causing the first stream start to fail
due to unbalanced pm_runtime counter. Later it stabilizes, but I see failures
with full duplex operation (arecord | aplay).
The root cause of this is not commit 18d7564, but the fact that we did not
configured the dapm->idle_bias_off for the CPU dai to be 1 (we do this for the
platform driver). The pm_runtime_get_sync is called from
dapm_pre_sequence_async() - since we add the cpu_dai dapm context to the list.

With this patch we set the dapm->idle_bias_off for DAIs not linked with a codec
which means cpu_dais.
If this is not acceptable we need to set this flag in the cpu_dai driver itself.

Regards,
Peter

 sound/soc/soc-core.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f81c597..f10f00b 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -3715,6 +3715,9 @@ int snd_soc_register_dai(struct device *dev,
 		}
 	}
 
+	if (!dai->codec)
+		dai->dapm.idle_bias_off = 1;
+
 	list_add(&dai->list, &dai_list);
 
 	mutex_unlock(&client_mutex);
@@ -3803,6 +3806,9 @@ int snd_soc_register_dais(struct device *dev,
 			}
 		}
 
+		if (!dai->codec)
+			dai->dapm.idle_bias_off = 1;
+
 		list_add(&dai->list, &dai_list);
 
 		mutex_unlock(&client_mutex);
-- 
1.7.8.6
