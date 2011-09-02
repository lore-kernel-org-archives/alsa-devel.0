From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH] ASoC: Add missing platform_device_put in
 raumfeld_audio_init error path
Date: Fri, 02 Sep 2011 21:47:41 +0800
Message-ID: <1314971261.3699.0.camel@phoenix>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Daniel Mack <daniel@caiaq.de>, Liam Girdwood <lrg@ti.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/pxa/raumfeld.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/sound/soc/pxa/raumfeld.c b/sound/soc/pxa/raumfeld.c
index 1a591f1..b899a3b 100644
--- a/sound/soc/pxa/raumfeld.c
+++ b/sound/soc/pxa/raumfeld.c
@@ -306,8 +306,10 @@ static int __init raumfeld_audio_init(void)
 				     &snd_soc_raumfeld_connector);
 
 	ret = platform_device_add(raumfeld_audio_device);
-	if (ret < 0)
+	if (ret < 0) {
+		platform_device_put(raumfeld_audio_device);
 		return ret;
+	}
 
 	raumfeld_enable_audio(true);
 	return 0;
-- 
1.7.4.1
