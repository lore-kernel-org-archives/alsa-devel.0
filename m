From: Roel Kluin <roel.kluin@gmail.com>
Subject: [PATCH] ASoC: count reaches 10001, not 10000.
Date: Sun, 08 Feb 2009 18:17:37 +0100
Message-ID: <498F13B1.1090704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.191])
	by alsa0.perex.cz (Postfix) with ESMTP id 57B662433B
	for <alsa-devel@alsa-project.org>; Sun,  8 Feb 2009 18:17:38 +0100 (CET)
Received: by nf-out-0910.google.com with SMTP id e27so323402nfd.32
	for <alsa-devel@alsa-project.org>; Sun, 08 Feb 2009 09:17:37 -0800 (PST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: lrg@slimlogic.co.uk, cooloney@kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: uclinux-dist-devel@blackfin.uclinux.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

With a postfix increment count reaches 10001, not 10000.

diff --git a/sound/soc/blackfin/bf5xx-ad73311.c b/sound/soc/blackfin/bf5xx-ad73311.c
index 7f2a5e1..edfbdc0 100644
--- a/sound/soc/blackfin/bf5xx-ad73311.c
+++ b/sound/soc/blackfin/bf5xx-ad73311.c
@@ -114,7 +114,7 @@ static int snd_ad73311_configure(void)
 	SSYNC();
 
 	/* When TUVF is set, the data is already send out */
-	while (!(status & TUVF) && count++ < 10000) {
+	while (!(status & TUVF) && ++count < 10000) {
 		udelay(1);
 		status = bfin_read_SPORT_STAT();
 		SSYNC();
@@ -123,7 +123,7 @@ static int snd_ad73311_configure(void)
 	SSYNC();
 	local_irq_enable();
 
-	if (count == 10000) {
+	if (count >= 10000) {
 		printk(KERN_ERR "ad73311: failed to configure codec\n");
 		return -1;
 	}
