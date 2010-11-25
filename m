From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 2/8] ASoC: pcm030-audio-fabric: fix resource leak in
	pcm030_fabric_init error path
Date: Thu, 25 Nov 2010 15:08:31 +0800
Message-ID: <1290668911.30158.10.camel@mola>
References: <1290668785.30158.7.camel@mola>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1290668785.30158.7.camel@mola>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Jon Smirl <jonsmirl@gmail.com>, Liam Girdwood <lrg@slimlogic.co.uk>, Mark Brown <broonie@opensource.wolfsonmicro.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Add missing platform_device_put() if platform_device_add() failed.

Signed-off-by: Axel Lin <axel.lin@gmail.com>
---
 sound/soc/fsl/pcm030-audio-fabric.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/fsl/pcm030-audio-fabric.c b/sound/soc/fsl/pcm030-audio-fabric.c
index 25f27ec..ba4d85e 100644
--- a/sound/soc/fsl/pcm030-audio-fabric.c
+++ b/sound/soc/fsl/pcm030-audio-fabric.c
@@ -76,6 +76,7 @@ static __init int pcm030_fabric_init(void)
 	rc = platform_device_add(pdev);
 	if (rc) {
 		pr_err("pcm030_fabric_init: platform_device_add() failed\n");
+		platform_device_put(pdev);
 		return -ENODEV;
 	}
 	return 0;
-- 
1.7.2
