From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] ASoC: omap-mcbsp: Use future proof OMAP
	version checks for configuration
Date: Tue, 17 Jan 2012 14:16:10 +0100
Message-ID: <1326806170-7425-3-git-send-email-peter.ujfalusi@ti.com>
References: <1326806170-7425-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog113.obsmtp.com (na3sys009aog113.obsmtp.com
	[74.125.149.209])
	by alsa0.perex.cz (Postfix) with ESMTP id CF03A1039CC
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 14:16:38 +0100 (CET)
Received: by mail-gy0-f173.google.com with SMTP id g20so1193294ghb.4
	for <alsa-devel@alsa-project.org>; Tue, 17 Jan 2012 05:16:37 -0800 (PST)
In-Reply-To: <1326806170-7425-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Jarkko Nikula <jarkko.nikula@bitmer.com>
List-Id: alsa-devel@alsa-project.org

Change the cpu_is_ checks so that we do not need to change them when new
SoC is available.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/omap-mcbsp.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/omap-mcbsp.c b/sound/soc/omap/omap-mcbsp.c
index 56333d5..4c3218f 100644
--- a/sound/soc/omap/omap-mcbsp.c
+++ b/sound/soc/omap/omap-mcbsp.c
@@ -416,11 +416,11 @@ static int omap_mcbsp_dai_set_dai_fmt(struct snd_soc_dai *cpu_dai,
 	regs->spcr2	|= XINTM(3) | FREE;
 	regs->spcr1	|= RINTM(3);
 	/* RFIG and XFIG are not defined in 34xx */
-	if (!cpu_is_omap34xx() && !cpu_is_omap44xx()) {
+	if (cpu_class_is_omap1() || cpu_is_omap24xx()) {
 		regs->rcr2	|= RFIG;
 		regs->xcr2	|= XFIG;
 	}
-	if (cpu_is_omap2430() || cpu_is_omap34xx() || cpu_is_omap44xx()) {
+	if (cpu_class_is_omap2() && !cpu_is_omap242x()) {
 		regs->xccr = DXENDLY(1) | XDMAEN | XDISABLE;
 		regs->rccr = RFULL_CYCLE | RDMAEN | RDISABLE;
 	}
-- 
1.7.8.3
