From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH] ASoC: omap-mcpdm: Set constraint for 24 msb
Date: Sat, 14 Jan 2012 17:16:43 +0100
Message-ID: <1326557803-18728-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog122.obsmtp.com (na3sys009aog122.obsmtp.com
	[74.125.149.147])
	by alsa0.perex.cz (Postfix) with ESMTP id 968B12466D
	for <alsa-devel@alsa-project.org>; Sat, 14 Jan 2012 17:17:18 +0100 (CET)
Received: by ggnk1 with SMTP id k1so2393221ggn.32
	for <alsa-devel@alsa-project.org>; Sat, 14 Jan 2012 08:17:16 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@ti.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

OMAP McPDM supports 24 msb in the 32 bit sample.
Make sure that applications get this information.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcpdm.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/sound/soc/omap/omap-mcpdm.c b/sound/soc/omap/omap-mcpdm.c
index 0e25df4..50d758a 100644
--- a/sound/soc/omap/omap-mcpdm.c
+++ b/sound/soc/omap/omap-mcpdm.c
@@ -265,6 +265,8 @@ static int omap_mcpdm_dai_startup(struct snd_pcm_substream *substream,
 
 	mutex_lock(&mcpdm->mutex);
 
+	snd_pcm_hw_constraint_msbits(substream->runtime, 0, 32, 24);
+
 	if (!dai->active) {
 		/* Enable watch dog for ES above ES 1.0 to avoid saturation */
 		if (omap_rev() != OMAP4430_REV_ES1_0) {
-- 
1.7.8.3
