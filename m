From: Axel Lin <axel.lin@gmail.com>
Subject: [PATCH 1/8] ASoC: efika-audio-fabric: fix resource leak in
	efika_fabric_init error path
Date: Thu, 25 Nov 2010 15:07:25 +0800
Message-ID: <1290668845.30158.8.camel@mola>
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
 sound/soc/fsl/efika-audio-fabric.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/fsl/efika-audio-fabric.c b/sound/soc/fsl/efika-audio-fabric.c
index 53251e6..108b5d8 100644
--- a/sound/soc/fsl/efika-audio-fabric.c
+++ b/sound/soc/fsl/efika-audio-fabric.c
@@ -76,6 +76,7 @@ static __init int efika_fabric_init(void)
 	rc = platform_device_add(pdev);
 	if (rc) {
 		pr_err("efika_fabric_init: platform_device_add() failed\n");
+		platform_device_put(pdev);
 		return -ENODEV;
 	}
 	return 0;
-- 
1.7.2
