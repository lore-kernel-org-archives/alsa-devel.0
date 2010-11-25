From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 3/8] ASoC: snd-soc-afeb9260: remove unneeded
	platform_device_del in error path
Date: Thu, 25 Nov 2010 15:10:01 +0800
Message-ID: <1290669001.30158.13.camel@mola>
References: <1290668785.30158.7.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1290668785.30158.7.camel@mola>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Sergey Lapin <slapin@ossfans.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

>From f3b1f9a02fe390b2f12b9097a1d4d9de55618b34 Mon Sep 17 00:00:00 2001
From: Axel Lin <axel.lin@gmail.com>
Date: Thu, 25 Nov 2010 10:44:59 +0800
Subject: [PATCH 3/8] ASoC: snd-soc-afeb9260: remove unneeded platform_device_del in error path

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/atmel/snd-soc-afeb9260.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/sound/soc/atmel/snd-soc-afeb9260.c b/sound/soc/atmel/snd-soc-afeb9260.c
index 1202f5e..da2208e 100644
--- a/sound/soc/atmel/snd-soc-afeb9260.c
+++ b/sound/soc/atmel/snd-soc-afeb9260.c
@@ -167,7 +167,6 @@ static int __init afeb9260_soc_init(void)
 
 	return 0;
 err1:
-	platform_device_del(afeb9260_snd_device);
 	platform_device_put(afeb9260_snd_device);
 	return err;
 }
-- 
1.7.2
