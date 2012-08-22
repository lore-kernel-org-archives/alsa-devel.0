From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH v2 1/4] ASoC: omap-mcbsp: Check mcbsp->id
	instead of cpu_dai->id when adding ST controls
Date: Wed, 22 Aug 2012 13:11:40 +0300
Message-ID: <1345630303-26291-2-git-send-email-peter.ujfalusi@ti.com>
References: <1345630303-26291-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog106.obsmtp.com (na3sys009aob106.obsmtp.com
 [74.125.149.76])
 by alsa0.perex.cz (Postfix) with ESMTP id 210502660E1
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2012 12:11:56 +0200 (CEST)
Received: by obbta17 with SMTP id ta17so1214927obb.36
 for <alsa-devel@alsa-project.org>; Wed, 22 Aug 2012 03:11:57 -0700 (PDT)
In-Reply-To: <1345630303-26291-1-git-send-email-peter.ujfalusi@ti.com>
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

In ddevice tree booted kernel all device have unique name and their device
id is set to 0.
Use the mcbsp->id for checking to decide which control set we should add
for McBSP sidetone handling.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcbsp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index d6de066..84a3132 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -722,7 +722,7 @@ int omap_mcbsp_st_add_controls(struct snd_soc_pcm_runtime *rtd)
 	if (!mcbsp->st_data)
 		return -ENODEV;
 
-	switch (cpu_dai->id) {
+	switch (mcbsp->id) {
 	case 2: /* McBSP 2 */
 		return snd_soc_add_dai_controls(cpu_dai,
 					omap_mcbsp2_st_controls,
-- 
1.7.8.6
