From: Luotao Fu <l.fu@pengutronix.de>
Subject: [PATCH] pxa2xx-ac97: fix displaying GSR after reset timeout
Date: Thu, 26 Mar 2009 13:18:03 +0100
Message-ID: <1238069883-12445-1-git-send-email-l.fu@pengutronix.de>
References: <20090325103406.GA20936@sirena.org.uk>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1754690AbZCZMSX@vger.kernel.org>
In-Reply-To: <20090325103406.GA20936@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: broonie@sirena.org.uk
Cc: linux@arm.linux.org.uk, dbaryshkov@gmail.com, alsa-devel@alsa-project.org, linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org, Luotao Fu <l.fu@pengutronix.de>
List-Id: alsa-devel@alsa-project.org

the variable gsr_bit is set in isr. It is however set to 0 and interrupts are
disabled prior to reset. Hence it doesn't make a lot of sense to show the
content of gsr_bit in case of a reset timeout.

Signed-off-by: Luotao Fu <l.fu@pengutronix.de>
---
 sound/arm/pxa2xx-ac97-lib.c |   15 ++++++++++-----
 1 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/sound/arm/pxa2xx-ac97-lib.c b/sound/arm/pxa2xx-ac97-lib.c
index 35afd0c..bbb71ae 100644
--- a/sound/arm/pxa2xx-ac97-lib.c
+++ b/sound/arm/pxa2xx-ac97-lib.c
@@ -199,6 +199,8 @@ static inline void pxa_ac97_cold_pxa3xx(void)
 
 bool pxa2xx_ac97_try_warm_reset(struct snd_ac97 *ac97)
 {
+	unsigned long gsr;
+
 #ifdef CONFIG_PXA25x
 	if (cpu_is_pxa25x())
 		pxa_ac97_warm_pxa25x();
@@ -215,10 +217,10 @@ bool pxa2xx_ac97_try_warm_reset(struct snd_ac97 *ac97)
 	else
 #endif
 		BUG();
-
-	if (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR))) {
+	gsr = GSR | gsr_bits;
+	if (!(gsr & (GSR_PCR | GSR_SCR))) {
 		printk(KERN_INFO "%s: warm reset timeout (GSR=%#lx)\n",
-				 __func__, gsr_bits);
+				 __func__, gsr);
 
 		return false;
 	}
@@ -229,6 +231,8 @@ EXPORT_SYMBOL_GPL(pxa2xx_ac97_try_warm_reset);
 
 bool pxa2xx_ac97_try_cold_reset(struct snd_ac97 *ac97)
 {
+	unsigned long gsr;
+
 #ifdef CONFIG_PXA25x
 	if (cpu_is_pxa25x())
 		pxa_ac97_cold_pxa25x();
@@ -246,9 +250,10 @@ bool pxa2xx_ac97_try_cold_reset(struct snd_ac97 *ac97)
 #endif
 		BUG();
 
-	if (!((GSR | gsr_bits) & (GSR_PCR | GSR_SCR))) {
+	gsr = GSR | gsr_bits;
+	if (!(gsr & (GSR_PCR | GSR_SCR))) {
 		printk(KERN_INFO "%s: cold reset timeout (GSR=%#lx)\n",
-				 __func__, gsr_bits);
+				 __func__, gsr);
 
 		return false;
 	}
-- 
1.6.2
