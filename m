From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] Revert "ASoC: core: Try to use regmap if the
	driver doesn't set up any I/O"
Date: Wed,  1 Aug 2012 16:50:22 +0300
Message-ID: <1343829022-23259-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog120.obsmtp.com (na3sys009aog120.obsmtp.com
 [74.125.149.140])
 by alsa0.perex.cz (Postfix) with ESMTP id 9A606265BA3
 for <alsa-devel@alsa-project.org>; Wed,  1 Aug 2012 15:49:38 +0200 (CEST)
Received: by obbuo13 with SMTP id uo13so14092168obb.33
 for <alsa-devel@alsa-project.org>; Wed, 01 Aug 2012 06:49:39 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Some codec driver can not have regmap implementation so core should not
assume that codecs without control_data have implemented regmap of it's
own.

This reverts commit 38cbf9598feba97de9f9b43efa9153fd7c1a2ec9.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---

Hi Mark,

the reverted patch broke the audio on OMAP based board using twl4030, twl6040
as codec.
We can not have regmap implementaion within these codec drivers since they rely
on the MFD core to do the IO towards the chip.

Regards,
Peter

 sound/soc/soc-core.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/sound/soc/soc-core.c b/sound/soc/soc-core.c
index f219b2f..da31aa4 100644
--- a/sound/soc/soc-core.c
+++ b/sound/soc/soc-core.c
@@ -1095,10 +1095,6 @@ static int soc_probe_codec(struct snd_soc_card *card,
 		}
 	}
 
-	/* If the driver didn't set I/O up try regmap */
-	if (!codec->control_data)
-		snd_soc_codec_set_cache_io(codec, 0, 0, SND_SOC_REGMAP);
-
 	if (driver->controls)
 		snd_soc_add_codec_controls(codec, driver->controls,
 				     driver->num_controls);
-- 
1.7.8.6
