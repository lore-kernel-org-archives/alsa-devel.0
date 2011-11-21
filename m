From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Subject: [PATCH 2/2] ASoC: sdp4430: Fix Panda support
Date: Mon, 21 Nov 2011 15:14:06 +0200
Message-ID: <1321881246-24163-3-git-send-email-peter.ujfalusi@ti.com>
References: <1321881246-24163-1-git-send-email-peter.ujfalusi@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from na3sys009aog101.obsmtp.com (na3sys009aog101.obsmtp.com
	[74.125.149.67]) by alsa0.perex.cz (Postfix) with ESMTP id 203192413A
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 14:14:41 +0100 (CET)
Received: by mail-fx0-f49.google.com with SMTP id r25so7323479faa.36
	for <alsa-devel@alsa-project.org>; Mon, 21 Nov 2011 05:14:40 -0800 (PST)
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

Panda supposed to be using the same driver (Kconfig selects
sdp4430 for panda board as well), but due to the wrong
machine_is check the Panda board support was broken.

Fix the Panda board support, and use different card name for
the SDP4430/Panda.

Signed-off-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
---
 sound/soc/omap/sdp4430.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/sound/soc/omap/sdp4430.c b/sound/soc/omap/sdp4430.c
index eef80b5..5b633b6 100644
--- a/sound/soc/omap/sdp4430.c
+++ b/sound/soc/omap/sdp4430.c
@@ -162,7 +162,6 @@ static struct snd_soc_dai_link sdp4430_dai = {
 
 /* Audio machine driver */
 static struct snd_soc_card snd_soc_sdp4430 = {
-	.name = "SDP4430",
 	.dai_link = &sdp4430_dai,
 	.num_links = 1,
 
@@ -178,7 +177,11 @@ static int __init sdp4430_soc_init(void)
 {
 	int ret;
 
-	if (!machine_is_omap_4430sdp())
+	if (machine_is_omap_4430sdp())
+		snd_soc_sdp4430.name = "OMAP4 SDP";
+	else if (machine_is_omap4_panda())
+		snd_soc_sdp4430.name = "OMAP4 Panda";
+	else
 		return -ENODEV;
 
 	sdp4430_snd_device = platform_device_alloc("soc-audio", -1);
-- 
1.7.8.rc3
