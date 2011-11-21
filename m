From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 1/2] ASoC: sdp4430: No need to announce the
	loading of the driver
Date: Mon, 21 Nov 2011 15:14:05 +0200
Message-ID: <1321881246-24163-2-git-send-email-peter.ujfalusi@ti.com>
References: <1321881246-24163-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog109.obsmtp.com (na3sys009aog109.obsmtp.com
	[74.125.149.201])
	by alsa0.perex.cz (Postfix) with ESMTP id 586E12413F
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 14:14:40 +0100 (CET)
Received: by mail-bw0-f53.google.com with SMTP id q10so7264035bka.26
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 05:14:39 -0800 (PST)
In-Reply-To: <1321881246-24163-1-git-send-email-peter.ujfalusi@ti.com>
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
Cc: alsa-devel@alsa-project.org, Misael Lopez Cruz <misael.lopez@ti.com>
List-Id: alsa-devel@alsa-project.org

Reduce the noise in kernel log for SDP4430 from audio.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/sdp4430.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/omap/sdp4430.c b/sound/soc/omap/sdp4430.c
index 03d9fa4..eef80b5 100644
--- a/sound/soc/omap/sdp4430.c
+++ b/sound/soc/omap/sdp4430.c
@@ -180,7 +180,6 @@ static int __init sdp4430_soc_init(void)
 
 	if (!machine_is_omap_4430sdp())
 		return -ENODEV;
-	printk(KERN_INFO "SDP4430 SoC init\n");
 
 	sdp4430_snd_device = platform_device_alloc("soc-audio", -1);
 	if (!sdp4430_snd_device) {
-- 
1.7.8.rc3
