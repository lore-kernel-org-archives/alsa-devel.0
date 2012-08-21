From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/3] ASoC: omap-mcbsp: Only print warning if
	the st_data is missing for the port
Date: Tue, 21 Aug 2012 17:42:02 +0300
Message-ID: <1345560123-23959-3-git-send-email-peter.ujfalusi@ti.com>
References: <1345560123-23959-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog106.obsmtp.com (na3sys009aob106.obsmtp.com
 [74.125.149.76])
 by alsa0.perex.cz (Postfix) with ESMTP id 7BA3E26600E
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 16:42:20 +0200 (CEST)
Received: by eeke52 with SMTP id e52so2398796eek.13
 for <alsa-devel@alsa-project.org>; Tue, 21 Aug 2012 07:42:19 -0700 (PDT)
In-Reply-To: <1345560123-23959-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

When asked to add the ST controls warn only if the st_data is missing.
In this way we do not block the otherwise functional card to probe.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcbsp.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 84a3132..c964f68 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -719,8 +719,10 @@ int omap_mcbsp_st_add_controls(struct snd_soc_pcm_runtime *rtd)
 	struct snd_soc_dai *cpu_dai = rtd->cpu_dai;
 	struct omap_mcbsp *mcbsp = snd_soc_dai_get_drvdata(cpu_dai);
 
-	if (!mcbsp->st_data)
-		return -ENODEV;
+	if (!mcbsp->st_data) {
+		dev_warn(mcbsp->dev, "No sidetone data for port\n");
+		return 0;
+	}
 
 	switch (mcbsp->id) {
 	case 2: /* McBSP 2 */
-- 
1.7.8.6
