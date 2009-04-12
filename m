From: Alexander Beregalov <a.beregalov@gmail.com>
Subject: [PATCH] ASoC: n810: replace BUG() with BUG_ON()
Date: Sun, 12 Apr 2009 05:04:43 +0400
Message-ID: <20090412010443.GA20476@orion>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.155])
	by alsa0.perex.cz (Postfix) with ESMTP id 49DF51037ED
	for <alsa-devel@alsa-project.org>;
	Sun, 12 Apr 2009 03:04:47 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id 22so470694fge.21
	for <alsa-devel@alsa-project.org>; Sat, 11 Apr 2009 18:04:46 -0700 (PDT)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org



Signed-off-by: Alexander Beregalov <a.beregalov@gmail.com>
---

 sound/soc/omap/n810.c |    7 +++----
 1 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/sound/soc/omap/n810.c b/sound/soc/omap/n810.c
index a6d1178..e54e1c2 100644
--- a/sound/soc/omap/n810.c
+++ b/sound/soc/omap/n810.c
@@ -383,10 +383,9 @@ static int __init n810_soc_init(void)
 	clk_set_parent(sys_clkout2_src, func96m_clk);
 	clk_set_rate(sys_clkout2, 12000000);
 
-	if (gpio_request(N810_HEADSET_AMP_GPIO, "hs_amp") < 0)
-		BUG();
-	if (gpio_request(N810_SPEAKER_AMP_GPIO, "spk_amp") < 0)
-		BUG();
+	BUG_ON((gpio_request(N810_HEADSET_AMP_GPIO, "hs_amp") < 0) ||
+	       (gpio_request(N810_SPEAKER_AMP_GPIO, "spk_amp") < 0));
+
 	gpio_direction_output(N810_HEADSET_AMP_GPIO, 0);
 	gpio_direction_output(N810_SPEAKER_AMP_GPIO, 0);
