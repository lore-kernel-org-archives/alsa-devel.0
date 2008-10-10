From: ext-jukka.hynninen@vaisala.com
Subject: ASoC: Merging at91 and avr32 dirs - test report
Date: Fri, 10 Oct 2008 18:15:17 +0300
Message-ID: <B9D3C48C98930741A166756A50C44A610F17B561@helx1.corp.vaisala.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgw.vaisala.com (mailgw.vaisala.com [192.81.123.24])
	by alsa0.perex.cz (Postfix) with ESMTP id 3EE7124767
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Oct 2008 17:15:37 +0200 (CEST)
Received: from helsrv02.vaisala.com (helsrv02.vaisala.com [192.81.123.16])
	by mailgw.vaisala.com (8.13.6/8.13.6) with SMTP id m9AFFJ2T016720
	for <alsa-devel@alsa-project.org>; Fri, 10 Oct 2008 18:15:19 +0300
Content-class: urn:content-classes:message
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: broonie@sirena.org.uk
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I tested the patches and got everything working with minor changes.

However, there seems to be some problem with PM, occasionally ASoC is
stuck with Standby mode (looking at dapm_widgets) when I start the
playback. Restarting the player brings the sound back. I'll carry out
some further investigation and get back to this.

My kernel is 2.6.27-rc3, and machine driver is adapted from
playpaq_wm8510.c to run on at91rm9200 board.

The SSC peripheral clock was disabled more often than it was enabled,
and that catched the bug trap in arch/arm/mach-at91/clock.c. I'm not
sure if this was the real problem, but it's the way I managed to solve
it.


-Jukka


diff -uprN a/sound/soc/atmel/atmel_ssc_dai.c
b/sound/soc/atmel/atmel_ssc_dai.c
--- a/sound/soc/atmel/atmel_ssc_dai.c   2008-10-10 17:23:46.000000000
+0300
+++ b/sound/soc/atmel/atmel_ssc_dai.c   2008-10-10 17:26:06.000000000
+0300
@@ -261,11 +261,11 @@ static void atmel_ssc_shutdown(struct sn
        spin_lock_irq(&ssc_p->lock);
        ssc_p->dir_mask &= ~dir_mask;
        if (!ssc_p->dir_mask) {
-               /* Shutdown the SSC clock. */
-               pr_debug("atmel_ssc_dau: Stopping clock\n");
-               clk_disable(ssc_p->ssc->clk);
-
                if (ssc_p->initialized) {
+                       /* Shutdown the SSC clock. */
+                       pr_debug("atmel_ssc_dai: Stopping clock\n");
+                       clk_disable(ssc_p->ssc->clk);
+
                        free_irq(ssc_p->ssc->irq, ssc_p);
                        ssc_p->initialized = 0;
                }
